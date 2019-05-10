Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58D8C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 12:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87DD12173B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 12:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87DD12173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42585 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP4dT-0002Y7-ES
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 08:28:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hP4cW-0002Dz-MX
	for qemu-devel@nongnu.org; Fri, 10 May 2019 08:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hP4cV-0006zM-9Q
	for qemu-devel@nongnu.org; Fri, 10 May 2019 08:27:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hP4cU-0006xm-Vn
	for qemu-devel@nongnu.org; Fri, 10 May 2019 08:27:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 948B6C058CB4;
	Fri, 10 May 2019 12:27:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F60D1001E85;
	Fri, 10 May 2019 12:27:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 994D31132B35; Fri, 10 May 2019 14:27:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
References: <20190510102637.10209-1-lvivier@redhat.com>
Date: Fri, 10 May 2019 14:27:19 +0200
In-Reply-To: <20190510102637.10209-1-lvivier@redhat.com> (Laurent Vivier's
	message of "Fri, 10 May 2019 12:26:37 +0200")
Message-ID: <87zhnuqyu0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Fri, 10 May 2019 12:27:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] rng-builtin: add an RNG backend that
 uses qemu_guest_getrandom()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Daniel P . =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
	Amit Shah <amit@kernel.org>, Kashyap Chamarthy <kchamart@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Richard W . M . Jones" <rjones@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent Vivier <lvivier@redhat.com> writes:

> Add a new RNG backend using QEMU builtin getrandom function.
>
> It can be created and used with something like:
>
>     ... -object rng-builtin,id=rng0 -device virtio-rng,rng=rng0 ...
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>
> Notes:
>     This patch applies on top of
>     "[PATCH v5 00/24] Add qemu_getrandom and ARMv8.5-RNG etc"
>     Based-on: 20190510012458.22706-1-richard.henderson@linaro.org
>     
>     v2: Update qemu-options.hx
>         describe the new backend and specify virtio-rng uses the
>         rng-random by default (do we want to change this?)
>
>  backends/Makefile.objs |  2 +-
>  backends/rng-builtin.c | 56 ++++++++++++++++++++++++++++++++++++++++++
>  qemu-options.hx        | 10 +++++++-
>  3 files changed, 66 insertions(+), 2 deletions(-)
>  create mode 100644 backends/rng-builtin.c
>
> diff --git a/backends/Makefile.objs b/backends/Makefile.objs
> index ff619d31b461..8da4a508d97b 100644
> --- a/backends/Makefile.objs
> +++ b/backends/Makefile.objs
> @@ -1,4 +1,4 @@
> -common-obj-y += rng.o rng-egd.o
> +common-obj-y += rng.o rng-egd.o rng-builtin.o
>  common-obj-$(CONFIG_POSIX) += rng-random.o
>  
>  common-obj-$(CONFIG_TPM) += tpm.o
> diff --git a/backends/rng-builtin.c b/backends/rng-builtin.c
> new file mode 100644
> index 000000000000..b1264b745407
> --- /dev/null
> +++ b/backends/rng-builtin.c
> @@ -0,0 +1,56 @@
> +/*
> + * QEMU Builtin Random Number Generator Backend
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "sysemu/rng.h"
> +#include "qapi/error.h"
> +#include "qapi/qmp/qerror.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/guest-random.h"
> +
> +#define TYPE_RNG_BUILTIN "rng-builtin"
> +#define RNG_BUILTIN(obj) OBJECT_CHECK(RngBuiltin, (obj), TYPE_RNG_BUILTIN)
> +
> +typedef struct RngBuiltin {
> +    RngBackend parent;
> +} RngBuiltin;
> +
> +static void rng_builtin_request_entropy(RngBackend *b, RngRequest *req)
> +{
> +    RngBuiltin *s = RNG_BUILTIN(b);
> +
> +    while (!QSIMPLEQ_EMPTY(&s->parent.requests)) {
> +        RngRequest *req = QSIMPLEQ_FIRST(&s->parent.requests);
> +
> +        qemu_guest_getrandom_nofail(req->data, req->size);
> +
> +        req->receive_entropy(req->opaque, req->data, req->size);
> +
> +        rng_backend_finalize_request(&s->parent, req);
> +    }
> +}
> +
> +static void rng_builtin_class_init(ObjectClass *klass, void *data)
> +{
> +    RngBackendClass *rbc = RNG_BACKEND_CLASS(klass);
> +
> +    rbc->request_entropy = rng_builtin_request_entropy;
> +}
> +
> +static const TypeInfo rng_builtin_info = {
> +    .name = TYPE_RNG_BUILTIN,
> +    .parent = TYPE_RNG_BACKEND,
> +    .instance_size = sizeof(RngBuiltin),
> +    .class_init = rng_builtin_class_init,
> +};
> +
> +static void register_types(void)
> +{
> +    type_register_static(&rng_builtin_info);
> +}
> +
> +type_init(register_types);
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 0191ef8b1eb7..3e2a51c691b0 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4280,13 +4280,21 @@ other options.
>  
>  The @option{share} boolean option is @var{on} by default with memfd.
>  
> +@item -object rng-builtin,id=@var{id}
> +
> +Creates a random number generator backend which obtains entropy from
> +QEMU builtin functions. The @option{id} parameter is a unique ID that
> +will be used to reference this entropy backend from the @option{virtio-rng}
> +device.
> +
>  @item -object rng-random,id=@var{id},filename=@var{/dev/random}
>  
>  Creates a random number generator backend which obtains entropy from
>  a device on the host. The @option{id} parameter is a unique ID that
>  will be used to reference this entropy backend from the @option{virtio-rng}
>  device.

There's also the "spapr-rng" device, I think.

>          The @option{filename} parameter specifies which file to obtain
> -entropy from and if omitted defaults to @option{/dev/random}.
> +entropy from and if omitted defaults to @option{/dev/random}. By default,
> +the @option{virtio-rng} device uses this RNG backend.
>  
>  @item -object rng-egd,id=@var{id},chardev=@var{chardevid}

Trivial conflict with Kashyap's "[PATCH v2] VirtIO-RNG: Update default
entropy source to `/dev/urandom`".

virtio-rng indeed creates an rng-random backend when the user doesn't
specify one.  I consider having device model frontends create backends a
bad idea.  Not this patch's fault, of course.

That said, would rng-builtin be a better default?  For starters, it's
available when !CONFIG_POSIX.  I suspect virtio-rng crashes when it
tries to create an rng-random that isn't available.

The new rng-builtin is considerably simpler than both rng-random and
rng-egd.  Moreover, it just works, whereas rng-random is limited to
CONFIG_POSIX, and rng-egd needs egd running (which I suspect basically
nobody does).  Have we considered deprecating these two backends in
favor of rng-builtin?


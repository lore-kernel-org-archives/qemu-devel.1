Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBDBC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 04:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3605207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 04:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3605207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54476 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYkKE-0005K2-2m
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 00:48:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYkIa-0004SR-SM
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 00:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYkIZ-00086n-PD
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 00:46:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hYkIZ-00083r-Ht
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 00:46:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9078530C1AD5;
	Thu,  6 Jun 2019 04:46:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 23A941057FD6;
	Thu,  6 Jun 2019 04:46:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id EAAFF11386A0; Thu,  6 Jun 2019 06:46:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
References: <20190529143106.11789-1-lvivier@redhat.com>
	<20190529143106.11789-3-lvivier@redhat.com>
Date: Thu, 06 Jun 2019 06:46:41 +0200
In-Reply-To: <20190529143106.11789-3-lvivier@redhat.com> (Laurent Vivier's
	message of "Wed, 29 May 2019 16:31:04 +0200")
Message-ID: <87v9xjjp72.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Thu, 06 Jun 2019 04:46:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 2/4] rng-builtin: add an RNG backend
 that uses qemu_guest_getrandom()
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
	Amit Shah <amit@kernel.org>, Markus Armbruster <armbru@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Richard W . M . Jones" <rjones@redhat.com>,
	qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
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
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  backends/Makefile.objs |  2 +-
>  backends/rng-builtin.c | 78 ++++++++++++++++++++++++++++++++++++++++++
>  qemu-options.hx        |  7 ++++
>  3 files changed, 86 insertions(+), 1 deletion(-)
>  create mode 100644 backends/rng-builtin.c
>
> diff --git a/backends/Makefile.objs b/backends/Makefile.objs
> index 981e8e122f2c..f0691116e86e 100644
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
> index 000000000000..3381d47174df
> --- /dev/null
> +++ b/backends/rng-builtin.c
> @@ -0,0 +1,78 @@
> +/*
> + * QEMU Builtin Random Number Generator Backend
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "sysemu/rng.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/guest-random.h"
> +
> +#define TYPE_RNG_BUILTIN "rng-builtin"
> +#define RNG_BUILTIN(obj) OBJECT_CHECK(RngBuiltin, (obj), TYPE_RNG_BUILTIN)
> +
> +typedef struct RngBuiltin {
> +    RngBackend parent;
> +    QEMUBH *bh;
> +} RngBuiltin;
> +
> +static void rng_builtin_receive_entropy_bh(void *opaque)
> +{
> +    RngBuiltin *s = opaque;
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
> +static void rng_builtin_request_entropy(RngBackend *b, RngRequest *req)
> +{
> +    RngBuiltin *s = RNG_BUILTIN(b);
> +
> +    qemu_bh_schedule(s->bh);
> +}

A comment explaining the need for a BH would be nice.

Regardless:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

[...]


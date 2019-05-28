Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F263DC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 08:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C934D208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 08:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C934D208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59056 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVXTJ-0001Te-3C
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 04:28:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hVXQs-0000HL-Ob
	for qemu-devel@nongnu.org; Tue, 28 May 2019 04:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hVXQn-0005ik-HX
	for qemu-devel@nongnu.org; Tue, 28 May 2019 04:26:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hVXQn-0005Zm-B5
	for qemu-devel@nongnu.org; Tue, 28 May 2019 04:26:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2394164394;
	Tue, 28 May 2019 08:25:49 +0000 (UTC)
Received: from [10.40.204.169] (ovpn-204-169.brq.redhat.com [10.40.204.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 917B010021B6;
	Tue, 28 May 2019 08:25:42 +0000 (UTC)
To: qemu-devel@nongnu.org
References: <20190514162744.30398-1-lvivier@redhat.com>
	<20190514162744.30398-3-lvivier@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <c9b025e7-0825-03e3-79ab-2224d6198a35@redhat.com>
Date: Tue, 28 May 2019 10:25:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190514162744.30398-3-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Tue, 28 May 2019 08:25:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 2/4] rng-builtin: add an RNG backend
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
Cc: "=?UTF-8?Q?Daniel_P_._Berrang=c3=a9?=" <berrange@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Richard W . M . Jones" <rjones@redhat.com>, Amit Shah <amit@kernel.org>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/05/2019 18:27, Laurent Vivier wrote:
> Add a new RNG backend using QEMU builtin getrandom function.
> 
> It can be created and used with something like:
> 
>      ... -object rng-builtin,id=rng0 -device virtio-rng,rng=rng0 ...
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   backends/Makefile.objs |  2 +-
>   backends/rng-builtin.c | 54 ++++++++++++++++++++++++++++++++++++++++++
>   qemu-options.hx        |  7 ++++++
>   3 files changed, 62 insertions(+), 1 deletion(-)
>   create mode 100644 backends/rng-builtin.c
> 
> diff --git a/backends/Makefile.objs b/backends/Makefile.objs
> index 981e8e122f2c..f0691116e86e 100644
> --- a/backends/Makefile.objs
> +++ b/backends/Makefile.objs
> @@ -1,4 +1,4 @@
> -common-obj-y += rng.o rng-egd.o
> +common-obj-y += rng.o rng-egd.o rng-builtin.o
>   common-obj-$(CONFIG_POSIX) += rng-random.o
>   
>   common-obj-$(CONFIG_TPM) += tpm.o
> diff --git a/backends/rng-builtin.c b/backends/rng-builtin.c
> new file mode 100644
> index 000000000000..6b9543a7de87
> --- /dev/null
> +++ b/backends/rng-builtin.c
> @@ -0,0 +1,54 @@
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
>

There is a problem here:

rng_backend_request_entropy() calls rng_builtin_request_entropy() and 
then add the request to the queue parent.requests, so receive_entropy() 
is called only on the next call of rng_backend_request_entropy() (and 
parameter req is unused).

Thanks,
Laurent



Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37B3C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:54:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484E82070D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484E82070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46821 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8mn-0006Gs-2F
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:54:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hP8WB-0007WH-M1
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hP8WA-0007qA-F7
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:37:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hP8W6-0007ob-Hq
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:37:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3190759473;
	Fri, 10 May 2019 16:37:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 510CD60BFB;
	Fri, 10 May 2019 16:36:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id CABE811385E4; Fri, 10 May 2019 18:36:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
References: <20190510134203.24012-1-lvivier@redhat.com>
	<20190510134203.24012-4-lvivier@redhat.com>
Date: Fri, 10 May 2019 18:36:56 +0200
In-Reply-To: <20190510134203.24012-4-lvivier@redhat.com> (Laurent Vivier's
	message of "Fri, 10 May 2019 15:42:03 +0200")
Message-ID: <871s16jmfr.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Fri, 10 May 2019 16:37:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/3] virtio-rng: change default backend
 to rng-builtin
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
Cc: "Daniel P . =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, "Richard W . M . Jones" <rjones@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent Vivier <lvivier@redhat.com> writes:

> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  backends/rng-builtin.c         |  8 +++-----
>  hw/virtio/virtio-rng.c         |  2 +-
>  include/hw/virtio/virtio-rng.h |  4 ++--
>  include/sysemu/rng-builtin.h   | 17 +++++++++++++++++
>  qemu-options.hx                |  5 ++---
>  5 files changed, 25 insertions(+), 11 deletions(-)
>  create mode 100644 include/sysemu/rng-builtin.h
>
> diff --git a/backends/rng-builtin.c b/backends/rng-builtin.c
> index b1264b745407..27675301933b 100644
> --- a/backends/rng-builtin.c
> +++ b/backends/rng-builtin.c
> @@ -7,17 +7,15 @@
>  
>  #include "qemu/osdep.h"
>  #include "sysemu/rng.h"
> +#include "sysemu/rng-builtin.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qemu/main-loop.h"
>  #include "qemu/guest-random.h"
>  
> -#define TYPE_RNG_BUILTIN "rng-builtin"
> -#define RNG_BUILTIN(obj) OBJECT_CHECK(RngBuiltin, (obj), TYPE_RNG_BUILTIN)
> -
> -typedef struct RngBuiltin {
> +struct RngBuiltin {
>      RngBackend parent;
> -} RngBuiltin;
> +};
>  
>  static void rng_builtin_request_entropy(RngBackend *b, RngRequest *req)
>  {
> diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
> index 30493a258622..67209f63ddbc 100644
> --- a/hw/virtio/virtio-rng.c
> +++ b/hw/virtio/virtio-rng.c
> @@ -189,7 +189,7 @@ static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
>      }
>  
>      if (vrng->conf.rng == NULL) {
> -        vrng->conf.default_backend = RNG_RANDOM(object_new(TYPE_RNG_RANDOM));
> +        vrng->conf.default_backend = RNG_BUILTIN(object_new(TYPE_RNG_BUILTIN));
>  
>          user_creatable_complete(USER_CREATABLE(vrng->conf.default_backend),
>                                  &local_err);
           if (local_err) {
               error_propagate(errp, local_err);
               object_unref(OBJECT(vrng->conf.default_backend));
               return;
           }

           object_property_add_child(OBJECT(dev),
                                     "default-backend",
                                     OBJECT(vrng->conf.default_backend),
                                     NULL);

           /* The child property took a reference, we can safely drop ours now */
           object_unref(OBJECT(vrng->conf.default_backend));

           object_property_set_link(OBJECT(dev),
                                    OBJECT(vrng->conf.default_backend),
                                    "rng", NULL);
       }
> diff --git a/include/hw/virtio/virtio-rng.h b/include/hw/virtio/virtio-rng.h
> index 922dce7caccf..f9b6339b19a4 100644
> --- a/include/hw/virtio/virtio-rng.h
> +++ b/include/hw/virtio/virtio-rng.h
> @@ -13,7 +13,7 @@
>  #define QEMU_VIRTIO_RNG_H
>  
>  #include "sysemu/rng.h"
> -#include "sysemu/rng-random.h"
> +#include "sysemu/rng-builtin.h"
>  #include "standard-headers/linux/virtio_rng.h"
>  
>  #define TYPE_VIRTIO_RNG "virtio-rng-device"
> @@ -26,7 +26,7 @@ struct VirtIORNGConf {
>      RngBackend *rng;
>      uint64_t max_bytes;
>      uint32_t period_ms;
> -    RngRandom *default_backend;
> +    RngBuiltin *default_backend;

This member appears to be superfluous.  As far as I can tell, it's only
used in the part of virtio-rng.c visible above.  If you replace it by a
local variable there (in a separate patch, perhaps), this patch will
become simpler.  In particular, you won't need to create rng-builtin.h.

>  };
>  
>  typedef struct VirtIORNG {
> diff --git a/include/sysemu/rng-builtin.h b/include/sysemu/rng-builtin.h
> new file mode 100644
> index 000000000000..a0f75f97dde8
> --- /dev/null
> +++ b/include/sysemu/rng-builtin.h
> @@ -0,0 +1,17 @@
> +/*
> + * QEMU Builtin Random Number Generator Backend
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +#ifndef QEMU_RNG_BUILTIN_H
> +#define QEMU_RNG_BUILTIN_H
> +
> +#include "qom/object.h"
> +
> +#define TYPE_RNG_BUILTIN "rng-builtin"
> +#define RNG_BUILTIN(obj) OBJECT_CHECK(RngBuiltin, (obj), TYPE_RNG_BUILTIN)
> +
> +typedef struct RngBuiltin RngBuiltin;
> +
> +#endif
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 6ab920f12be4..c9784be83cb5 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4285,7 +4285,7 @@ The @option{share} boolean option is @var{on} by default with memfd.
>  Creates a random number generator backend which obtains entropy from
>  QEMU builtin functions. The @option{id} parameter is a unique ID that
>  will be used to reference this entropy backend from the @option{virtio-rng}
> -device.
> +device. By default, the @option{virtio-rng} device uses this RNG backend.

Aside: this piece of information should ideally go into virtio-rng
documentation.  If only it existed; -device virtio-rng,help is all we
got.  So you keep it here.  Fair enough.

>  
>  @item -object rng-random,id=@var{id},filename=@var{/dev/random}
>  
> @@ -4293,8 +4293,7 @@ Creates a random number generator backend which obtains entropy from
>  a device on the host. The @option{id} parameter is a unique ID that
>  will be used to reference this entropy backend from the @option{virtio-rng}
>  device. The @option{filename} parameter specifies which file to obtain
> -entropy from and if omitted defaults to @option{/dev/urandom}. By default,
> -the @option{virtio-rng} device uses this RNG backend.
> +entropy from and if omitted defaults to @option{/dev/urandom}.
>  
>  @item -object rng-egd,id=@var{id},chardev=@var{chardevid}


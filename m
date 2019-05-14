Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBE1C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:26:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2407020644
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2407020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49848 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQZJc-00035l-Bb
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 11:26:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQZIV-0002Tp-Hf
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQZIU-0000tI-Bc
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:24:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hQZIU-0000qT-42
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:24:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C753781E0C;
	Tue, 14 May 2019 15:24:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0167D5D706;
	Tue, 14 May 2019 15:24:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 7572C11385E4; Tue, 14 May 2019 17:24:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
References: <20190514075602.7674-1-lvivier@redhat.com>
	<20190514075602.7674-4-lvivier@redhat.com>
Date: Tue, 14 May 2019 17:24:44 +0200
In-Reply-To: <20190514075602.7674-4-lvivier@redhat.com> (Laurent Vivier's
	message of "Tue, 14 May 2019 09:56:02 +0200")
Message-ID: <87sgthcb43.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Tue, 14 May 2019 15:24:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 3/3] virtio-rng: change default backend
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

Rebase on top of the PATCH 3.5 I just posted gets rid of patch hunks
from here...

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
>  };
>  
>  typedef struct VirtIORNG {

... until here.

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

The last hunk goes away if you take my suggestion on PATCH 2.

Preferably simplified along these lines:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


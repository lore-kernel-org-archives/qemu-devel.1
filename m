Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1439FC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC9E720867
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9E720867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGLEl-0000Xg-LF
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 06:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iGK81-0003Ca-Ac
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iGK7z-0001cu-EB
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:44:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42820)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iGK7x-0001aw-If
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:43:59 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 667005117D
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 09:43:56 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id g67so1394952wmg.4
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 02:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=so92RmyzpSBPlQMlFqQ9gQn20WQcsSKTXy/qkSJ9eI4=;
 b=Bcvcpv3+RGPGWuP7oj8TFKuyoDJOyEPX31/lrTOCnvNPmRoH/Tp37b9/7P9VsLrSBu
 CpfxsfMHmSBe06YGBAjkX7R3MX3S9h/fOulzwV/fJluwg6hXwqmTdef4Na87ByolGmxL
 K5ANoItWU1T62va2mtv2E3Hn3bY/teutvwQ12OVTsOyHrZ9TiAFqNnSaloQjfdRIWyOq
 Ey4s3sR7cYeDW6NBJBR0Uh36TTC8lz7vGw/4Og+QEVq1qyCRIDFG8giA8RixzrQ81c85
 HZ8vPk16Nw3xb0eZLVeb6G9nOReZ+ZgR0DdU59Y6AnoUnFty/j1ldhyVhD0ZGRKN+map
 7Rdg==
X-Gm-Message-State: APjAAAVfm41ac/ylabQ34O9Z1Gm/sIxOgp/1SDUc8cxGgX42V4bXQqYZ
 Y1u2YMMIjPnX0dFtckbZBGd4b7+go9zsEM1QaSA6LE/xBChKU1fGVioacEbVANbsWmiqIh6XpCO
 hrdWUZFtEj0GoqoQ=
X-Received: by 2002:a1c:9a46:: with SMTP id c67mr10201924wme.115.1570182235068; 
 Fri, 04 Oct 2019 02:43:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxrp0sUP254DdZZXWAIPrx0+ZAQoyzu3ak9BPav/Os4yetuNaOGf8d0EGSTFvydny/B8nQ/Bw==
X-Received: by 2002:a1c:9a46:: with SMTP id c67mr10201903wme.115.1570182234796; 
 Fri, 04 Oct 2019 02:43:54 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id a10sm6165747wrm.52.2019.10.04.02.43.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2019 02:43:54 -0700 (PDT)
Subject: Re: [PATCH v6 01/10] hw/virtio: Factorize virtio-mmio headers
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191004093752.16564-1-slp@redhat.com>
 <20191004093752.16564-2-slp@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c197783a-a845-9448-ae39-960fb7dc305b@redhat.com>
Date: Fri, 4 Oct 2019 11:43:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191004093752.16564-2-slp@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ehabkost@redhat.com, mst@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sergio,

On 10/4/19 11:37 AM, Sergio Lopez wrote:
> Put QOM and main struct definition in a separate header file, so it
> can be accessed from other components.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Please collect/keep reviewer tags between iterations, this will save=20
them time. Only reset (remove) them if you want the reviewer to review=20
your patch carefully again.

Only cosmetic change since v5 which had:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   include/hw/virtio/virtio-mmio.h | 73 ++++++++++++++++++++++++++++++++=
+
>   hw/virtio/virtio-mmio.c         | 48 +---------------------
>   2 files changed, 74 insertions(+), 47 deletions(-)
>   create mode 100644 include/hw/virtio/virtio-mmio.h
>=20
> diff --git a/include/hw/virtio/virtio-mmio.h b/include/hw/virtio/virtio=
-mmio.h
> new file mode 100644
> index 0000000000..7dbfd03dcf
> --- /dev/null
> +++ b/include/hw/virtio/virtio-mmio.h
> @@ -0,0 +1,73 @@
> +/*
> + * Virtio MMIO bindings
> + *
> + * Copyright (c) 2011 Linaro Limited
> + *
> + * Author:
> + *  Peter Maydell <peter.maydell@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the GNU General Public License; either versio=
n 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License a=
long
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_VIRTIO_MMIO_H
> +#define HW_VIRTIO_MMIO_H
> +
> +#include "hw/virtio/virtio-bus.h"
> +
> +/* QOM macros */
> +/* virtio-mmio-bus */
> +#define TYPE_VIRTIO_MMIO_BUS "virtio-mmio-bus"
> +#define VIRTIO_MMIO_BUS(obj) \
> +        OBJECT_CHECK(VirtioBusState, (obj), TYPE_VIRTIO_MMIO_BUS)
> +#define VIRTIO_MMIO_BUS_GET_CLASS(obj) \
> +        OBJECT_GET_CLASS(VirtioBusClass, (obj), TYPE_VIRTIO_MMIO_BUS)
> +#define VIRTIO_MMIO_BUS_CLASS(klass) \
> +        OBJECT_CLASS_CHECK(VirtioBusClass, (klass), TYPE_VIRTIO_MMIO_B=
US)
> +
> +/* virtio-mmio */
> +#define TYPE_VIRTIO_MMIO "virtio-mmio"
> +#define VIRTIO_MMIO(obj) \
> +        OBJECT_CHECK(VirtIOMMIOProxy, (obj), TYPE_VIRTIO_MMIO)
> +
> +#define VIRT_MAGIC 0x74726976 /* 'virt' */
> +#define VIRT_VERSION 2
> +#define VIRT_VERSION_LEGACY 1
> +#define VIRT_VENDOR 0x554D4551 /* 'QEMU' */
> +
> +typedef struct VirtIOMMIOQueue {
> +    uint16_t num;
> +    bool enabled;
> +    uint32_t desc[2];
> +    uint32_t avail[2];
> +    uint32_t used[2];
> +} VirtIOMMIOQueue;
> +
> +typedef struct {
> +    /* Generic */
> +    SysBusDevice parent_obj;
> +    MemoryRegion iomem;
> +    qemu_irq irq;
> +    bool legacy;
> +    /* Guest accessible state needing migration and reset */
> +    uint32_t host_features_sel;
> +    uint32_t guest_features_sel;
> +    uint32_t guest_page_shift;
> +    /* virtio-bus */
> +    VirtioBusState bus;
> +    bool format_transport_address;
> +    /* Fields only used for non-legacy (v2) devices */
> +    uint32_t guest_features[2];
> +    VirtIOMMIOQueue vqs[VIRTIO_QUEUE_MAX];
> +} VirtIOMMIOProxy;
> +
> +#endif
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index 3d5ca0f667..94d934c44b 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -29,57 +29,11 @@
>   #include "qemu/host-utils.h"
>   #include "qemu/module.h"
>   #include "sysemu/kvm.h"
> -#include "hw/virtio/virtio-bus.h"
> +#include "hw/virtio/virtio-mmio.h"
>   #include "qemu/error-report.h"
>   #include "qemu/log.h"
>   #include "trace.h"
>  =20
> -/* QOM macros */
> -/* virtio-mmio-bus */
> -#define TYPE_VIRTIO_MMIO_BUS "virtio-mmio-bus"
> -#define VIRTIO_MMIO_BUS(obj) \
> -        OBJECT_CHECK(VirtioBusState, (obj), TYPE_VIRTIO_MMIO_BUS)
> -#define VIRTIO_MMIO_BUS_GET_CLASS(obj) \
> -        OBJECT_GET_CLASS(VirtioBusClass, (obj), TYPE_VIRTIO_MMIO_BUS)
> -#define VIRTIO_MMIO_BUS_CLASS(klass) \
> -        OBJECT_CLASS_CHECK(VirtioBusClass, (klass), TYPE_VIRTIO_MMIO_B=
US)
> -
> -/* virtio-mmio */
> -#define TYPE_VIRTIO_MMIO "virtio-mmio"
> -#define VIRTIO_MMIO(obj) \
> -        OBJECT_CHECK(VirtIOMMIOProxy, (obj), TYPE_VIRTIO_MMIO)
> -
> -#define VIRT_MAGIC 0x74726976 /* 'virt' */
> -#define VIRT_VERSION 2
> -#define VIRT_VERSION_LEGACY 1
> -#define VIRT_VENDOR 0x554D4551 /* 'QEMU' */
> -
> -typedef struct VirtIOMMIOQueue {
> -    uint16_t num;
> -    bool enabled;
> -    uint32_t desc[2];
> -    uint32_t avail[2];
> -    uint32_t used[2];
> -} VirtIOMMIOQueue;
> -
> -typedef struct {
> -    /* Generic */
> -    SysBusDevice parent_obj;
> -    MemoryRegion iomem;
> -    qemu_irq irq;
> -    bool legacy;
> -    /* Guest accessible state needing migration and reset */
> -    uint32_t host_features_sel;
> -    uint32_t guest_features_sel;
> -    uint32_t guest_page_shift;
> -    /* virtio-bus */
> -    VirtioBusState bus;
> -    bool format_transport_address;
> -    /* Fields only used for non-legacy (v2) devices */
> -    uint32_t guest_features[2];
> -    VirtIOMMIOQueue vqs[VIRTIO_QUEUE_MAX];
> -} VirtIOMMIOProxy;
> -
>   static bool virtio_mmio_ioeventfd_enabled(DeviceState *d)
>   {
>       return kvm_eventfds_enabled();
>=20


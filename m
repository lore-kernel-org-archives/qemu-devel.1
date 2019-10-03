Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB51C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439BF21A4C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439BF21A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFy9y-0003ec-BR
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 06:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFy8Z-0002kR-Es
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:15:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFy8X-0005ik-W4
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:15:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49702)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFy8X-0005iP-O1
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:15:05 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 79C75C01B81A
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 10:15:04 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id n3so936965wmf.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 03:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=110pg/R/6quKydyAPUDStbEinZE05RYFGyxpolzxe30=;
 b=fFKfVEoyTwkfkFPNXGowhcon8Yiz5sBdkkBHy/FmMC2mwfUhS9seQuDId3hDZKOwdz
 ryTdIq41xoXnNqvcy8eM86gd7iRu0CWfrJI0K+Pn29A0tYm98Hm668DtQ2a4bCAYfG3r
 S4ZKgGUILMrQZw1b9vk15QZJD9t2HZtT7IAerRR6Z99/5ge2GflWhhZ5R52rFFBk3BUC
 b2DsI6evmoxDqHtdyBqb1a0Baf1CO1P01NW8qtE2971MfXgg3Nli3vWQv+tP7hgvI/r+
 x4sPzJwFxLmZN3+cJYfoCYMoTAhmP7MPrxlvxQVYEWHgT1B2ep8gyoJYeBpf99dgyBFt
 aOfA==
X-Gm-Message-State: APjAAAVynMRjmNXax1mPdy/ETrUuRaiTe9w/LBbyiYE+3e+TKjW0VZou
 HGhPHZ95gEh8TNfKRIXNCHxum329V4s6M0Xe3l6DhWin6QIfnm6BGzCNs1Xoil+Qm+IIxnrc85h
 /OmKjEFhCqc29lac=
X-Received: by 2002:a7b:c5c2:: with SMTP id n2mr6151900wmk.20.1570097703122;
 Thu, 03 Oct 2019 03:15:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxD4QffscLTOeo90j0D2jO7nDVBSPfzI1WCKGo5fbLpfc9dx2QYcFRh7V4aQ5NHBBerbncT2w==
X-Received: by 2002:a7b:c5c2:: with SMTP id n2mr6151878wmk.20.1570097702895;
 Thu, 03 Oct 2019 03:15:02 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id f83sm2447702wmf.43.2019.10.03.03.15.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2019 03:15:02 -0700 (PDT)
Subject: Re: [PATCH v5 01/10] hw/virtio: Factorize virtio-mmio headers
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191002113103.45023-1-slp@redhat.com>
 <20191002113103.45023-2-slp@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <96ff1ae1-fc3f-af56-08bd-a8b821385572@redhat.com>
Date: Thu, 3 Oct 2019 12:15:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191002113103.45023-2-slp@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, ehabkost@redhat.com,
 mst@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/19 1:30 PM, Sergio Lopez wrote:
> Put QOM and main struct definition in a separate header file, so it
> can be accessed from other components.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>   hw/virtio/virtio-mmio.c         | 48 +---------------------
>   include/hw/virtio/virtio-mmio.h | 73 ++++++++++++++++++++++++++++++++=
+
>   2 files changed, 74 insertions(+), 47 deletions(-)
>   create mode 100644 include/hw/virtio/virtio-mmio.h
>=20
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
> diff --git a/include/hw/virtio/virtio-mmio.h b/include/hw/virtio/virtio=
-mmio.h
> new file mode 100644
> index 0000000000..c8a6ef20de
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
> +#ifndef QEMU_VIRTIO_MMIO_H
> +#define QEMU_VIRTIO_MMIO_H

I'd rather use HW_VIRTIO_MMIO_H

Regardless:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

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
>=20


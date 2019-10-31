Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F6FCA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 23:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 198D02080F
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 23:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198D02080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQJol-0000Pf-7k
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 19:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iQJn0-0007ve-3s
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 19:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iQJmx-0002uQ-Pt
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 19:23:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37626)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iQJmv-0002nz-Bd
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 19:23:35 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 68B8E85537
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 23:23:31 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id r16so1512856wrj.4
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 16:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AHe94hIvQZyTw8SP80G7e/YOzr4yZD+3NkCoT6MZ8rw=;
 b=Ut2RWkDbpk8fptjl62qogS2owiegB2AFkaOcPExfo36mAob0U96dBORGOQX2O8i9Kd
 4L8RdYT0/hORB56C9W9sShHivWOLFd8I2cZj3Kh4T3ODgCzTI0EgmXBpvdfpixUckvSP
 kRTijhpjDkpJK0BzQ3zYjJxL8g8bP8zO+nENu0G2Ib2xN8oEAKjIgzVjLAchLLAkEkNi
 GmzxBN7cN4MIypz82yYch+Kn20EnYTjUkxToWhBLHxFQDpKx4ArrfAyrKB3S9ezQ4XOs
 VBmKshvSJUSDjUEG6hO7OLx234ESpT3aL3WiqHnBNp3bh7TtrXl/lkjg1wYAI1EsMqK7
 XGYg==
X-Gm-Message-State: APjAAAXlUigLPuE5I4GtOQzWxomRFJR5OOCm0WYw2EvpvmQNERfzg0ly
 t3KC37e0RevXjGEmysX/MOBJWRgmx0dOV9rCdg6rPbznYwcyz2tOC+DOQfY3GReF++r92W4DwFx
 9IZHFRCmzuLzKTow=
X-Received: by 2002:a1c:808d:: with SMTP id b135mr7220151wmd.175.1572564210121; 
 Thu, 31 Oct 2019 16:23:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwyRiqbwX82BN5PdcNZoNzL2PxYP1RQq8aH7ynTdwXziqkwbCXh4tid8JZoaAujqVngFB8/yg==
X-Received: by 2002:a1c:808d:: with SMTP id b135mr7220136wmd.175.1572564209909; 
 Thu, 31 Oct 2019 16:23:29 -0700 (PDT)
Received: from [192.168.20.58] (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id q2sm4670145wmq.30.2019.10.31.16.23.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2019 16:23:29 -0700 (PDT)
Subject: Re: [PATCH v5 02/13] hw/core/qdev: add trace events to help with
 resettable transition
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-3-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f5d78215-ee4d-ae1a-74dc-52b3c179d88c@redhat.com>
Date: Fri, 1 Nov 2019 00:23:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018150630.31099-3-damien.hedde@greensocs.com>
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 cohuck@redhat.com, mark.burton@greensocs.com, qemu-s390x@nongnu.org,
 edgari@xilinx.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 5:06 PM, Damien Hedde wrote:
> Adds trace events to reset procedure and when updating the parent
> bus of a device.
>=20
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>   hw/core/qdev.c       | 27 ++++++++++++++++++++++++---
>   hw/core/trace-events |  9 +++++++++
>   2 files changed, 33 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 60be2f2fef..f230063189 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -38,6 +38,7 @@
>   #include "hw/boards.h"
>   #include "hw/sysbus.h"
>   #include "migration/vmstate.h"
> +#include "trace.h"
>  =20
>   bool qdev_hotplug =3D false;
>   static bool qdev_hot_added =3D false;
> @@ -98,7 +99,9 @@ void qdev_set_parent_bus(DeviceState *dev, BusState *=
bus)
>       bool replugging =3D dev->parent_bus !=3D NULL;
>  =20
>       if (replugging) {
> -        /* Keep a reference to the device while it's not plugged into
> +        trace_qdev_update_parent_bus(dev, dev->parent_bus, bus);

Nitpicking, if you respin, can you add object_get_typename(OBJECT(dev)))=20
and object_get_typename(OBJECT(bus)))?

With/without it:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +        /*
> +         * Keep a reference to the device while it's not plugged into
>            * any bus, to avoid it potentially evaporating when it is
>            * dereffed in bus_remove_child().
>            */
> @@ -272,6 +275,18 @@ HotplugHandler *qdev_get_hotplug_handler(DeviceSta=
te *dev)
>       return hotplug_ctrl;
>   }
>  =20
> +static int qdev_prereset(DeviceState *dev, void *opaque)
> +{
> +    trace_qdev_reset_tree(dev, object_get_typename(OBJECT(dev)));
> +    return 0;
> +}
> +
> +static int qbus_prereset(BusState *bus, void *opaque)
> +{
> +    trace_qbus_reset_tree(bus, object_get_typename(OBJECT(bus)));
> +    return 0;
> +}
> +
>   static int qdev_reset_one(DeviceState *dev, void *opaque)
>   {
>       device_legacy_reset(dev);
> @@ -282,6 +297,7 @@ static int qdev_reset_one(DeviceState *dev, void *o=
paque)
>   static int qbus_reset_one(BusState *bus, void *opaque)
>   {
>       BusClass *bc =3D BUS_GET_CLASS(bus);
> +    trace_qbus_reset(bus, object_get_typename(OBJECT(bus)));
>       if (bc->reset) {
>           bc->reset(bus);
>       }
> @@ -290,7 +306,9 @@ static int qbus_reset_one(BusState *bus, void *opaq=
ue)
>  =20
>   void qdev_reset_all(DeviceState *dev)
>   {
> -    qdev_walk_children(dev, NULL, NULL, qdev_reset_one, qbus_reset_one=
, NULL);
> +    trace_qdev_reset_all(dev, object_get_typename(OBJECT(dev)));
> +    qdev_walk_children(dev, qdev_prereset, qbus_prereset,
> +                       qdev_reset_one, qbus_reset_one, NULL);
>   }
>  =20
>   void qdev_reset_all_fn(void *opaque)
> @@ -300,7 +318,9 @@ void qdev_reset_all_fn(void *opaque)
>  =20
>   void qbus_reset_all(BusState *bus)
>   {
> -    qbus_walk_children(bus, NULL, NULL, qdev_reset_one, qbus_reset_one=
, NULL);
> +    trace_qbus_reset_all(bus, object_get_typename(OBJECT(bus)));
> +    qbus_walk_children(bus, qdev_prereset, qbus_prereset,
> +                       qdev_reset_one, qbus_reset_one, NULL);
>   }
>  =20
>   void qbus_reset_all_fn(void *opaque)
> @@ -1108,6 +1128,7 @@ void device_legacy_reset(DeviceState *dev)
>   {
>       DeviceClass *klass =3D DEVICE_GET_CLASS(dev);
>  =20
> +    trace_qdev_reset(dev, object_get_typename(OBJECT(dev)));
>       if (klass->reset) {
>           klass->reset(dev);
>       }
> diff --git a/hw/core/trace-events b/hw/core/trace-events
> index fe47a9c8cb..1a669be0ea 100644
> --- a/hw/core/trace-events
> +++ b/hw/core/trace-events
> @@ -1,2 +1,11 @@
>   # loader.c
>   loader_write_rom(const char *name, uint64_t gpa, uint64_t size, bool =
isrom) "%s: @0x%"PRIx64" size=3D0x%"PRIx64" ROM=3D%d"
> +
> +# qdev.c
> +qdev_reset(void *obj, const char *objtype) "obj=3D%p(%s)"
> +qdev_reset_all(void *obj, const char *objtype) "obj=3D%p(%s)"
> +qdev_reset_tree(void *obj, const char *objtype) "obj=3D%p(%s)"
> +qbus_reset(void *obj, const char *objtype) "obj=3D%p(%s)"
> +qbus_reset_all(void *obj, const char *objtype) "obj=3D%p(%s)"
> +qbus_reset_tree(void *obj, const char *objtype) "obj=3D%p(%s)"
> +qdev_update_parent_bus(void *obj, void *oldp, void *newp) "obj=3D%p ol=
d_parent=3D%p new_parent=3D%p"
>=20


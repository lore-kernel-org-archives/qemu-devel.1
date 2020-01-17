Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3FAC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 09:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13DE120730
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 09:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GroLfiWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DE120730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isOEq-0000MI-11
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 04:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1isODg-0007jB-6J
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1isODc-0005Bq-Nu
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:47:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41699
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1isODc-0005B2-L0
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579254427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SPkIXciK6E3wUC+dxJgDQm8p/aYfCKeUbCuWsiNqGHg=;
 b=GroLfiWBke8QcsnBuXYhVNY80KBxj9Vd9UaqFdsFhwWkAlO5BQ6snNfiBDRyxjpGEYb6Nh
 pfstJT+tpdQM2+atmbX22yC6alawlA34CZcc721ajFy8yo6mIsj11Up/+UrgxYOf+SjnCG
 2mRM5CW0d2vMqEw7rVNZ6EHDO1DN6Pk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-kEQZXIRUMZ6lsoqqjxdrbQ-1; Fri, 17 Jan 2020 04:47:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28CB518FF660;
 Fri, 17 Jan 2020 09:47:03 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E05505C241;
 Fri, 17 Jan 2020 09:46:58 +0000 (UTC)
Date: Fri, 17 Jan 2020 10:46:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v2] hw/arm: Adjust some coding styles about memory hotplug
Message-ID: <20200117104657.583abb3d@redhat.com>
In-Reply-To: <20200117063822.57918-1-zhukeqian1@huawei.com>
References: <20200117063822.57918-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: kEQZXIRUMZ6lsoqqjxdrbQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, qemu-arm@nongnu.org,
 wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jan 2020 14:38:22 +0800
Keqian Zhu <zhukeqian1@huawei.com> wrote:

> From: zhukeqian <zhukeqian1@huawei.com>
> 
> There is extra indent in ACPI GED plug cb. And we can use
> existing helper function to trigger hotplug handler plug.
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
> 
> v1->v2:
>  - Add Igor's R-b

FYI one does not need to repost v2 for the purpose of
picking up tags, usually maintainer takes care of that
when patch is queued 

> 
> Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/acpi/generic_event_device.c | 2 +-
>  hw/arm/virt.c                  | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 9cee90cc70..55eb29d80a 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -175,7 +175,7 @@ static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
>      AcpiGedState *s = ACPI_GED(hotplug_dev);
>  
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> -            acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
> +        acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
>      } else {
>          error_setg(errp, "virt: device plug request for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 39ab5f47e0..656b0081c2 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1934,7 +1934,6 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>  static void virt_memory_plug(HotplugHandler *hotplug_dev,
>                               DeviceState *dev, Error **errp)
>  {
> -    HotplugHandlerClass *hhc;
>      VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>      Error *local_err = NULL;
>  
> @@ -1943,8 +1942,9 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
>          goto out;
>      }
>  
> -    hhc = HOTPLUG_HANDLER_GET_CLASS(vms->acpi_dev);
> -    hhc->plug(HOTPLUG_HANDLER(vms->acpi_dev), dev, &error_abort);
> +    hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
> +                         dev, &error_abort);
> +
>  out:
>      error_propagate(errp, local_err);
>  }



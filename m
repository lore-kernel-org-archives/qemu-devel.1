Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFC7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 08:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CADA22065F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 08:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5jiAtZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CADA22065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbg7T-0005vG-Sv
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 03:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbg6o-00057S-1F
 for qemu-devel@nongnu.org; Thu, 21 May 2020 03:59:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35794
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbg6m-0000Z4-PA
 for qemu-devel@nongnu.org; Thu, 21 May 2020 03:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590047954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=57YaKa9BHFEUtBziFfUy/l9IGUB153INf5Tvp3kpsqc=;
 b=h5jiAtZH2jwzykyCdzPKN36Aa8Z6voBRwla8LzGXb7uf6Y7Bz7iHPpmU/2JRmNGd2G0uix
 2Cw4Hbid9OeTNAoSaQ9xeTEbylNVmoSYXbDqHu9382/t68Uq32Ala/ceiMkLwTz9+9Z70M
 7TXNGFLUjtVKEqWJ9mk9uHjfvbLlr+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-1IXsag8KPb6BdouentaxGA-1; Thu, 21 May 2020 03:59:13 -0400
X-MC-Unique: 1IXsag8KPb6BdouentaxGA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8063107ACCA;
 Thu, 21 May 2020 07:59:11 +0000 (UTC)
Received: from nas.mammed.net (unknown [10.40.193.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6167B5C1B0;
 Thu, 21 May 2020 07:59:01 +0000 (UTC)
Date: Thu, 21 May 2020 09:58:59 +0200
From: Igor Mammedow <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 09/22] acpi: ged: rename event memory region
Message-ID: <20200521095859.45791508@nas.mammed.net>
In-Reply-To: <20200520132003.9492-10-kraxel@redhat.com>
References: <20200520132003.9492-1-kraxel@redhat.com>
 <20200520132003.9492-10-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 00:43:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 May 2020 15:19:50 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Rename memory region and callbacks and ops to carry "evt" in the name
> because a second region will be added shortly.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Igor Mammedow <imammedo@redhat.com>

> ---
>  include/hw/acpi/generic_event_device.h |  2 +-
>  hw/acpi/generic_event_device.c         | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/acpi/generic_event_device.h
> b/include/hw/acpi/generic_event_device.h index
> 83917de02425..90a9180db572 100644 ---
> a/include/hw/acpi/generic_event_device.h +++
> b/include/hw/acpi/generic_event_device.h @@ -86,7 +86,7 @@
>  #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
>  
>  typedef struct GEDState {
> -    MemoryRegion io;
> +    MemoryRegion evt;
>      uint32_t     sel;
>  } GEDState;
>  
> diff --git a/hw/acpi/generic_event_device.c
> b/hw/acpi/generic_event_device.c index b1cbdd86b66c..1cb34111e59a
> 100644 --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -142,7 +142,7 @@ void build_ged_aml(Aml *table, const char *name,
> HotplugHandler *hotplug_dev, }
>  
>  /* Memory read by the GED _EVT AML dynamic method */
> -static uint64_t ged_read(void *opaque, hwaddr addr, unsigned size)
> +static uint64_t ged_evt_read(void *opaque, hwaddr addr, unsigned
> size) {
>      uint64_t val = 0;
>      GEDState *ged_st = opaque;
> @@ -161,14 +161,14 @@ static uint64_t ged_read(void *opaque, hwaddr
> addr, unsigned size) }
>  
>  /* Nothing is expected to be written to the GED memory region */
> -static void ged_write(void *opaque, hwaddr addr, uint64_t data,
> -                      unsigned int size)
> +static void ged_evt_write(void *opaque, hwaddr addr, uint64_t data,
> +                          unsigned int size)
>  {
>  }
>  
> -static const MemoryRegionOps ged_ops = {
> -    .read = ged_read,
> -    .write = ged_write,
> +static const MemoryRegionOps ged_evt_ops = {
> +    .read = ged_evt_read,
> +    .write = ged_evt_write,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>      .valid = {
>          .min_access_size = 4,
> @@ -287,9 +287,9 @@ static void acpi_ged_initfn(Object *obj)
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>      GEDState *ged_st = &s->ged_state;
>  
> -    memory_region_init_io(&ged_st->io, obj, &ged_ops, ged_st,
> +    memory_region_init_io(&ged_st->evt, obj, &ged_evt_ops, ged_st,
>                            TYPE_ACPI_GED, ACPI_GED_EVT_SEL_LEN);
> -    sysbus_init_mmio(sbd, &ged_st->io);
> +    sysbus_init_mmio(sbd, &ged_st->evt);
>  
>      sysbus_init_irq(sbd, &s->irq);
>  



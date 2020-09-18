Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A32AC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C6972075B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QR3kfcoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6972075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBs7-0005hR-TU
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kJBoF-0002hD-BP
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kJBoC-0006El-0v
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600417914;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Kf3CPqBjknClbjakj9GXz1ZtGhF+Agkx3vzQld74qtE=;
 b=QR3kfcoIchL/NTf8sGSsX4ppMU+bW62CpopiXKmxLEw5K/woPxrdsQS1kf67zVP7qAuLcv
 P4N0xg/yOMgPJTB1oRmuqr72ssoBdl+vs3t/xVzLFc98RyivTKma/DOczuTzELxS3SqwIO
 0W9pz8kO8qbWc/TebBsYwtD7r+b+OVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-cp0cOaA0OdytICIkis6CCg-1; Fri, 18 Sep 2020 04:31:42 -0400
X-MC-Unique: cp0cOaA0OdytICIkis6CCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B1B064093;
 Fri, 18 Sep 2020 08:31:40 +0000 (UTC)
Received: from redhat.com (ovpn-113-161.ams2.redhat.com [10.36.113.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA8AE610F3;
 Fri, 18 Sep 2020 08:31:35 +0000 (UTC)
Date: Fri, 18 Sep 2020 09:31:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Erich Mcmillan <erich.mcmillan@hp.com>
Subject: Re: [PATCH 2/2] add maximum combined fw size as machine
 configuration option
Message-ID: <20200918083132.GC1628512@redhat.com>
References: <20200918042339.3477-1-erich.mcmillan@hp.com>
MIME-Version: 1.0
In-Reply-To: <20200918042339.3477-1-erich.mcmillan@hp.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 04:23:39AM +0000, Erich Mcmillan wrote:
> From: Erich McMillan <erich.mcmillan@hp.com>
> 
> Signed-off-by: Erich McMillan <erich.mcmillan@hp.com>
> ---
>  hw/i386/pc.c         | 40 ++++++++++++++++++++++++++++++++++++++++
>  hw/i386/pc_sysfw.c   | 13 ++-----------
>  include/hw/i386/pc.h | 22 ++++++++++++----------
>  3 files changed, 54 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index d11daac..b304988 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1869,6 +1869,39 @@ static void pc_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
>      pcms->max_ram_below_4g = value;
>  }
>  
> +static void pc_machine_get_max_fw_size(Object *obj, Visitor *v,
> +                                             const char *name, void *opaque,
> +                                             Error **errp)
> +{
> +    PCMachineState *pcms = PC_MACHINE(obj);
> +    uint64_t value = pcms->max_fw_size;
> +
> +    visit_type_size(v, name, &value, errp);
> +}
> +
> +static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
> +                                             const char *name, void *opaque,
> +                                             Error **errp)
> +{
> +    PCMachineState *pcms = PC_MACHINE(obj);
> +    Error *error = NULL;
> +    uint64_t value;
> +
> +    visit_type_size(v, name, &value, &error);
> +    if (error) {
> +        error_propagate(errp, error);
> +        return;
> +    }
> +

Just here we should have a comment explaining why we pick this max limit.
The comment you removed later can be transplanted to here...

> +    if (value > 16 * MiB) {
> +        warn_report("User specifed max allowed firmware size %" PRIu64 " is greater than 16MiB,"
> +                    "if combined firwmare size exceeds 16MiB system may not boot,"
> +                    "or experience intermittent stability issues.", value);
> +    }
> +
> +    pcms->max_fw_size = value;
> +}
> +
>  static void pc_machine_initfn(Object *obj)
>  {
>      PCMachineState *pcms = PC_MACHINE(obj);
> @@ -1884,6 +1917,7 @@ static void pc_machine_initfn(Object *obj)
>      pcms->smbus_enabled = true;
>      pcms->sata_enabled = true;
>      pcms->pit_enabled = true;
> +    pcms->max_fw_size = 8 * MiB;
>  
>      pc_system_flash_create(pcms);
>      pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
> @@ -2004,6 +2038,12 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>  
>      object_class_property_add_bool(oc, PC_MACHINE_PIT,
>          pc_machine_get_pit, pc_machine_set_pit);
> +
> +    object_class_property_add(oc, PC_MACHINE_MAX_FW_SIZE, "size",
> +        pc_machine_get_max_fw_size, pc_machine_set_max_fw_size,
> +        NULL, NULL);
> +    object_class_property_set_description(oc, PC_MACHINE_MAX_FW_SIZE,
> +        "Maximum combined firmware size");
>  }
>  
>  static const TypeInfo pc_machine_info = {
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index b6c0822..22450ba 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -39,15 +39,6 @@
>  #include "hw/block/flash.h"
>  #include "sysemu/kvm.h"
>  
> -/*
> - * We don't have a theoretically justifiable exact lower bound on the base
> - * address of any flash mapping. In practice, the IO-APIC MMIO range is
> - * [0xFEE00000..0xFEE01000] -- see IO_APIC_DEFAULT_ADDRESS --, leaving free
> - * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8MB in
> - * size.
> - */

....this comment should be transplanted above^^

> -#define FLASH_SIZE_LIMIT (8 * MiB)
> -
>  #define FLASH_SECTOR_SIZE 4096
>  
>  static void pc_isa_bios_init(MemoryRegion *rom_memory,
> @@ -182,10 +173,10 @@ static void pc_system_flash_map(PCMachineState *pcms,
>          }
>          if ((hwaddr)size != size
>              || total_size > HWADDR_MAX - size
> -            || total_size + size > FLASH_SIZE_LIMIT) {
> +            || total_size + size > pcms->max_fw_size) {
>              error_report("combined size of system firmware exceeds "
>                           "%" PRIu64 " bytes",
> -                         FLASH_SIZE_LIMIT);
> +                         pcms->max_fw_size);
>              exit(1);
>          }
>  
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index fe52e16..cae213d 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -39,10 +39,11 @@ struct PCMachineState {
>      uint64_t max_ram_below_4g;
>      OnOffAuto vmport;
>  
> -    bool acpi_build_enabled;
> -    bool smbus_enabled;
> -    bool sata_enabled;
> -    bool pit_enabled;
> +    bool     acpi_build_enabled;
> +    bool     smbus_enabled;
> +    bool     sata_enabled;
> +    bool     pit_enabled;
> +    uint64_t max_fw_size;

Don't change whitespace in the existing fields - trying to
horizontally align fields has no benefit and needlessly
creates bigger diffs.

>  
>      /* NUMA information: */
>      uint64_t numa_nodes;
> @@ -52,13 +53,14 @@ struct PCMachineState {
>      hwaddr memhp_io_base;
>  };
>  
> -#define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
> -#define PC_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
> +#define PC_MACHINE_ACPI_DEVICE_PROP   "acpi-device"
> +#define PC_MACHINE_MAX_RAM_BELOW_4G   "max-ram-below-4g"
>  #define PC_MACHINE_DEVMEM_REGION_SIZE "device-memory-region-size"
> -#define PC_MACHINE_VMPORT           "vmport"
> -#define PC_MACHINE_SMBUS            "smbus"
> -#define PC_MACHINE_SATA             "sata"
> -#define PC_MACHINE_PIT              "pit"
> +#define PC_MACHINE_VMPORT             "vmport"
> +#define PC_MACHINE_SMBUS              "smbus"
> +#define PC_MACHINE_SATA               "sata"
> +#define PC_MACHINE_PIT                "pit"
> +#define PC_MACHINE_MAX_FW_SIZE        "max-fw-size"

Same here, just don't change whitespace alignment please.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



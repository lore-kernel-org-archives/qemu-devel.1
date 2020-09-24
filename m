Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86E5C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 12:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2026E21D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 12:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDOJUfMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2026E21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLQI0-0005CV-01
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 08:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kLQGt-0004J6-JF
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 08:22:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kLQGr-0003bP-0S
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 08:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600950164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GUBgbnCJxt9kS+b6UkytuscPP1YtoZ25ibGXDeO9No=;
 b=RDOJUfMVjovr7xqeTrqQY/JatSKop8HgoUq4T9EGg73g9mzV4zZkmT/sZ/cIASWq4CyqUn
 WHBRG0VnypAzJgiF1/qzf1UoFMZB0Iyh0zBEgn1en4hKAaQ0VC2CJap+xx8ITXJECMvbgp
 mKOQ3TDCrTPkToU/4maVZEAzxOBe61M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-NI8nva2sN-KLX36fxBdcjg-1; Thu, 24 Sep 2020 08:22:42 -0400
X-MC-Unique: NI8nva2sN-KLX36fxBdcjg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E335ACE22;
 Thu, 24 Sep 2020 12:22:41 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-35.ams2.redhat.com
 [10.36.114.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77A9F5C1C7;
 Thu, 24 Sep 2020 12:22:32 +0000 (UTC)
Subject: Re: [PATCH v4] hw/i386/pc: add max combined fw size as machine
 configuration option
To: Erich Mcmillan <erich.mcmillan@hp.com>, qemu-devel@nongnu.org
References: <20200923131829.3849-1-erich.mcmillan@hp.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <de343c71-f446-c68b-d0bc-5f9db97b5a00@redhat.com>
Date: Thu, 24 Sep 2020 14:22:32 +0200
MIME-Version: 1.0
In-Reply-To: <20200923131829.3849-1-erich.mcmillan@hp.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: imammedo@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, dgilbert@redhat.com,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/23/20 15:18, Erich Mcmillan wrote:
> From: Erich McMillan <erich.mcmillan@hp.com>
> 
> At HPi we have a need for increased fw size to enable testing of our custom fw.
> 
> Signed-off-by: Erich McMillan <erich.mcmillan@hp.com>
> ---
>  hw/i386/pc.c         | 50 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/pc_sysfw.c   | 13 ++----------
>  include/hw/i386/pc.h |  2 ++
>  3 files changed, 54 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index d11daacc23..89775e7d5b 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1869,6 +1869,49 @@ static void pc_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
>      pcms->max_ram_below_4g = value;
>  }
>  
> +static void pc_machine_get_max_fw_size(Object *obj, Visitor *v,
> +                                       const char *name, void *opaque,
> +                                       Error **errp)
> +{
> +    PCMachineState *pcms = PC_MACHINE(obj);
> +    uint64_t value = pcms->max_fw_size;
> +
> +    visit_type_size(v, name, &value, errp);
> +}
> +
> +static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
> +                                       const char *name, void *opaque,
> +                                       Error **errp)
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
> +    /*
> +    * We don't have a theoretically justifiable exact lower bound on the base
> +    * address of any flash mapping. In practice, the IO-APIC MMIO range is
> +    * [0xFEE00000..0xFEE01000] -- see IO_APIC_DEFAULT_ADDRESS --, leaving free
> +    * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8MB in
> +    * size.
> +    */
> +    if (value > 16 * MiB) {
> +        error_setg(errp,
> +                   "User specified max allowed firmware size %" PRIu64 " is "
> +                   "greater than 16MiB. If combined firwmare size exceeds "
> +                   "16MiB the system may not boot, or experience intermittent"
> +                   "stability issues.",
> +                   value);

(1) Please put a "return" statement here.

> +    }
> +
> +    pcms->max_fw_size = value;
> +}
> +
>  static void pc_machine_initfn(Object *obj)
>  {
>      PCMachineState *pcms = PC_MACHINE(obj);
> @@ -1884,6 +1927,7 @@ static void pc_machine_initfn(Object *obj)
>      pcms->smbus_enabled = true;
>      pcms->sata_enabled = true;
>      pcms->pit_enabled = true;
> +    pcms->max_fw_size = 8 * MiB; /* use default */

(2) While I'm not 100% certain, I suspect that the /* use default */
comment is not justified here.

The model is of course

    pcms->max_ram_below_4g = 0; /* use default */

but there, the value we set in pc_machine_initfn() has a different
meaning -- zero is stored deliberately so that the machine type specific
logic in "hw/i386/pc_piix.c" and "hw/i386/pc_q35.c" *overwrite* it.

"hw/i386/pc_piix.c":

        if (!pcms->max_ram_below_4g) {
            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
        }

"hw/i386/pc_q35.c":

    if (!pcms->max_ram_below_4g) {
        pcms->max_ram_below_4g = 4 * GiB;
    }

In other words, the comment "use default" in pc_machine_initfn()
actually means "defer to the i440fx/q35-specific default".

And that's not what we're doing with "max_fw_size".

All I'm saying is that the "/* use default */" comment should not be
copied from "max_ram_below_4g" to "max_fw_size", because the (assumed)
meaning of the original comment does not apply to the new field.

CC'ing Gerd wrt. (2).


With (1) fixed, and with (2) optionally fixed:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo

>  
>      pc_system_flash_create(pcms);
>      pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
> @@ -2004,6 +2048,12 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
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
> index b6c0822fe3..22450ba0ef 100644
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
> index fe52e165b2..f7c8e7cbfe 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -43,6 +43,7 @@ struct PCMachineState {
>      bool smbus_enabled;
>      bool sata_enabled;
>      bool pit_enabled;
> +    uint64_t max_fw_size;
>  
>      /* NUMA information: */
>      uint64_t numa_nodes;
> @@ -59,6 +60,7 @@ struct PCMachineState {
>  #define PC_MACHINE_SMBUS            "smbus"
>  #define PC_MACHINE_SATA             "sata"
>  #define PC_MACHINE_PIT              "pit"
> +#define PC_MACHINE_MAX_FW_SIZE      "max-fw-size"
>  
>  /**
>   * PCMachineClass:
> 



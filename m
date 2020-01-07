Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5854FC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C782073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLAcxNJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C782073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iorSx-0005kk-WE
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iorS3-0005B2-Iq
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:11:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iorS0-00035c-Qv
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:11:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51162
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iorS0-00034b-Di
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578413483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=jg4pELUbMj/txjaK60OtrFfCsilDjBsdo2cMaqc7aeQ=;
 b=HLAcxNJFFTUUL3QDS8tFzI2RJY0YemHciRGiUE3cf0NoO5qZo6xe02fzFMN7ie8yjPtJ2q
 JfSG1wZHjVyEvhz3zjQDm30czSdBRSgmmQZWiOnBUBgpH2INEXJMzwSTSuN8vdEoWMyIr5
 TQQh+j0yTbl3tAxYvbEL5sRVkGJK2pk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-H3hasu00P9SH2KGyPlP9cA-1; Tue, 07 Jan 2020 11:11:21 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7D481800D4E
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 16:11:19 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-116.ams2.redhat.com [10.36.116.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E49531001920;
 Tue,  7 Jan 2020 16:11:18 +0000 (UTC)
Subject: Re: [PATCH 49/86] m68k:an5206: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-50-git-send-email-imammedo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c94dde83-4fbe-7d02-6fee-f0fe3bce55f9@redhat.com>
Date: Tue, 7 Jan 2020 17:11:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1577797450-88458-50-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: H3hasu00P9SH2KGyPlP9cA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/12/2019 14.03, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/m68k/an5206.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
> index 54ccbe1..69a8ffa 100644
> --- a/hw/m68k/an5206.c
> +++ b/hw/m68k/an5206.c
> @@ -33,7 +33,6 @@ static void an5206_init(MachineState *machine)
>      uint64_t elf_entry;
>      hwaddr entry;
>      MemoryRegion *address_space_mem = get_system_memory();
> -    MemoryRegion *ram = g_new(MemoryRegion, 1);
>      MemoryRegion *sram = g_new(MemoryRegion, 1);
>  
>      cpu = M68K_CPU(cpu_create(machine->cpu_type));
> @@ -46,8 +45,7 @@ static void an5206_init(MachineState *machine)
>      env->rambar0 = AN5206_RAMBAR_ADDR | 1;
>  
>      /* DRAM at address zero */
> -    memory_region_allocate_system_memory(ram, NULL, "an5206.ram", ram_size);
> -    memory_region_add_subregion(address_space_mem, 0, ram);
> +    memory_region_add_subregion(address_space_mem, 0, machine->ram);
>  
>      /* Internal SRAM.  */
>      memory_region_init_ram(sram, NULL, "an5206.sram", 512, &error_fatal);
> @@ -89,6 +87,7 @@ static void an5206_machine_init(MachineClass *mc)
>      mc->desc = "Arnewsh 5206";
>      mc->init = an5206_init;
>      mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5206");
> +    mc->default_ram_id = "an5206.ram";
>  }
>  
>  DEFINE_MACHINE("an5206", an5206_machine_init)
> 

Acked-by: Thomas Huth <thuth@redhat.com>



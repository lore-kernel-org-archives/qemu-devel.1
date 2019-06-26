Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113FFC48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 08:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E374F20B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 08:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E374F20B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg2sl-0003QC-88
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 04:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39718)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hg2pe-0001sl-Rd
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hg2pd-0004sg-Oo
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:59:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hg2pd-0004sE-Hu
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:59:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id c85so931210pfc.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 00:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=0zwfrZJlxdbQyl8WOSwwjOIw8/aUFJ5nRNTQ7k14DRo=;
 b=GmEMcw5ovQE1yzCce+uOEEm9MFfOFsXREMZxf74Rt1nXokwjAmqiLpjzPX0CMpvUri
 pN46NfP7FYX+Pt61uXFpoV2NxtnQzNuNuFvyOlGRbCVMeJRtQ2stJiLimXVzpkNE/4on
 DTqEM60J8aM+PgjtZw8NEIECDetyzy0tRQVUrLtWx30IJ7Cnkef+IyOBV0Ar/IFk4iyf
 Bh8Bcpc/RYYKjE5pk9cGF6YHNi924hGWoreFZSQaFNDKyFf/pzxC8oL2uxvebZHR6nDF
 3JiNvqgs16kdzFzo4xrYGoHvkzCzZLV3OZGBN4BiGErpU85OMXa80vnDQ5Pwazw44uc9
 krhg==
X-Gm-Message-State: APjAAAWfJRqRALASU02Xbv1M+Y1xf4fjH3EWlPS56dzP0wJ+HkVb1TfD
 if2UgvhwhgCATWsoq0MGzTp31g==
X-Google-Smtp-Source: APXvYqyR01nS/gZO1ChSG7McBHzUreq6FjXHGwXyWHefUwnUR0y4PLxoW1CvwTossJAK5apYYjSa6g==
X-Received: by 2002:a63:5d54:: with SMTP id o20mr1570807pgm.97.1561535944230; 
 Wed, 26 Jun 2019 00:59:04 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id k3sm15450599pgo.81.2019.06.26.00.59.03
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 26 Jun 2019 00:59:03 -0700 (PDT)
Date: Wed, 26 Jun 2019 00:59:03 -0700 (PDT)
X-Google-Original-Date: Wed, 26 Jun 2019 00:58:39 PDT (-0700)
In-Reply-To: <f0e0ab118a46b81351cfa833c13d0791d203de2d.camel@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-3e4dd9ae-754c-4563-a19d-3dcfbcb9fcbf@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.196
Subject: Re: [Qemu-devel] [PATCH 2/2] riscv: sifive_u: Update the plic hart
 config to support multicore
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
Cc: bmeng.cn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 May 2019 14:35:56 PDT (-0700), Alistair Francis wrote:
> On Fri, 2019-05-17 at 08:51 -0700, Bin Meng wrote:
>> At present the PLIC is instantiated to support only one hart, while
>> the machine allows at most 4 harts to be created. When more than 1
>> hart is configured, PLIC needs to instantiated to support multicore,
>> otherwise an SMP OS does not work.
>> 
>> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

I got this one as well.

> 
> Alistair
> 
>> ---
>> 
>>  hw/riscv/sifive_u.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>> 
>> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
>> index e2120ac..a416d5d 100644
>> --- a/hw/riscv/sifive_u.c
>> +++ b/hw/riscv/sifive_u.c
>> @@ -344,6 +344,8 @@ static void
>> riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>>      MemoryRegion *system_memory = get_system_memory();
>>      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>>      qemu_irq plic_gpios[SIFIVE_U_PLIC_NUM_SOURCES];
>> +    char *plic_hart_config;
>> +    size_t plic_hart_config_len;
>>      int i;
>>      Error *err = NULL;
>>      NICInfo *nd = &nd_table[0];
>> @@ -357,9 +359,21 @@ static void
>> riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>>      memory_region_add_subregion(system_memory,
>> memmap[SIFIVE_U_MROM].base,
>>                                  mask_rom);
>>  
>> +    /* create PLIC hart topology configuration string */
>> +    plic_hart_config_len = (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1) *
>> smp_cpus;
>> +    plic_hart_config = g_malloc0(plic_hart_config_len);
>> +    for (i = 0; i < smp_cpus; i++) {
>> +        if (i != 0) {
>> +            strncat(plic_hart_config, ",", plic_hart_config_len);
>> +        }
>> +        strncat(plic_hart_config, SIFIVE_U_PLIC_HART_CONFIG,
>> +                plic_hart_config_len);
>> +        plic_hart_config_len -= (strlen(SIFIVE_U_PLIC_HART_CONFIG) +
>> 1);
>> +    }
>> +
>>      /* MMIO */
>>      s->plic = sifive_plic_create(memmap[SIFIVE_U_PLIC].base,
>> -        (char *)SIFIVE_U_PLIC_HART_CONFIG,
>> +        plic_hart_config,
>>          SIFIVE_U_PLIC_NUM_SOURCES,
>>          SIFIVE_U_PLIC_NUM_PRIORITIES,
>>          SIFIVE_U_PLIC_PRIORITY_BASE,


Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9458AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:13:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52EEA206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pu+z/GHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EEA206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZCkL-0001fC-Es
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 08:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZCjk-0001FH-PU
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:13:16 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZCjj-0000k6-HM
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:13:16 -0400
Received: by mail-wr1-x443.google.com with SMTP id j5so3762857wrq.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 05:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=K87U8Ru8lIDFqCvcgFYQYF/pxC8jZfOxyBt6Kv9xdG0=;
 b=pu+z/GHb9pVikutIJCNQmg97eQzdZQSeiQNotNFSnx8NstnGG0K3fTeNQTNUm1+CPN
 iZGp1EZopuB4YOmgNKkUel+O7OLk65ZMr7jXXSrCY0XIOe5sa8zHoohsG15bTGI1u0IY
 COSb8VcgVf3mSgR74JlBd9oDuYr3o1VGpcFHpaRi83vxEqgqBC5kcaUaYij6WOd5viuD
 BjARqCuqwu/navN8q537CzcysI957GDsWjW64kx7ly9sqNzCrGomzi5a36qSu80ZuJSn
 S2VoH12IeqAZXqML/OsQTccAooPe7iDXUlo2h/YTj8fRAC2ZR9Y1j3IguMDWCdXuakDl
 OXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K87U8Ru8lIDFqCvcgFYQYF/pxC8jZfOxyBt6Kv9xdG0=;
 b=YN3tybIP+QYTXSs4DS1YvGBLvKVJLEznpXhv+Zt3qbvO7DhdKXX6IZx8K7vGo71kng
 2+B/hdw8BL5OYr4Ihfoa8/ApDlejeFBO4cqum2X3kRHnnDEtGgN+dPeaaUcTxbAVGnYB
 VSSFzu62LL8MaSiw5y9dH9PCKiXMwXDX5IurInC+sst3GQ7zB7BsntYZx3WMSlK3O7QT
 K79DyJLUaYRPj/enSxVfYoOpIVIEuUft2smPR/Tc3nxQgaG65JnZosU1rsytuRL/NBaO
 64ufzyps7Xqp9g2g7bmzHnxNZ7Uv6W568wrgo/j5G4Ij0CbO4go5Zbea0YWLVRJJOSxG
 NiQg==
X-Gm-Message-State: AOAM531Fem1z7yZyFb0Zz60SgEpeBzC6eS8ZnN1oRSrpztKvsrXEMu+v
 Miv8XYBZBpxVQSSiVbB0yv8=
X-Google-Smtp-Source: ABdhPJzjtZ1wiJlCWnOXezUe+g7I78ceUxsgAWeiEmYrMS2+rtAYik8fphp0VbOnZqzmJvkY4s3S9w==
X-Received: by 2002:a5d:4b0f:: with SMTP id v15mr5069037wrq.162.1589458393302; 
 Thu, 14 May 2020 05:13:13 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id a15sm3643226wrw.56.2020.05.14.05.13.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2020 05:13:12 -0700 (PDT)
Subject: Re: [RFC PATCH] hw/sparc/sun4m: Use memdev backend for main RAM
To: Igor Mammedov <imammedo@redhat.com>
References: <20200510113505.10500-1-f4bug@amsat.org>
 <20200514120951.3588bc30@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <58238d26-a9dc-0cc0-749d-6230d2646f75@amsat.org>
Date: Thu, 14 May 2020 14:13:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514120951.3588bc30@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 12:09 PM, Igor Mammedov wrote:
> On Sun, 10 May 2020 13:35:05 +0200
> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> 
>> Since commit 82b911aaff3, machine_run_board_init() checks for
>> ram_memdev_id and consume it. As TYPE_SUN4M_MEMORY is no more
>> needed, replace it by the generic memdev allocated MemoryRegion
>> and remove it. This completes commit b2554752b1da7c8f.
> 
> I don't get justification here.
> You are removing 'frontend' device model that has little/nothing
> to do with how backend is instantiated.
> 
> TYPE_SUN4M_MEMORY is analog to pc-dimm, only for builtin RAM
> (not really useful but could serve as an example).

I have no idea about the benefits of using memory frontend/backend with 
emulation. Is there documentation and examples? I'm seeing this code as 
a complicated way of doing a simple thing, but I guess I'm missing the 
big picture here.

> It's fine to drop it as it doesn't accually do much
> and map memory region directly like we do elsewhere for builtin RAM
> and get rid of TYPE_SUN4M_MEMORY boiler-plate code.
> 
> with such reasoning, I'd Ack it, but the final say belongs to board maintainers
> 
> 
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/sparc/sun4m.c | 54 ++----------------------------------------------
>>   1 file changed, 2 insertions(+), 52 deletions(-)
>>
>> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
>> index 36ee1a0a3d..9838c5a183 100644
>> --- a/hw/sparc/sun4m.c
>> +++ b/hw/sparc/sun4m.c
>> @@ -772,50 +772,6 @@ static const TypeInfo prom_info = {
>>       .class_init    = prom_class_init,
>>   };
>>   
>> -#define TYPE_SUN4M_MEMORY "memory"
>> -#define SUN4M_RAM(obj) OBJECT_CHECK(RamDevice, (obj), TYPE_SUN4M_MEMORY)
>> -
>> -typedef struct RamDevice {
>> -    SysBusDevice parent_obj;
>> -    HostMemoryBackend *memdev;
>> -} RamDevice;
>> -
>> -/* System RAM */
>> -static void ram_realize(DeviceState *dev, Error **errp)
>> -{
>> -    RamDevice *d = SUN4M_RAM(dev);
>> -    MemoryRegion *ram = host_memory_backend_get_memory(d->memdev);
>> -
>> -    sysbus_init_mmio(SYS_BUS_DEVICE(dev), ram);
>> -}
>> -
>> -static void ram_initfn(Object *obj)
>> -{
>> -    RamDevice *d = SUN4M_RAM(obj);
>> -    object_property_add_link(obj, "memdev", TYPE_MEMORY_BACKEND,
>> -                             (Object **)&d->memdev,
>> -                             object_property_allow_set_link,
>> -                             OBJ_PROP_LINK_STRONG, &error_abort);
>> -    object_property_set_description(obj, "memdev", "Set RAM backend"
>> -                                    "Valid value is ID of a hostmem backend",
>> -                                     &error_abort);
>> -}
>> -
>> -static void ram_class_init(ObjectClass *klass, void *data)
>> -{
>> -    DeviceClass *dc = DEVICE_CLASS(klass);
>> -
>> -    dc->realize = ram_realize;
>> -}
>> -
>> -static const TypeInfo ram_info = {
>> -    .name          = TYPE_SUN4M_MEMORY,
>> -    .parent        = TYPE_SYS_BUS_DEVICE,
>> -    .instance_size = sizeof(RamDevice),
>> -    .instance_init = ram_initfn,
>> -    .class_init    = ram_class_init,
>> -};
>> -
>>   static void cpu_devinit(const char *cpu_type, unsigned int id,
>>                           uint64_t prom_addr, qemu_irq **cpu_irqs)
>>   {
>> @@ -858,8 +814,6 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>>       SysBusDevice *s;
>>       unsigned int smp_cpus = machine->smp.cpus;
>>       unsigned int max_cpus = machine->smp.max_cpus;
>> -    Object *ram_memdev = object_resolve_path_type(machine->ram_memdev_id,
>> -                                                  TYPE_MEMORY_BACKEND, NULL);
>>   
>>       if (machine->ram_size > hwdef->max_mem) {
>>           error_report("Too much memory for this machine: %" PRId64 ","
>> @@ -876,11 +830,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>>       for (i = smp_cpus; i < MAX_CPUS; i++)
>>           cpu_irqs[i] = qemu_allocate_irqs(dummy_cpu_set_irq, NULL, MAX_PILS);
>>   
>> -    /* Create and map RAM frontend */
>> -    dev = qdev_create(NULL, "memory");
>> -    object_property_set_link(OBJECT(dev), ram_memdev, "memdev", &error_fatal);
>> -    qdev_init_nofail(dev);
>> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0);
>> +    /* RAM */
>> +    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
>>   
>>       /* models without ECC don't trap when missing ram is accessed */
>>       if (!hwdef->ecc_base) {
>> @@ -1575,7 +1526,6 @@ static void sun4m_register_types(void)
>>       type_register_static(&idreg_info);
>>       type_register_static(&afx_info);
>>       type_register_static(&prom_info);
>> -    type_register_static(&ram_info);
>>   
>>       type_register_static(&ss5_type);
>>       type_register_static(&ss10_type);
> 
> 


Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F22EC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 17:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78BAA2074A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 17:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u83Ne1vv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BAA2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTqDZ-0008OQ-9w
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 13:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTqA3-0006VO-5U; Sat, 17 Oct 2020 13:38:34 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTqA0-0001kJ-VN; Sat, 17 Oct 2020 13:38:30 -0400
Received: by mail-wr1-x442.google.com with SMTP id j7so2843167wrt.9;
 Sat, 17 Oct 2020 10:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KuEYCGFH8gjp+8Ls6mQNWt3KwF5OST9pKx9d2hlW3yE=;
 b=u83Ne1vvo6WKQCkaa1O/gwjlBVtyx5Q5l+epoCdhKo1cB+X2jy1tFPdW/UqUb7PRC6
 0MLEd2A1ZLWtoWs0yzVNPlrdcx+xSZXFuaYewwjX/beqQxvkl2KhtVnXC6y6aLlrc8zI
 35oO2YHjRWGfEqZSwvwhLd/V5arnA2ZjHjya9WGF47r18vbuohbGV/Yon3IGV2RMT9mO
 GTL+vAy+hBnaVijL+JDXokdZCXDIwXcO+N/AfaeuA8nPNqcFEPEFtS0bsUrkPpcXzk6F
 QQfBm1Ho7L+jzhs+ih0bgVtddm0Pj8dB4usF+TZ89OZfwlBTMB9Nhn16jWnoFABCkkdT
 Z0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KuEYCGFH8gjp+8Ls6mQNWt3KwF5OST9pKx9d2hlW3yE=;
 b=rMch89oxrtKni6eu972qYhUTR9InLt3JqiHWB8CdfOeU624qyWJfHHRZ8oG4FbWRr1
 PY8LwPZlRdD42JD6cRe6GbU5ihBHzcHKbVnZLlBwBwO/hxK3exTu2pP+P9ojSsyf+NED
 OvXKKJHmPqLiVFDX8wUG7KPc1Qu4Ry8S47fQw+Rw5f7BAKjRWhMNxxjW363fNS/fcscC
 w6SsG+2/WJTSRQokdNKyH5Z2cUmgnG2jAbP6q3c99LeJADPMdBhUlRpYpXv+6XvH7oCu
 N8Bh4rEw6g2WOwpHLBp0Do/4wHb0X9xO1/W/ka4MgzALIxdnp/t8FFIdIB2kGH3mkOMm
 x7xQ==
X-Gm-Message-State: AOAM531jV/L1m0BK8KMXmgTBjOSd+R/3bU3IY6pWehqLl706OcoMDJc2
 HD0IE6i24P6IUmNLytfYjNeYmNYQvrI=
X-Google-Smtp-Source: ABdhPJwmFszSFr/tnFtM3YH8R76XzCopuPko75lBYDn6PncjLyrf8FFjYJpoQPyspGoSUp0o2b7fNA==
X-Received: by 2002:a5d:4e8d:: with SMTP id e13mr11070104wru.368.1602956306108; 
 Sat, 17 Oct 2020 10:38:26 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id c15sm4274382wmb.27.2020.10.17.10.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 10:38:25 -0700 (PDT)
Subject: Re: [PATCH v9] mac_oldworld: Allow loading binary ROM image
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20201017155139.5A36A746331@zero.eik.bme.hu>
 <11c1edab-bcbe-bb02-7c53-b4b0707779c2@amsat.org>
 <146aa146-80e9-6cea-fbda-ccca6e47d33@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <348bb0e5-dee2-1d4d-0fb5-bf6d56ef5706@amsat.org>
Date: Sat, 17 Oct 2020 19:38:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <146aa146-80e9-6cea-fbda-ccca6e47d33@eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.247,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alistair Francis <alistair@alistair23.me>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/20 6:31 PM, BALATON Zoltan via wrote:
> On Sat, 17 Oct 2020, Philippe Mathieu-Daudé wrote:
>> +Alistair for loader
>>
>> On 10/17/20 5:47 PM, BALATON Zoltan via wrote:
>>> The beige G3 Power Macintosh has a 4MB firmware ROM. Fix the size of
>>> the rom region and fall back to loading a binary image with -bios if
>>> loading ELF image failed. This allows testing emulation with a ROM
>>> image from real hardware as well as using an ELF OpenBIOS image.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>> v9: Revert change from v8, back to the same as v7 rebased on latest
>>>
>>>   hw/ppc/mac_oldworld.c | 29 ++++++++++++++++++++---------
>>>   1 file changed, 20 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
>>> index 05e46ee6fe..0117ae17f5 100644
>>> --- a/hw/ppc/mac_oldworld.c
>>> +++ b/hw/ppc/mac_oldworld.c
>>> @@ -59,6 +59,8 @@
>>>   #define NDRV_VGA_FILENAME "qemu_vga.ndrv"
>>>     #define GRACKLE_BASE 0xfec00000
>>> +#define PROM_BASE 0xffc00000
>>> +#define PROM_SIZE (4 * MiB)
>>>     static void fw_cfg_boot_set(void *opaque, const char *boot_device,
>>>                               Error **errp)
>>> @@ -100,6 +102,7 @@ static void ppc_heathrow_init(MachineState *machine)
>>>       SysBusDevice *s;
>>>       DeviceState *dev, *pic_dev;
>>>       BusState *adb_bus;
>>> +    uint64_t bios_addr;
>>>       int bios_size;
>>>       unsigned int smp_cpus = machine->smp.cpus;
>>>       uint16_t ppc_boot_device;
>>> @@ -128,24 +131,32 @@ static void ppc_heathrow_init(MachineState 
>>> *machine)
>>>         memory_region_add_subregion(sysmem, 0, machine->ram);
>>>   -    /* allocate and load BIOS */
>>> -    memory_region_init_rom(bios, NULL, "ppc_heathrow.bios", BIOS_SIZE,
>>> +    /* allocate and load firmware ROM */
>>> +    memory_region_init_rom(bios, NULL, "ppc_heathrow.bios", PROM_SIZE,
>>>                              &error_fatal);
>>> +    memory_region_add_subregion(sysmem, PROM_BASE, bios);
>>>   -    if (bios_name == NULL)
>>> +    if (!bios_name) {
>>>           bios_name = PROM_FILENAME;
>>> +    }
>>>       filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>>> -    memory_region_add_subregion(sysmem, PROM_ADDR, bios);
>>> -
>>> -    /* Load OpenBIOS (ELF) */
>>>       if (filename) {
>>> -        bios_size = load_elf(filename, NULL, 0, NULL, NULL, NULL, 
>>> NULL, NULL,
>>> -                             1, PPC_ELF_MACHINE, 0, 0);
>>> +        /* Load OpenBIOS (ELF) */
>>> +        bios_size = load_elf(filename, NULL, NULL, NULL, NULL, 
>>> &bios_addr,
>>> +                             NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
>>> +        /* Unfortunately, load_elf sign-extends reading elf32 */
>>
>> Maybe this is what translate_fn() is for?
>>
>> uint64_t oldworld_phys(void *opaque, uint64_t addr)
>> {
>>    return addr & UINT32_MAX;
>> }
>>
>> Using as (untested):
>>
>>        bios_size = load_elf(filename, NULL, oldworld_phys, NULL,
>>                             NULL, &bios_addr, NULL,
>>                             NULL, 1, PPC_ELF_MACHINE, 0, 0);
> 
> Please don't come up with any more great ideas for this patch unless you 
> also propose a replacement and test it. This one works and we could just 
> get this in as it is until the real problem with load_elf is fixed at 
> which point all this can be removed so no need to be more sophisticated 
> as the simple cast I have.

Zoltan, I'm not trying to block your patch to get merged,
I'm asking because I'm trying to understand how this API
is expected to be used.

> As you can see in the original discussion:
> 
> http://patchwork.ozlabs.org/project/qemu-devel/patch/c69a791c7cad1246f3f34b3993dee4f549b75aa2.1593456926.git.balaton@eik.bme.hu/ 
> 
> 
> problem is really in include/hw/elf_ops.h this is just a work around for 
> that as I did not want to break anything I can't test so I'd rather fix 
> it up here and let you fix load_elf then drop this cast. But unless you 
> can do that before the freeze please don't hold up this patch any more.
> 
> Regards,
> BALATON Zoltan
> 
>>> +        bios_addr = (uint32_t)bios_addr;
>>> +
>>> +        if (bios_size <= 0) {
>>> +            /* or load binary ROM image */
>>> +            bios_size = load_image_targphys(filename, PROM_BASE, 
>>> PROM_SIZE);
>>> +            bios_addr = PROM_BASE;
>>> +        }
>>>           g_free(filename);
>>>       } else {
>>>           bios_size = -1;
>>>       }
>>> -    if (bios_size < 0 || bios_size > BIOS_SIZE) {
>>> +    if (bios_size < 0 || bios_addr - PROM_BASE + bios_size > 
>>> PROM_SIZE) {
>>>           error_report("could not load PowerPC bios '%s'", bios_name);
>>>           exit(1);
>>>       }
>>>
>>
>>
>>


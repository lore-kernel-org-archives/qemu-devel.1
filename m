Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE250C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 17:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B45BF2089E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 17:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45BF2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36948 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heN0J-0001LJ-RT
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 13:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45748)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1heMZ0-0004nN-7Q
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1heMYy-00013M-9P
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:38:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1heMYw-0000wn-Bc
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:38:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so6890980wmj.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 09:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SxFkDQ30w85owKderyiBuNZH71h2AvOJdVXytaPwQdU=;
 b=HHiyQKcFlz8kPhytWZ7IY9YtBYiF9oqlrLOvSp9YjMnAWKRWj2KVhwvinO19B41mp/
 U7g+Q2141/467LYZ9YM5QVhzbZQk/2B8PDWPkEMeMDU9swmnsaPL4jPz+v5QhQqP5kYB
 edLlv62+Vt8xRVOP5oCFE7GqirPzJYFkFyLmSLjqDN0cI/xKgAcG7rrLl7DFNaVIo/QH
 FGa8hwpJYdiNk1MmFrKYCW4GgRl4QVehFQ4P6vG48u4cGuWZ9Tk39Ao4AREgc9U6DMHR
 w6a3eZubQ9XtEv9unMcLYo9R2n4pc7Uv/LAi8pl10id4ZVDpP7VxvckpnhT0FOAeJxqE
 INsg==
X-Gm-Message-State: APjAAAWnPdKnQjqME3FS4mDQ6cRD/4kKT/hy6SVWxqFcuMuYOPdARNsD
 5++shVlLhV6T+3KYXydkSGkZjw==
X-Google-Smtp-Source: APXvYqzGpaqi6Ykg/Glhwvn0AfdTA4LxEdNpU/qGuM8CtKrjB8qut5VxaAhNrcZtqL8ktb9PbFT3iA==
X-Received: by 2002:a05:600c:2388:: with SMTP id
 m8mr4494159wma.23.1561135132753; 
 Fri, 21 Jun 2019 09:38:52 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id f1sm3115869wml.28.2019.06.21.09.38.51
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 09:38:52 -0700 (PDT)
To: Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
References: <cover.1560919807.git.alistair@alistair23.me>
 <PSXP216MB0277171F4F3978296BE895F2DDE50@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4c619c3a-8567-be68-5d4d-eda0ff5b566f@redhat.com>
Date: Fri, 21 Jun 2019 18:38:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <PSXP216MB0277171F4F3978296BE895F2DDE50@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v3 2/6] target/arm: Allow setting M mode
 entry and sp
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
Cc: "alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On 6/19/19 6:54 AM, Alistair Francis wrote:
> Add M mode initial entry PC and SP properties.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  target/arm/cpu.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/cpu.h |  3 +++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 376db154f0..1d83972ab1 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -301,6 +301,9 @@ static void arm_cpu_reset(CPUState *s)
>               */
>              initial_msp = ldl_p(rom);
>              initial_pc = ldl_p(rom + 4);
> +        } else if (cpu->init_sp || cpu->init_entry) {
> +            initial_msp = cpu->init_sp;
> +            initial_pc = cpu->init_entry;
>          } else {
>              /* Address zero not covered by a ROM blob, or the ROM blob
>               * is in non-modifiable memory and this is a second reset after
> @@ -801,6 +804,38 @@ static void arm_set_init_svtor(Object *obj, Visitor *v, const char *name,
>      visit_type_uint32(v, name, &cpu->init_svtor, errp);
>  }
>  
> +static void arm_get_init_sp(Object *obj, Visitor *v, const char *name,
> +                            void *opaque, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    visit_type_uint32(v, name, &cpu->init_sp, errp);
> +}
> +
> +static void arm_set_init_sp(Object *obj, Visitor *v, const char *name,
> +                            void *opaque, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    visit_type_uint32(v, name, &cpu->init_sp, errp);
> +}
> +
> +static void arm_get_init_entry(Object *obj, Visitor *v, const char *name,
> +                            void *opaque, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    visit_type_uint32(v, name, &cpu->init_entry, errp);
> +}
> +
> +static void arm_set_init_entry(Object *obj, Visitor *v, const char *name,
> +                            void *opaque, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    visit_type_uint32(v, name, &cpu->init_entry, errp);
> +}
> +
>  void arm_cpu_post_init(Object *obj)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
> @@ -913,6 +948,18 @@ void arm_cpu_post_init(Object *obj)
>          object_property_add(obj, "init-svtor", "uint32",
>                              arm_get_init_svtor, arm_set_init_svtor,
>                              NULL, NULL, &error_abort);
> +    } else {
> +        /*
> +         * M profile: initial value of the SP and entry. We can't just use
> +         * a simple DEFINE_PROP_UINT32 for this because we want to permit
> +         * the property to be set after realize.
> +         */

This comment is mostly a copy of the other if() branch, maybe you can
extract one generic comment for the 2 cases.

> +        object_property_add(obj, "init-sp", "uint32",
> +                            arm_get_init_sp, arm_set_init_sp,
> +                            NULL, NULL, &error_abort);
> +        object_property_add(obj, "init-entry", "uint32",
> +                            arm_get_init_entry, arm_set_init_entry,
> +                            NULL, NULL, &error_abort);

I'm having difficulties to test your patch :( I tried:

$ arm-softmmu/qemu-system-arm -M emcraft-sf2 \
  -device loader,file=/networking.uImage,cpu-num=0 \
  -d in_asm,int,mmu \
  -global cpu.init-sp=0x2000fff0 \
  -global cpu.init-entry=0xa0008001
PMSA MPU lookup for execute at 0xa0008000 mmu_idx 65 -> Miss (prot rw-)
Taking exception 3 [Prefetch Abort]
...with CFSR.IACCVIOL
PMSA MPU lookup for writing at 0x2000ffd0 mmu_idx 65 -> Hit (prot rwx)
PMSA MPU lookup for writing at 0x2000ffd4 mmu_idx 65 -> Hit (prot rwx)
PMSA MPU lookup for writing at 0x2000ffd8 mmu_idx 65 -> Hit (prot rwx)
PMSA MPU lookup for writing at 0x2000ffdc mmu_idx 65 -> Hit (prot rwx)
PMSA MPU lookup for writing at 0x2000ffe0 mmu_idx 65 -> Hit (prot rwx)
PMSA MPU lookup for writing at 0x2000ffe4 mmu_idx 65 -> Hit (prot rwx)
PMSA MPU lookup for writing at 0x2000ffe8 mmu_idx 65 -> Hit (prot rwx)
PMSA MPU lookup for writing at 0x2000ffec mmu_idx 65 -> Hit (prot rwx)
...taking pending nonsecure exception 3
PMSA MPU lookup for execute at 0x00000000 mmu_idx 67 -> Hit (prot rwx)
----------------
IN:
PMSA MPU lookup for reading at 0x00000000 mmu_idx 67 -> Hit (prot rwx)
0x00000000:  00000000  andeq    r0, r0, r0

Taking exception 18 [v7M INVSTATE UsageFault]
qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)

R00=00000000 R01=00000000 R02=00000000 R03=00000000
R04=00000000 R05=00000000 R06=00000000 R07=00000000
R08=00000000 R09=00000000 R10=00000000 R11=00000000
R12=00000000 R13=2000ffd0 R14=fffffff9 R15=00000000
XPSR=40000003 -Z-- A handler
FPSCR: 00000000
Aborted (core dumped)

(same without setting cpu.init-entry).

Downloaded "Prebuilt Linux image ready to be loaded to the M2S-FG484
SOM" here: https://emcraft.com/products/255#software

$ file networking.uImage
networking.uImage: u-boot legacy uImage, Linux-2.6.33-cortexm-1.14.3,
Linux/ARM, OS Kernel Image (Not compressed), 2299232 bytes, Wed Nov 11
14:19:53 2015, Load Address: 0xA0008000, Entry Point: 0xA0008001, Header
CRC: 0x419AA120, Data CRC: 0x1C34C4BE

This board memory map is:

(qemu) info mtree
address-space: memory
  0000000000000000-ffffffffffffffff (prio -1, i/o): system
    0000000000000000-000000000003ffff (prio 0, i/o): alias MSF2.eNVM
    0000000020000000-000000002000ffff (prio 0, ram): MSF2.eSRAM
    0000000040000000-000000004000001f (prio 0, i/o): serial
    0000000040001000-000000004000103f (prio 0, i/o): mss-spi
    0000000040002000-0000000040002fff (prio -1000, i/o): i2c_0
    0000000040003000-0000000040003fff (prio -1000, i/o): dma
    0000000040004000-000000004000402f (prio 0, i/o): mss-timer
    0000000040005000-0000000040005fff (prio -1000, i/o): watchdog
    0000000040011000-000000004001103f (prio 0, i/o): mss-spi
    0000000040012000-0000000040012fff (prio -1000, i/o): i2c_1
    0000000040013000-0000000040013fff (prio -1000, i/o): gpio
    0000000040014000-0000000040014fff (prio -1000, i/o): hs-dma
    0000000040015000-0000000040015fff (prio -1000, i/o): can
    0000000040017000-0000000040017fff (prio -1000, i/o): rtc
    0000000040020000-000000004002ffff (prio -1000, i/o): apb_config
    0000000040038000-00000000400382ff (prio 0, i/o): msf2-sysreg
    0000000040041000-0000000040041fff (prio -1000, i/o): emac
    0000000040043000-0000000040043fff (prio -1000, i/o): usb
    0000000060000000-000000006003ffff (prio 0, rom): MSF2.eNVM
    00000000a0000000-00000000a3ffffff (prio 0, ram): ddr-ram

So I set cpu.init-sp close to the end of the SRAM (0x2000fff0).

Without your patch:

PMSA MPU lookup for execute at 0xa0008000 mmu_idx 65 -> Miss (prot rw-)
Taking exception 3 [Prefetch Abort]
...with CFSR.IACCVIOL
PMSA MPU lookup for writing at 0xffffffe0 mmu_idx 65 -> Hit (prot rw-)
...BusFault with BFSR.STKERR
...taking pending nonsecure exception 3
PMSA MPU lookup for execute at 0x00000000 mmu_idx 67 -> Hit (prot rwx)
----------------
IN:
PMSA MPU lookup for reading at 0x00000000 mmu_idx 67 -> Hit (prot rwx)
0x00000000:  00000000  andeq    r0, r0, r0

Taking exception 18 [v7M INVSTATE UsageFault]
qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)

R00=00000000 R01=00000000 R02=00000000 R03=00000000
R04=00000000 R05=00000000 R06=00000000 R07=00000000
R08=00000000 R09=00000000 R10=00000000 R11=00000000
R12=00000000 R13=ffffffe0 R14=fffffff9 R15=00000000
XPSR=40000003 -Z-- A handler
FPSCR: 00000000
Aborted (core dumped)

304             } else if (cpu->init_sp || cpu->init_entry) {
(gdb)
305                 initial_msp = cpu->init_sp;
(gdb)
306                 initial_pc = cpu->init_entry;
(gdb)
317             env->regs[13] = initial_msp & 0xFFFFFFFC;
(gdb) p/x initial_msp
$1 = 0x2000fff0
(gdb) p/x initial_pc
$2 = 0xa0008001
(gdb) n
318             env->regs[15] = initial_pc & ~1;
(gdb)
319             env->thumb = initial_pc & 1;

I don't understand where I get $pc reset...

>      }
>  
>      qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index f9da672be5..290fac19d3 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -805,6 +805,9 @@ struct ARMCPU {
>       */
>      uint32_t psci_conduit;
>  
> +    /* For M, initial value of the entry and SP */
> +    uint32_t init_sp, init_entry;
> +
>      /* For v8M, initial value of the Secure VTOR */
>      uint32_t init_svtor;
>  
> 


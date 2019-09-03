Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBF6C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144B02341F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144B02341F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i59KN-0004HL-Ey
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i5906-0003lx-KH
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i5905-0007MP-Aw
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:37:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42730)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i5905-0007M6-3U
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:37:37 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2FA672CE905
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2019 13:37:36 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id r187so14291wme.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 06:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DfP94qPAkTZ+gSxr/ofdQYrTK1iKl3TWo1iVnl2DcE8=;
 b=ZCtPgPNkVJAFfibdygSmFD1pDI0RXoc5AxwRvF4JsByP8E8mTiw9wEYMbtkXmuqIAN
 XSk52PYSBaiBN/890dj7EZUih8eBLmYOIBYFx42sDxvOGjcJWisp7AEESlQ7bfRX+YIl
 hmRpr1ZhbdsQCOgJ6Gl2EIM6+VMg1pzkBpxAOvc+o59x2N3yopdj9EsWlTClSgAH5YhQ
 YpvEXf0G87SXOwauYbBPI/ihyLMEjPNRVBz9rqjcX8OeR4sWnWqth2sI18w5Ozzdf/6n
 Sz+f4vefx8UkoinVsng7SHT1oFRGZvUeeFJEL45v68AHP1SWr4P8M+li1gUx/UQRkAn3
 Fh6Q==
X-Gm-Message-State: APjAAAWnsAOmyLvhGgxqzuqj+/aoqq7oJzo4kDrrR2tYERxYWrsQX1Gg
 wdiGUhdFiR4kHqEaEpfoPlIja66XZAm1BsOEHPBPY3p+zPKazlKa9T506TEOyHPxP6vXGTR0OWL
 JPnJI2VAKz+6CTVE=
X-Received: by 2002:a05:600c:2047:: with SMTP id p7mr58674wmg.13.1567517854725; 
 Tue, 03 Sep 2019 06:37:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzBlASrUlwHxRdbphyyZAi8TlTDmrgr5y0HBIgXtq/deVYjRh4SGFbBENATlwT0OCEbgLHaLw==
X-Received: by 2002:a05:600c:2047:: with SMTP id p7mr58653wmg.13.1567517854471; 
 Tue, 03 Sep 2019 06:37:34 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id w13sm40406932wre.44.2019.09.03.06.37.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2019 06:37:33 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190903114729.3400-1-philmd@redhat.com>
 <20190903114729.3400-3-philmd@redhat.com>
 <a035e876-6f38-b80f-9a8f-1f88472fc7d7@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3684dbbe-3aaf-6206-3943-fd883f8f7c2a@redhat.com>
Date: Tue, 3 Sep 2019 15:37:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a035e876-6f38-b80f-9a8f-1f88472fc7d7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/5] target/arm: Restrict pre-ARMv7 cpus
 to TCG
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/19 2:10 PM, Thomas Huth wrote:
> On 03/09/2019 13.47, Philippe Mathieu-Daud=C3=A9 wrote:
>> KVM requires a cpu based on (at least) the ARMv7 architecture.
>>
>> The following CPUs are disabled:
>>
>> * ARMv4
>>
>>   - StrongARM (SA1100/1110)
>>   - OMAP1510 (TI925T)
>>
>> * ARMv5
>>
>>   - ARM926
>>   - ARM946
>>   - ARM1026
>>   - XScale (PXA250/255/260/261/262/270)
>>
>> * ARMv6
>>
>>   - ARM1136
>>   - ARM1176
>>   - ARM11MPCore
>>   - Cortex-M0
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> v2: fixed misplaced #endif (rth), list cpus
>> ---
>>  target/arm/cpu.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 2399c14471..f69780147c 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -1678,6 +1678,8 @@ static ObjectClass *arm_cpu_class_by_name(const =
char *cpu_model)
>>  /* CPU models. These are not needed for the AArch64 linux-user build.=
 */
>>  #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
>> =20
>> +#ifdef CONFIG_TCG
>> +
>>  static void arm926_initfn(Object *obj)
>>  {
>>      ARMCPU *cpu =3D ARM_CPU(obj);
>> @@ -1900,6 +1902,8 @@ static void cortex_m0_initfn(Object *obj)
>>      cpu->midr =3D 0x410cc200;
>>  }
>> =20
>> +#endif
>> +
>>  static void cortex_m3_initfn(Object *obj)
>>  {
>>      ARMCPU *cpu =3D ARM_CPU(obj);
>> @@ -2283,6 +2287,8 @@ static void cortex_a15_initfn(Object *obj)
>>      define_arm_cp_regs(cpu, cortexa15_cp_reginfo);
>>  }
>> =20
>> +#ifdef CONFIG_TCG
>> +
>>  static void ti925t_initfn(Object *obj)
>>  {
>>      ARMCPU *cpu =3D ARM_CPU(obj);
>> @@ -2451,6 +2457,8 @@ static void pxa270c5_initfn(Object *obj)
>>      cpu->reset_sctlr =3D 0x00000078;
>>  }
>> =20
>> +#endif
>> +
>>  #ifndef TARGET_AARCH64
>>  /* -cpu max: if KVM is enabled, like -cpu host (best possible with th=
is host);
>>   * otherwise, a CPU with as many features enabled as our emulation su=
pports.
>> @@ -2523,6 +2531,7 @@ struct ARMCPUInfo {
>> =20
>>  static const ARMCPUInfo arm_cpus[] =3D {
>>  #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
>> +#ifdef CONFIG_TCG
>>      { .name =3D "arm926",      .initfn =3D arm926_initfn },
>>      { .name =3D "arm946",      .initfn =3D arm946_initfn },
>>      { .name =3D "arm1026",     .initfn =3D arm1026_initfn },
>> @@ -2536,6 +2545,7 @@ static const ARMCPUInfo arm_cpus[] =3D {
>>      { .name =3D "arm11mpcore", .initfn =3D arm11mpcore_initfn },
>>      { .name =3D "cortex-m0",   .initfn =3D cortex_m0_initfn,
>>                               .class_init =3D arm_v7m_class_init },
>> +#endif
>>      { .name =3D "cortex-m3",   .initfn =3D cortex_m3_initfn,
>>                               .class_init =3D arm_v7m_class_init },
>>      { .name =3D "cortex-m4",   .initfn =3D cortex_m4_initfn,
>> @@ -2548,6 +2558,7 @@ static const ARMCPUInfo arm_cpus[] =3D {
>>      { .name =3D "cortex-a8",   .initfn =3D cortex_a8_initfn },
>>      { .name =3D "cortex-a9",   .initfn =3D cortex_a9_initfn },
>>      { .name =3D "cortex-a15",  .initfn =3D cortex_a15_initfn },
>> +#ifdef CONFIG_TCG
>>      { .name =3D "ti925t",      .initfn =3D ti925t_initfn },
>>      { .name =3D "sa1100",      .initfn =3D sa1100_initfn },
>>      { .name =3D "sa1110",      .initfn =3D sa1110_initfn },
>> @@ -2564,6 +2575,7 @@ static const ARMCPUInfo arm_cpus[] =3D {
>>      { .name =3D "pxa270-b1",   .initfn =3D pxa270b1_initfn },
>>      { .name =3D "pxa270-c0",   .initfn =3D pxa270c0_initfn },
>>      { .name =3D "pxa270-c5",   .initfn =3D pxa270c5_initfn },
>> +#endif
>>  #ifndef TARGET_AARCH64
>>      { .name =3D "max",         .initfn =3D arm_max_initfn },
>>  #endif
>>
>=20
> All that #ifdeffery is a little bit ugly. I wonder whether we could
> solve this by moving the CPU registrations to separate files which then
> only get compiled if the corresponding CONFIG_ARM_Vx switch is set.

I tried splitting arm_cpus[] and move the ifdef in
arm_cpu_register_types(), but the resulting diff is much bigger and it
only reduces from 4 '#ifdef CONFIG_TCG' to 2...

I'll see what thinks Peter first.

> That reminds me of a patch series of mine where I tried to make the cod=
e
> compilable without CONFIG_ARM_V7M ... unfortunately, I never found
> enough spare time to finish and publish it... I'll have a try to see
> whether I can rebase it and send it as an RFC or so.

Well, this is the same goal of this series... So regarding on Peter's
comments I might wait on your work.

Regards,

Phil.


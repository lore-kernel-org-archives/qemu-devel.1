Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F43C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:15:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6998520644
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6998520644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54480 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUA3C-00013B-K5
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 09:15:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hUA0u-0007aO-Ki
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU9z6-0002Cx-Cv
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:11:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hU9z4-00029I-AY
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:11:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so9957164wrr.13
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 06:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=UnpSL6wMxAxKNBlKTNYXQ4v0wpRW0lqEf4uxxLaEmeo=;
	b=RneWhqhzDFF9AI/WHpgFCDjJS/vEXg13T3oaOdZRbaNhdxPFmI+BoJ+1MH7taPXwJt
	7hIdS68ImjvXsRFT0pWkwR7BRK2xWTfeUNhJV34jDGU3Qm/JifrfnnvP7BNOhcHRrhqr
	2JRLKv2FYwzGpm7wrB3t3RKN3LuUYDTe9EaTb0kS3w1Sn1EgM3UhiTrIKcDobn01jMks
	7S9AFXqyzTuT9FJXH+G0CKZ53AiQstSCSwsB7I3iHjNtt7dXqvMtp57UE8JgobYCXcsN
	5GRiwuqkb7SOalK+1Wu2qcIzhMzePFK5vl3O6gHa6FXxWwkMVelqL46uglAUjUwHGetC
	Gn+w==
X-Gm-Message-State: APjAAAUnLO60vogp4Hp21bUL1DNXx07E9ze9V/ftHn9D6ntwm3dBkmWt
	2pGCdN38e83QrOOoH0EXeIiO8A==
X-Google-Smtp-Source: APXvYqwpqMQqUzsPtV0SGEv9yTcm5cIw9e6WEnB8E98CFlxJBOELrRuU16dVI/v/XLqSpX/i6ynmhg==
X-Received: by 2002:adf:c7d3:: with SMTP id y19mr545722wrg.298.1558703497533; 
	Fri, 24 May 2019 06:11:37 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	j28sm4839397wrd.64.2019.05.24.06.11.36
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 06:11:36 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, Peter Maydell
	<peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
References: <20181102171638.24069-1-peter.maydell@linaro.org>
	<20181102171638.24069-9-peter.maydell@linaro.org>
	<3e3d2018-3993-f651-8e94-5bea612bd776@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0d1c8338-a8b4-23b5-7297-e80428fbabff@redhat.com>
Date: Fri, 24 May 2019 15:11:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3e3d2018-3993-f651-8e94-5bea612bd776@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PULL 08/10] target/arm: Conditionalize some
 asserts on aarch32 support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/24/19 2:33 PM, Laszlo Ersek wrote:
> Hi,
> 
> On 11/02/18 18:16, Peter Maydell wrote:
>> From: Richard Henderson <richard.henderson@linaro.org>
>>
>> When populating id registers from kvm, on a host that doesn't support
>> aarch32 mode at all, neither arm_div nor jazelle will be supported either.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>> Tested-by: Alex Bennée <alex.bennee@linaro.org>
>> Message-id: 20181102102025.3546-1-richard.henderson@linaro.org
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  target/arm/cpu.h |  5 +++++
>>  target/arm/cpu.c | 15 +++++++++++++--
>>  2 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 8e6779936eb..b5eff79f73b 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -3296,6 +3296,11 @@ static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
>>      return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) == 1;
>>  }
>>  
>> +static inline bool isar_feature_aa64_aa32(const ARMISARegisters *id)
>> +{
>> +    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL0) >= 2;

FWIW here we check EL0, ...

>> +}
>> +
>>  static inline bool isar_feature_aa64_sve(const ARMISARegisters *id)
>>  {
>>      return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SVE) != 0;
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 8f16e96b6c8..784a4c2dfcc 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -774,6 +774,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>>      CPUARMState *env = &cpu->env;
>>      int pagebits;
>>      Error *local_err = NULL;
>> +    bool no_aa32 = false;
>>  
>>      /* If we needed to query the host kernel for the CPU features
>>       * then it's possible that might have failed in the initfn, but
>> @@ -820,6 +821,16 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>>              set_feature(env, ARM_FEATURE_V7VE);
>>          }
>>      }
>> +
>> +    /*
>> +     * There exist AArch64 cpus without AArch32 support.  When KVM
>> +     * queries ID_ISAR0_EL1 on such a host, the value is UNKNOWN.

... then here the comment is about EL1.

>> +     * Similarly, we cannot check ID_AA64PFR0 without AArch64 support.
>> +     */
>> +    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>> +        no_aa32 = !cpu_isar_feature(aa64_aa32, cpu);
>> +    }
>> +
>>      if (arm_feature(env, ARM_FEATURE_V7VE)) {
>>          /* v7 Virtualization Extensions. In real hardware this implies
>>           * EL2 and also the presence of the Security Extensions.
>> @@ -829,7 +840,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>>           * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
>>           * Security Extensions is ARM_FEATURE_EL3.
>>           */
>> -        assert(cpu_isar_feature(arm_div, cpu));
>> +        assert(no_aa32 || cpu_isar_feature(arm_div, cpu));
> 
> The assertion above fails on my AArch64 host (APM Mustang A3). Meaning
> that my host CPU supports AArch32, but lacks "arm_div".
> 
> (My understanding is that this commit, i.e., 0f8d06f16c9d, relaxed the
> assert originally added in commit 7e0cf8b47f0e ("target/arm: Convert
> division from feature bits to isar0 tests", 2018-10-24). Can we relax it
> even further?
> 
> Better yet: can we rework the code to emit a warning, rather than
> aborting QEMU? Assertions are not the best tool IMHO for catching
> unusual (or slightly non-conformant / early) hardware.)
> 
> Thanks,
> Laszlo
> 
>>          set_feature(env, ARM_FEATURE_LPAE);
>>          set_feature(env, ARM_FEATURE_V7);
>>      }
>> @@ -855,7 +866,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>>      if (arm_feature(env, ARM_FEATURE_V6)) {
>>          set_feature(env, ARM_FEATURE_V5);
>>          if (!arm_feature(env, ARM_FEATURE_M)) {
>> -            assert(cpu_isar_feature(jazelle, cpu));
>> +            assert(no_aa32 || cpu_isar_feature(jazelle, cpu));
>>              set_feature(env, ARM_FEATURE_AUXCR);
>>          }
>>      }
>>
> 


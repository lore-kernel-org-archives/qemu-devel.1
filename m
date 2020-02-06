Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74A6C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7098020730
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZxSaUVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7098020730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izeet-00049j-Gf
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 05:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1izeeE-0003hz-QT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:44:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1izeeC-0008I0-DV
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:44:38 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39011)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1izeeC-0007y8-3B
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:44:36 -0500
Received: by mail-wm1-x342.google.com with SMTP id c84so6431883wme.4
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=gdR/nScs6F4cHmnBQODQO9NFt/jKw0D5TyrF6Qxqpwg=;
 b=GZxSaUVyYHJ9p2OOPk4jouDbkBT1b24Uj9JhmbsUkE/1UUnV66PFQqvRX/SwkHX0zx
 p3LkOELd5SDr6rlJjfg9vr2OlyrfFbh4dF/LuXUK21O4b+ygGctWJA/W3d3rscal/c5t
 DaIzqnV4mTNEnxYNc/tbsb5El9XpuuHkvv54Re3AU3FLf1mgkqaXTzujJDXcbaT0EbIe
 k5VsHZoe3tTORoLtWQx3DVpIjUsj9IgfehK2Et0O4MOHI/2IBfXQvjgi9V3pmpdAU97r
 9PidJnXotyljGrhJFtscwKCUPQ+3BAqq0qwIT1eCjwyq5VBINE7WhdgFFAcUeyVx9o7e
 LQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=gdR/nScs6F4cHmnBQODQO9NFt/jKw0D5TyrF6Qxqpwg=;
 b=FPU5N8AnzbT4rXN4u899G5RmAWX3vqD3v8bhdZPesJxWn8+ZMjhLoL5jwCeKe+1GYJ
 6VENKcD1cHkuwcsq1K2NJLmyU5AI6x7n1dyjvVGFKetwwJMHqIlybYGPedRRlmGrlo2S
 QZnC+w68RicRE6zQB5xKoNlYjiN+QinNliFe6bkfPzJWAu/g5fZYheA14uOxUhCOdGRr
 T1tSKka5S5gV8GeT34afICfw4beOioL07SeW/PWh/zgbBIF0qtib+m6trLBdHXj3T7DQ
 R91/kProAKetfMTH1dvX+78XXaOeF2kDMcWCPC1QigFewzxlfZm0XhaDtMGmCLoNT6QR
 Et+Q==
X-Gm-Message-State: APjAAAV+3PIYDNDEkrqouB0lDdG5oftIHiZh7PMK1bZzFwFJDD8ZovWx
 UpExegoJVTZwQRl/mztmSOHS7g==
X-Google-Smtp-Source: APXvYqxGYkiCQ79mBWuOouyIERLQB3OSOUGygBbwRzf0SkMOKgluFq8E0w6vdfENq5JRaWkaR3+C7Q==
X-Received: by 2002:a1c:a947:: with SMTP id s68mr3899730wme.61.1580985874804; 
 Thu, 06 Feb 2020 02:44:34 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 16sm3243172wmi.0.2020.02.06.02.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:44:33 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DF5F61FF87;
 Thu,  6 Feb 2020 10:44:32 +0000 (GMT)
References: <20200201192916.31796-1-richard.henderson@linaro.org>
 <878slja79n.fsf@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 00/41] target/arm: Implement ARMv8.1-VHE
In-reply-to: <878slja79n.fsf@linaro.org>
Date: Thu, 06 Feb 2020 10:44:32 +0000
Message-ID: <87ftfo806n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> Version 6 moves vhe_reginfo[] to file scope, and one tweak
>> to the vhe register access masking that Peter asked for.
>>
>> All patches now have reviews.
>
> I was re-testing and I was able to boot my guest Image+buildroot.
> However the busybox crashes after login so I'm unable to do stuff in the
> guests userspace. I seem to recall we saw this last time but I can't
> remember what the problem was.

PEBKAC

I've now deleted the errant Image and re-tested with both 32 bit and 64
bit EL0 userspaces in the guest. So keep my:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>




>
>>
>>
>> r~
>>
>>
>> Alex Benn=C3=A9e (1):
>>   target/arm: check TGE and E2H flags for EL0 pauth traps
>>
>> Richard Henderson (40):
>>   target/arm: Define isar_feature_aa64_vh
>>   target/arm: Enable HCR_E2H for VHE
>>   target/arm: Add CONTEXTIDR_EL2
>>   target/arm: Add TTBR1_EL2
>>   target/arm: Update CNTVCT_EL0 for VHE
>>   target/arm: Split out vae1_tlbmask
>>   target/arm: Split out alle1_tlbmask
>>   target/arm: Simplify tlb_force_broadcast alternatives
>>   target/arm: Rename ARMMMUIdx*_S12NSE* to ARMMMUIdx*_E10_*
>>   target/arm: Rename ARMMMUIdx_S2NS to ARMMMUIdx_Stage2
>>   target/arm: Rename ARMMMUIdx_S1NSE* to ARMMMUIdx_Stage1_E*
>>   target/arm: Rename ARMMMUIdx_S1SE[01] to ARMMMUIdx_SE10_[01]
>>   target/arm: Rename ARMMMUIdx*_S1E3 to ARMMMUIdx*_SE3
>>   target/arm: Rename ARMMMUIdx_S1E2 to ARMMMUIdx_E2
>>   target/arm: Recover 4 bits from TBFLAGs
>>   target/arm: Expand TBFLAG_ANY.MMUIDX to 4 bits
>>   target/arm: Rearrange ARMMMUIdxBit
>>   target/arm: Tidy ARMMMUIdx m-profile definitions
>>   target/arm: Reorganize ARMMMUIdx
>>   target/arm: Add regime_has_2_ranges
>>   target/arm: Update arm_mmu_idx for VHE
>>   target/arm: Update arm_sctlr for VHE
>>   target/arm: Update aa64_zva_access for EL2
>>   target/arm: Update ctr_el0_access for EL2
>>   target/arm: Add the hypervisor virtual counter
>>   target/arm: Update timer access for VHE
>>   target/arm: Update define_one_arm_cp_reg_with_opaque for VHE
>>   target/arm: Add VHE system register redirection and aliasing
>>   target/arm: Add VHE timer register redirection and aliasing
>>   target/arm: Flush tlb for ASID changes in EL2&0 translation regime
>>   target/arm: Flush tlbs for E2&0 translation regime
>>   target/arm: Update arm_phys_excp_target_el for TGE
>>   target/arm: Update {fp,sve}_exception_el for VHE
>>   target/arm: Update get_a64_user_mem_index for VHE
>>   target/arm: Update arm_cpu_do_interrupt_aarch64 for VHE
>>   target/arm: Enable ARMv8.1-VHE in -cpu max
>>   target/arm: Move arm_excp_unmasked to cpu.c
>>   target/arm: Pass more cpu state to arm_excp_unmasked
>>   target/arm: Use bool for unmasked in arm_excp_unmasked
>>   target/arm: Raise only one interrupt in arm_cpu_exec_interrupt
>>
>>  target/arm/cpu-param.h     |    2 +-
>>  target/arm/cpu-qom.h       |    1 +
>>  target/arm/cpu.h           |  423 +++++--------
>>  target/arm/internals.h     |   73 ++-
>>  target/arm/translate.h     |    4 +-
>>  target/arm/cpu.c           |  162 ++++-
>>  target/arm/cpu64.c         |    1 +
>>  target/arm/debug_helper.c  |   50 +-
>>  target/arm/helper-a64.c    |    2 +-
>>  target/arm/helper.c        | 1220 +++++++++++++++++++++++++++---------
>>  target/arm/pauth_helper.c  |   14 +-
>>  target/arm/translate-a64.c |   47 +-
>>  target/arm/translate.c     |   74 ++-
>>  13 files changed, 1392 insertions(+), 681 deletions(-)


--=20
Alex Benn=C3=A9e


Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0E6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD8E2100A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DrGknGhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD8E2100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlm9j-0003Qc-6Z
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm8Y-0001bH-KX
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:26:50 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:46630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm8W-0002Eg-BS
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:26:50 -0400
Received: by mail-pg1-x533.google.com with SMTP id u128so2316162pgu.13
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e/fEhOUzGdTnNfh8i2Z+asqAlqWKRehzb+Bm4f2AJnk=;
 b=DrGknGhyGI/q0rCEXwJLy+g4DHmdVvUnnCwZW+AF3eLt0LqpQczYtFV+e+5necMbdV
 cE4JuodeoDUr7y/kOcY+m/gFW/320f0bl3OvZ/JlUstze83TeVgXaTW9sZN3pgNNVTKa
 sjfvTVU2kZ+ri/0hkQL3YL/7q4BezXOYlT0KeVyDr0Qwqw7HOCKNAqhQjGjPO/ZGEqmt
 52TbZkCgcN0vmXRuDNuU2uo1La5VTwfHwDHuAe4kqO7vmdFrYhqjjSbkYr1oNEnuQ3rN
 032dzj2OyBMO+STB1SiRAG/+vbzFYEh7cOvSQuCubK+kQ62ZFb5rdKZfuw7Qk4U064tz
 vS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e/fEhOUzGdTnNfh8i2Z+asqAlqWKRehzb+Bm4f2AJnk=;
 b=f3HQtmn7xGPo6+10ys1aGGNXgc1VQpVpFUMvdS01u4YcpuMbxcCKh5wVwCgr4ARXE4
 I1XQR2SuG6tM6UrkOGK8rdJmyrbfpozbRInWwMDjToz1TrHfTPYOIekODh+1IF3JLZwH
 Sc/DpdaNpNKR0XJjMoZzwI10VqlO98oqvgHD16zLo+7I5T4xgAjyNCE5aeymqv4Qs5Og
 KNHGvtTx2e7f4DWJRlq5V5+a+jl/ahNbFnZZVcAkd8OFqceEGw3OHTq7MOQtynlZRwoB
 JP7Pd6r4YezO3axR+sctBganWpJHY4LdJEOZILymEP2HnsE8BH5FMSiSGJ2tZoba3h1t
 OR3g==
X-Gm-Message-State: AOAM530TVNa5GFvo91FQxGDENufdF3LTywRlTGuc77kHSQ2+nd+eCKZC
 E5sgjvfmpkUo4/tNVLzjuXt7QYNlyo8=
X-Google-Smtp-Source: ABdhPJyc4t5BvOnHKBwDxiYf9LBZKpdlkAQeZziPtg4S2xR3IWQio6bdeZBUv0STEiZoEiXPm8qooQ==
X-Received: by 2002:aa7:84cc:: with SMTP id x12mr1864545pfn.235.1592454406143; 
 Wed, 17 Jun 2020 21:26:46 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o16sm1162035pgg.57.2020.06.17.21.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:26:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 000/100] target/arm: Implement SVE2
Date: Wed, 17 Jun 2020 21:25:04 -0700
Message-Id: <20200618042644.1685561-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I know this patch set is too big, and that there are parts that
can be split out that are prepatory rather that specifically sve2.

It's also not 100% tested.  I have done some amount of testing
vs ArmIE, but because of bugs and missing features therein, that
testing has been somewhat limited.  I understand a new version
of FVP has just been release containing SVE2 support, but I have
not yet tried that.

However, I believe this finally contains all of the instructions
in sve2 and its optional extensions.  Excluding BFloat16, since
that extension is supposed to implement AdvSIMD at the same time.


r~


Richard Henderson (81):
  tcg: Save/restore vecop_list around minmax fallback
  qemu/int128: Add int128_lshift
  target/arm: Split out gen_gvec_fn_zz
  target/arm: Split out gen_gvec_fn_zzz, do_zzz_fn
  target/arm: Rearrange {sve,fp}_check_access assert
  target/arm: Merge do_vector2_p into do_mov_p
  target/arm: Clean up 4-operand predicate expansion
  target/arm: Use tcg_gen_gvec_bitsel for trans_SEL_pppp
  target/arm: Split out gen_gvec_ool_zzzp
  target/arm: Merge helper_sve_clr_* and helper_sve_movz_*
  target/arm: Split out gen_gvec_ool_zzp
  target/arm: Split out gen_gvec_ool_zzz
  target/arm: Split out gen_gvec_ool_zz
  target/arm: Add ID_AA64ZFR0 fields and isar_feature_aa64_sve2
  target/arm: Enable SVE2 and some extensions
  target/arm: Implement SVE2 Integer Multiply - Unpredicated
  target/arm: Implement SVE2 integer pairwise add and accumulate long
  target/arm: Implement SVE2 integer unary operations (predicated)
  target/arm: Split out saturating/rounding shifts from neon
  target/arm: Implement SVE2 saturating/rounding bitwise shift left
    (predicated)
  target/arm: Implement SVE2 integer halving add/subtract (predicated)
  target/arm: Implement SVE2 integer pairwise arithmetic
  target/arm: Implement SVE2 saturating add/subtract (predicated)
  target/arm: Implement SVE2 integer add/subtract long
  target/arm: Implement SVE2 integer add/subtract interleaved long
  target/arm: Implement SVE2 integer add/subtract wide
  target/arm: Implement SVE2 integer multiply long
  target/arm: Implement PMULLB and PMULLT
  target/arm: Tidy SVE tszimm shift formats
  target/arm: Implement SVE2 bitwise shift left long
  target/arm: Implement SVE2 bitwise exclusive-or interleaved
  target/arm: Implement SVE2 bitwise permute
  target/arm: Implement SVE2 complex integer add
  target/arm: Implement SVE2 integer absolute difference and accumulate
    long
  target/arm: Implement SVE2 integer add/subtract long with carry
  target/arm: Implement SVE2 bitwise shift right and accumulate
  target/arm: Implement SVE2 bitwise shift and insert
  target/arm: Implement SVE2 integer absolute difference and accumulate
  target/arm: Implement SVE2 saturating extract narrow
  target/arm: Implement SVE2 SHRN, RSHRN
  target/arm: Implement SVE2 SQSHRUN, SQRSHRUN
  target/arm: Implement SVE2 UQSHRN, UQRSHRN
  target/arm: Implement SVE2 SQSHRN, SQRSHRN
  target/arm: Implement SVE2 WHILEGT, WHILEGE, WHILEHI, WHILEHS
  target/arm: Implement SVE2 WHILERW, WHILEWR
  target/arm: Implement SVE2 bitwise ternary operations
  target/arm: Implement SVE2 saturating multiply-add long
  target/arm: Generalize inl_qrdmlah_* helper functions
  target/arm: Implement SVE2 saturating multiply-add high
  target/arm: Implement SVE2 integer multiply-add long
  target/arm: Implement SVE2 complex integer multiply-add
  target/arm: Implement SVE2 XAR
  target/arm: Fix sve_uzp_p vs odd vector lengths
  target/arm: Fix sve_zip_p vs odd vector lengths
  target/arm: Fix sve_punpk_p vs odd vector lengths
  target/arm: Pass separate addend to {U,S}DOT helpers
  target/arm: Pass separate addend to FCMLA helpers
  target/arm: Split out formats for 2 vectors + 1 index
  target/arm: Split out formats for 3 vectors + 1 index
  target/arm: Implement SVE2 integer multiply (indexed)
  target/arm: Use helper_gvec_mul_idx_* for aa64 advsimd
  target/arm: Implement SVE2 integer multiply-add (indexed)
  target/arm: Use helper_gvec_ml{a,s}_idx_* for aa64 advsimd
  target/arm: Implement SVE2 saturating multiply-add high (indexed)
  target/arm: Implement SVE2 saturating multiply-add (indexed)
  target/arm: Implement SVE2 integer multiply long (indexed)
  target/arm: Implement SVE2 saturating multiply (indexed)
  target/arm: Implement SVE2 signed saturating doubling multiply high
  target/arm: Use helper_neon_sq{,r}dmul_* for aa64 advsimd
  target/arm: Implement SVE2 saturating multiply high (indexed)
  target/arm: Implement SVE2 multiply-add long (indexed)
  target/arm: Implement SVE2 complex integer multiply-add (indexed)
  target/arm: Implement SVE mixed sign dot product (indexed)
  target/arm: Implement SVE mixed sign dot product
  target/arm: Implement SVE2 crypto unary operations
  target/arm: Implement SVE2 crypto destructive binary operations
  target/arm: Implement SVE2 crypto constructive binary operations
  tcg: Implement 256-bit dup for tcg_gen_gvec_dup_mem
  target/arm: Share table of sve load functions
  target/arm: Implement SVE2 LD1RO
  target/arm: Implement 128-bit ZIP, UZP, TRN

Stephen Long (19):
  target/arm: Implement SVE2 floating-point pairwise
  target/arm: Implement SVE2 MATCH, NMATCH
  target/arm: Implement SVE2 ADDHNB, ADDHNT
  target/arm: Implement SVE2 RADDHNB, RADDHNT
  target/arm: Implement SVE2 SUBHNB, SUBHNT
  target/arm: Implement SVE2 RSUBHNB, RSUBHNT
  target/arm: Implement SVE2 HISTCNT, HISTSEG
  target/arm: Implement SVE2 scatter store insns
  target/arm: Implement SVE2 gather load insns
  target/arm: Implement SVE2 FMMLA
  target/arm: Implement SVE2 SPLICE, EXT
  target/arm: Implement SVE2 TBL, TBX
  target/arm: Implement SVE2 FCVTNT
  target/arm: Implement SVE2 FCVTLT
  target/arm: Implement SVE2 FCVTXNT, FCVTX
  softfloat: Add float16_is_normal
  target/arm: Implement SVE2 FLOGB
  target/arm: Implement SVE2 bitwise shift immediate
  target/arm: Implement SVE2 fp multiply-add long

 include/fpu/softfloat.h         |    5 +
 include/qemu/int128.h           |   16 +
 target/arm/cpu.h                |   56 +
 target/arm/helper-sve.h         |  717 ++++++-
 target/arm/helper.h             |  132 +-
 target/arm/translate-a64.h      |    3 +
 target/arm/translate.h          |    1 +
 target/arm/vec_internal.h       |  143 ++
 target/arm/sve.decode           |  594 +++++-
 target/arm/cpu64.c              |   11 +
 target/arm/helper.c             |    3 +-
 target/arm/kvm64.c              |   11 +
 target/arm/neon_helper.c        |  507 +----
 target/arm/sve_helper.c         | 2123 +++++++++++++++++--
 target/arm/translate-a64.c      |  177 +-
 target/arm/translate-neon.inc.c |   20 +-
 target/arm/translate-sve.c      | 3364 ++++++++++++++++++++++++++++---
 target/arm/vec_helper.c         |  942 +++++++--
 tcg/tcg-op-gvec.c               |   52 +-
 tcg/tcg-op-vec.c                |    2 +
 20 files changed, 7698 insertions(+), 1181 deletions(-)

-- 
2.25.1



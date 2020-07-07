Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE86C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 22:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC6920771
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 22:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC6920771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jswE2-0003PE-Nh
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 18:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jswDS-0002yH-Md; Tue, 07 Jul 2020 18:37:30 -0400
Received: from mail142-1.mail.alibaba.com ([198.11.142.1]:23391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jswDP-000593-BC; Tue, 07 Jul 2020 18:37:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.9109071|0.8101484; CH=green;
 DM=|SPAM|false|; DS=CONTINUE|ham_regular_dialog|0.0483645-0.000218332-0.951417;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01a16367; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=4; RT=4; SR=0; TI=SMTPD_---.HzsBShv_1594157819; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HzsBShv_1594157819)
 by smtp.aliyun-inc.com(10.147.42.135);
 Wed, 08 Jul 2020 05:37:00 +0800
Subject: Re: [PATCH v2 000/100] target/arm: Implement SVE2
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <fe439285-e68a-2fbb-1ad2-153a00ddce3a@c-sky.com>
Date: Wed, 8 Jul 2020 05:36:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: none client-ip=198.11.142.1; envelope-from=zhiwei_liu@c-sky.com;
 helo=mail142-1.mail.alibaba.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 18:15:39
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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


On 2020/6/18 12:25, Richard Henderson wrote:
> I know this patch set is too big, and that there are parts that
> can be split out that are prepatory rather that specifically sve2.
>
> It's also not 100% tested.  I have done some amount of testing
> vs ArmIE, but because of bugs and missing features therein, that
> testing has been somewhat limited.  I understand a new version
> of FVP has just been release containing SVE2 support, but I have
> not yet tried that.
>
> However, I believe this finally contains all of the instructions
> in sve2 and its optional extensions.  Excluding BFloat16, since
> that extension is supposed to implement AdvSIMD at the same time.
Hi Richard,

I try to merge this patch set to master branch. As some MTE instructions 
have been merged after this patch set,
it can't be merged now.

Would you mind to rebase it to master branch and send the patch set again?

Best Regards,
Zhiwei
>
> r~
>
>
> Richard Henderson (81):
>    tcg: Save/restore vecop_list around minmax fallback
>    qemu/int128: Add int128_lshift
>    target/arm: Split out gen_gvec_fn_zz
>    target/arm: Split out gen_gvec_fn_zzz, do_zzz_fn
>    target/arm: Rearrange {sve,fp}_check_access assert
>    target/arm: Merge do_vector2_p into do_mov_p
>    target/arm: Clean up 4-operand predicate expansion
>    target/arm: Use tcg_gen_gvec_bitsel for trans_SEL_pppp
>    target/arm: Split out gen_gvec_ool_zzzp
>    target/arm: Merge helper_sve_clr_* and helper_sve_movz_*
>    target/arm: Split out gen_gvec_ool_zzp
>    target/arm: Split out gen_gvec_ool_zzz
>    target/arm: Split out gen_gvec_ool_zz
>    target/arm: Add ID_AA64ZFR0 fields and isar_feature_aa64_sve2
>    target/arm: Enable SVE2 and some extensions
>    target/arm: Implement SVE2 Integer Multiply - Unpredicated
>    target/arm: Implement SVE2 integer pairwise add and accumulate long
>    target/arm: Implement SVE2 integer unary operations (predicated)
>    target/arm: Split out saturating/rounding shifts from neon
>    target/arm: Implement SVE2 saturating/rounding bitwise shift left
>      (predicated)
>    target/arm: Implement SVE2 integer halving add/subtract (predicated)
>    target/arm: Implement SVE2 integer pairwise arithmetic
>    target/arm: Implement SVE2 saturating add/subtract (predicated)
>    target/arm: Implement SVE2 integer add/subtract long
>    target/arm: Implement SVE2 integer add/subtract interleaved long
>    target/arm: Implement SVE2 integer add/subtract wide
>    target/arm: Implement SVE2 integer multiply long
>    target/arm: Implement PMULLB and PMULLT
>    target/arm: Tidy SVE tszimm shift formats
>    target/arm: Implement SVE2 bitwise shift left long
>    target/arm: Implement SVE2 bitwise exclusive-or interleaved
>    target/arm: Implement SVE2 bitwise permute
>    target/arm: Implement SVE2 complex integer add
>    target/arm: Implement SVE2 integer absolute difference and accumulate
>      long
>    target/arm: Implement SVE2 integer add/subtract long with carry
>    target/arm: Implement SVE2 bitwise shift right and accumulate
>    target/arm: Implement SVE2 bitwise shift and insert
>    target/arm: Implement SVE2 integer absolute difference and accumulate
>    target/arm: Implement SVE2 saturating extract narrow
>    target/arm: Implement SVE2 SHRN, RSHRN
>    target/arm: Implement SVE2 SQSHRUN, SQRSHRUN
>    target/arm: Implement SVE2 UQSHRN, UQRSHRN
>    target/arm: Implement SVE2 SQSHRN, SQRSHRN
>    target/arm: Implement SVE2 WHILEGT, WHILEGE, WHILEHI, WHILEHS
>    target/arm: Implement SVE2 WHILERW, WHILEWR
>    target/arm: Implement SVE2 bitwise ternary operations
>    target/arm: Implement SVE2 saturating multiply-add long
>    target/arm: Generalize inl_qrdmlah_* helper functions
>    target/arm: Implement SVE2 saturating multiply-add high
>    target/arm: Implement SVE2 integer multiply-add long
>    target/arm: Implement SVE2 complex integer multiply-add
>    target/arm: Implement SVE2 XAR
>    target/arm: Fix sve_uzp_p vs odd vector lengths
>    target/arm: Fix sve_zip_p vs odd vector lengths
>    target/arm: Fix sve_punpk_p vs odd vector lengths
>    target/arm: Pass separate addend to {U,S}DOT helpers
>    target/arm: Pass separate addend to FCMLA helpers
>    target/arm: Split out formats for 2 vectors + 1 index
>    target/arm: Split out formats for 3 vectors + 1 index
>    target/arm: Implement SVE2 integer multiply (indexed)
>    target/arm: Use helper_gvec_mul_idx_* for aa64 advsimd
>    target/arm: Implement SVE2 integer multiply-add (indexed)
>    target/arm: Use helper_gvec_ml{a,s}_idx_* for aa64 advsimd
>    target/arm: Implement SVE2 saturating multiply-add high (indexed)
>    target/arm: Implement SVE2 saturating multiply-add (indexed)
>    target/arm: Implement SVE2 integer multiply long (indexed)
>    target/arm: Implement SVE2 saturating multiply (indexed)
>    target/arm: Implement SVE2 signed saturating doubling multiply high
>    target/arm: Use helper_neon_sq{,r}dmul_* for aa64 advsimd
>    target/arm: Implement SVE2 saturating multiply high (indexed)
>    target/arm: Implement SVE2 multiply-add long (indexed)
>    target/arm: Implement SVE2 complex integer multiply-add (indexed)
>    target/arm: Implement SVE mixed sign dot product (indexed)
>    target/arm: Implement SVE mixed sign dot product
>    target/arm: Implement SVE2 crypto unary operations
>    target/arm: Implement SVE2 crypto destructive binary operations
>    target/arm: Implement SVE2 crypto constructive binary operations
>    tcg: Implement 256-bit dup for tcg_gen_gvec_dup_mem
>    target/arm: Share table of sve load functions
>    target/arm: Implement SVE2 LD1RO
>    target/arm: Implement 128-bit ZIP, UZP, TRN
>
> Stephen Long (19):
>    target/arm: Implement SVE2 floating-point pairwise
>    target/arm: Implement SVE2 MATCH, NMATCH
>    target/arm: Implement SVE2 ADDHNB, ADDHNT
>    target/arm: Implement SVE2 RADDHNB, RADDHNT
>    target/arm: Implement SVE2 SUBHNB, SUBHNT
>    target/arm: Implement SVE2 RSUBHNB, RSUBHNT
>    target/arm: Implement SVE2 HISTCNT, HISTSEG
>    target/arm: Implement SVE2 scatter store insns
>    target/arm: Implement SVE2 gather load insns
>    target/arm: Implement SVE2 FMMLA
>    target/arm: Implement SVE2 SPLICE, EXT
>    target/arm: Implement SVE2 TBL, TBX
>    target/arm: Implement SVE2 FCVTNT
>    target/arm: Implement SVE2 FCVTLT
>    target/arm: Implement SVE2 FCVTXNT, FCVTX
>    softfloat: Add float16_is_normal
>    target/arm: Implement SVE2 FLOGB
>    target/arm: Implement SVE2 bitwise shift immediate
>    target/arm: Implement SVE2 fp multiply-add long
>
>   include/fpu/softfloat.h         |    5 +
>   include/qemu/int128.h           |   16 +
>   target/arm/cpu.h                |   56 +
>   target/arm/helper-sve.h         |  717 ++++++-
>   target/arm/helper.h             |  132 +-
>   target/arm/translate-a64.h      |    3 +
>   target/arm/translate.h          |    1 +
>   target/arm/vec_internal.h       |  143 ++
>   target/arm/sve.decode           |  594 +++++-
>   target/arm/cpu64.c              |   11 +
>   target/arm/helper.c             |    3 +-
>   target/arm/kvm64.c              |   11 +
>   target/arm/neon_helper.c        |  507 +----
>   target/arm/sve_helper.c         | 2123 +++++++++++++++++--
>   target/arm/translate-a64.c      |  177 +-
>   target/arm/translate-neon.inc.c |   20 +-
>   target/arm/translate-sve.c      | 3364 ++++++++++++++++++++++++++++---
>   target/arm/vec_helper.c         |  942 +++++++--
>   tcg/tcg-op-gvec.c               |   52 +-
>   tcg/tcg-op-vec.c                |    2 +
>   20 files changed, 7698 insertions(+), 1181 deletions(-)
>



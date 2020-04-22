Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CFFC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 03:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086D12070B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 03:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TQU2jwV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086D12070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR5jq-0005UV-5y
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 23:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuzwnan@163.com>) id 1jR5jA-00054X-5e
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 23:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <liuzwnan@163.com>) id 1jR5iw-000499-Tt
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 23:07:07 -0400
Received: from m12-15.163.com ([220.181.12.15]:43157)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <liuzwnan@163.com>)
 id 1jR5ir-0002Ph-6O; Tue, 21 Apr 2020 23:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=2oxoH
 tq9PZYqYLwQaOi1NQyPrMBVH6kT96nkKq5jzvE=; b=TQU2jwV784bJ7CsJZgmUT
 u/k/4NdBa5BrHXZLTY7dLgtTXgKe+kDoLVm/YGpZnvnwdpk5wpvfM81ZJHlcx8rU
 eMowyD2eGDNLlnE7jo1PBltMwhhX7ltPlFWeUH5KP6d9YCnA9jILaOlDlOzIGs4F
 Rt97TQNiQsSe9I6NEPWdKs=
Received: from [30.225.208.25] (unknown [42.120.72.89])
 by smtp11 (Coremail) with SMTP id D8CowABXXBgZsZ9eYGIhEQ--.22S2;
 Wed, 22 Apr 2020 10:51:13 +0800 (CST)
Subject: Re: [PATCH for-5.1 00/31] target/arm: SVE2, part 1
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200326230838.31112-1-richard.henderson@linaro.org>
From: LIU Zhiwei <liuzwnan@163.com>
Message-ID: <eb7eea48-ecb8-f64d-83cd-66463a61d5a6@163.com>
Date: Wed, 22 Apr 2020 10:51:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200326230838.31112-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: D8CowABXXBgZsZ9eYGIhEQ--.22S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF1ftw43uF1xWrW5Gr1Dtrb_yoWrZFW8pF
 W5KFZxKr4Utay3WasayF1UXwn8Xw18KryUCw1xtw1fXw13tryDXr1Dta4SgFyUKFy7uF47
 JF1IyF15uw45XrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jR38nUUUUU=
X-Originating-IP: [42.120.72.89]
X-CM-SenderInfo: xolx64xqdqqiywtou0bp/1tbiRAIOElSIfSuM5AAAs4
Received-SPF: pass client-ip=220.181.12.15; envelope-from=liuzwnan@163.com;
 helo=m12-15.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 22:51:17
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Received-From: 220.181.12.15
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
Cc: rajav@quicinc.com, qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,

I find BF16 is included in the ISA.  Will you extend  the softfpu in 
this patch set?

Zhiwei

On 2020/3/27 7:08, Richard Henderson wrote:
> Posting this for early review.  It's based on some other patch
> sets that I have posted recently that also touch SVE, listed
> below.  But it might just be easier to clone the devel tree [2].
> While the branch itself will rebase frequently for development,
> I've also created a tag, post-sve2-20200326, for this posting.
>
> This is mostly untested, as the most recently released Foundation
> Model does not support SVE2.  Some of the new instructions overlap
> with old fashioned NEON, and I can verify that those have not
> broken, and show that SVE2 will use the same code path.  But the
> predicated insns and bottom/top interleaved insns are not yet
> RISU testable, as I have nothing to compare against.
>
> The patches are in general arranged so that one complete group
> of insns are added at once.  The groups within the manual [1]
> have so far been small-ish.
>
>
> r~
>
> ---
>
> [1] ISA manual: https://static.docs.arm.com/ddi0602/d/ISA_A64_xml_futureA-2019-12_OPT.pdf
>
> [2] Devel tree: https://github.com/rth7680/qemu/tree/tgt-arm-sve-2
>
> Based-on: http://patchwork.ozlabs.org/project/qemu-devel/list/?series=163610
> ("target/arm: sve load/store improvements")
>
> Based-on: http://patchwork.ozlabs.org/project/qemu-devel/list/?series=164500
> ("target/arm: Use tcg_gen_gvec_5_ptr for sve FMLA/FCMLA")
>
> Based-on: http://patchwork.ozlabs.org/project/qemu-devel/list/?series=164048
> ("target/arm: Implement ARMv8.5-MemTag, system mode")
>
> Richard Henderson (31):
>    target/arm: Add ID_AA64ZFR0 fields and isar_feature_aa64_sve2
>    target/arm: Implement SVE2 Integer Multiply - Unpredicated
>    target/arm: Implement SVE2 integer pairwise add and accumulate long
>    target/arm: Remove fp_status from helper_{recpe,rsqrte}_u32
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
>    target/arm: Create arm_gen_gvec_[us]sra
>    target/arm: Create arm_gen_gvec_{u,s}{rshr,rsra}
>    target/arm: Implement SVE2 bitwise shift right and accumulate
>    target/arm: Create arm_gen_gvec_{sri,sli}
>    target/arm: Tidy handle_vec_simd_shri
>    target/arm: Implement SVE2 bitwise shift and insert
>    target/arm: Vectorize SABD/UABD
>    target/arm: Vectorize SABA/UABA
>    target/arm: Implement SVE2 integer absolute difference and accumulate
>
>   target/arm/cpu.h           |  31 ++
>   target/arm/helper-sve.h    | 345 +++++++++++++++++
>   target/arm/helper.h        |  81 +++-
>   target/arm/translate-a64.h |   9 +
>   target/arm/translate.h     |  24 +-
>   target/arm/vec_internal.h  | 161 ++++++++
>   target/arm/sve.decode      | 217 ++++++++++-
>   target/arm/helper.c        |   3 +-
>   target/arm/kvm64.c         |   2 +
>   target/arm/neon_helper.c   | 515 ++++---------------------
>   target/arm/sve_helper.c    | 757 ++++++++++++++++++++++++++++++++++---
>   target/arm/translate-a64.c | 557 +++++++++++++++++++++++----
>   target/arm/translate-sve.c | 557 +++++++++++++++++++++++++++
>   target/arm/translate.c     | 626 ++++++++++++++++++++++--------
>   target/arm/vec_helper.c    | 411 ++++++++++++++++++++
>   target/arm/vfp_helper.c    |   4 +-
>   16 files changed, 3532 insertions(+), 768 deletions(-)
>   create mode 100644 target/arm/vec_internal.h
>




Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5A6C2D0E8
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97BBA20658
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ax2U9u49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BBA20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbdG-0003gT-Mh
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcB-0001q7-SD
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcA-0001EF-5b
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:08:43 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:36313)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbcA-0001E2-0j
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:08:42 -0400
Received: by mail-pl1-x62c.google.com with SMTP id g2so2741988plo.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F6i9arXen4TLeK0sY1KC/vE3U9xI96E0JovDA1nAh+A=;
 b=ax2U9u49VmY0gE13qfwVJclO+B1Tzk6x0lBTKlYeB8FjPOuL4aesEUgEYCiT+/iWbu
 Ti66yszpdyU6RBxsu7tM92nCKns3X/0HhuRzBHFsm5PsXwfOARJ8FZIMrD6KvD92HTsw
 OaSQJiTBxacF5By+QvK9OlhAD0WfayjBqQwMGCmyggrVQ/1Esp1fZ/TxmOftAG10Aevs
 lPpDbDXLHqRtcgxNg7qiKff0toKJLRIQyJQACRgEppCDIRL6kvRfr/3xpcaJudFHaEQC
 duXYrQuJot/hgEvrKeKxV1MJ8TpZBdoyzZqZHySpriR5yQGpYDkAO/T6MQO48ASnmnfg
 7XNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F6i9arXen4TLeK0sY1KC/vE3U9xI96E0JovDA1nAh+A=;
 b=cEG9tuCizI3xwttgcHxxWpqmS98vYqCbMarv1Hn/aednbFvWky+tebx7tXuz4+GKNc
 6aslJ+Wzm6lzSz1McAHUX2pQCsy4PE05IufmDiwm9i3VhP+hWShi29RujovgAaKgfTVJ
 FaQIo8hmRIr0ZotLPeZuBsW1Vw5JwH4LUvRHZ9NfKjueuUA2kmObfQKlE0x+d+OACF6Y
 bXmN0xO5eaVJxhmm/Pd+c7CkUdluODoRlo8BpC5yJyQK7+hKYKB/yGMZhaNi5k9Cqczm
 Wl2pcjyS274aXDP4tzHaU+T/Bd7529S3GVq9NwCHSWlTkHNb81sZTMxFS6OJerd/t44K
 tucQ==
X-Gm-Message-State: ANhLgQ0MiLi3Fy3/M4VCEHN1afYC5RYbxP9HI1uCRXiaMtNESMOO/Z/q
 ANkBfOuzjcAgsUnFHBHgHAvHD8NUc7c=
X-Google-Smtp-Source: ADFU+vvTAL4gO2DwpR7KsVUJzW9zNlhO3nWXvpY6XWDmwaadkij/Awxe93LkIjR/K8kpdSeYuP2bCw==
X-Received: by 2002:a17:90a:208:: with SMTP id
 c8mr2561202pjc.153.1585264120482; 
 Thu, 26 Mar 2020 16:08:40 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i187sm2530037pfg.33.2020.03.26.16.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 16:08:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 00/31] target/arm: SVE2, part 1
Date: Thu, 26 Mar 2020 16:08:07 -0700
Message-Id: <20200326230838.31112-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62c
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

Posting this for early review.  It's based on some other patch
sets that I have posted recently that also touch SVE, listed
below.  But it might just be easier to clone the devel tree [2].
While the branch itself will rebase frequently for development,
I've also created a tag, post-sve2-20200326, for this posting.

This is mostly untested, as the most recently released Foundation
Model does not support SVE2.  Some of the new instructions overlap
with old fashioned NEON, and I can verify that those have not
broken, and show that SVE2 will use the same code path.  But the
predicated insns and bottom/top interleaved insns are not yet
RISU testable, as I have nothing to compare against.

The patches are in general arranged so that one complete group
of insns are added at once.  The groups within the manual [1]
have so far been small-ish.


r~

---

[1] ISA manual: https://static.docs.arm.com/ddi0602/d/ISA_A64_xml_futureA-2019-12_OPT.pdf

[2] Devel tree: https://github.com/rth7680/qemu/tree/tgt-arm-sve-2

Based-on: http://patchwork.ozlabs.org/project/qemu-devel/list/?series=163610
("target/arm: sve load/store improvements")

Based-on: http://patchwork.ozlabs.org/project/qemu-devel/list/?series=164500
("target/arm: Use tcg_gen_gvec_5_ptr for sve FMLA/FCMLA")

Based-on: http://patchwork.ozlabs.org/project/qemu-devel/list/?series=164048
("target/arm: Implement ARMv8.5-MemTag, system mode")

Richard Henderson (31):
  target/arm: Add ID_AA64ZFR0 fields and isar_feature_aa64_sve2
  target/arm: Implement SVE2 Integer Multiply - Unpredicated
  target/arm: Implement SVE2 integer pairwise add and accumulate long
  target/arm: Remove fp_status from helper_{recpe,rsqrte}_u32
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
  target/arm: Create arm_gen_gvec_[us]sra
  target/arm: Create arm_gen_gvec_{u,s}{rshr,rsra}
  target/arm: Implement SVE2 bitwise shift right and accumulate
  target/arm: Create arm_gen_gvec_{sri,sli}
  target/arm: Tidy handle_vec_simd_shri
  target/arm: Implement SVE2 bitwise shift and insert
  target/arm: Vectorize SABD/UABD
  target/arm: Vectorize SABA/UABA
  target/arm: Implement SVE2 integer absolute difference and accumulate

 target/arm/cpu.h           |  31 ++
 target/arm/helper-sve.h    | 345 +++++++++++++++++
 target/arm/helper.h        |  81 +++-
 target/arm/translate-a64.h |   9 +
 target/arm/translate.h     |  24 +-
 target/arm/vec_internal.h  | 161 ++++++++
 target/arm/sve.decode      | 217 ++++++++++-
 target/arm/helper.c        |   3 +-
 target/arm/kvm64.c         |   2 +
 target/arm/neon_helper.c   | 515 ++++---------------------
 target/arm/sve_helper.c    | 757 ++++++++++++++++++++++++++++++++++---
 target/arm/translate-a64.c | 557 +++++++++++++++++++++++----
 target/arm/translate-sve.c | 557 +++++++++++++++++++++++++++
 target/arm/translate.c     | 626 ++++++++++++++++++++++--------
 target/arm/vec_helper.c    | 411 ++++++++++++++++++++
 target/arm/vfp_helper.c    |   4 +-
 16 files changed, 3532 insertions(+), 768 deletions(-)
 create mode 100644 target/arm/vec_internal.h

-- 
2.20.1



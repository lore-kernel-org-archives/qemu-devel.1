Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AAECA9EBC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D59F120684
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qp4yki9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59F120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0Zm-0007UB-65
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Tc-0004vW-Hl
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Tb-0001Zi-5T
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:04 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729]:35339)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iO0Tb-0001Zb-1x
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:03 -0400
Received: by mail-qk1-x729.google.com with SMTP id w2so1917138qkf.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7loauZePKYcg95Q38hmuQ9PVmrv0CuTPbCtC++fDvcQ=;
 b=Qp4yki9KYLUKnAt0ZlxTF91QDtBsiiFL1WpsTcvVTq72aMJdq21otwgus4QnOsDda7
 UdGRBBujLAA5GKKF16KDzSO0JiW3xdPeOaLOWP/Hkgm+xJB+/KVW7gbOo/0ldAcIIVoX
 +MXg/JcBlCkv2fTPxm2pztxILL+hjS+qOKoelNledyRImnoDAsLogoIQguUqTCKCg0zq
 i1X8yMo4IL/rX8KxMDQRydXso0L5Z+vSdYLDD2fc0/UnhiND2yJYDlWl2+j/0OfLB4Ag
 qoOXJ2/d4dmRQuWb2E8FMbTuE2JU7o0QF04LSdjOWAz7JVB3m7ri8bBNSgiMCOmwv4hZ
 xCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7loauZePKYcg95Q38hmuQ9PVmrv0CuTPbCtC++fDvcQ=;
 b=Ehi3/DUnMCxC9BHTeYIj1LCD+tW4xdMqbB8D6kCin1sJgomaFIaOXRsao+TLuqQM55
 dq4dBhR984+WngFCEJSlJD8OILao4tZa0w4mQti7YTs9GZn/Mq7Y8dfnSls8AlZnyYfc
 L0brYyj0LfgxCAR4O/hEOAYh3E3FkOAfkqhb4yC/7ywJII7mWTXeAb7E8En/NNBFy5/Y
 FnYKl2AeOuBgDfUpRwnrk9qyE8u8Z7e6wOW8ZF7KVx6KGzDALQviH9JDIHE8Pz/MBBtj
 d94qKT5ZJY1akhPWQcloLwVIPZ9yzhg4aDfy9/GlgUrfPgJgsv7gjmAKS4cAfwa0rl3b
 OyTg==
X-Gm-Message-State: APjAAAXJhrcv6f0BqN0JoR2A51TMOUQW6g16tRwsRkwjgJCBZ2shB+aK
 1sXU45tdOmu6n89OYr1XtOB70zfVC00=
X-Google-Smtp-Source: APXvYqw9lQWXNO2dpbpNuq/3D82AyWp5tYNH86cb7Oj6sNuzULoZQdjDvSX3/UAjqzfUdQ5WATE5xg==
X-Received: by 2002:a37:5842:: with SMTP id m63mr3067549qkb.59.1572013321544; 
 Fri, 25 Oct 2019 07:22:01 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id q17sm1137050qtq.58.2019.10.25.07.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 07:22:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] tcg patch queue
Date: Fri, 25 Oct 2019 10:21:47 -0400
Message-Id: <20191025142159.12459-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::729
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit bad76ac319556dab2497429d473b49a237672e1c:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2019-10-25 14:17:08 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20191025

for you to fetch changes up to 0ed1bfb046b740b70eed2cf3581e01768703b185:

  translate-all: Remove tb_alloc (2019-10-25 10:15:25 -0400)

----------------------------------------------------------------
Improvements for TARGET_PAGE_BITS_VARY
Fix for TCI ld16u_i64.
Fix for segv on icount execute from i/o memory.
Two misc cleanups.

----------------------------------------------------------------
Alex Bennée (1):
      cputlb: ensure _cmmu helper functions follow the naming standard

Clement Deschamps (1):
      translate-all: fix uninitialized tb->orig_tb

Richard Henderson (8):
      exec: Split out variable page size support to exec-vary.c
      configure: Detect compiler support for __attribute__((alias))
      exec: Use const alias for TARGET_PAGE_BITS_VARY
      exec: Restrict TARGET_PAGE_BITS_VARY assert to CONFIG_DEBUG_TCG
      exec: Promote TARGET_PAGE_MASK to target_long
      exec: Cache TARGET_PAGE_MASK for TARGET_PAGE_BITS_VARY
      cputlb: Fix tlb_vaddr_to_host
      translate-all: Remove tb_alloc

Stefan Weil (1):
      tci: Add implementation for INDEX_op_ld16u_i64

Wei Yang (1):
      cpu: use ROUND_UP() to define xxx_PAGE_ALIGN

 Makefile.target                  |   2 +-
 include/exec/cpu-all.h           |  33 +++++++++----
 include/exec/cpu_ldst_template.h |   4 +-
 include/qemu-common.h            |   6 +++
 tcg/tcg.h                        |  20 +++++---
 accel/tcg/cputlb.c               |  26 ++++++++--
 accel/tcg/translate-all.c        |  21 ++------
 exec-vary.c                      | 102 +++++++++++++++++++++++++++++++++++++++
 exec.c                           |  34 -------------
 target/cris/translate_v10.inc.c  |   3 +-
 tcg/tci.c                        |  15 ++++++
 configure                        |  19 ++++++++
 12 files changed, 208 insertions(+), 77 deletions(-)
 create mode 100644 exec-vary.c


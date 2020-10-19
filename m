Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966EDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F03C2231B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y11auK2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F03C2231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUWvn-0004co-Th
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 11:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUWqU-0006oS-QV
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:13:11 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:37586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUWqQ-0002jT-UV
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:13:09 -0400
Received: by mail-wm1-x334.google.com with SMTP id j136so208957wmj.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 08:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nfoR8sqiK+gHy7yD6/tEtbPtJxBhQTr1YZYkY4YxcN8=;
 b=Y11auK2Btu6HGbq/JcbQj2ZuW7uiSIFu5K4NND6lx00izU3s5sI3+JdZ5xbeRZHmDi
 QSoNXQY0zA6nQuYhrCj/vUCfte5jT/soKONi48uuUd7M0ePOdsU07NPtnN3MTAN69JRq
 fkMgZDGWRupGpNTcx9+Y/JolXcL+wdTWWY4UvysPUugm6Eg7NCsUQhAn3E8Q7u/yxWNY
 l9VdUjnWE2Y/ByQDSQ/PguMpODoKzwupH6Zr7y1kY4fVj9NlxgDdxxkX0rdqCv+6E9hX
 DHWXSaayIC0Ixy7A5xVAxIi6WQfXYnDmxOpi3We/0Qh5h38gcH4CwUcUG+n4YpPbK1cn
 yVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nfoR8sqiK+gHy7yD6/tEtbPtJxBhQTr1YZYkY4YxcN8=;
 b=mbuWqAHhlshJHXESs6nv8Rwt7/MVjNRE958hYqh+LjRLTu0oCiuEMWBUi7Vb2QsdQx
 fBOy+XsD11R5vvEcSKNgiOulITwnVoocgo3xFJwKCE7yeFV2AxxhLnr0myPs8ut1k09v
 ELKaSfLf35KFrGRbhgLH1xiYjn299bO/B8Ie5PD4Izgz8gk2AREOtelHxmf+/ysVEh2M
 kakmW7UaYEMPPpBZUeUD4y2OacsEVy2CESaN6dQqaTUclhstd7G/O7V+qu+120vDlhtX
 EMUi6vwVeiS18zrZMqeQskcfXVor46PUXxGqkh62Qyif+Fyu/5LQoN2kLLq+6eeINfAw
 qlQg==
X-Gm-Message-State: AOAM532xWqiNF2OFEXFhVKNhNfkk2g5iHWPvQsp6P4IAtxr5XrLbEkbY
 7Mfx5M2pFk8uf7Z8/JqaeQXnBg==
X-Google-Smtp-Source: ABdhPJyxGzSB5XbGtMtHFo5YXHYHyOvSbrjWJffR3m7jclMuUZ/o03MdoeCUtczr0o3j+/wzcFrjjA==
X-Received: by 2002:a1c:e287:: with SMTP id
 z129mr17497050wmg.109.1603120383889; 
 Mon, 19 Oct 2020 08:13:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y14sm309918wma.48.2020.10.19.08.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 08:13:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 00/10] target/arm: Various v8.1M minor features
Date: Mon, 19 Oct 2020 16:12:51 +0100
Message-Id: <20201019151301.2046-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchseries implements various minor v8.1M new features,
notably the branch-future and low-overhead-loop extensions.

(None of this will get enabled until we have enough to implement
a CPU model which has v8.1M, which will be the Cortex-M55, but
as usual we can get stuff into the tree gradually.)

Changes v1->v2:
 * added missing check that rm!=13 for CSEL decode
 * folded in gen_jmp_tb() fixup for DLS/WLS/LE patch
 * reversed sense of branch in trans_WLS
 * reworked set_fpscr changes as suggested by RTH
 * provide an env->v7m.ltpsize now (always 4 until
   MVE implemented, but it avoids code changes later)

Unreviewed patches: 2, 7, 9, 10

thanks
-- PMM

Peter Maydell (10):
  decodetree: Fix codegen for non-overlapping group inside overlapping
    group
  target/arm: Implement v8.1M NOCP handling
  target/arm: Implement v8.1M conditional-select insns
  target/arm: Make the t32 insn[25:23]=111 group non-overlapping
  target/arm: Don't allow BLX imm for M-profile
  target/arm: Implement v8.1M branch-future insns (as NOPs)
  target/arm: Implement v8.1M low-overhead-loop instructions
  target/arm: Fix has_vfp/has_neon ID reg squashing for M-profile
  target/arm: Allow M-profile CPUs with FP16 to set FPSCR.FP16
  target/arm: Implement FPSCR.LTPSIZE for M-profile LOB extension

 target/arm/cpu.h               |   8 ++
 target/arm/m-nocp.decode       |  10 +-
 target/arm/t32.decode          |  50 ++++++---
 target/arm/cpu.c               |  38 +++++--
 target/arm/translate.c         | 181 ++++++++++++++++++++++++++++++++-
 target/arm/vfp_helper.c        |  53 ++++++----
 scripts/decodetree.py          |   2 +-
 target/arm/translate-vfp.c.inc |  17 +++-
 8 files changed, 305 insertions(+), 54 deletions(-)

-- 
2.20.1



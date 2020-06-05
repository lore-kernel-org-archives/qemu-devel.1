Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C720C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E611207D3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AatOKgix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E611207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh3oW-000607-BV
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 00:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3nX-00049h-Mm
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:39 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3nV-0000hU-9Z
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:39 -0400
Received: by mail-pl1-x644.google.com with SMTP id g12so3109656pll.10
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 21:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0A6sysLQGM7PIUVrKKD2e+tjvdFPeywZ4FvTVenRjO8=;
 b=AatOKgixysqnlj2TGrVJ0nCU68wFlF3Fp8Y63O30I1vUZQkHWtmryWadpHTaHNUk9Q
 b6ndXLc5yqWpXjb2Q4UDAHrE7JIWRiEkKuNNl+n+lT9O/Zs0PuUxeuyrmld80hNlo8aI
 LXHKcuXdm00gJJl9V/1BJsVz59VEaBlxbM8W4kISkJOLU0FonhzN2wEBgfXuaPo9l5LN
 HBzkm9Dcy9d8LSfzgaJ51l4Jcwkx772EybKo6/Jlvw3DUrPPqMDR6eAaQXpVyFxcs39c
 fOotfj4vQ69agrw9zsuZNqfFv7o75eNq+IyNqjgbGlec3+WySne/6zAY9BlTk4/1NQcZ
 qbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0A6sysLQGM7PIUVrKKD2e+tjvdFPeywZ4FvTVenRjO8=;
 b=MS9AkhBBa5GYk/rkygkMCsjFLUKdToE+4As4fc/oKDuLxoOQ60Q8V/E0c6WdVBPw1w
 S3nLZFRgbYTG6qjTa3IwPSYi3fyICEOw7IqyE7o6qvOOWRqwinJxIbjBM9zVo7GbGkR0
 tHl/kVOR9SbumHDketBziLr5DQGJq2WkgQIwIOYB30T9mUeIjUMZyTcfTDiImP/bWsiF
 W8ToSt/cHxe0AK0lKIntRFxKwKKgGPoDNRvnEKJ89Hfq0+czfhu0mbM+FdRXn7iizZ4l
 juDtsvgLHZSJcj4EYI73Tl2hm/W5nb75ORR8s8alYtdhqu2H93NNHlehzvCPwu9mAjZa
 FeEw==
X-Gm-Message-State: AOAM531Tujw6wywYK3iQnDYB+UOg6cpX+pGUqp/eyMSKLDnZCn9Et6HA
 TJOEmmh+A/WOgo5dJ9W5PnlUuz2qb5w=
X-Google-Smtp-Source: ABdhPJz0subGX6n0v4ONO86mJNJH3U5Ck3fd9ZDSo+5ejKlVHCJxsMb8guEOkNtXDolAcwCV0yF1CA==
X-Received: by 2002:a17:90b:1244:: with SMTP id
 gx4mr779943pjb.136.1591330655275; 
 Thu, 04 Jun 2020 21:17:35 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h15sm5440902pgl.12.2020.06.04.21.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 21:17:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/17] target-arm: Implement ARMv8.5-MemTag, user mode
Date: Thu,  4 Jun 2020 21:17:16 -0700
Message-Id: <20200605041733.415188-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Version 1 was back in October:
https://patchew.org/QEMU/20191015163254.12041-1-richard.henderson@linaro.org/

Although that post claims there was an actual v1 in March 2019,
I can't locate it, so... whatever.

This version -- call it 2 -- is the first attempt to implement the
actual in-progress kernel abi, rather than making up a private abi:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=devel/mte-v4

Based-on: 20200603011317.473934-1-richard.henderson@linaro.org
("target/arm: Implement ARMv8.5-MemTag, system mode")
Based-on: 20200520172800.8499-1-richard.henderson@linaro.org
("linux-user: User support for AArch64 BTI")

The full tree is available at:
https://github.com/rth7680/qemu/tree/tgt-arm-mte-user


r~


Richard Henderson (17):
  tcg: Introduce target-specific page data for user-only
  linux-user: Introduce PAGE_ANON
  linux-user: Check for overflow in access_ok
  linux-user: Tidy VERIFY_READ/VERIFY_WRITE
  bsd-user: Tidy VERIFY_READ/VERIFY_WRITE
  linux-user: Do not use guest_addr_valid for h2g_valid
  linux-user: Fix guest_addr_valid vs reserved_va
  exec: Add support for TARGET_TAGGED_ADDRESSES
  linux-user/aarch64: Implement PR_TAGGED_ADDR_ENABLE
  linux-user/aarch64: Implement PR_MTE_TCF and PR_MTE_TAG
  linux-user/aarch64: Implement PROT_MTE
  linux-user/aarch64: Pass syndrome to EXC_*_ABORT
  linux-user/aarch64: Signal SEGV_MTESERR for sync tag check fault
  linux-user/aarch64: Signal SEGV_MTEAERR for async tag check error
  target/arm: Add allocation tag storage for user mode
  target/arm: Enable MTE for user-only
  tests/tcg/aarch64: Add mte smoke tests

 bsd-user/qemu.h                     |  9 ++--
 include/exec/cpu-all.h              | 23 ++++++---
 include/exec/cpu_ldst.h             | 40 +++++++++++-----
 linux-user/aarch64/target_signal.h  |  3 ++
 linux-user/aarch64/target_syscall.h | 13 +++++
 linux-user/qemu.h                   | 19 +++++---
 linux-user/syscall_defs.h           |  1 +
 target/arm/cpu-param.h              |  3 ++
 tests/tcg/aarch64/mte.h             | 54 +++++++++++++++++++++
 accel/tcg/translate-all.c           | 28 +++++++++++
 bsd-user/main.c                     |  5 ++
 linux-user/aarch64/cpu_loop.c       | 60 +++++++++++++++++++-----
 linux-user/main.c                   |  5 ++
 linux-user/mmap.c                   | 28 +++++++----
 linux-user/syscall.c                | 73 ++++++++++++++++++++++++++++-
 target/arm/cpu.c                    | 17 +++++++
 target/arm/mte_helper.c             | 39 ++++++++++++++-
 target/arm/tlb_helper.c             | 27 ++++++++---
 tests/tcg/aarch64/mte-1.c           | 25 ++++++++++
 tests/tcg/aarch64/mte-2.c           | 42 +++++++++++++++++
 tests/tcg/aarch64/mte-3.c           | 47 +++++++++++++++++++
 tests/tcg/aarch64/Makefile.target   |  4 ++
 22 files changed, 502 insertions(+), 63 deletions(-)
 create mode 100644 tests/tcg/aarch64/mte.h
 create mode 100644 tests/tcg/aarch64/mte-1.c
 create mode 100644 tests/tcg/aarch64/mte-2.c
 create mode 100644 tests/tcg/aarch64/mte-3.c

-- 
2.25.1



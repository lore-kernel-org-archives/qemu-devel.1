Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF37BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 17:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E5FB20872
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 17:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uAyubkjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5FB20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbSWX-0002t0-Pe
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 13:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbSVk-0001ly-SC
 for qemu-devel@nongnu.org; Wed, 20 May 2020 13:28:08 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbSVj-0004J3-8Y
 for qemu-devel@nongnu.org; Wed, 20 May 2020 13:28:08 -0400
Received: by mail-pg1-x544.google.com with SMTP id u5so1754674pgn.5
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 10:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m0smmKWM3ILO4U+9uDDvaXLhnVQU+uqi21bdkLG9M4I=;
 b=uAyubkjmSYu+FanEeckKrlw42FYgwjHiTxzfInZCMJUFSHco1oVpYZbNSeQRBtGFB8
 wMkOc8pQEho5TQQspDXOEUBUybULWfyfzYC3PkiOascdyFHfEHGP6WktMyjfBC5MHZSb
 XoAMjWbZVP9OJDKakMWN60XtHmbji6YouNkGW0KRHYKVG7r65RVLndN3mbH/km2AEXsS
 3g6hHJ1ukiPl+nfLWzmfK2MNH4yIvwFJwu+BQLduZ/mF/ZXuk5jVpLO8646uGXdvle5/
 KeHskhsCzAJowTtoiYvqWS91Un3X/HhnxnCuc0WLqHfKPirlGFcdJ+xJcZjMvl6PU2Qz
 ++Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m0smmKWM3ILO4U+9uDDvaXLhnVQU+uqi21bdkLG9M4I=;
 b=D8tS4Z6udCHNO77zxReuCpzNt9owUVbJKH7/RniQUPvqh0qDSUA8PQgFDrzoJLPQjC
 iYFg8BR5so3O9jOOFdW/cQtOC4ynK02yWbACJCAp0msd2NWiGq8xmEUd3WwsdabpTzEE
 jrtONd9+s+E8vE4OQ1ZesuuI98natlG+V+hy7iCI7DuH2aqO1TrGL/JJdRgPMmHrPgD0
 /dtdPwH+14E+Evt6QcX79bKizJe6QUINtcXc5xt66FOQ03btweJa8t1XIHJ7jjBaOvNk
 Hnd1Cr3Sb8P4IZgSFhOQHOxtQ4iRwhPFP+CAcrtRcaZztj3jkQaeR5xtqIZnzuxLkBuE
 HWPg==
X-Gm-Message-State: AOAM530ICwpVmjJqZrl/B0vQ+scuD6ng4JAZPZx2RTNeuavO3gYtJsdP
 lXZTd+/O1Rpz4bbWQn7PlEGOvQqsAhM=
X-Google-Smtp-Source: ABdhPJwFk26JU3KGGyeWqdbIJvdjT5BG6Bmb7x04xo8/oqysOFpDY3f6IzmSpCuCgfSYnlfnsie2RQ==
X-Received: by 2002:a65:51ca:: with SMTP id i10mr5195627pgq.115.1589995682243; 
 Wed, 20 May 2020 10:28:02 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id k18sm2643672pfg.217.2020.05.20.10.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 10:28:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 0/5] linux-user: User support for AArch64 BTI
Date: Wed, 20 May 2020 10:27:55 -0700
Message-Id: <20200520172800.8499-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kernel ABI for this is (finally) close to being merged:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/bti-user

I've made a couple of tweaks from v8:

 (1) Only map the interpreter or a static executable with BTI.
     The interpreter is responsible for handling the pages of
     a dynamic executable.  This is a behaviour change in the
     kernel ABI since the last time I audited the code.

 (2) Rely on the recently released gcc 10 for building the test case.
     Thanks to Alex for helping me get a docker setup for that.

Based-on: <20200519185645.3915-1-richard.henderson@linaro.org>
("linux-user: mmap/mprotect prot values")

Based-on: An unpublished version of stsquad's testing/next

So for avoidance of doubt, the complete tree may be found at

https://github.com/rth7680/qemu/tree/tgt-arm-bti


r~


Richard Henderson (5):
  linux-user/aarch64: Reset btype for signals
  linux-user: Set PAGE_TARGET_1 for TARGET_PROT_BTI
  include/elf: Add defines related to GNU property notes for AArch64
  linux-user: Parse NT_GNU_PROPERTY_TYPE_0 notes
  tests/tcg/aarch64: Add bti smoke test

 include/elf.h                     |  22 +++++
 include/exec/cpu-all.h            |   2 +
 linux-user/qemu.h                 |   4 +
 linux-user/syscall_defs.h         |   4 +
 linux-user/aarch64/signal.c       |  10 ++-
 linux-user/elfload.c              | 143 ++++++++++++++++++++++--------
 linux-user/mmap.c                 |  16 ++++
 target/arm/translate-a64.c        |   6 +-
 tests/tcg/aarch64/bti-1.c         |  62 +++++++++++++
 tests/tcg/aarch64/bti-crt.inc.c   |  51 +++++++++++
 tests/tcg/aarch64/Makefile.target |   7 ++
 tests/tcg/configure.sh            |   4 +
 12 files changed, 291 insertions(+), 40 deletions(-)
 create mode 100644 tests/tcg/aarch64/bti-1.c
 create mode 100644 tests/tcg/aarch64/bti-crt.inc.c

-- 
2.20.1



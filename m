Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE69C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9748C21531
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fd76l9IT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9748C21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKg8-0003LP-Pe
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jmKWM-0005En-NC
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:09:42 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jmKWK-0004qg-Pz
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:09:42 -0400
Received: by mail-wr1-x443.google.com with SMTP id b6so10373579wrs.11
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=33jMxZwxgXxmUOJv94id4+UgOjK1tI0YM/XIzTe9z9I=;
 b=Fd76l9ITXyakjw9v81IxZymwW4n0b8J0g96xgYGoz0qVG7RaWrAf8ukyIn1OZr6bqw
 UXDxu7vGVogcw7lMsPkbE5fK4LkDnraoDNocaagn4FSLsq6i5fiEm2uN1lvMEb8Teas5
 uxIoklGg24B64cMBYO9SvQ1YxPbjjtWhLErUAi1WzLnPiKcy7hkY23ndM7kc45v92a56
 fdIwNsN0EzCnu9GhcIAt/+f6scVojMZKwZHQMAlu+btJbEAE9LKndsiPGETDwPHwZziU
 f7qE3ItAUtD/uqsb/As7lFQkMrQNfDqW5MJ8zHeWYR5a0fBPOmVIL13EG5C93s+cIRPE
 9LZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=33jMxZwxgXxmUOJv94id4+UgOjK1tI0YM/XIzTe9z9I=;
 b=CTtvMMOvNWGlJX7c1XYjAz0YrI3ypAd0ThXs4SCXM9hgZ5HZRRX/LLlVxxR9YtEQdS
 QrX7z2pk8h8CAUNo5hpr1GPC/FfetWwcy5lM/UFGmgLFXho++MeYxBNc0A3ZRjFnwkpn
 vkc/WgAEThcNF979gXtbfSwgOpWygSGNysffVZmfcMWxukMG/7RAHiUYCSnzKMglL265
 4PueJLa5wDMnY2UKVtkoxIJTgWuVHiZLo148uWS9Zb37jq4Rj0CvxyLgh7ZF5FTP3D/6
 +jbeoHwKxETy9bVG8ODqAKlJxz8ShnIFlDx24kKBN77s3WwDgWqNgJ0e5XuU+4nobdFk
 LYQg==
X-Gm-Message-State: AOAM531IZo7sUSvfiXPHa7DG1SrE0MUwKhA6j9718VFL8UwiDhSVPjCL
 7CCdPnlUze7gcqrqvFSkhOBynQ==
X-Google-Smtp-Source: ABdhPJx/z8A/8cdrrjLUocEEnQSsi/bmncDgr5svVp/r8fYByOfCh6JBQ9F85gn+silPHEwwZbPLSQ==
X-Received: by 2002:a5d:56c7:: with SMTP id m7mr5063694wrw.223.1592586579159; 
 Fri, 19 Jun 2020 10:09:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h13sm3827610wrp.77.2020.06.19.10.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 10:09:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CF09D1FF7E;
 Fri, 19 Jun 2020 18:09:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] docs/devel: add some notes on tcg-icount for developers
Date: Fri, 19 Jun 2020 18:09:30 +0100
Message-Id: <20200619170930.11704-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This attempts to bring together my understanding of the requirements
for icount behaviour into one reference document for our developer
notes. It currently make one piece of conjecture which I think is true
that we don't need gen_io_start/end statements for non-MMIO related
I/O operations.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200619135844.23307-1-alex.bennee@linaro.org>

---
v2
  - fix copyright date
  - it's -> its
  - drop mentioned of gen_io_end()
  - remove and correct original conjecture
---
 docs/devel/tcg-icount.rst | 89 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 docs/devel/tcg-icount.rst

diff --git a/docs/devel/tcg-icount.rst b/docs/devel/tcg-icount.rst
new file mode 100644
index 00000000000..cb51cb34dde
--- /dev/null
+++ b/docs/devel/tcg-icount.rst
@@ -0,0 +1,89 @@
+..
+   Copyright (c) 2020, Linaro Limited
+   Written by Alex Bennée
+
+
+========================
+TCG Instruction Counting
+========================
+
+TCG has long supported a feature known as icount which allows for
+instruction counting during execution. This should be confused with
+cycle accurate emulation - QEMU does not attempt to emulate how long
+an instruction would take on real hardware. That is a job for other
+more detailed (and slower) tools that simulate the rest of a
+micro-architecture.
+
+This feature is only available for system emulation and is
+incompatible with multi-threaded TCG. It can be used to better align
+execution time with wall-clock time so a "slow" device doesn't run too
+fast on modern hardware. It can also provides for a degree of
+deterministic execution and is an essential part of the record/replay
+support in QEMU.
+
+Core Concepts
+=============
+
+At its heart icount is simply a count of executed instructions which
+is stored in the TimersState of QEMU's timer sub-system. The number of
+executed instructions can then be used to calculate QEMU_CLOCK_VIRTUAL
+which represents the amount of elapsed time in the system since
+execution started. Depending on the icount mode this may either be a
+fixed number of ns per instructions or adjusted as execution continues
+to keep wall clock time and virtual time in sync.
+
+To be able to calculate the number of executed instructions the
+translator starts by allocating a budget of instructions to be
+executed. The budget of instructions is limited by how long it will be
+until the next timer will expire. We store this budget as part of a
+vCPU icount_decr field which shared with the machinery for handling
+cpu_exit(). The whole field is checked at the start of every
+translated block and will cause a return to the outer loop to deal
+with whatever caused the exit.
+
+In the case of icount before the flag is checked we subtract the
+number of instructions the translation block would execute. If this
+would cause the instruction budget to got negative we exit the main
+loop and regenerate a new translation block with exactly the right
+number of instructions to take the budget to 0 meaning whatever timer
+was due to expire will expire exactly when we exit the main run loop.
+
+Dealing with MMIO
+-----------------
+
+While we can adjust the instruction budget for known events like timer
+expiry we can not do the same for MMIO. Every load/store we execute
+might potentially trigger an I/O event at which point we will need an
+up to date and accurate reading of the icount number.
+
+To deal with this case when an I/O access is made we:
+
+  - restore un-executed instructions to the icount budget
+  - re-compile a single [1]_ instruction block for the current PC
+  - exit the cpu loop and execute the re-compiled block
+
+The new block is created with the CF_LAST_IO compile flag which
+ensures the final instruction translation starts with a call to
+gen_io_start() so we don't enter a perpetual loop constantly
+recompiling a single instruction block. For translators using the
+common translator_loop this is done automatically.
+  
+.. [1] sometimes two instructions if dealing with delay slots  
+
+Other I/O operations
+--------------------
+
+MMIO isn't the only type of operation for which we might need a
+correct and accurate clock. IO port instructions and accesses to
+system registers are the common examples here. These instructions have
+to be handled by the individual translators which have the knowledge
+of which operations are I/O operations.
+
+.. warning:: Any instruction that eventually causes an access to
+             QEMU_CLOCK_VIRTUAL needs to be preceded by a
+             gen_io_start() and must also be the last instruction
+             translated in the block.
+   
+
+
+
-- 
2.20.1



Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41066C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09C6B207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzcFeOSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C6B207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmHYi-0006Mw-Av
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 09:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jmHXj-0005G1-5R
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:58:55 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jmHXh-0001xi-9k
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:58:54 -0400
Received: by mail-wr1-x442.google.com with SMTP id h5so9815493wrc.7
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 06:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=56swg9m7x4afL9ERav2fhFo7u7ycjKdoOMzkEstl03E=;
 b=TzcFeOShSYaYLoEdRvUZLmwFaz69TDE9dFXjjyDCP9nUwRqWoD+BQokg92yHnWY6YP
 kE0fTacM3F6WMTwbAN0GFHf9Ud2XSYKuP6Ezok4oql8QyIB6/OBrlxjaiOLCPy6LL3ef
 Y5DYIfGdsxbN2FOgRF4duaeCvzPrB/nskptrbvA6FlBc4OqSOJFWunmd/roWRjMee5YC
 5xTylnik0XYokU7kNwPf8ozeYccSMuGPGuT3ZnnznCLtLhK7VEV9eE03QgzEKLhEXOvi
 9Fu8GBOdtmnpQFVC80PmAHkjKfxUxgUeljw4WBLlv3ECMMXwCi93vPQRcSepAuysz3DS
 a6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=56swg9m7x4afL9ERav2fhFo7u7ycjKdoOMzkEstl03E=;
 b=nH2tM5W7p7dQFONKirQQQtWwV6tP0YdLHd3mOnkq/YQiwIQJPMa1GQbWFQXIwMWEDF
 ty9NViVwbU2n9geNjnHvJOYcQSd0vTHCFosOc2qh1hhnoIbulx6/O84sI1hgvaOtiTb7
 aYSP05J1ti0H+xGpa8t6ZBjEKZkaRhQ8w3u642DQbuLb4pwpZdohlG1uhjwc16ts9SuV
 zOfXOmk/n6Npa8KWELd3OMHj2BeVJO1pyACvbYEBHbwppA1ggyPFOiBlweq5hLV6Nh5q
 Xr2LklzsctZ8Petr6NdzFSWOYuuLMLrrHzsDj8knY1S+/FoJraF+p4Mp43dJWcsEwm5p
 0u2A==
X-Gm-Message-State: AOAM531455YMny91NanzqFe9VzX2MJptA6RaNqLEvEH+1wVnt3749pVM
 EfyR6ssudcmatkEP61xK01jtXg==
X-Google-Smtp-Source: ABdhPJzgU1Jo+fwJv6r0ncrHFdT5g+7/Zw4jSw6Kktb7SE+MpLakSSlFwZQDK7jl/up3U9BlzUuIpg==
X-Received: by 2002:a5d:6884:: with SMTP id h4mr4635578wru.198.1592575131529; 
 Fri, 19 Jun 2020 06:58:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b185sm16229336wmd.3.2020.06.19.06.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 06:58:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9588F1FF7E;
 Fri, 19 Jun 2020 14:58:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] docs/devel: add some notes on tcg-icount for developers
Date: Fri, 19 Jun 2020 14:58:44 +0100
Message-Id: <20200619135844.23307-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
---
 docs/devel/tcg-icount.rst | 86 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 docs/devel/tcg-icount.rst

diff --git a/docs/devel/tcg-icount.rst b/docs/devel/tcg-icount.rst
new file mode 100644
index 00000000000..53d08ce9282
--- /dev/null
+++ b/docs/devel/tcg-icount.rst
@@ -0,0 +1,86 @@
+..
+   Copyright (c) 2019, Linaro Limited
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
+At it's heart icount is simply a count of executed instructions which
+is stored in the TimersState of QEMU's timer sub-system. The number of
+executed instructions can then be used to calculate QEMU_CLOCK_VIRTUAL
+which represents the amount of elapsed time in the system since
+execution started. Depending on the icount mode this may either be a
+fixed number of ns per instructions or adjusted as execution continues
+to keep real time and virtual time in sync.
+
+To be able to calculate the number of executed instructions the
+translator starts by allocating a budget of instructions to be
+executed. The budget of instructions is limited by how long it will be
+until the next timer will expire. We store this budget as part of a
+CPUs icount_decr field which shared with the machinery for handling
+cpu_exit(). The whole field is checked at the start of every
+translated block and will cause us to return to the outer loop to deal
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
+ensures the final instruction is wrapped with a
+gen_io_start()/gen_io_end() pair so we don't enter a perpetual loop
+constantly recompiling a single instruction block. For translators
+using the common translator_loop this is done automatically.
+  
+.. [1] sometimes two instructions if dealing with delay slots  
+
+Other I/O operations
+--------------------
+
+MMIO isn't the only type of operation for which we might need a
+correct and accurate clock. IO port instructions and accesses to
+system registers are the common examples here. For the clock to be
+accurate you end a translation block on these instructions.
+
+.. warning:: (CONJECTURE) instructions that won't get trapped in the
+             io_read/writex shouldn't need gen_io_start/end blocks
+             around them.
+
+
+
-- 
2.20.1



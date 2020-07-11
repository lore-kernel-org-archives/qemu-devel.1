Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C83C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5336207D4
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RnPerTqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5336207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juIzK-00054G-SQ
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 13:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juIyS-0003OO-Ux
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:07:40 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:37235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juIyR-0006hO-0E
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:07:40 -0400
Received: by mail-wr1-x434.google.com with SMTP id a6so8983389wrm.4
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 10:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GlUgvngOZnRX3GgJ1xL0C8Uj1g/LwLg5JPDA/WlWH+w=;
 b=RnPerTqm3aHrkXW+4VWK2Ac7jngKyC9bnsEq+1MloYKVxdzRnCoWWpyuHaFqy5SyXp
 Asg+dyXwdeptZ5C5JnPooDg5FHZWm+OseYqulHCpl7io/DxJCqczBvBTp7809XvNmu3V
 AZxf13OjpeZFTmE3RkXV5Sw8HkEfhh3ZawRm1egMzURdCk4Dfxy53w6bZBkSMRRusYE2
 LAoQggCJtqXUG4Cs3aqNqwkjBHiqdfkjwHnX1xEcDn82/FChf6/I6DWApuONasXf8rN5
 JPLT/r5fgYCebENoj1FoAP826+Z0V7VPmM1QtN4WmcnFdYlrGe//tUmFnHMfICzYHGpJ
 FMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GlUgvngOZnRX3GgJ1xL0C8Uj1g/LwLg5JPDA/WlWH+w=;
 b=oXx1qDZ4Stfu1DOzCwC6UO0mMNMEbKmmzwRgtwsTOyE1QsA7EoCN/QaNciEcU8mx6n
 Ch+gtpGV8j5me2iKjH11KWShBUqisjb/tOGVUQ109NyqOt1QGFgHoAThdgQtUtRZ9I9a
 p0j2KsI5ogB1WwMbQ8siflFY6tWRwlA8LJqc1/PTKD6MQQy3j2n+OjV2Ejt0zT30xMeR
 xIAlzALk/z3zavjnPGax9C6ZmNihUgpRw5gx5hfaf1uC6l1wKUkPjcU+Vpama/wU2biu
 igxht4vgh4ujFMBM9DALJbGBGhjVecs5t+aJGAkZujDiWfMhII/BYi3u+9W5zNM8kHAb
 5kJg==
X-Gm-Message-State: AOAM53067aa9aBjLOLs3fxN4T0nlSWlndV7Fz0CLWWV0NZXZc8Faar/G
 8bUXLvmt/djXehmMpi5kEOwkLA==
X-Google-Smtp-Source: ABdhPJx9reANItf2+uduOE3QgE/oERPRdPU3LF8kdclnZMOb7H7Bu3pfc5p526oS+mvVOR6g14hQ2Q==
X-Received: by 2002:adf:c3c7:: with SMTP id d7mr70401426wrg.51.1594487257607; 
 Sat, 11 Jul 2020 10:07:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v12sm15239745wrt.31.2020.07.11.10.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 10:07:32 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 676101FF8F;
 Sat, 11 Jul 2020 18:07:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 43/50] docs/devel: add some notes on tcg-icount for
 developers
Date: Sat, 11 Jul 2020 18:07:25 +0100
Message-Id: <20200711170732.26213-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711170732.26213-1-alex.bennee@linaro.org>
References: <20200711170732.26213-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This attempts to bring together my understanding of the requirements
for icount behaviour into one reference document for our developer
notes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200709141327.14631-3-alex.bennee@linaro.org>

diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 4ecaea3643..ae6eac7c9c 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -23,6 +23,7 @@ Contents:
    decodetree
    secure-coding-practices
    tcg
+   tcg-icount
    multi-thread-tcg
    tcg-plugins
    bitops
diff --git a/docs/devel/tcg-icount.rst b/docs/devel/tcg-icount.rst
new file mode 100644
index 0000000000..8d67b6c076
--- /dev/null
+++ b/docs/devel/tcg-icount.rst
@@ -0,0 +1,97 @@
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
+instruction counting during execution. This should not be confused
+with cycle accurate emulation - QEMU does not attempt to emulate how
+long an instruction would take on real hardware. That is a job for
+other more detailed (and slower) tools that simulate the rest of a
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
+fixed number of ns per instruction or adjusted as execution continues
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
+In the case of icount, before the flag is checked we subtract the
+number of instructions the translation block would execute. If this
+would cause the instruction budget to go negative we exit the main
+loop and regenerate a new translation block with exactly the right
+number of instructions to take the budget to 0 meaning whatever timer
+was due to expire will expire exactly when we exit the main run loop.
+
+Dealing with MMIO
+-----------------
+
+While we can adjust the instruction budget for known events like timer
+expiry we cannot do the same for MMIO. Every load/store we execute
+might potentially trigger an I/O event, at which point we will need an
+up to date and accurate reading of the icount number.
+
+To deal with this case, when an I/O access is made we:
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
+When the translator is handling an instruction of this kind:
+
+* it must call gen_io_start() if icount is enabled, at some
+   point before the generation of the code which actually does
+   the I/O, using a code fragment similar to:
+
+.. code:: c
+
+    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
+
+* it must end the TB immediately after this instruction
+
+Note that some older front-ends call a "gen_io_end()" function:
+this is obsolete and should not be used.
-- 
2.20.1



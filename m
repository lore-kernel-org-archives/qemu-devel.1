Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEBBC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:45:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E2320760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0sn1ef5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E2320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhfL-0007lj-Bh
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQT-0003OZ-Bp
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:21 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:38718)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQR-0001XJ-CC
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:20 -0400
Received: by mail-wm1-x333.google.com with SMTP id v12so1934195wmh.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6WD9Ks2QvGXimCjR6xfwgm6lrYby8X5mCiKe4m027WE=;
 b=R0sn1ef50AyVUmtCZIuzV/uNjf7h55rB0BfPToTyp2qCxgA8H7dbyFDOqLl6gSMS3Y
 SaAS2CzMgFSI2sSFGLnrJeeBfdKtiJinLt+Pg7o62Y53Ji2vuralqIeVtK9bUuz4mwTV
 d4idtc/sr33biXhpWdaRWzUpT1okxKsPo6AWcegTQt0qKsfpF7YJcEIM58MT9F0FafZp
 3CkRuhlG6DrlvUSjgvXvy8B6K0SYzGKC/c2Av6jm6WrdqBgHCiEqaeAiioVbUHJz2uxc
 2VPAsE9sGLrQ6Qd6n3oprWZebnsVhYNIPGL18B6BVOyo22RLFRa7AhFNh03hf5JJyS5G
 s1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6WD9Ks2QvGXimCjR6xfwgm6lrYby8X5mCiKe4m027WE=;
 b=ENmU+jcZTy16X7iRxU7jTKRonTGkmCZVsnmzO7Ee2GH0zQDjuZl0pS85NOi+LW5MGs
 orjUVgMbJ7zuUlMOmIP90KgF9qkt6srTzQEJmlI2k+92sL01A0i0dAOlCtcf+vDuBzft
 mvPH9jIj5hyBAh7CZ6doOChfaYcqiMpwVgcGKrZ+tsnwr56JmZG3BU4FS0wa/KmOXule
 GdkESJagGISNWI9v/tfEz2wdRU4HkOkyNot+JnVexBD4DxQe2V6j7aZdD3FWhVV12sX9
 LN8eQ420yF+0UxcPf+Ta6hg5rLmRuo5AZ1iaYFeE9CRy2eEtfuMRgEMXlspol2zlhBjr
 T8TA==
X-Gm-Message-State: AOAM5331/eppFZZ9x6cNO4XbDc8+MePzJN4lOqB7k60B+9BOH3AIa52U
 /SSegEnz1Im4G8Md8hGmBD6rlWWUPAA=
X-Google-Smtp-Source: ABdhPJztGnKN3vKINbbFKytqlgzKRP8Q6EFVNGUGjqw8SI/VUpdx1ckBO/IB8Uvo6vca0SKtaOSogQ==
X-Received: by 2002:a1c:6a0a:: with SMTP id f10mr3302175wmc.86.1601969417737; 
 Tue, 06 Oct 2020 00:30:17 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:30:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 35/37] replay: describe reverse debugging in docs/replay.txt
Date: Tue,  6 Oct 2020 09:29:45 +0200
Message-Id: <20201006072947.487729-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch updates the documentation and describes usage of the reverse
debugging in QEMU+GDB.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

--

v4 changes:
 - added an example of the command line for reverse debugging of
   the diskless machine
Message-Id: <160174523509.12451.1409905901920738979.stgit@pasha-ThinkPad-X280>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/replay.txt | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/docs/replay.txt b/docs/replay.txt
index 8952e6d852..87a64ae068 100644
--- a/docs/replay.txt
+++ b/docs/replay.txt
@@ -265,6 +265,16 @@ of the original disk image, use overlay files linked to the original images.
 Therefore all new snapshots (including the starting one) will be saved in
 overlays and the original image remains unchanged.
 
+When you need to use snapshots with diskless virtual machine,
+it must be started with 'orphan' qcow2 image. This image will be used
+for storing VM snapshots. Here is the example of the command line for this:
+
+  qemu-system-i386 -icount shift=3,rr=replay,rrfile=record.bin,rrsnapshot=init \
+    -net none -drive file=empty.qcow2,if=none,id=rr
+
+empty.qcow2 drive does not connected to any virtual block device and used
+for VM snapshots only.
+
 Network devices
 ---------------
 
@@ -294,6 +304,42 @@ for recording and replaying must contain identical number of ports in record
 and replay modes, but their backends may differ.
 E.g., '-serial stdio' in record mode, and '-serial null' in replay mode.
 
+Reverse debugging
+-----------------
+
+Reverse debugging allows "executing" the program in reverse direction.
+GDB remote protocol supports "reverse step" and "reverse continue"
+commands. The first one steps single instruction backwards in time,
+and the second one finds the last breakpoint in the past.
+
+Recorded executions may be used to enable reverse debugging. QEMU can't
+execute the code in backwards direction, but can load a snapshot and
+replay forward to find the desired position or breakpoint.
+
+The following GDB commands are supported:
+ - reverse-stepi (or rsi) - step one instruction backwards
+ - reverse-continue (or rc) - find last breakpoint in the past
+
+Reverse step loads the nearest snapshot and replays the execution until
+the required instruction is met.
+
+Reverse continue may include several passes of examining the execution
+between the snapshots. Each of the passes include the following steps:
+ 1. loading the snapshot
+ 2. replaying to examine the breakpoints
+ 3. if breakpoint or watchpoint was met
+    - loading the snaphot again
+    - replaying to the required breakpoint
+ 4. else
+    - proceeding to the p.1 with the earlier snapshot
+
+Therefore usage of the reverse debugging requires at least one snapshot
+created in advance. This can be done by omitting 'snapshot' option
+for the block drives and adding 'rrsnapshot' for both record and replay
+command lines.
+See the "Snapshotting" section to learn more about running record/replay
+and creating the snapshot in these modes.
+
 Replay log format
 -----------------
 
-- 
2.26.2




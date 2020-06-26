Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B08C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A3320656
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A3320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jood6-0004J6-7p
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 09:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1jolTY-0000Ok-26
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:20:52 -0400
Received: from mail.ispras.ru ([83.149.199.84]:59562)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1jolTW-0000YG-Cw
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:20:51 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id A3C6640A92BE;
 Fri, 26 Jun 2020 10:20:48 +0000 (UTC)
Subject: [PATCH 12/13] replay: describe reverse debugging in docs/replay.txt
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jun 2020 13:20:48 +0300
Message-ID: <159316684833.10508.798035270216502557.stgit@pasha-ThinkPad-X280>
In-Reply-To: <159316678008.10508.6615172353109944370.stgit@pasha-ThinkPad-X280>
References: <159316678008.10508.6615172353109944370.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 06:19:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 26 Jun 2020 09:41:37 -0400
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, pavel.dovgalyuk@ispras.ru,
 ehabkost@redhat.com, alex.bennee@linaro.org, mtosatti@redhat.com,
 armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, crosa@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch updates the documentation and describes usage of the reverse
debugging in QEMU+GDB.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
---
 0 files changed

diff --git a/docs/replay.txt b/docs/replay.txt
index 70c27edb36..18d6169f3b 100644
--- a/docs/replay.txt
+++ b/docs/replay.txt
@@ -294,6 +294,39 @@ for recording and replaying must contain identical number of ports in record
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
+created in advance. See the "Snapshotting" section to learn about running
+record/replay and creating the snapshot in these modes.
+
 Replay log format
 -----------------
 



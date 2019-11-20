Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94B9C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0FD420731
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="d9l/vjsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0FD420731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRSN-0006Y9-JQ
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 09:59:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1iXROo-0004je-J0
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1iXROn-0004Al-8r
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:56:06 -0500
Received: from mout.gmx.net ([212.227.15.19]:58973)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1iXROm-0004AG-RU
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1574261759;
 bh=1ubok1u63c1rSbLKP6w6jiBXY2S+LRHqFH652t8sVrA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=d9l/vjsJQm7fo/ykoW35ms+pD956vnVPEizocz3/JAt7T9KN+8TTKWzCm8lAY0Pi2
 Tq3a5Tfnn/88ytHc+1Jh4JhMI1lQke+ScC9TZl4HfwwbsjeXg2CmBjbZqp8319CqMJ
 2onV7xRzOXNsFBBuXLbhmsDhRwAquP00y0LJ0lQg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.153.182]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvbBk-1hgAFl00Fa-00scTr; Wed, 20
 Nov 2019 15:55:59 +0100
Date: Wed, 20 Nov 2019 15:55:55 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] linux-user/strace: Add missing signal strings
Message-ID: <20191120145555.GA15154@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Provags-ID: V03:K1:k+HKkEMSKiPMm9aFvXJz7FA6cigmrkUWkyld9IF0+EMl5HWsHpZ
 UMLb6dqcHu2R7dyYoJdJfk0+3tuNLsbyXlS3ttimJFWgdhwLJl65A8jDlsbPrjuvwdPKL5f
 5AkLF/XOIsAibomsgnxUpY0tItpHwH7yhQWLu67NLXe4L7Eg/DQWyJ5jNHXMpCrMZAp81oY
 YI23p7gyg/YkhEvrdK+8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cbYcewHEtQU=:KYLAnxcbPM4Q5vyT4eiHSP
 jsTuSkHj/LiakiuqNuFm3YuynRH/HWSIMbW7AlJjlDvB/O4jQTJyJyVL0KQfYNX4Vp61c406u
 QR2ar3oZ2H+nJCzUlg74TNPfPLct9xFb+wsai0dCZ2aHe5m38B9Iy9r4dUOai3M+/WcCe/G0c
 JlVqP9g4w54ZX+xZEKkYngoVm6OSlJjpp4cj6kDqcIrwvUMKOd7XPBxZ/Q/hWhUCk18i0NAwl
 lPQQoGLkDldYkV15nO/Rdnf5wmnRYPODuresIzFUg9dc77LAvPvqxEgVIShO5JDYcL2IYvzWm
 /bJzSzG4/3x+dKTmSkSbFqvkBQhVnzhZkXqS4ieq6UDanZm3xIw0fxW4fANu8yRKGqFNBI4/k
 5cUcctfWcUIsvVGpI+lsZoA74QdtecAh9s8uyiOBn6XR5darQ/QL4siMp6WS/eiwBoSZG0lgt
 uGtHhskGal1cf4n5kGKC7nlo/JApDUNXt7KFZPTz/gnXssa/RT5ng+bQbvPcNAJzYKd8N87lA
 vwksdIp/YApQPaZcW/eY/hTIQ7Ef8/xexHE/q7JGDz5EkEzTgAh4aeyyX5B47Rl9pLHHwyWl8
 FcpQTwoEsZxk6G3GbRayBQQLx0Wt+zbmkH6HLpnLe7EGs+SB4drDeIYUC8ApWLP8vKtIRNUKe
 rqEAb/bpsSbwqGQPIeoZXxX3AWziB50hktIloOR2/ahjPvtswCjXsa/6Q5Il4kxjdvwsTU0Ye
 18vTY5NZw1UJHVHRawoT1UcoEwoBKk8tOluVIocTYi6xnQlM/5fvFUt/DoRADAey4efvcjCJD
 u8FemS/i0Uz3Fqz4nndlddeujRdGEz7hr50uR/b2PFp8fUp1J260FknmfQuoYvffeEy5BI/Qe
 vMtm8J1nIJsRkMWoim40aRP4mYq1IrPVEaqchDMidYcG5Xir3O671KAWrpYlX8olLbgvDFpUo
 SEd6b1mSvr16MJvcou1sYHGPOS954jQQmcnrAZao2ToItokXmP5RAKLVE2PI1Gi73HtLobDhM
 hnhjEjS8TJqaEh6mmCnBDYCVwuHff+MsGIzEcB/iQyXWALAwtbJ9jIa9Rets9RFMjK7cBQQ2k
 VWS0BJAc/kbX7HqMkf1QOmcst31CDDj16tzD5ey/e/Oo6QrZ5bkmeUXxainBlhMlxvkjX6Uhw
 op2GcwrXY6yjY62PnD6UBJdF0o5AMsBvuReKhf2wVxs22nZILZMxTD9gM/NAct7hc1NZ/bFqo
 3XRFNhXidl0AfAZwRKzE2EWAE2nErl3qqdOC/uQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.19
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
 Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the textual representations of some missing target signals.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 3d4d684450..de43238fa4 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -146,6 +146,19 @@ print_signal(abi_ulong arg, int last)
     case TARGET_SIGSTOP: signal_name = "SIGSTOP"; break;
     case TARGET_SIGTTIN: signal_name = "SIGTTIN"; break;
     case TARGET_SIGTTOU: signal_name = "SIGTTOU"; break;
+    case TARGET_SIGIO: signal_name = "SIGIO"; break;
+    case TARGET_SIGBUS: signal_name = "SIGBUS"; break;
+    case TARGET_SIGPWR: signal_name = "SIGPWR"; break;
+    case TARGET_SIGURG: signal_name = "SIGURG"; break;
+    case TARGET_SIGSYS: signal_name = "SIGSYS"; break;
+    case TARGET_SIGTRAP: signal_name = "SIGTRAP"; break;
+    case TARGET_SIGXCPU: signal_name = "SIGXCPU"; break;
+    case TARGET_SIGPROF: signal_name = "SIGPROF"; break;
+    case TARGET_SIGTSTP: signal_name = "SIGTSTP"; break;
+    case TARGET_SIGXFSZ: signal_name = "SIGXFSZ"; break;
+    case TARGET_SIGWINCH: signal_name = "SIGWINCH"; break;
+    case TARGET_SIGVTALRM: signal_name = "SIGVTALRM"; break;
+    case TARGET_SIGSTKFLT: signal_name = "SIGSTKFLT"; break;
     }
     if (signal_name == NULL) {
         print_raw_param("%ld", arg, last);


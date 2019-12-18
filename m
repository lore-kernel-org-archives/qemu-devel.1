Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD6EC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 156162176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156162176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihZBw-0005hK-0W
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 08:16:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ihYx6-0001xm-6b
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ihYx4-0007zW-MR
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:01:19 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:40751)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1ihYx1-0007ge-AA; Wed, 18 Dec 2019 08:01:15 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mt7Pt-1hp3WQ00z3-00tPoh; Wed, 18 Dec 2019 14:01:11 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 5/7] target/sparc: Remove old TODO file
Date: Wed, 18 Dec 2019 14:01:03 +0100
Message-Id: <20191218130105.125981-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218130105.125981-1-laurent@vivier.eu>
References: <20191218130105.125981-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bKfy2QzkGVq3B4KwCkJG1BCHQ+Kwx6GjFWipxIkeISNUQQDSx9G
 276T34V+p2WSG/jLpk12hDfm1jV9GslZNcMY8wlZyYnv1P9rj+s9B2c8eQXD0On9dxxSSWw
 1CGjwIj278Z0zFHbuaU+a5+GjfxiOyuwb8gFiLem1uvmCYzk21YIxXQzY5g06zVMEdugaF9
 wbxK/girfkTH+M/9mQLsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TkUqZgL0x6M=:p+TwhpnT4CR5kRLMQREU57
 aKdQI3glGwzh80N96ZWLj9A0W20Np+YfNn35m4tpeX0afX37orfSpwWda2LDH8h5GPP2hak9f
 cjgL5Ux4Q5tn7/5ws3qJxU8kS9czAe+/hkI8XIg2GTgFy5z+dMKDiJznoP3N/cACtflAyzJHr
 zjn1KXtFCFu5OGqiDmvRz8LFCQaq/Uf3E3POu+bQZpt8LYLPIHb2R4SxEGsmxLCO5bWeZDXzF
 ShgbJEONF0kWFu3lGFqajB2CuMjPEMbx45ncy+CD9DHP9ytjdwZkiA4bIWppoxZArH9xuMaiS
 X7p3yPFovKfeMSUeCEy6fxU9m9+9U9Fe8FxgO9QJ9o3sZcg/9N6yHixh57iZCSb9WkJEUdi8T
 PmGfwypUF4IzmKmghLsjZ6iB082BLeavB8HqTt41dFL69KsACYiFYfVOBlsExpF4oDh3fjkPx
 7iHgCpfgle4sSA9PpJLsTwxn8ygujlKv614U6EsxIKbmxq+E/OKRx/7QjG6kO6UUfIiCMVq1o
 OC+OpWw713dnezdCQM5IoWq0+5fYJqsPPSo1GfTWjl6QKQT6xHNPeMfi8LlqCay/ivIInIu0K
 +d3AyUhE2hEiu8rbqiJBNyH3B7VJoF5OMUvXZ07lYyntNB3Wk3zr/LfLxuFEWhrqoUZ4pC0Yi
 C8SYKmXi5nSl7/zyRXqxpllffj/++T5wHddOLitwbmh/H6gFq+J5tioeYd8/pHJPbj4ZGnApo
 q5MDVlVbU+9WEAaoSmacnWnVOySVYI71rxAVv7B02Nq1tZypra0F5S9bNt9r2shZl9HCZWil+
 dEtF2lEpEHa9EBjIdbL5hypYrr8u0EC1SdQ/6OUkOLN1YjCbfLW09F2TCgngYDt+KK4C5qTmq
 sz6B4lALCS+JUiUs+cwg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.130
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

This file hasn't seen a real (non-trivial) update since 2008 anymore,
so we can assume that it is pretty much out of date and nobody cares
for it anymore. Let's simply remove it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <20190930171044.25312-1-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/sparc/TODO | 88 -----------------------------------------------
 1 file changed, 88 deletions(-)
 delete mode 100644 target/sparc/TODO

diff --git a/target/sparc/TODO b/target/sparc/TODO
deleted file mode 100644
index b8c727e85846..000000000000
--- a/target/sparc/TODO
+++ /dev/null
@@ -1,88 +0,0 @@
-TODO-list:
-
-CPU common:
-- Unimplemented features/bugs:
- - Delay slot handling may fail sometimes (branch end of page, delay
- slot next page)
- - Atomical instructions
- - CPU features should match real CPUs (also ASI selection)
-- Optimizations/improvements:
- - Condition code/branch handling like x86, also for FPU?
- - Remove remaining explicit alignment checks
- - Global register for regwptr, so that windowed registers can be
- accessed directly
- - Improve Sparc32plus addressing
- - NPC/PC static optimisations (use JUMP_TB when possible)? (Is this
- obsolete?)
- - Synthetic instructions
- - MMU model dependent on CPU model
- - Select ASI helper at translation time (on V9 only if known)
- - KQemu/KVM support for VM only
- - Hardware breakpoint/watchpoint support
- - Cache emulation mode
- - Reverse-endian pages
- - Faster FPU emulation
- - Busy loop detection
-
-Sparc32 CPUs:
-- Unimplemented features/bugs:
- - Sun4/Sun4c MMUs
- - Some V8 ASIs
-
-Sparc64 CPUs:
-- Unimplemented features/bugs:
- - Interrupt handling
- - Secondary address space, other MMU functions
- - Many V9/UA2005/UA2007 ASIs
- - Rest of V9 instructions, missing VIS instructions
- - IG/MG/AG vs. UA2007 globals
- - Full hypervisor support
- - SMP/CMT
- - Sun4v CPUs
-
-Sun4:
-- To be added
-
-Sun4c:
-- A lot of unimplemented features
-- Maybe split from Sun4m
-
-Sun4m:
-- Unimplemented features/bugs:
- - Hardware devices do not match real boards
- - Floppy does not work
- - CS4231: merge with cs4231a, add DMA
- - Add cg6, bwtwo
- - Arbitrary resolution support
- - PCI for MicroSparc-IIe
- - JavaStation machines
- - SBus slot probing, FCode ROM support
- - SMP probing support
- - Interrupt routing does not match real HW
- - SuSE 7.3 keyboard sometimes unresponsive
- - Gentoo 2004.1 SMP does not work
- - SS600MP ledma -> lebuffer
- - Type 5 keyboard
- - Less fixed hardware choices
- - DBRI audio (Am7930)
- - BPP parallel
- - Diagnostic switch
- - ESP PIO mode
-
-Sun4d:
-- A lot of unimplemented features:
- - SBI
- - IO-unit
-- Maybe split from Sun4m
-
-Sun4u:
-- Unimplemented features/bugs:
- - Interrupt controller
- - PCI/IOMMU support (Simba, JIO, Tomatillo, Psycho, Schizo, Safari...)
- - SMP
- - Happy Meal Ethernet, flash, I2C, GPIO
- - A lot of real machine types
-
-Sun4v:
-- A lot of unimplemented features
- - A lot of real machine types
-- 
2.24.1



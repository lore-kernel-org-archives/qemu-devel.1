Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429ECC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:15:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3192076E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3192076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKcWc-0007f8-IM
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 03:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1kKcVY-0006iy-M4
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:14:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:37153)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1kKcVV-0006Lq-Au
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:14:36 -0400
IronPort-SDR: HyhLptx9yxOJqOjeebNftHCEd4Z7Epvja0dJR0wXsvV5eW2mFTyh2vuWxh4NBzZ2/rm1sCZ4ne
 u361xhdLnEgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="222141830"
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; d="scan'208";a="222141830"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 00:14:32 -0700
IronPort-SDR: l79sfWKdKxjwfXJbDUcJZIHMt/fnd7gbf2NGaPe8FnkJa2QyPSrCbgt6fz//W8nhI23BXjrEiY
 8l/EoKDJonXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; d="scan'208";a="341918109"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by fmsmga002.fm.intel.com with ESMTP; 22 Sep 2020 00:14:29 -0700
From: Robert Hoo <robert.hu@linux.intel.com>
To: ehabkost@redhat.com, eblake@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net, armbru@redhat.com
Subject: [PATCH v4 2/2] Mark Icelake-Client CPU models deprecated
Date: Tue, 22 Sep 2020 15:14:15 +0800
Message-Id: <1600758855-80046-2-git-send-email-robert.hu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600758855-80046-1-git-send-email-robert.hu@linux.intel.com>
References: <1600758855-80046-1-git-send-email-robert.hu@linux.intel.com>
Received-SPF: none client-ip=134.134.136.31;
 envelope-from=robert.hu@linux.intel.com; helo=mga06.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 03:14:31
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: robert.hu@intel.com, qemu-devel@nongnu.org,
 Robert Hoo <robert.hu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Going to obsolete Icelake-Client CPU models in the future.

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
Change log
v4:
Deprecation note is general now. More detailed information is moved to
docs/system/deprecated.rst.

v3:
Obsolete in v5.2 --> v5.3.

---
 docs/system/deprecated.rst |  6 ++++++
 target/i386/cpu.c          | 10 +++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 0cb8b01..5dc2ff3 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -329,6 +329,12 @@ The ``compat`` property used to set backwards compatibility modes for
 the processor has been deprecated. The ``max-cpu-compat`` property of
 the ``pseries`` machine type should be used instead.
 
+``Icelake-Client`` CPU Model (since 3.1)
+''''''''''''''''''''''''''''''''''''''''
+
+``Icelake-Client`` CPU Models are deprecated. Use ``Icelake-Server`` CPU
+Models instead.
+
 System emulator devices
 -----------------------
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 323c7e3..5566356 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3358,10 +3358,13 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .xlevel = 0x80000008,
         .model_id = "Intel Core Processor (Icelake)",
         .versions = (X86CPUVersionDefinition[]) {
-            { .version = 1 },
+            {
+                .version = 1,
+                .note = "Deprecated"
+            },
             {
                 .version = 2,
-                .note = "no TSX",
+                .note = "no TSX, Deprecated",
                 .alias = "Icelake-Client-noTSX",
                 .props = (PropValue[]) {
                     { "hle", "off" },
@@ -3370,7 +3373,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
                 },
             },
             { /* end of list */ }
-        }
+        },
+        .deprecation_note = "Deprecated. Use Icelake-Server instead."
     },
     {
         .name = "Icelake-Server",
-- 
1.8.3.1



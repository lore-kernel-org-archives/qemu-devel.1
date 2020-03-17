Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E32C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4408520719
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4408520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE5EL-0005aY-HJ
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 01:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <like.xu@linux.intel.com>) id 1jE5Dg-000553-QQ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <like.xu@linux.intel.com>) id 1jE5Df-0006VA-EY
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:56:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:19038)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
 id 1jE5Df-0005au-6m; Tue, 17 Mar 2020 01:56:51 -0400
IronPort-SDR: r2WD3s/tiA+FvtPYfWQAHun7wDUnqCSpi8hTxfWWZTr7KOj16SBR3k2PMvjWRK1iPjpXrOUeV1
 tzcHRIUHhYkw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2020 22:56:44 -0700
IronPort-SDR: 9c5T64UsMmZ1iD+Q6QCAj1UFomKlCJwR/AVoK2+Q8MrJH5N+j9qYQcKuhf38yfavro3zT26vsT
 DiPQ/6k4TaMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; d="scan'208";a="445384869"
Received: from sqa-gate.sh.intel.com (HELO clx-ap-likexu.tsp.org)
 ([10.239.48.212])
 by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2020 22:56:43 -0700
From: Like Xu <like.xu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH] i386/cpu: Expand MAX_FIXED_COUNTERS from 3 to 4 to for Icelake
Date: Tue, 17 Mar 2020 13:54:13 +0800
Message-Id: <20200317055413.66404-1-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.20
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Like Xu <like.xu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the Intel SDM, "Table 18-2. Association of Fixed-Function
Performance Counters with Architectural Performance Events",
we may have a new fixed counter 'TOPDOWN.SLOTS' (since Icelake),
which counts the number of available slots for an unhalted
logical processor. Check commit 6017608936 in the kernel tree.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 target/i386/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 576f309bbf..ec2b67d425 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1185,7 +1185,7 @@ typedef struct {
 #define CPU_NB_REGS CPU_NB_REGS32
 #endif
 
-#define MAX_FIXED_COUNTERS 3
+#define MAX_FIXED_COUNTERS 4
 #define MAX_GP_COUNTERS    (MSR_IA32_PERF_STATUS - MSR_P6_EVNTSEL0)
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
-- 
2.21.1



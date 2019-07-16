Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625DFC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:01:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BFC720880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFC720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnPsw-00030S-Hp
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 12:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43104)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paul.c.lai@intel.com>) id 1hnPsR-0001Hi-F8
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paul.c.lai@intel.com>) id 1hnPsP-0007k5-U6
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:00:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:24367)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <paul.c.lai@intel.com>)
 id 1hnPsP-0007e8-M3
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:00:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Jul 2019 09:00:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,498,1557212400"; d="scan'208";a="342758654"
Received: from pclaidev.sc.intel.com ([143.183.85.146])
 by orsmga005.jf.intel.com with ESMTP; 16 Jul 2019 09:00:16 -0700
From: Paul Lai <paul.c.lai@intel.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 08:58:08 -0700
Message-Id: <20190716155808.25010-1-paul.c.lai@intel.com>
X-Mailer: git-send-email 2.17.2
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
Subject: [Qemu-devel]  Fixing Snowridge CPU model name and features
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
Cc: wei.w.wang@intel.com, luwei.kang@intel.com, tao3.xu@intel.com,
 paul.c.lai@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changing the name to Snowridge from SnowRidge-Server.
There is no client model of Snowridge, so "-Server" is unnecessary.

Removing CPUID_EXT_VMX from Snowridge cpu feature list.

Signed-off-by: Paul Lai <paul.c.lai@intel.com>
Tested-by: Tao3 Xu <tao3.xu@intel.com>
---
 target/i386/cpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 63d89276fe..7f56e887ae 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2688,7 +2688,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .model_id = "Intel Xeon Processor (Icelake)",
     },
     {
-        .name = "SnowRidge-Server",
+        .name = "Snowridge",
         .level = 27,
         .vendor = CPUID_VENDOR_INTEL,
         .family = 6,
@@ -2706,7 +2706,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_FXSR | CPUID_SSE | CPUID_SSE2,
         .features[FEAT_1_ECX] =
             CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_MONITOR |
-            CPUID_EXT_VMX |
             CPUID_EXT_SSSE3 |
             CPUID_EXT_CX16 |
             CPUID_EXT_SSE41 |
-- 
2.17.2



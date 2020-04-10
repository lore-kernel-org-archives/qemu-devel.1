Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60FCC2BB86
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 06:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA0E2063A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 06:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA0E2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMnGj-0000Z5-Q6
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 02:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenyi.qiang@intel.com>) id 1jMnFa-0007HQ-V0
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 02:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenyi.qiang@intel.com>) id 1jMnFZ-0007DM-SX
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 02:34:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:42757)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chenyi.qiang@intel.com>)
 id 1jMnFZ-0007BO-LK
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 02:34:49 -0400
IronPort-SDR: EGEVUS0wPxpD4VnSD2Y8ZuKxj4qOW9ROCXvZ1TTKeKgWiF4v1GOAzM6EpeKjWKcCHky8q2u6h8
 7GYnIF7Csk0g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 23:34:47 -0700
IronPort-SDR: R2p4DFymLWwVHchEGoYrdiv087rMj6e2XpD2eJbqcTblmkCifkAQPIa8nmMcvz9PDs4u40mHM/
 5DATugx0FWGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,364,1580803200"; d="scan'208";a="425800280"
Received: from chenyi-pc.sh.intel.com ([10.239.159.72])
 by orsmga005.jf.intel.com with ESMTP; 09 Apr 2020 23:34:45 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH v3 4/4] target/i386: modify Icelake-Server CPU model number
Date: Fri, 10 Apr 2020 14:35:55 +0800
Message-Id: <20200410063555.2309-5-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200410063555.2309-1-chenyi.qiang@intel.com>
References: <20200410063555.2309-1-chenyi.qiang@intel.com>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.100
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
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 Robert Hoo <robert.hu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to the Intel Icelake family list, Icelake-Server uses model
number 106(0x6A).

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d2f8a276c4..04bcf01b5a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3364,7 +3364,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .level = 0xd,
         .vendor = CPUID_VENDOR_INTEL,
         .family = 6,
-        .model = 134,
+        .model = 106,
         .stepping = 0,
         .features[FEAT_1_EDX] =
             CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
-- 
2.17.1



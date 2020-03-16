Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B202DC18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 10:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497F620658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 10:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497F620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDn0T-0004hY-MO
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 06:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiaoyao.li@intel.com>) id 1jDmZR-0003bq-Qu
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xiaoyao.li@intel.com>) id 1jDmZP-0001d2-4e
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:02:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:46378)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xiaoyao.li@intel.com>)
 id 1jDmZO-00018N-EQ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:02:02 -0400
IronPort-SDR: RLO4Ze4FAl4ycvx5kj/TxNx3i4/NUGmkdxgHw+T4cKsa1GljZfmBZpF+UEAxMPb5z7pCGHulIp
 GFX2AFLPy7fA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2020 03:01:52 -0700
IronPort-SDR: JgOmwo0g4HksdkWOCRIEitFm2qR1z0erOZEGSdMO4bWJx/DL0AG+nXOuoqQ7jHjnEQ22sGZpn/
 PYodh2E/qsNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,559,1574150400"; d="scan'208";a="267511272"
Received: from lxy-dell.sh.intel.com ([10.239.13.109])
 by fmsmga004.fm.intel.com with ESMTP; 16 Mar 2020 03:01:52 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH v2] target/i386: Add ARCH_CAPABILITIES related bits into
 Icelake-Server CPU model
Date: Mon, 16 Mar 2020 17:56:05 +0800
Message-Id: <20200316095605.12318-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: e90ff880-c395-9013-6855-eaa4be7969be@redhat.com
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.151
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
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Current Icelake-Server CPU model lacks all the features enumerated by
MSR_IA32_ARCH_CAPABILITIES.

Add them, so that guest of "Icelake-Server" can see all of them.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
v2:
 - Add it as a new version.
---
 target/i386/cpu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 92fafa265914..5fba6a2ad6b3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3496,6 +3496,19 @@ static X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 },
             },
+            {
+                .version = 3,
+                .props = (PropValue[]) {
+                    { "arch-capabilities", "on" },
+                    { "rdctl-no", "on" },
+                    { "ibrs-all", "on" },
+                    { "skip-l1dfl-vmentry", "on" },
+                    { "mds-no", "on" },
+                    { "pschange-mc-no", "on" },
+                    { "taa-no", "on" },
+                    { /* end of list */ }
+                },
+            },
             { /* end of list */ }
         }
     },
-- 
2.20.1



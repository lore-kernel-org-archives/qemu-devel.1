Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3083CC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82DA2064E
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82DA2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISyu-0008LU-L0
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1kISwX-0005jz-HL
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:37:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:47314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1kISwU-00078m-Kj
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:37:33 -0400
IronPort-SDR: dXnNaK4+qYMpEgYD9yD3VKw5KMU0OaQ+Ta4zCoKBcotWeUVWEN20b0jVgLcNriCEBfOT3TC1hg
 kHRRPLSxFznQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="158705914"
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; d="scan'208";a="158705914"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2020 01:37:28 -0700
IronPort-SDR: b3kyrAn65mKXzuqOzuQ4r5CZ0YGPGlSwRVZOXEQyHeqn2hLeFVgFVMJ/Utssyq7rbfy6kD416m
 CeZvJ+/HSy0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; d="scan'208";a="306959088"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by orsmga006.jf.intel.com with ESMTP; 16 Sep 2020 01:37:26 -0700
From: Robert Hoo <robert.hu@linux.intel.com>
To: ehabkost@redhat.com, eblake@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net, armbru@redhat.com
Subject: [PATCH v3 2/2] Mark Icelake-Client CPU models deprecated
Date: Wed, 16 Sep 2020 16:37:14 +0800
Message-Id: <1600245434-63021-2-git-send-email-robert.hu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600245434-63021-1-git-send-email-robert.hu@linux.intel.com>
References: <1600245434-63021-1-git-send-email-robert.hu@linux.intel.com>
Received-SPF: none client-ip=192.55.52.115;
 envelope-from=robert.hu@linux.intel.com; helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 04:37:26
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
v3:
Obsolete in v5.2 --> v5.3.

 target/i386/cpu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9cb82b7..15c1c00 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3467,7 +3467,12 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .xlevel = 0x80000008,
         .model_id = "Intel Core Processor (Icelake)",
         .versions = (X86CPUVersionDefinition[]) {
-            { .version = 1 },
+            {
+                .version = 1,
+                .deprecated = true,
+                .note = "Deprecated. Will be obsoleted in v5.3. Please use "
+                        "'Icelake-Server-v1' CPU model",
+            },
             {
                 .version = 2,
                 .note = "no TSX",
@@ -3477,6 +3482,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
                     { "rtm", "off" },
                     { /* end of list */ }
                 },
+                .deprecated = true,
+                .note = "Deprecated. Will be obsoleted in v5.3. Please use "
+                        "'Icelake-Server-v2' CPU model",
             },
             { /* end of list */ }
         }
-- 
1.8.3.1



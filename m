Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9894FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C00A20759
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C00A20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqBH5-00069n-Nw
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1jqBGX-0005fX-4i
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:05:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:27272)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1jqBGU-0001jO-3B
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:05:16 -0400
IronPort-SDR: ed8oQUS+Vzu8AOG1+n4ASqDRZh1O9xQUjtNqWBS8G2ytwAKDqw6lKpr/pU6MDjgSK1I1IGjZfb
 DhtKOPxjOKuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="133622474"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; d="scan'208";a="133622474"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 01:05:08 -0700
IronPort-SDR: gKJ37AnQCx1UWP+jTFVnoHaEFXph2P2PnD2oaXyAtHK+Bd7xOkmYvYXZzzBQA0Rr8+PM7QTkaO
 VtBiPbxeT+VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; d="scan'208";a="454515633"
Received: from icx-2s.bj.intel.com ([10.240.192.138])
 by orsmga005.jf.intel.com with ESMTP; 30 Jun 2020 01:05:07 -0700
From: Luwei Kang <luwei.kang@intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: Correct the warning message of Intel PT
Date: Tue, 30 Jun 2020 14:38:33 +0800
Message-Id: <1593499113-4768-1-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=luwei.kang@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 04:05:09
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, Luwei Kang <luwei.kang@intel.com>, ehabkost@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CPUID level need to be set to 0x14 manually on old
machine-type if Intel PT is enabled in guest. E.g. the
CPUID[0].EAX(level)=7 and CPUID[7].EBX[25](intel-pt)=1 when the
Qemu with "-machine pc-i440fx-3.1 -cpu qemu64,+intel-pt" parameter.

This patch corrects the warning message of the previous
submission(ddc2fc9).

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 90ffc5f..a0e39d1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6375,7 +6375,7 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
             } else if (cpu->env.cpuid_min_level < 0x14) {
                 mark_unavailable_features(cpu, FEAT_7_0_EBX,
                     CPUID_7_0_EBX_INTEL_PT,
-                    "Intel PT need CPUID leaf 0x14, please set by \"-cpu ...,+intel-pt,level=0x14\"");
+                    "Intel PT need CPUID leaf 0x14, please set by \"-cpu ...,+intel-pt,min-level=0x14\"");
             }
         }
 
-- 
1.8.3.1



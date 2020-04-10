Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0074EC2BB85
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 06:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCCE02063A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 06:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCE02063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMnGi-0000WU-Ux
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 02:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenyi.qiang@intel.com>) id 1jMnFb-0007HP-20
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 02:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenyi.qiang@intel.com>) id 1jMnFZ-0007CD-EA
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 02:34:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:42754)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chenyi.qiang@intel.com>)
 id 1jMnFZ-0007Al-6n
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 02:34:49 -0400
IronPort-SDR: gSwy3RgQGX03+N/WOtdi0sFHbmqbf4OCvfrEGD+6Ah0Kf8dkv0ziGNze2eQUpjnFWSidGmAcA3
 lVmdNYJTP+tg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 23:34:41 -0700
IronPort-SDR: uLEH4+2TgYoEpNNj2/mfPAdBmkyJcsUUXcyYk5fa6HwIn1Wc58jHi/t5od+mlNwrHTBZeGXNkG
 mMFTN+Df0Gmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,364,1580803200"; d="scan'208";a="425800261"
Received: from chenyi-pc.sh.intel.com ([10.239.159.72])
 by orsmga005.jf.intel.com with ESMTP; 09 Apr 2020 23:34:39 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH v3 1/4] target/i386: add missing vmx features for several CPU
 models
Date: Fri, 10 Apr 2020 14:35:52 +0800
Message-Id: <20200410063555.2309-2-chenyi.qiang@intel.com>
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

Add some missing VMX features in Skylake-Server, Cascadelake-Server and
Icelake-Server CPU models based on the output of Paolo's script.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 target/i386/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 90ffc5f3b1..3ed7502e80 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2982,6 +2982,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
              VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
              VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
              VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Skylake)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -3110,6 +3111,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
              VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
              VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
              VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Cascadelake)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -3457,7 +3459,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
              VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
              VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
              VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
-             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+             VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Icelake)",
         .versions = (X86CPUVersionDefinition[]) {
-- 
2.17.1



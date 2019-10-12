Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C75C10F14
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 12:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6640D2089F
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 12:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6640D2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJGVS-00049t-Jw
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 08:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cathy.zhang@intel.com>) id 1iJBRt-0001Gu-R5
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 03:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cathy.zhang@intel.com>) id 1iJBRs-0001yg-1G
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 03:04:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:29439)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cathy.zhang@intel.com>)
 id 1iJBRr-0001wh-PE
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 03:04:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Oct 2019 00:04:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,286,1566889200"; d="scan'208";a="197802834"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.238.156.101])
 by orsmga003.jf.intel.com with ESMTP; 12 Oct 2019 00:04:14 -0700
From: Cathy Zhang <cathy.zhang@intel.com>
To: pbonzini@redhat.com,
	rth@twiddle.net,
	ehabkost@redhat.com
Subject: [PATCH 2/3] i386: Add macro for stibp
Date: Sat, 12 Oct 2019 15:00:37 +0800
Message-Id: <1570863638-22272-3-git-send-email-cathy.zhang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570863638-22272-1-git-send-email-cathy.zhang@intel.com>
References: <1570863638-22272-1-git-send-email-cathy.zhang@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
X-Mailman-Approved-At: Sat, 12 Oct 2019 08:24:54 -0400
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
Cc: qemu-devel@nongnu.org, Cathy Zhang <cathy.zhang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

stibp feature is already added through the following commit.
https://github.com/qemu/qemu/commit/0e8916582991b9fd0b94850a8444b8b80d0a0955

Add a macro for it to allow CPU models report it when host supports.

Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>
---
 target/i386/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e757149..c47bcb5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -717,6 +717,7 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
 #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
+#define CPUID_7_0_EDX_STIBP     (1U << 27) /* Single Thread Indirect Branch Predictors */
 #define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities*/
 #define CPUID_7_0_EDX_CORE_CAPABILITY   (1U << 30)  /*Core Capability*/
 #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
-- 
1.8.3.1



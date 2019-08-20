Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E61C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9611B214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9611B214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyQZ-0002M7-Cc
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8x-0005xl-R7
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8w-0003o0-Dk
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10336)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy8u-0003dp-Ds
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3AEA43091D63;
 Tue, 20 Aug 2019 07:01:11 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F1EB60BE2;
 Tue, 20 Aug 2019 07:01:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:50 +0200
Message-Id: <1566284395-30287-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 20 Aug 2019 07:01:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 31/36] kvm: vmxcap: Enhance with latest features
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Based on SDM from May 2019.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/kvm/vmxcap | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
index 99a8146..d8c7d6d 100755
--- a/scripts/kvm/vmxcap
+++ b/scripts/kvm/vmxcap
@@ -178,7 +178,11 @@ controls = [
             19: 'Conceal non-root operation from PT',
             20: 'Enable XSAVES/XRSTORS',
             22: 'Mode-based execute control (XS/XU)',
+            23: 'Sub-page write permissions',
+            24: 'GPA translation for PT',
             25: 'TSC scaling',
+            26: 'User wait and pause',
+            28: 'ENCLV exiting',
             },
         cap_msr = MSR_IA32_VMX_PROCBASED_CTLS2,
         ),
@@ -197,6 +201,7 @@ controls = [
             22: 'Save VMX-preemption timer value',
             23: 'Clear IA32_BNDCFGS',
             24: 'Conceal VM exits from PT',
+            25: 'Clear IA32_RTIT_CTL',
             },
         cap_msr = MSR_IA32_VMX_EXIT_CTLS,
         true_cap_msr = MSR_IA32_VMX_TRUE_EXIT_CTLS,
@@ -214,6 +219,7 @@ controls = [
             15: 'Load IA32_EFER',
             16: 'Load IA32_BNDCFGS',
             17: 'Conceal VM entries from PT',
+            18: 'Load IA32_RTIT_CTL',
             },
         cap_msr = MSR_IA32_VMX_ENTRY_CTLS,
         true_cap_msr = MSR_IA32_VMX_TRUE_ENTRY_CTLS,
@@ -227,6 +233,7 @@ controls = [
             6: 'HLT activity state',
             7: 'Shutdown activity state',
             8: 'Wait-for-SIPI activity state',
+            14: 'PT in VMX operation',
             15: 'IA32_SMBASE support',
             (16,24): 'Number of CR3-target values',
             (25,27): 'MSR-load/store count recommendation',
@@ -249,6 +256,7 @@ controls = [
             17: '1GB EPT pages',
             20: 'INVEPT supported',
             21: 'EPT accessed and dirty flags',
+            22: 'Advanced VM-exit information for EPT violations',
             25: 'Single-context INVEPT',
             26: 'All-context INVEPT',
             32: 'INVVPID supported',
-- 
1.8.3.1




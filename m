Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ADAC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8837421D6C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8837421D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGoxl-0004EO-J1
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGoo1-0002wn-8Y; Fri, 11 Sep 2020 15:33:57 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:43811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGonz-0000qB-40; Fri, 11 Sep 2020 15:33:56 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N3omW-1kh2ty0cU4-00zjhC; Fri, 11 Sep 2020 21:33:50 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 14/18] target/i386/kvm: Rename host_tsx_blacklisted() as
 host_tsx_broken()
Date: Fri, 11 Sep 2020 21:33:26 +0200
Message-Id: <20200911193330.1148942-15-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911193330.1148942-1-laurent@vivier.eu>
References: <20200911193330.1148942-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ByzX+nKrU9Pn4umFephF1QbtRl8A/12WTAEMwwAf2fcVuf8nmQy
 DmLcO6ggFMt+YE36skQSW1hF9QBFEYmX57411DBFQFrUVCDpCCDREKpzbpfjAuMf7/M/Mks
 4HTyAYYDRQxNzlC3kXdQUSL89vLB9BZIa9VuKfU/Br3c+nG2utj5ritqL6G6UDOBBn4Y6+j
 0wS6QAcjOZQFwv3jnsO7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:secB9ygbXB4=:wb8DnbEG1Acrhl06BddOd7
 Fy/EqviGqcXbgjR6wZ7UT99ODYUwIjNm1YXHfJ9Ez85rf0AI7zlGDXx9edjhEiccrT07BVaT+
 W5+YbEBeFByN7b0iBHe6dfVnLltEHRpiP3VMGbI1JUl7efWMJ38HZExNQ0s23Tcf/lDj87Rd/
 F2DZoo/kNVrLKf+CnnDXUof3wnZiIOkQMDAz4ZFASy9Y73GpWwBtycvs8ygzkVFEP6HJePnSW
 iZ2KNiZyM79PYETAmKAogy5Uwg106shzQpfUVSndASVuRCWCdgOXkftBJRPfBPhle2kjvJutR
 cR/n1lGLidQcMI8FVcXspxWtokUr5U1uoFGDeSM2mBa37leHJfpphGzb8M91/Kr5+mK+msG9Y
 lYELfwMb1EM+3kqn77mEbvE3iniTlbT7jBicxPzMO30p0Cvk2Kro0wlaszdhxqO14PYf202Ab
 Ozeaz+7zqrgchQA6L64dv63HqIqVU34jLVZZPKWloD6fSZv6y8VLn6HXgB3k7VFRI8mmnFjya
 AsMnWxTZVaMweVU05yDrIKlIWetH/JUQ+2//51QwlyNCKaaJchiIT/kgCzN0P6AGcm/mXvEvB
 W00fkq7KKZV1PbTOJVsUPHlW2xEOm8xp5K70g9XL+rHyx2cIOlf95XIzqSjn4iSAOEyIfn7z9
 TNt2KyhdHvFDFJYM1zkventj2+0dCE1XQ+2xvm1aMmiFoDemMvGskrnm66HCsko5pJCCSi3aa
 MZtiz7owggrHCbeh3Eizjvn5tW5RVw0x3jAJTzYktDekvYGgrWIWsEs7xYaf1t4JfDqiP87L1
 SBocenNMPVi+FzHxv3Qdx2pPrFXM282rA/y6wU0gxzDR3fg0rnTd14gsU0SShMxhai9GhGl
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 15:33:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

In order to use inclusive terminology, rename host_tsx_blacklisted()
as host_tsx_broken().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200910070131.435543-7-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/i386/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 205b68bc0ce8..3d640a8decf6 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -302,7 +302,7 @@ static int get_para_features(KVMState *s)
     return features;
 }
 
-static bool host_tsx_blacklisted(void)
+static bool host_tsx_broken(void)
 {
     int family, model, stepping;\
     char vendor[CPUID_VENDOR_SZ + 1];
@@ -408,7 +408,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
     } else if (function == 6 && reg == R_EAX) {
         ret |= CPUID_6_EAX_ARAT; /* safe to allow because of emulated APIC */
     } else if (function == 7 && index == 0 && reg == R_EBX) {
-        if (host_tsx_blacklisted()) {
+        if (host_tsx_broken()) {
             ret &= ~(CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_HLE);
         }
     } else if (function == 7 && index == 0 && reg == R_EDX) {
-- 
2.26.2



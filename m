Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DC8C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA41221E5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1NMYsxHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA41221E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLt3l-0004W9-5v
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 15:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kLt1s-0001hC-IO
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:05:15 -0400
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com
 ([40.107.236.89]:10240 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kLt1q-0002ju-SY
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:05:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/Um1p3AovVydtswi1qLrr150t3z4GQQmCNZcDBDYXXwg7VyA/Z5hBWG2buJ14FeWJCkj9dmRw7PIs3D1DLxqxUvFkVBdm4eXSJMkBm5ihGOAAJaijnfroZcsY9nlk30aOrm6oErhW4pQ64nNhJouFcDgbV55+Pl0gy3VFiKxZwoE5/qHDaNQ09XTGOqHTzDoPcFfaUak8vy7K+PlyKmxPYHI8TRfI7aRTFvKAjRlW3Q2E/SDr4wG0wF2RjmLnQp6QmZqmdFh+sXeeC4TS4uZKIwbdbBt8hsy5elCIHl7knrHritTuGQ+PoyYAKqxhv/Pj/m6pnqcFJgvLCLjIC6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTsr4nd8RWrfRb11z5zIPJohWSIyFWKOcjm5SrLAVyc=;
 b=FUwOmjDfAGl0ITLro8j8A95v0NicFGye1fFPGAwTxNLEcgUeklajl0sldmEecyke0V9oaqxzHS679rLv/CglBaVOhiNnrL2FCvxEBy8dcXnJt4L/fX+fZSxPu4IXP4CypJotfZrawXhECOZ9f5hHG6dJWTchSoV70U52v3uBxdP1P4ihYB+Ndm2M/NWP5BKhnb2urEUzdXbjoxN5ETdVrTjo+lI1WFu8R4NaidzuKqP8A1xwDmlUU9whlN1mIlYgCXyysqaxuhkrYGLB+pfHefmRHddbyFEmik0K1V1Uq2ZN7PgQycJC3b8RYIpGVVJjEuN6MXkWNMONNk3CGQ4d+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTsr4nd8RWrfRb11z5zIPJohWSIyFWKOcjm5SrLAVyc=;
 b=1NMYsxHOiUbIikt55f078kcTqSFipLr61pi6BgDvEFTLklRFGtxzc4zxWY6rVD9brVNghH2IAwCRoIkGhCZ2gqzXAIUmhrztQhpzDL2fVzO3cJXCZP+jMudJbAjgCOQGWtvhyAGNzi0UWOXsBRQqcTBTcSIlzNooRCZYUxNtsQk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.22; Fri, 25 Sep 2020 19:04:48 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3391.024; Fri, 25 Sep 2020
 19:04:48 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 4/6] sev/i386: Don't allow a system reset under an SEV-ES
 guest
Date: Fri, 25 Sep 2020 14:03:38 -0500
Message-Id: <c40de4c1bf4d14d60942fba86b2827543c19374a.1601060620.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1601060620.git.thomas.lendacky@amd.com>
References: <cover.1601060620.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR20CA0044.namprd20.prod.outlook.com
 (2603:10b6:3:13d::30) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by
 DM5PR20CA0044.namprd20.prod.outlook.com (2603:10b6:3:13d::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 19:04:47 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eda5e69a-bde3-45dd-b25e-08d86185df89
X-MS-TrafficTypeDiagnostic: DM6PR12MB4297:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4297D0B1B35925344B131D56EC360@DM6PR12MB4297.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QWklHsCGlz2k1irQtRKW4+XTWpwBpR1EYN4s+8W694UxUjMOERw5Uvnu3oYeNrsMozBRyCXb+nti0uOo74GYqehrlfsHwKCky8AGJcu176+Ecstj5P8w280C4axZSi0vyaNI5pqKIFDECJzVXOm+wN+/cccMpcccI76XsK7KJzejcQvJyoKnLeiVrlI6Z8jPyHxUTld0x+syCSDSb+uvM8bV8HmjCWTuevWvYrDp4Pd8Szy+Cma19yKAtTlvX0zMol2y+qzfT85CwZ8mSWosdnyQ3TAW8sYipsnKQzBiE0vyX/HfPGwvIg1L2SVFbJjS8LVuiYWmLTiCITbkpjuKyiI91EnD8xaxTyMNs5NH0X0+G4Q1X2dtu0gn4RKnufFi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(26005)(7416002)(956004)(186003)(6666004)(16526019)(54906003)(2616005)(6486002)(66556008)(66946007)(36756003)(8936002)(66476007)(86362001)(316002)(478600001)(7696005)(52116002)(2906002)(5660300002)(4326008)(83380400001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: erUX9xP7UvcEAtZoZrbp6OP7DMItOjj6XR3zcgR+pbF7q9Xi3F5wsadC8Ejb+xI5rq81XpyYgcQVpAVulheIIJoZ46b2bU2pQt8Xi6TtfrROvBppnXrkxFQuYenhfcTDHFawOCZJmhxTn8qO7QzCMqmSGZ8ljbANYHe2QF/Nwt7n9iFXKY6WjOx6W7EokcbduQR6LsrmN2IGlEtFzz5a7jqUYThkXk3I9BZU5vNOItmXZYFifkMngATf1DbRTtFTt1N2eGOJIRMOxEzG/YR6xFkag+JJlJhqxrvIQ38aqzA7w0jjdxuIt8JIqcW6Zf4+y+AV2+xpVA8RnIl9zhvHtqca0u2cp0yrnuCedMtuzkh/XBl2rKORYOAd+2Kyw9ZSJ+EKT4rr+Hg2zXk7ie8vRQ2Dsh41q6l++SbHFrHumYazStHbnHbKGfJXxD10mOUSCzG/e70Y42CK44hGWz1c0fQGlJRhUdAeoRYubeE1qZSmmItZS+FDfOST/c/ldfDTp+6WClr/pcIus7Wr1QbSbAGI32XChldqJFEjuWOLbqL0xc27BMyBAt9ZDaGw5P51w0IzIXoMQOpp7OqtTvFK0e+n3aAArPs4UVFrymVGhBZqe0+IW//wc4UiytqyhaCci6uyTmDOp/Htle25CZ/qmg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda5e69a-bde3-45dd-b25e-08d86185df89
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 19:04:48.4381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPxYTdMnMaOIY4Kys3FEJCjFTRyhX3KYVJEsEJ2gFtpKDiarbQuRGAlLUyuzo5TogATHVzdqxpzRJOiQuZv44A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
Received-SPF: none client-ip=40.107.236.89;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 15:05:00
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Brijesh Singh <brijesh.singh@amd.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Connor Kuehl <ckuehl@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Jiri Slaby <jslaby@suse.cz>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tom Lendacky <thomas.lendacky@amd.com>

An SEV-ES guest does not allow register state to be altered once it has
been measured. When an SEV-ES guest issues a reboot command, Qemu will
reset the vCPU state and resume the guest. This will cause failures under
SEV-ES. Prevent that from occuring by introducing an arch-specific
callback that returns a boolean indicating whether vCPUs are resettable.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 accel/kvm/kvm-all.c       |  5 +++++
 include/sysemu/cpus.h     |  2 ++
 include/sysemu/hw_accel.h |  5 +++++
 include/sysemu/kvm.h      | 10 ++++++++++
 softmmu/cpus.c            |  5 +++++
 softmmu/vl.c              |  5 ++++-
 target/arm/kvm.c          |  5 +++++
 target/i386/kvm.c         |  6 ++++++
 target/mips/kvm.c         |  5 +++++
 target/ppc/kvm.c          |  5 +++++
 target/s390x/kvm.c        |  5 +++++
 11 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 08b66642dd..a161fff813 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2388,6 +2388,11 @@ void kvm_flush_coalesced_mmio_buffer(void)
     s->coalesced_flush_in_progress = false;
 }
 
+bool kvm_cpu_check_are_resettable(void)
+{
+    return kvm_arch_cpu_check_are_resettable();
+}
+
 static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->vcpu_dirty) {
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index 3c1da6a018..d3e6cdf126 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -24,6 +24,8 @@ void dump_drift_info(void);
 void qemu_cpu_kick_self(void);
 void qemu_timer_notify_cb(void *opaque, QEMUClockType type);
 
+bool cpus_are_resettable(void);
+
 void cpu_synchronize_all_states(void);
 void cpu_synchronize_all_post_reset(void);
 void cpu_synchronize_all_post_init(void);
diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
index e128f8b06b..6d387226d4 100644
--- a/include/sysemu/hw_accel.h
+++ b/include/sysemu/hw_accel.h
@@ -17,6 +17,11 @@
 #include "sysemu/hvf.h"
 #include "sysemu/whpx.h"
 
+static inline bool cpu_check_are_resettable(void)
+{
+    return kvm_enabled() ? kvm_cpu_check_are_resettable() : true;
+}
+
 static inline void cpu_synchronize_state(CPUState *cpu)
 {
     if (kvm_enabled()) {
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index b7ff481d61..51a12c83ed 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -581,4 +581,14 @@ int kvm_get_max_memslots(void);
 /* Notify resamplefd for EOI of specific interrupts. */
 void kvm_resample_fd_notify(int gsi);
 
+/**
+ * kvm_cpu_check_are_resettable - return whether CPUs can be reset
+ *
+ * Returns: true: CPUs are resettable
+ *          false: CPUs are not resettable
+ */
+bool kvm_cpu_check_are_resettable(void);
+
+bool kvm_arch_cpu_check_are_resettable(void);
+
 #endif
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index e3b98065c9..ee9c46527c 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -927,6 +927,11 @@ void hw_error(const char *fmt, ...)
     abort();
 }
 
+bool cpus_are_resettable(void)
+{
+    return cpu_check_are_resettable();
+}
+
 void cpu_synchronize_all_states(void)
 {
     CPUState *cpu;
diff --git a/softmmu/vl.c b/softmmu/vl.c
index f7b103467c..1f54c6b416 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1475,7 +1475,10 @@ void qemu_system_guest_crashloaded(GuestPanicInformation *info)
 
 void qemu_system_reset_request(ShutdownCause reason)
 {
-    if (no_reboot && reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
+    if (!cpus_are_resettable()) {
+        error_report("cpus are not resettable, terminating");
+        shutdown_requested = reason;
+    } else if (no_reboot && reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
         shutdown_requested = reason;
     } else {
         reset_requested = reason;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 0dcb9bfe13..f9584a1425 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1029,3 +1029,8 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
 {
     return (data - 32) & 0xffff;
 }
+
+bool kvm_arch_cpu_check_are_resettable(void)
+{
+    return true;
+}
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 7c2a3a123b..eefd1a11b6 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -26,6 +26,7 @@
 #include "sysemu/kvm_int.h"
 #include "sysemu/runstate.h"
 #include "kvm_i386.h"
+#include "sev_i386.h"
 #include "hyperv.h"
 #include "hyperv-proto.h"
 
@@ -4738,3 +4739,8 @@ bool kvm_has_waitpkg(void)
 {
     return has_msr_umwait;
 }
+
+bool kvm_arch_cpu_check_are_resettable(void)
+{
+    return !sev_es_enabled();
+}
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 72637a1e02..ad612e74c1 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -1296,3 +1296,8 @@ int mips_kvm_type(MachineState *machine, const char *vm_type)
 
     return -1;
 }
+
+bool kvm_arch_cpu_check_are_resettable(void)
+{
+    return true;
+}
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index d85ba8ffe0..d9a4750324 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2948,3 +2948,8 @@ void kvmppc_svm_off(Error **errp)
         error_setg_errno(errp, -rc, "KVM_PPC_SVM_OFF ioctl failed");
     }
 }
+
+bool kvm_arch_cpu_check_are_resettable(void)
+{
+    return true;
+}
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index f2f75d2a57..f68210373f 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2543,3 +2543,8 @@ void kvm_s390_stop_interrupt(S390CPU *cpu)
 
     kvm_s390_vcpu_interrupt(cpu, &irq);
 }
+
+bool kvm_arch_cpu_check_are_resettable(void)
+{
+    return true;
+}
-- 
2.28.0



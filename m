Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEB0C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:39:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC17207EA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yOO8cZc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC17207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCltn-0000ZE-SP
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 11:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kClsw-0007Px-GL
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:38:18 -0400
Received: from mail-dm6nam08on2070.outbound.protection.outlook.com
 ([40.107.102.70]:41056 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kClsv-0001yB-0v
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:38:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lH9seH9Sf+TRE5Q4c5DPo0Y7mNH7xc0CNSmkZiqIWH6n5DAKB1Dn1+l+El1ePeQ1fhoHnJZ+afTI+8oQZOFX+BoQfO1Ot1Td0QvkdamLrp3B6lT89IVgnGtodoJrNhEcSb+f1hiBNTbPD6szbOCkT8FhYPXP5pxVc6GWUrJrU/iLTXuEzMCmtBJffABVwlBnITK7rPmB0XEe+v4QzP21zU0FRbG1qZn71gn9wP7d4Sxb2Ysb9QLwGso3QfkMXcoI+92K0xeMOrmMfVkCxSkeiHAceBtof/v3MySSl2C2MnM1s1j46DtpPCF1mXojlll+T6sMDlUMeJ0PlLe6BPczkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXF8fTPJ/Y9pFcClOLMeQ5tenPBU4qylEmby8f9sbW8=;
 b=miim6xnQ0HxXovoXKDEnp8qKCeTQLweQStUxWSIWWEeIlNgI1HSjk2zHI06KMxOHGvMRsu/pOa6vWwApRGYHr8bsTxCQ8aEw9p3AXhNO9kpoU7zdfyoMmhejbl8TuZdMls+TyC+80LFBwxtwOvh9c3DiEajfDXx87tyn9SVXdWMy+dda8mhkiGEx1ZNSZUJmoFxQ90puTjPM+8VpJpa6DKgz3P/PH7mJWkD8MfRKb2wdbIqPD0olaoh7gYSbYvRw2T5YPaFd22nXyiDCGh6T9ZfDA1rkKAf0Li+m/nrYoQ4ZqRteFx7oXSvJNLsSRqvI18KLnMRTp6H6nPkykjwtCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXF8fTPJ/Y9pFcClOLMeQ5tenPBU4qylEmby8f9sbW8=;
 b=yOO8cZc9TY6omObVz30baBinFtakqBehZ9mNtBR/ZHMClametkwj3sI9Q4kbJawIbofntS9VR37E6l7Gp9oELdMXYFKSfYK5GYb8cFsOqROacvqulY0HMMZgJwOmhR4zYgpaJVWtwzQZjp32k7eG4rw8frNYdCbLcNF2jenizAs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Mon, 31 Aug 2020 15:37:53 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 15:37:53 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v2 3/4] sev/i386: Don't allow a system reset under an SEV-ES
 guest
Date: Mon, 31 Aug 2020 10:37:12 -0500
Message-Id: <42e7c4c3b410731b191d5328a19a790255818a00.1598888232.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598888232.git.thomas.lendacky@amd.com>
References: <cover.1598888232.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0401CA0029.namprd04.prod.outlook.com
 (2603:10b6:803:2a::15) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN4PR0401CA0029.namprd04.prod.outlook.com (2603:10b6:803:2a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Mon, 31 Aug 2020 15:37:52 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bda848df-9c59-4aad-9924-08d84dc3d363
X-MS-TrafficTypeDiagnostic: DM6PR12MB4484:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4484F5DC1A2E6617C4860931EC510@DM6PR12MB4484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3feol6n2Z8j7UvXAkSvWFCXemD1fBIk0VWZDLE7/srLZ3s/x4JzkwClM6fNsLf/VVhlXyDV3E+XbGn/PZjK5caCnSvGfFEAxvEB+lX1etkNvT5HMHvKTTZdMOhh4QO+12JgmheanKgcR9ki5sW9xrDVwtSq9WRlFNIuYE53iYjFRcOJ84zoHcLUP4HagaycN4FrEjQ1Fne6fPfkXXHgaaHu1W+1ArwHTG8YfP2Wc1mgYXG/7e6aEyFKuSiiBGEOIeQ1JkVX2/zA/qTIdYm7N1/y5j7EyroDvFM4gb68yiVNTYGJoHerE4GoMyCiXYx+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(54906003)(956004)(16576012)(7416002)(2906002)(6666004)(4326008)(2616005)(6486002)(316002)(66556008)(8676002)(66946007)(478600001)(186003)(5660300002)(8936002)(86362001)(83380400001)(66476007)(36756003)(52116002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cnsTIa8m9YMXqbyF0uIw7Ao+nfksQqqZcgYkm8YI1/Sk8stejtIFEvjgkaCsZBEUsF/NnCXhGbYNgH7Bu4omvss/JgF6eGsXnUmuNNhJEO8k1KHmNOgDAl/hB3FIAIn4gPVvdY1pvqImylq2Kpk9JbJ24XdOWMlsXDM0ZWxn49V69qAfKYw4LQZSG6b06pfUpdbaOiBq8UIZH0BJB+4QbUjh0mMBuE6TN5SJy+Pp+BT3K+0reJ0Dfw0vIRaRYYRCfVF6mXJcCRFDz4D9yncCnxZqY/g8gR255oNqNR+x6mEUcED3krm8Ym5gaXht9wTvUW+AWW6lWhGHNv1dD67/hhn/YQIU1urWx2LPafPNk2wtYayENOAYNBrSUm87wuRBWqbMMKmD+FYnrNhZAvsywepgbCJaSkmTCTIaFgMcIe/yipiZJD6QsnUJHsKJAPYlZUtVaG5Vg64+0N63CqYPgDYpoCaM3fqi8oQKh6AdjkTviRRDWV73e9U5NVFKfrhRgirsLE+8HiMfMRrXuHr3g9k+AW6wb+JJMzQ0ljpSb4UgLMxHiL8tRI2uCEMZpvaUjyNilKi/FuhsxawzvmS1I2Bm7Xwp9quUXsh9/3k7YbZWTjHw81km56T8jKgJvXkIfIhgMlV823vJKx7R01IMBg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda848df-9c59-4aad-9924-08d84dc3d363
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 15:37:53.6325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2hrWQQNTRrT167uAXf0q1g15rF2IYLOv/BZiat0rvfI++hW4QA7UAJLRW7GxYW6Kw3EKH3jtTxH4rD1t58Adw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
Received-SPF: none client-ip=40.107.102.70;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 11:38:11
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, RCVD_ILLEGAL_IP=1.3,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Brijesh Singh <brijesh.singh@amd.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Connor Kuehl <ckuehl@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tom Lendacky <thomas.lendacky@amd.com>

An SEV-ES guest does not allow register state to be altered once it has
been measured. When a SEV-ES guest issues a reboot command, Qemu will
reset the vCPU state and resume the guest. This will cause failures under
SEV-ES, so prevent that from occurring.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 accel/kvm/kvm-all.c       | 9 +++++++++
 include/sysemu/cpus.h     | 2 ++
 include/sysemu/hw_accel.h | 5 +++++
 include/sysemu/kvm.h      | 2 ++
 softmmu/cpus.c            | 5 +++++
 softmmu/vl.c              | 5 ++++-
 6 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 20725b0368..63153b6e53 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2388,6 +2388,15 @@ void kvm_flush_coalesced_mmio_buffer(void)
     s->coalesced_flush_in_progress = false;
 }
 
+bool kvm_cpu_check_resettable(void)
+{
+    /*
+     * If we have a valid reset vector override, then SEV-ES is active
+     * and the CPU can't be reset.
+     */
+    return !kvm_state->reset_valid;
+}
+
 static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->vcpu_dirty) {
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index 3c1da6a018..6d688c757f 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -24,6 +24,8 @@ void dump_drift_info(void);
 void qemu_cpu_kick_self(void);
 void qemu_timer_notify_cb(void *opaque, QEMUClockType type);
 
+bool cpu_is_resettable(void);
+
 void cpu_synchronize_all_states(void);
 void cpu_synchronize_all_post_reset(void);
 void cpu_synchronize_all_post_init(void);
diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
index e128f8b06b..8b4536e7ae 100644
--- a/include/sysemu/hw_accel.h
+++ b/include/sysemu/hw_accel.h
@@ -17,6 +17,11 @@
 #include "sysemu/hvf.h"
 #include "sysemu/whpx.h"
 
+static inline bool cpu_check_resettable(void)
+{
+    return kvm_enabled() ? kvm_cpu_check_resettable() : true;
+}
+
 static inline void cpu_synchronize_state(CPUState *cpu)
 {
     if (kvm_enabled()) {
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index f74cfa85ab..eb94bbbff9 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -494,6 +494,8 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
 
 #endif /* NEED_CPU_H */
 
+bool kvm_cpu_check_resettable(void);
+
 void kvm_cpu_synchronize_state(CPUState *cpu);
 void kvm_cpu_synchronize_post_reset(CPUState *cpu);
 void kvm_cpu_synchronize_post_init(CPUState *cpu);
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index a802e899ab..32f286643f 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -927,6 +927,11 @@ void hw_error(const char *fmt, ...)
     abort();
 }
 
+bool cpu_is_resettable(void)
+{
+    return cpu_check_resettable();
+}
+
 void cpu_synchronize_all_states(void)
 {
     CPUState *cpu;
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 4eb9d1f7fd..422fbb1650 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1475,7 +1475,10 @@ void qemu_system_guest_crashloaded(GuestPanicInformation *info)
 
 void qemu_system_reset_request(ShutdownCause reason)
 {
-    if (no_reboot && reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
+    if (!cpu_is_resettable()) {
+        error_report("cpus are not resettable, terminating");
+        shutdown_requested = reason;
+    } else if (no_reboot && reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
         shutdown_requested = reason;
     } else {
         reset_requested = reason;
-- 
2.28.0



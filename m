Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA658C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D852074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="foGvAMRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D852074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeIk-00025l-TK
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kAeHP-0008NJ-Gg
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:06:47 -0400
Received: from mail-bn7nam10on2076.outbound.protection.outlook.com
 ([40.107.92.76]:42272 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kAeHN-0003xT-V0
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:06:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbTEsnU2PcNmjfk1FeN7Sk/CqflXDjRK0Vi761brPaUnHHBpl8bLTNVvmiFvbzbkEht7kU0tZaj3/agziSm+pMkPwgQlCLZ0XWPE9hKzbNdgJW0sPFOCGBHdYqmsywLyGhCa29IuLs5u/2nEPk6wWYeJArdgyMJ1Ir5n/BrTEr0IYSisxekepuN3/ZmLcCU+V15xDk5QTdbssUbIGJK+dHYlqNreQV7XVg7bmGxf6y6wIKXQJJYmIVwYN74TvA0nVdRKfx7qWq4q4vJqWfFhCBGkEd4iyGBwinmMGduYpo19WHWyYQtIUAH9ITtfoD59rRSqrxrCwi/duJkTnib1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad/nf83l2epmwPr5uQxGiDbyaCIjQcn72MgaSbtOkXA=;
 b=M8EHC6/nS8IzHuLK73BMceH8VgTfM1r4EkJCb82jKIBcHD+UwkwL7JZXF4Tu3SdP+U9mbs1htuG/A7MgzWV5oGZMYf9fFA1H/yDjJxWAjSgsTz2VIfEyDPb53NV15h8Xw8QIfIp8rdFSZe6KDmiqTij+4waDCZ3/vBQPrCxTFswfpuv8O51C5+9RR9iDGsKWgnXClWncLxlsJX+kY5bnSnpPRKxtM96HTlwOQJoesuikWV3o02OvzjCHCaW37WBLhBsE6QmTC+KQx609FzziTo8OkM0+pFn4ktYh+sWiuD7y8BxtXvhJm+24je51ZZ2RFEkXxWgLy+dis++Vk17v9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad/nf83l2epmwPr5uQxGiDbyaCIjQcn72MgaSbtOkXA=;
 b=foGvAMRCEW8GyRVdLX0sEV9JV5MSsFheVArnXkuzkcuL45ULTVdYU+6WPhQICqbMKk2+NtSLb3qXkgoKsuN/TnaFdyxd+U7H9nQzlQ4TjnFHYnpACLk//WUN8if2Go385OEsqnLQPZWM4Lrl/ubrs9Ua/a/V3qrpvkzzLyieEvc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR1201MB0219.namprd12.prod.outlook.com (2603:10b6:4:56::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25; Tue, 25 Aug 2020 19:06:22 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 19:06:22 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH 3/4] sev/i386: Don't allow a system reset under an SEV-ES guest
Date: Tue, 25 Aug 2020 14:05:42 -0500
Message-Id: <b394ef2e743ebd57d3b8fb5ce1d5069c030ffcfc.1598382343.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598382343.git.thomas.lendacky@amd.com>
References: <cover.1598382343.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR04CA0072.namprd04.prod.outlook.com
 (2603:10b6:3:ef::34) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 DM5PR04CA0072.namprd04.prod.outlook.com (2603:10b6:3:ef::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Tue, 25 Aug 2020 19:06:21 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a38ec267-063a-45b1-c359-08d84929f481
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB021916684866E417C76DD181EC570@DM5PR1201MB0219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EiazKAsyb/ymA9ReNqx5WgUJskeRDjbriiMy6NmfTvxbD/M8oYbeflFNxLNjXm+RGoVASt5DYZ0vt2REp3cCOYHjM2lLsa1cD4gdDaEZxMKhjOmozB4umTWNfU7cEpXzrn4Tg8jGeKnIYsVlq9WxL6svLQA1YOyxpgrjVxKd0WjQlsvWV+9fZo6Hu9IR1h3bWvJniVHncSHB1scDXIJNklh3JUkk8pJeu9mqHibwEJDOUCjc9+dmZhv9fhUtsLKCzEaPRPGsMCPafZt0cI8WpvdmpY88cOB8NjshfBT1v0jchFciptNmLNseByk5TuT4NlgXwFtoapMm46u8nbrtmK2Bs2tbk8vMFkOuPhnRv2KUwrVLVaRoC7hhyx0TOm3H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(4326008)(186003)(86362001)(8676002)(83380400001)(54906003)(16576012)(8936002)(6486002)(316002)(478600001)(36756003)(52116002)(26005)(6666004)(66556008)(2616005)(66476007)(66946007)(956004)(2906002)(5660300002)(136400200001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 9VCSk67WJUEOHaTTwrZqZoiXgwHBbN+q1M/xqCyPImdsttk8WKcrv6r6jHCsAKtH8BMe1ChQsM+BNb5rSi4/vmwK7I5SJHmYgrn/OJVX6OaturzwUQE79zn8a3V9+sRdj1VaqbGHvNF3YOvZ6XTBH2HOTWJSxb+UE4L9MGKFShAfXPhIrkrUJCsxKwa09VD4kR3GyA0jS6xTh6xJMWpgquUn0/r3lzjWt0bArjT5sS+OeCB7LBgIRwXMZZTgBKmtIkbtNwC+69wguwrGKesuitwGC+JTs2hUnAX9mTj18BbCSNu9OObDLSPuL2ueJq/6VElJEgxH5yd6D00cc2wgC863YpXvmUugUP4C9ldrS/lRDtUpc3d9XawpyzVXgAa40cQD/wtdyo/3/vx7Zk/hvYRyg3s84Dp6qCQ3vDNNKAqLA22mCFjGBdCq0k4tA/njoTHI0kPZTPj7f4J9mtQmfq2X/E2OL4Jfrfha8Vdo9yEBCDBeZSKlO5P9GOPdFmeMNSmsDUdjRLhX9Uqk6OynuPAzMLTml6WilEVCc9d8M7MQx4ea8G3z+usF08O0pkQiFDAWDCD2kQMPHldAcHV8Efai87goCrfMpSrh8CMHWxVJjR70ZjGx01aFKhKVpB4MNpx3HfYmSdZKSq7EHUMqVA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38ec267-063a-45b1-c359-08d84929f481
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 19:06:22.1595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+uFI3g/d6iQaD+m+iMFNXsY17cdfNDFDzwAE5/71u6ErD9UgK+BBeHQBYYqza96iR+ngBhQMMfeGb1ssb0mcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0219
Received-SPF: none client-ip=40.107.92.76;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 15:06:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001, RCVD_ILLEGAL_IP=1.3,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
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
 accel/kvm/kvm-all.c       | 8 ++++++++
 include/sysemu/cpus.h     | 2 ++
 include/sysemu/hw_accel.h | 4 ++++
 include/sysemu/kvm.h      | 2 ++
 softmmu/cpus.c            | 5 +++++
 softmmu/vl.c              | 5 ++++-
 6 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 54e8fd098d..1d925821b2 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2384,6 +2384,14 @@ void kvm_flush_coalesced_mmio_buffer(void)
     s->coalesced_flush_in_progress = false;
 }
 
+bool kvm_cpu_check_resettable(void)
+{
+    /* If we have a valid reset vector override, then SEV-ES is active
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
index e128f8b06b..1fddf4f5e1 100644
--- a/include/sysemu/hw_accel.h
+++ b/include/sysemu/hw_accel.h
@@ -17,6 +17,10 @@
 #include "sysemu/hvf.h"
 #include "sysemu/whpx.h"
 
+static inline bool cpu_check_resettable(void)
+{
+    return kvm_enabled() ? kvm_cpu_check_resettable() : true;
+}
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



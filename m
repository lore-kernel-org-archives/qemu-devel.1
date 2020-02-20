Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B51FC3404C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44AB524658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="laVH9jUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44AB524658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4dDv-0001Ba-FJ
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 23:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j4dBo-0004gH-NU
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j4dBn-0005yc-OE
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:52 -0500
Received: from mail-co1nam11on2136.outbound.protection.outlook.com
 ([40.107.220.136]:38881 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j4dBn-0005yE-HO
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfKnm+wi296iD7BmP0zMZPyRrrvzTjvMu08xbc6SY/2zjmfsz86KXo2upOl4gLN5kOxtVY9cm4lOMzporFA0IwRNJX5AdSfFEyNVSkMeQELRlrdr25QL9F4bWxw9S++GKHEJuKPjtSx87yQRESuP7icgnJ5O9yZic6KAVUndDPoHGVmaV5NjKmBJYdjFTngTPv4INGnbFjdYXtpSESBTZHq//RvoJ86vSDQloyiN1R8BvojGpMUajIUG4fKKVq1PxeP9WR0OdEwIEsGEfYOBA5QZenJCFrskTen62wFS0ayDIL4JmonMSqfDfYcrWoQ3yHf/pdv7j4oRrKe9hUgRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05U5h3WDwUYNOjflgUQUtGsB+LG5FvrHD0dL78Kevi4=;
 b=Iml6RltmSv+pYeYkVOJEDJZ0nJ3VkP6vOe2i2NG9srnWjY09+Aasvt653PiwvjeG9raoVpImQKLWG68WA/JNv8y50c1p3N0YWNzlJj7MhAAo5df+e9DmOaBoLx9pFZn9ARzi2Ofvt00Gtx8OxZ1yEpv+vSWtUJsDhRkJXIiMv9KxxJbmotfVOATB+/oWmw2gSVhPErc5SssWgLKfKrPm6PKMCX+9AKZ+AKv3rXFP/rx0iH5681hFatzSCAtMMbkPNd//FerIMnPuSNj8nakRDY9cUUGa0MF5xcBbof/5ypZ6wJhFzdGJ5mP2x4gOZUQMs+QqHkPwK+7WFPT+5cDDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05U5h3WDwUYNOjflgUQUtGsB+LG5FvrHD0dL78Kevi4=;
 b=laVH9jUFuQpPP0vACcRG2auMHvpTdqlnxI4NTk8AMkEYO8oHSpwk9kdpJg/StusRW1QsIofFDNn2ovidVtEQAVC8vFXfodgJ2cmWDeqdOviM6Vc0d319cvMtW2zGg28Hf27+dzCq9xrzdh7eU3JrPx67nXSEVpc2lNi+cw+hpqs=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3807.namprd03.prod.outlook.com (2603:10b6:805:6a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Thu, 20 Feb
 2020 04:11:50 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 04:11:50 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 14/22] main: keep rcu_atfork callback enabled for qtest
Date: Wed, 19 Feb 2020 23:11:10 -0500
Message-ID: <20200220041118.23264-15-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220041118.23264-1-alxndr@bu.edu>
References: <20200220041118.23264-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0048.prod.exchangelabs.com
 (2603:10b6:208:25::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR0102CA0048.prod.exchangelabs.com (2603:10b6:208:25::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 04:11:49 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 000d455d-3e70-4ba3-cbb0-08d7b5bb0238
X-MS-TrafficTypeDiagnostic: SN6PR03MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3807F1D70A15B3BBDC35BC5CBA130@SN6PR03MB3807.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(36756003)(86362001)(81166006)(75432002)(8676002)(2616005)(478600001)(81156014)(8936002)(66476007)(5660300002)(6916009)(66556008)(66946007)(956004)(316002)(786003)(6486002)(6666004)(7696005)(16526019)(186003)(26005)(4326008)(1076003)(2906002)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3807;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nf3gFdXs8u6jXS865Z851ldzeD+hjVcXHVcsX03WuJP20F9UYZcOYQ+ETeLDZMTq1x7RhICsqoGGv3001Wp8CcjjVpAl40Ozu4aEnjaLl1PEmemFeMGslJCgBKrTqVydVDZgnsw4QgOcdUPNOD0fs+rgkNoNN593z31/MbSYx8gNPM+i5663t9wuI2jKYMrj30v5BxvIs6WFXDe9ZX+2HeS4oXH6OnByap/F/8DIt7MmWttlEpQVsh6ag3cXBXnN1aMZ13fUHxcNsH02PcZzvsOSmJGycD2J4/O9a6tINqgx5R84CZE+rW96Xcuyw2p4FyV2vubQoljTaRcj0tycG1QtX5vnD2S7vOXsalzu14fzxPRTvA5pZbo0aee4TCjeElQ5GL+i0otASdqTjfyhJFm62Nz/ZJxzOUIB2r89XiH0gVDBq0nBthp9AscXNhq/
X-MS-Exchange-AntiSpam-MessageData: eECVMbEUFniHUw8Er60+qU6/h9QeYed3BEPzg78ExDknAkx7Fss8S/pjigYsXD4RJAomrEcaY7fo8HUNhXPzmadFNZxwtkT4479asW4pmglbQ3vNpX+plqjERfQYhAe3ovTpRI+QYBPPtbmGeAoLzA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 000d455d-3e70-4ba3-cbb0-08d7b5bb0238
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 04:11:50.0341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnjqcMV+StugTbDxsNQLVfXas+Btj6/ArithT2+TLdpANw5t0Q5rd/xj1w/YDrB4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3807
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.136
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
Cc: Alexander Bulekov <alxndr@bu.edu>, pbonzini@redhat.com, bsd@redhat.com,
 stefanha@redhat.com, darren.kenny@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qtest-based fuzzer makes use of forking to reset-state between
tests. Keep the callback enabled, so the call_rcu thread gets created
within the child process.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 softmmu/vl.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 46a48d09df..78f6530620 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -3813,7 +3813,17 @@ void qemu_init(int argc, char **argv, char **envp)
     set_memory_options(&ram_slots, &maxram_size, machine_class);
=20
     os_daemonize();
-    rcu_disable_atfork();
+
+    /*
+     * If QTest is enabled, keep the rcu_atfork enabled, since system proc=
esses
+     * may be forked testing purposes (e.g. fork-server based fuzzing) The=
 fork
+     * should happen before a signle cpu instruction is executed, to preve=
nt
+     * deadlocks. See commit 73c6e40, rcu: "completely disable pthread_atf=
ork
+     * callbacks as soon as possible"
+     */
+    if (!qtest_enabled()) {
+        rcu_disable_atfork();
+    }
=20
     if (pid_file && !qemu_write_pidfile(pid_file, &err)) {
         error_reportf_err(err, "cannot create PID file: ");
--=20
2.25.0



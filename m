Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AD4C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:39:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 026C520659
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="ESsffH2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026C520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cJE-00033Z-0i
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:39:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cG0-0006Zu-Ho
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cFy-0008QZ-Eh
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:44 -0500
Received: from mail-dm6nam12on2092.outbound.protection.outlook.com
 ([40.107.243.92]:50848 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cFy-0008HE-0R
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBSUaDeXOeLsqXZA0sYiVVTQXwq+l+FfcbEXD/FleAXx1Yh0V7SyvVtLJ7RBrxTE2ueahFh6LLHe7uqRWaO5VEXUxy1L7i9e2UcIryNaNcGAy8yxWx3NLipEY5yvOXHYfE412mjsncmLCNgO7HxdgLyfHFGY3eUFCZbrHpXiu0AlGJGOzRIUbmuN1YrYN/rjty15tnWcPOeSPQwfZyRzGK0ohVUMWidSmVBFYAnE8SEEdPRtt76oySwF3MeEyQQ+UHR3q4cW9EUX5t9sKOwpOg7qOITtWSf4D9OJtyRtYCaZKsyN4Yb3038WXzV2qtI0mfKSO2LTR8uS7EQ6evhmhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05U5h3WDwUYNOjflgUQUtGsB+LG5FvrHD0dL78Kevi4=;
 b=EnE9jc8PW4e4xuEO1bfmVwoRKPLrJyKs5lQo4XBhZKP0N5aTyAx5bSGcV6fxlS6LNOOIgD7v7VfLwWeIAaWYcwpgpZcAXKQwV5ECyivnkh3taYEaLObc7BNIGwEeBUdFdvD/iUIi8GXZZwQcMMdFEIeLjm2oKJdt1ri/GGHwBshk5B3dtYT7XI2WhaHLo456t6F1aWEXMrXTgYYoJoC3y+NAas1SGmZbXtbOciUrX2qgazl+mQUfUuOhzEnh97JI0mH7T7lEg3ZHVYy1QP0dUsatKv6K3ZdnVT6U6x8XZDSdhrR0pSU6ug3RukgBEm9Wzmf+PZ2uZqSigch8w7wB3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05U5h3WDwUYNOjflgUQUtGsB+LG5FvrHD0dL78Kevi4=;
 b=ESsffH2jvOHc4lyY3F6vjJH6hVHZQNZSJLchXiapI5ghlWEmTjiH9TP83IBa5SZa0YkHoDMdQ+YQ/Whltiu2xkq4YKqHck3+/GoLFkU9v1wYkTO/oQNYxy9QOJ0Ufupm7qfmEEzU/FeWPDJxgt4k2pzJfIejZRO59QlI6kN7D3o=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4336.namprd03.prod.outlook.com (20.177.254.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Tue, 11 Feb 2020 20:35:35 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:35 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 15/23] main: keep rcu_atfork callback enabled for qtest
Date: Tue, 11 Feb 2020 15:35:02 -0500
Message-ID: <20200211203510.3534-16-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211203510.3534-1-alxndr@bu.edu>
References: <20200211203510.3534-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:34 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b21fe97d-43ca-431f-8617-08d7af31f26e
X-MS-TrafficTypeDiagnostic: SN6PR03MB4336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB433675B24E8B4D95A7539C64BA180@SN6PR03MB4336.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(199004)(189003)(16526019)(6666004)(1076003)(5660300002)(86362001)(316002)(186003)(786003)(66556008)(6916009)(66476007)(6486002)(66946007)(8936002)(478600001)(4326008)(7696005)(52116002)(36756003)(75432002)(2616005)(2906002)(956004)(8676002)(26005)(81166006)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4336;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iygZQ7pGkUg6shIEUNgGQwb2VYrBTi++5bfIFqBdOxetkZOutOAxllEveUa2Q1p555cJrFiTBwq+OAt332MY5q8zxUc9/IMqBHdGzPXYvK+536Rlr6d/YR9kvX1UETv9FpPeC7hE1c4j/9ng3LivAB8/gA+5pFOUA7Q1KgMo96yusZeX9uyOvF/+FUxasgWRWgAi37Af+8UIvG+uDP6CFc7rUM4i9Of4ZHj2wvuSZXkM6WvccTXfocD4N5SVMVX6xH2AahQ5kCnMTka92imgCIy9yzJ9mySo/sdMzjSeXvHI6egzuQcqg6xAsBSACsQZ50VHoLuOEV4OBnsi9WOo70/LbJk3LoDlyC2OEpRDoZ6GtPJp1qDkiw0nbO1M9vqkerknZZeKHYRV+8O4Ye6P8qbM0terckrFn/2yY38b1Rd/oh3QUYl8YXiIQ//hxm19
X-MS-Exchange-AntiSpam-MessageData: yX7mz5bXtjv+6CI2laUIyG55K6y+u+Ufn3p3lHxSqI2YDA1r/NmxQzZIN8X5UfoPIR/bNjn1HfTykT6IVKi3yFKu/0LYMYZkRB6Knj/IjyLerBBTUdBjLvcxQuY6ZGk6VPmOkqYmEKL4zQlFynbYEg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b21fe97d-43ca-431f-8617-08d7af31f26e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:35.4690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35I5YMpvipEGz8TUAtmEw/k3vwel3LQbfU67U4MSdH/kQwZcz9JobTm8HIiZryx9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4336
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.243.92
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



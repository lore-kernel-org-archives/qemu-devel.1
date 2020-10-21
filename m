Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54C3C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FBEE2177B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="F8Yq/jr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBEE2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFt6-0004HZ-Sh
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaP-00067Z-65; Wed, 21 Oct 2020 10:59:33 -0400
Received: from mail-eopbgr70109.outbound.protection.outlook.com
 ([40.107.7.109]:36743 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaL-00085a-Or; Wed, 21 Oct 2020 10:59:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiKTGbuwSKknjjZUi2UkwvJRdMjiYMr1Rul5O1K3kWyjLJ7RyUW3+2ZhpNyjuo9Cuw1vzKNe8w4Iseo1U5qK3EuuaTGY3WFUJs6aOqrs1P+jsIvUKlBJqQIxm3f7ZCMDoKcz9dDfcAw3v6xBa1ky0FbR8xjo1tPGWebkhHrZ78UF3QhFyPp3wI+TKgCRcGznM5ETqllA41NJzGxcpRlXHxLLaLHbbDc34o7JjeTNxpqk/j0rILEb8k+4WZRHJVM9y67/cFdURgJBdHqevRjL6NflKw9fyBkL7cT3NQZHpJhSHPyr/PRV+calwC/MUe7mtI4J3ycMhLg4XSr+CRaeIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCsMwp8on7gc4u06kqzDbEnADVRaXIT9MVKHZXcDDWI=;
 b=LQnPO4VhydCPBmHtdPFADLnJDVQccToA/3dFvY+ZI2Nm4u6OKPpriW0Ufqf6qw/hTrRbsHY8uxlgMnTRYQETGfq9fp75JY2+gPhrK53nKmNMuRqabmbSVo78+r6Berk6W4eP2fD0t1vH1fNQpmwHNkAht/Pny4n7QIVH0gSgR/1dCRaohJQ3Uyg7xaCSGiwCc/LVQG+HK+WNPTFVTp/VTX+dlZQK53weaWoBDd6UZMcNCYd0voA/hNAGkGqKHPO6CPc/rD90iaNMC1S0ADc/5/pTZPAJLQ4NsjspyJ5ly2KmGtOhrnjJNabV0VRQfwt42KJvh0gKmLDEywZ/aQZ9xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCsMwp8on7gc4u06kqzDbEnADVRaXIT9MVKHZXcDDWI=;
 b=F8Yq/jr/q1/Wa9JF+B59sz4tkem1jPNh/6Hg9tW/as9Uwlk2DpKFb8RXI62rH2YaJ+wBOyEWPdHFWhBn1ut+rQ9K5K4MZ9oQK7ynGjb549o/YlNhKWoTavKJuF5v1QW8EQCH1utmDu71ZT0880AK+2utdivmGf2BapWUBXqzKFg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4472.eurprd08.prod.outlook.com (2603:10a6:20b:bf::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:59:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:20 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
Subject: [PATCH v7 09/21] qemu-io: add preallocate mode parameter for truncate
 command
Date: Wed, 21 Oct 2020 17:58:47 +0300
Message-Id: <20201021145859.11201-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201021145859.11201-1-vsementsov@virtuozzo.com>
References: <20201021145859.11201-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR03CA0091.eurprd03.prod.outlook.com
 (2603:10a6:208:69::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR03CA0091.eurprd03.prod.outlook.com (2603:10a6:208:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:59:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63ffadfa-f7f1-4006-6f41-08d875d1e3eb
X-MS-TrafficTypeDiagnostic: AM6PR08MB4472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4472947AFFE2A32B1FECD50AC11C0@AM6PR08MB4472.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PoLVBgDrjX+I7+fj4JS7rX1z5uJ60Rtfn4lHlnELnSsnqs/XJIrT4w6fj96jBRoUANVOwgCND4DsbOyPPxhuQ3P4ET29/3/GoBBjKqZ+GhBA4FNdHLPkD77ejLKQ4jaAXw6waF8H/VTxmd2ExBNSO0E48C8JK+nixIoFUx31GaXBruJV7vc2gcjE56kSjUlkv8h3g5MhVzDCJWw+nu2krggZ4RooYDiuVIpza+xw9dXTWO3wFLzhceoALAveoswy6T2X+CzTJdC+A9gb8JDAJJfHx7OPwW1Yl4hfyaKXCviRLwvNatMj8u6xUgQczLIHk/IspaNWk2be0d41H+RKGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39840400004)(66556008)(16526019)(66476007)(83380400001)(6512007)(26005)(478600001)(66946007)(186003)(6506007)(6916009)(86362001)(1076003)(6486002)(8936002)(2906002)(5660300002)(52116002)(8676002)(2616005)(6666004)(316002)(956004)(107886003)(4326008)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 9cUe9dtkZHLfliJnfkaK4b+3RN2Q9z50AtudxyElveYyHMJuTiLq2P9j8A5hXNrz2KnJguRDJWXvlSXXrtclZrxgT5JoyiiQXk7yYKXZfsdbvmwdDM8PPLxEC7H3kkfCzN/8uEOolx9YVmXStS6umKOLZ3mW7yHQ+jKoEHvEk0rlpOpUnGRNb/e8FlD7pswcjhTCi1xZojruL7TXHn7kxcImXxyXqPpVVF06ObWsaLXNa0tzgBztIBoUZSsvTtD59Wj5OWKt9ntWDIGyobsEPnVD+pi7oF0JJ0JZ6Equ350tNmRELgosN/SUFTWbAvupdkdvhT1wEUV7+BXselHg7F4wBeMTJmA0lIiA4cm324HDcHMra5AkbnkMCwUKWF36vq27Bkc40/5F+WH06JFJxhJo9b28/WYdwneGYeYjFkYF0Jcl/GD6TsigX5NswpGin5NyvatD+nqZcop+k0KqSq0DWbtlU5ZmS0rTBLdhhwtOz0pOyQUvYlv2npZT9MTmisaAn1dyBHpgdMB1cJNHx8w5JAa3UEAhzSsSM7GM6VYQtXxwn/Mc37O4B7gwInegsgpSWBQrXDdcw+01jL8uPAA5SBDsebyduYOdE+zrM/OoOu/C+DQKkw1GKQ6VPNignnQFTiO97Fd5ugcd9aBBYQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ffadfa-f7f1-4006-6f41-08d875d1e3eb
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:20.6751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGhUmhLFFTHzle/amu3bH/B+uEY0x+ojOlxXR+H1kTRr0g3b/1k9hsWpVNQqHJNkEdbTD3JBVcvVNExFsP4TPvwe+soNSHbV7JkEjRbzLqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4472
Received-SPF: pass client-ip=40.107.7.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:59:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will be used in further test.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 qemu-io-cmds.c | 46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 4153f1c0b0..97611969cb 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1698,13 +1698,42 @@ static const cmdinfo_t flush_cmd = {
     .oneline    = "flush all in-core file state to disk",
 };
 
+static int truncate_f(BlockBackend *blk, int argc, char **argv);
+static const cmdinfo_t truncate_cmd = {
+    .name       = "truncate",
+    .altname    = "t",
+    .cfunc      = truncate_f,
+    .perm       = BLK_PERM_WRITE | BLK_PERM_RESIZE,
+    .argmin     = 1,
+    .argmax     = 3,
+    .args       = "[-m prealloc_mode] off",
+    .oneline    = "truncates the current file at the given offset",
+};
+
 static int truncate_f(BlockBackend *blk, int argc, char **argv)
 {
     Error *local_err = NULL;
     int64_t offset;
-    int ret;
+    int c, ret;
+    PreallocMode prealloc = PREALLOC_MODE_OFF;
 
-    offset = cvtnum(argv[1]);
+    while ((c = getopt(argc, argv, "m:")) != -1) {
+        switch (c) {
+        case 'm':
+            prealloc = qapi_enum_parse(&PreallocMode_lookup, optarg,
+                                       PREALLOC_MODE__MAX, NULL);
+            if (prealloc == PREALLOC_MODE__MAX) {
+                error_report("Invalid preallocation mode '%s'", optarg);
+                return -EINVAL;
+            }
+            break;
+        default:
+            qemuio_command_usage(&truncate_cmd);
+            return -EINVAL;
+        }
+    }
+
+    offset = cvtnum(argv[optind]);
     if (offset < 0) {
         print_cvtnum_err(offset, argv[1]);
         return offset;
@@ -1715,7 +1744,7 @@ static int truncate_f(BlockBackend *blk, int argc, char **argv)
      * exact=true.  It is better to err on the "emit more errors" side
      * than to be overly permissive.
      */
-    ret = blk_truncate(blk, offset, false, PREALLOC_MODE_OFF, 0, &local_err);
+    ret = blk_truncate(blk, offset, false, prealloc, 0, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
         return ret;
@@ -1724,17 +1753,6 @@ static int truncate_f(BlockBackend *blk, int argc, char **argv)
     return 0;
 }
 
-static const cmdinfo_t truncate_cmd = {
-    .name       = "truncate",
-    .altname    = "t",
-    .cfunc      = truncate_f,
-    .perm       = BLK_PERM_WRITE | BLK_PERM_RESIZE,
-    .argmin     = 1,
-    .argmax     = 1,
-    .args       = "off",
-    .oneline    = "truncates the current file at the given offset",
-};
-
 static int length_f(BlockBackend *blk, int argc, char **argv)
 {
     int64_t size;
-- 
2.21.3



Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCA1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 653CC20720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="dv5adF9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653CC20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr1u2-0006Tt-Kx
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jr1mJ-0000p7-Rm
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:09:36 -0400
Received: from mail-eopbgr40126.outbound.protection.outlook.com
 ([40.107.4.126]:60803 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jr1mH-0002wL-UM
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:09:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgO27vZbxU3OjavFZ2LPjrbGb0awPh3MZLojD18c38FMG0RldC3HO9Ht4HpyNWZ0j4RPybgD/S0Hu+tBLsGKham5U56TEJUnIhzJnAI5iV6EbWnaIYcaKaYKMUhzIwaSHTYX8suDtj/n7kQe4AvCDJBZVcEAVTFR20XnGWpcsaHSH8n41Imbkr5Y9NvslGzoBSN2Lw/wZMvseaoa8FjljKC8LoGY7m/rTyhlGXPCqJccxJaKEB22JwalBO0MbIvhkwGNv0RFjvCrz9672U/1l/EpcGmikmz0TSEmOt5Da2DBIvpxE3kJEbfEnhZwnZv9z4DzuxUCriYzuWuT2MxTLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxVT2zMhw8C0EB4zAuIMEyoO6N8LFlkL3R0eMVYLfIg=;
 b=KAEKUV4ntob2g3WnbIfgaGoClVWq3/cLo4/QjfVqQD2omugj0Z1pdTsj/tWhtRn3r4CZWluzEDhBQC7BeXtoWSTe4BqrAUTR5ig8nBPRABVQhQO9zRbvFQZQdtAoh5D650sCdigW40kh6pUIKHsXOTHKgVhF0nPvSiV5DKQPCRdyv42zY4IQGQ/yIVqIjKSs90kEsDSsj0HEhE7DXpNdJeq1bDOgv10U4QLOxnXOthn4eFENWaOXSLZZOs/lJCDt7lRFNwoxCLDO2Scc46sSlPNiXFu6Cn/5ftl6qBRZtC7JlsQLJeFARQM3ICd1JhRq8P/Uixceu9k1bssnjfjwpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxVT2zMhw8C0EB4zAuIMEyoO6N8LFlkL3R0eMVYLfIg=;
 b=dv5adF9O29eyMpBetWshZuqX3nIgHpLx+FqMQIXjvNqaIDH2xYq6tA2BGSC89cZi8bAi3KaFei2yCokelQPuxkWesbga9dm3R9zHtz+Q6K3i/hChx2GK2qPjBpUeq9Eh9XRttsKqPwoHGBAcsw9XIC5hzRP8R4JCQ92HPcpNYsw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB4743.eurprd03.prod.outlook.com (2603:10a6:20b:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Thu, 2 Jul
 2020 16:09:30 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3153.023; Thu, 2 Jul 2020
 16:09:30 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] linux-user: Fix "print_fdset()" in "strace.c" to not print
 ", " after last value
Date: Thu,  2 Jul 2020 18:09:15 +0200
Message-Id: <20200702160915.9517-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0004.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::14) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 GV0P278CA0004.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:26::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.22 via Frontend Transport; Thu, 2 Jul 2020 16:09:29 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a89483e2-77d0-43d1-f1e5-08d81ea24d54
X-MS-TrafficTypeDiagnostic: AM6PR03MB4743:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB4743855C32D1969E3DA7B648EB6D0@AM6PR03MB4743.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0iGXIXic+jdjZDFgh/cIkNaaAERmJBq/hd7c5cn2mnOpjTLkB57HI802KbBmWtJ5qjADo5XVrZdWyINBCuwgxEM6KXq4hcJPakWpG5QVkJj2PfKqUNpc6gBFpbbBrP1M0J4FJy2SVwRv5BX768FF0PniqLaOJbe77nhqG2/jq5koJYLIfhNvkOs0biFvgEziMYRv6B6SrSw2xhj1t3IldB2BAgKVKErggNaWMSUleXZMMyfQMMSln7g5haMoeZuwA+YpO+gfMOrhc7fCZaCuNsBrAguxBsc5B0G+d0GzPz7zDzyETDS2fYewGPnN0Vq/RxGFB4lD4ZsB23YJEfelqdteRH0JTPnUBobgLHF0WSKxGDPFMqEcNBdYaa9LBB1a
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(5660300002)(4326008)(107886003)(6916009)(26005)(2616005)(16526019)(186003)(6666004)(36756003)(86362001)(6506007)(66946007)(6512007)(69590400007)(956004)(83380400001)(1076003)(8936002)(66556008)(52116002)(66476007)(2906002)(6486002)(8676002)(508600001)(54906003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: woHGyAvMB5bShHHfoOKM0Ckm63SWDO7+E3P2F6I5GNuFWzHdeoNzxb0eX3ShPFajFj6f0GNwWS5vJoc0mMxEhxIdJDriu5Cttpb3VDLqa3u7PD44y/P14BT/JdW8hG7O4tegQrL0WxR8aIiQik7nPV1FFbUIn+ve5zZfyR+1E8XHRq56imOOoKd6tpPTQRfq13XGYJLitwJBcrklMaaqq2DIzr5FZ3SZ43Rz6oBt0Z/v/99W9axKH6D0enoDUPDswlTJ04ktx+1HvbsRys8mpVDtK8tiWukNDyHsR6hkNMctpu9IJl+MmM1xCzGy+2CFg1yaQacAVO0tbVxTCHsdGDoJEsAzZCw8uKK2sl4VSObiqm8AclwqWwh6omHkQSXSpf8umBBQkJLPcLSjUZShy/aCWp3Ew02NHF6YrKzdDNrkfc/QsPA984OciOPyKaYp24tBfUf4e/WIwJnH80ZF0093Wfe5uAfLNtg4gHhXFZM=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89483e2-77d0-43d1-f1e5-08d81ea24d54
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 16:09:30.6721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AO/WyjKv8PRvmvEqybzp8H2yaOYiyv2uynHlGe84vs0XYHLJZmvA6OLkPivqwk0NutVQqZHnicV5vTxe/XqLQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4743
Received-SPF: pass client-ip=40.107.4.126;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 12:09:32
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Function "print_fdset()" in "strace.c" is used to print the file descriptor
values in "print__newselect()" which prints arguments of syscall _newselect().
Until changes from this patch, this function was printing "," even after the
last value of the fd_set argument. This was changed in this patch by removing
this unnecessary "," after the last fd value and thus improving the estetics of
the _newselect() "-strace" print.

Implementation notes:

   The printing fix was made possible by using an existing function "get_comma()"
   which returns a "," or an empty string "" based on its argument (0 for "," and
   other for "").

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 6044c66954..23ca5d88c8 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -541,6 +541,7 @@ static void
 print_fdset(int n, abi_ulong target_fds_addr)
 {
     int i;
+    int first = 1;
 
     qemu_log("[");
     if( target_fds_addr ) {
@@ -555,9 +556,12 @@ print_fdset(int n, abi_ulong target_fds_addr)
             return;
 
         for (i=n; i>=0; i--) {
-            if ((tswapal(target_fds[i / TARGET_ABI_BITS]) >> (i & (TARGET_ABI_BITS - 1))) & 1)
-                qemu_log("%d,", i);
+            if ((tswapal(target_fds[i / TARGET_ABI_BITS]) >>
+                (i & (TARGET_ABI_BITS - 1))) & 1) {
+                qemu_log("%s%d", get_comma(first), i);
+                first = 0;
             }
+        }
         unlock_user(target_fds, target_fds_addr, 0);
     }
     qemu_log("]");
-- 
2.17.1



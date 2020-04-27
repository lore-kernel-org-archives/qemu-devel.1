Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF05CC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68DD206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hxUwrRI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68DD206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSz6W-0000DN-RM
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3b-0002Ny-2d
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3X-0007Zw-TH
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:02 -0400
Received: from mail-eopbgr70114.outbound.protection.outlook.com
 ([40.107.7.114]:29366 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jSz3W-0007Ta-B1; Mon, 27 Apr 2020 04:23:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuVO5k54BPNf4UPGg/wUT/DbqJjbx+RDIQxgYIj2SMTLYwx402Eqau1wsrozuh0Tqshollr+M7JIkelpZJGYt4mtya6cypefwj7Ss4kQpJxN60GhQqizwmhrwQvroE98SalOAcG62aVMj5sViMi0ui8BXSFZXJ/1PdEjxwO/7VypMpCcs/74MIaYuInWcUwNEAYxukWcfhIrvM0nETjuy+8kmC3Hb7cRv8Z3fsb/frF5mDFN+2j9f2jmzH4GtxRZf9c+Zg9NUDbmrvExxKDXFYlPeS9xO6xReYobYDJ+Fl/goZudIWHm2SDWTC9ErJCA5Pjb4F6SRzs73jlcRMXiPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyxwVFEjIJ8maOv80J+vFbwCLPp9tzvkpv96RwU/OkE=;
 b=ktfsCJbvoBw/eqXxt+0clCwScvD9v49ESej0vZhAmDgKmEar39QR7oC/9l6eGyXMsEDmFcGEo5W899PkmO5Pv5/yxx/at6/tzfIR9rHyEndpCjFMHnpv42pLBohNsKQr1iuq+lHKM9Q77UZCe2ucbmtvWGSYtuQesFTdDj8hu8tO1Ix9DwEuTTrXMosj3CiLschp7xc7OSCz3BwVF1Yg5UOfw+7byQaKujZUmqIoTXkdK7GLNvuWERb/faOGjsj9r7Ik6ib/wSwadNjB5Td1hprDMMbKhQUdr8blg3XRRhp8j3GC7PDGnZ77ubwH0eK8jrZyUEV230lTDhz7Cu3EXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyxwVFEjIJ8maOv80J+vFbwCLPp9tzvkpv96RwU/OkE=;
 b=hxUwrRI6+Bcyy8TvMdZniZTyDsWq9CORxe9e0XWfVD5LaWPdcHL2RB3ONJhIJ5VCXaYaPKDlJ6TKPecx0ENxgi8VR0dXaTW0SYMjNzg25Frc3bO7g1KQ6sRcytP0/R4G/yFJXvT1zphCu7EqIZ4Vt/kin1/nuHu1Jtx89uH4JtM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5463.eurprd08.prod.outlook.com (2603:10a6:20b:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 08:23:56 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 08:23:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 03/17] block/io: use int64_t bytes parameter in
 bdrv_check_byte_request()
Date: Mon, 27 Apr 2020 11:23:11 +0300
Message-Id: <20200427082325.10414-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200427082325.10414-1-vsementsov@virtuozzo.com>
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 08:23:54 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65dc8ad8-59d2-4bc0-a41a-08d7ea8453b3
X-MS-TrafficTypeDiagnostic: AM7PR08MB5463:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5463C8F842A708445657ED95C1AF0@AM7PR08MB5463.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39840400004)(2906002)(81156014)(6486002)(26005)(8676002)(8936002)(4326008)(6916009)(478600001)(66556008)(7416002)(66946007)(66476007)(6666004)(16526019)(316002)(2616005)(1076003)(186003)(5660300002)(4744005)(52116002)(6506007)(956004)(36756003)(107886003)(6512007)(69590400007)(86362001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CYfoT/wEr18FsBnZRePooEgSiv6j3xtnaBniWNmVu4Wak5Oyae/kzj5rcbzkHeHj5dkiwOwaSMmGn1oqhUsmPRVbaDBGf/8e4bBWnmWj/Eu2OQ9Lr2gfWLTqdeGQOf0IW2SSCI+7lhOmYlx/iwN0oyeO2zGZj/WzrFZ3Lw79tuit/7X2/hYl1GM5XUyGM5nDY6EYhK3td6hdHze5901ycodH/W4RGzt5uzrjkGMrDqwiIZjMZ51p9pyL0VnKfMTCgLBR6QMBHg5DSCZ+SxaRMSc91JQLoeIxhBESJjVoukz7SETXTs8IKWvpkj0I6WTwz/QN9n82N/V0gxp2lHirPjnkhkaCrg9Z4H05m2n4SGNmFRQzensrnOwpMn3/gKPqI7PQhjmpcFNA0cfs4bkarBCy7oxS985g1LhLU1jWs/GIzya6oDMKQiR6wy5+sT/Nvznbz8xoTuK2MfehqR8d/bYLI/UP6XIv9+/h254zQkVNtKL4CZjCN+zLHuCM6W/D
X-MS-Exchange-AntiSpam-MessageData: IpI7pYIdTxhMGzt0r3IU29QnGfprHtIFhVe32HrYFSfwlbVHVoksxoXtbRT5iCmEATLgwAhXVmdt9Jq8p+pMN/M1wLx9Guom89kpUtCpVsv95iS8to7SKUZaZbqjogLjmcqmPLc2qcdrgg9RxMzHYvxU5uSOeD9q7t6IXd1TEslJP0mtYprQjcaElKtRr1J4xFKPTDqC6bkM2K2/TSQPhc0jJl68jVKm7NakoC7fvtkSG1Bez5O9YXanFS9F/3D5VLhC3AuI8iRmW/DZZbWpFl3ZCh0xNae3JZ/Ll9hqVrJpxI2ZGNWE8/ufp8Z+KmAqewyw3VQX0cLdGoosC62D1j4uEP34nfq25/TB2Mz3HfjOy6lvSEHKktbZGESsoIxh8JNYMVzEAfjSpJ59T4gkD3Y2mIjpUWAFlxGpYSALoYQKyiO4WBviA5Iyy+9y6k13Tyylu3UMLTpwmsthn/OcNSXAJbH6gERffljyN5T1i6GPEtBizmeUEY9g5rDaM8b3hTFnaOlSK17VezFxgoH14dCuxm8TW0TZJs/+QCN7Cny/UVnwsrdHWWL1hjk72pGiThNVh+pSdvAgszW/bE3rE9Jd33YN24O/944pxv4rUnL1j1oMpErEq5If6lJc0gIwrbB+gb2TFIUtyBvUeRtzbDe1S/E29820kY1TYwIwZJdopt7Ggehf1Z6JJuzmjshSP9Q2uNODnNzRZzbGqAUOcbWCiXN14BK1niqzUuId2Xeh5K2PhLReyrerIIVQ8GTt4NS2EdU3biiwbQMdkipYBxMRSMeViM1sM5Nm5JFiMgk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dc8ad8-59d2-4bc0-a41a-08d7ea8453b3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:23:55.9130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apKEtLMBuuoBPSFUh3PHKFeIUKQ/ZE8jeAXTLWbTJ3IxAo+fhMOqesXPYbsLCC69sQWuJDf3W7lDbkZbbQMmIHt51yRG1TBT71cvk0c/ZRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5463
Received-SPF: pass client-ip=40.107.7.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 04:23:52
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.114
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, dillaman@redhat.com, qemu-devel@nongnu.org,
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, vsementsov@virtuozzo.com, stefanha@redhat.com,
 namei.unix@gmail.com, pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com,
 ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are generally moving to int64_t for both offset and bytes parameters
on all io paths. Convert bdrv_check_byte_request() now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index 7cbb80bd24..1267918def 100644
--- a/block/io.c
+++ b/block/io.c
@@ -875,9 +875,9 @@ static bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self
 }
 
 static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
-                                   size_t size)
+                                   int64_t bytes)
 {
-    if (size > BDRV_REQUEST_MAX_BYTES) {
+    if (bytes > BDRV_REQUEST_MAX_BYTES) {
         return -EIO;
     }
 
@@ -885,7 +885,7 @@ static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
         return -ENOMEDIUM;
     }
 
-    if (offset < 0) {
+    if (offset < 0 || bytes < 0) {
         return -EIO;
     }
 
-- 
2.21.0



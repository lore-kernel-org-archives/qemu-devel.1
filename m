Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A361C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:30:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991AF20728
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bmsmWjo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991AF20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSz9f-0007A2-On
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3f-0002dZ-L7
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3e-0007mW-W9
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:07 -0400
Received: from mail-eopbgr70127.outbound.protection.outlook.com
 ([40.107.7.127]:7750 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jSz3d-0007bA-1m; Mon, 27 Apr 2020 04:24:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/2PCBSmm3Yg0nZbR8ubkCEYWRBeu0AT+zeWMjt95mtXML6C/d8QtPP0cdY78lEaZIsZFEKLcoRcqF2BfMd/tdIg10500vFnp/4hB3kJm4X4dh5orX5KJiS6yMElqipICE99o8y3clsjc7foTgSAfs9O2bpmH+YoaxufGg2XsZMbbU7bjb0VK42JKFAGgTJBtzmpPzv/pTzdN4ybdfDLSLd/6INa9wQPfd+vH5eLQIx+cEB5q+q95DQpdmaJ+IpaPVlo9O8AgGj3NjSdVaF2x+EyHOtjUh4cKh5HgtyI26XGPKu1lEl+NEbBm8mVI4pdIQzCQbaVnAJwYN4RcXh9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVKM/PxHKaTTlyg2sgwg4PfxbzmIqoHhlmzSAmmu4/I=;
 b=NspmM+F+Mcdhe7mHGkFvpbOUlYYl12ec+8yZpBKwQa/vJHMWxQbTyoa4tbOnLmM2Ew9pVjGz8ygU7AGAEfZDZw/AgMlePjaFF6oK1Zdn+eGfeaWDyQ6DmNt5X7s1VAQnv3ASlMSRqzruco+7UAs33c7VvsPUYnbUCTKY0/XZg8NTMJiRGlzo2bB3qOzgkPviLc/jfP+1koTnEMEiFZwBxOaHJ9R+v1QB7WNgBONxd0Qm78ysnBX5rjtJIY7Y5E0gAUMYwGxjgtUEZXztFV9ls0H166uM/PGt+PcSn9bNOhyloTbkQYnlOGmQ58j+2fxCthqesMrsT5hPTvwb4Mfiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVKM/PxHKaTTlyg2sgwg4PfxbzmIqoHhlmzSAmmu4/I=;
 b=bmsmWjo74rHbrVUKIH8LwT9kh8ZETTdvsK8uy8kOBlC4jzZrn8xG8DoGXDM2UI9tlndRCjivOuBIfF2inhG3wHkQHKGMJAG3i8R2DoMDfvdEpVX21JtcQRHsbKNQn7vV2qkrl2/w6cO5G4yVKMDbXljYlKCIXaB2TUkrH0tdwiE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5463.eurprd08.prod.outlook.com (2603:10a6:20b:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 08:24:03 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 08:24:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 08/17] block/io: support int64_t bytes in
 bdrv_aligned_preadv()
Date: Mon, 27 Apr 2020 11:23:16 +0300
Message-Id: <20200427082325.10414-9-vsementsov@virtuozzo.com>
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
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 08:24:01 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6043e689-7d87-45ab-98bc-08d7ea8457e8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5463:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54639E6EC527D8B5EADF5577C1AF0@AM7PR08MB5463.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39840400004)(2906002)(81156014)(6486002)(26005)(8676002)(8936002)(4326008)(6916009)(478600001)(66556008)(7416002)(66946007)(66476007)(6666004)(16526019)(316002)(2616005)(1076003)(186003)(5660300002)(52116002)(6506007)(956004)(36756003)(107886003)(6512007)(69590400007)(86362001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8lI864AT5xUwM5RrE8KFiKzQee2F4hlP3hc67HnMFPL420cidYzwaJcEAUhvPPu3KL6dr1I6QWlj831/Zx1cULFm1drC8hykv0ijXs6Rke4U7c/0jdjsJwKPexPI1yzIHrvD6QlmI52KKup0FWhj7rJjr3MvmdtmMTQImHywKGfpF41c0BlDd15n2xWuQSWvudDLLUL6OVZI/H1nRm6QL2gszVDAcRpQCJnWLc76I80hXvpLFPTc8cbyBAwu+Q1VnhPlLEt9Ys+gQ4YBdaLsuwE370EfruhLVEJcq1O9BEIoN0VJOFwWF+DBcJvCFyLIWUcMeZVLNlVHyAov7CUsxpCzpOuAZsZRiIvY9dl4GTBQSD7+bev0Uw4kHqda/qKO2S1TUlnOB4VZk9jiCtHYy8/9WzzxTaKYrNET8rS94cp/gJPURuqWh8z4SRm0cSVlFH2fgpPHAQqZmvXpCRLtMZbt9S/yvafbwi1p1b4szPavI4ZxU8z06Q8sVq+h0mJ9
X-MS-Exchange-AntiSpam-MessageData: l4fcUBNJ1p2QH93n4Wyy3DfX/89n7OwdshnWgD3/osYZe4RvMwAd+nzT7rD4S6Y5YoLkgfJsNLRF7pjVYaeATI2JtgH2GVLlsb7zmXd98vga0SOQRKLx8X1M8dByi6b0vvyeXh5QGNfi8JvTtaoD3tQ34Exya98k2Da22EYm0uKkNuQfiFiH/DOFqSejZV8PXTxaIlM4WTj9Z5BvoiVe0NxFWLgfcRMVOuGnILERgFpexFHZOkXYqDMScbMcgkn+2eYw129UGt5Ohpx7fblB/AhrHT0EWwk9raPTdZKC2EWGnZNa789Ey27AL0AkAojGprMPRXOJR/gMW/kdGfPJ41kMH3GJejWCdjDIoDEwaVdf4ojJJkgsZaDJbzA8e2TR+pNVvWyNCTPizub2h0R90pEFoW5AM5tpk9mMlg7xdq+ED9Z4w+UtaMmHzRxhK3bUBbktQKwpHw7BAiUBQGAjjfWB73Z9m1VQIdERiMXgJ8tolbWL4X7c3M6RrWsmO1BmLgPOb3V6pDMrpiN+GrpA71+BEgeUw+22uuCAPTjSM8fOaHKh4jFKsB+AVAfwbrYx6fNLS1wd2aVqQ7lRTM0fwaWEKx1uX85WFSwDLook5GNXDlriUE5djf4jVXpsPBAKoCLowY+eIdqDzc6AHk2sYe/ownxbHiTM/8H9S6EnJB2knhcUVS3LNjjS+1XWJSj4deg5Sgz0tXuzS6tx3r0j8m7dxgAhJxUZYCZWYLrVF5qX1phSBfsVaA092luXck4kO3BnqexabC5adV+1hsobZCKSoYYHM+BtNLdNKEUXDfs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6043e689-7d87-45ab-98bc-08d7ea8457e8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:24:02.9579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxvmlxWXaLwQ+uvzUJ98vvCOs2ifo8v1YR6pBRdCzxZcgUJMcePN5MSSeYxdKm505Z52mzHOJWgLCyYwLo9WJUOK6r3zbOp7p1zQaP0pdnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5463
Received-SPF: pass client-ip=40.107.7.127;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 04:24:00
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.127
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
on all io paths. Prepare bdrv_aligned_preadv() now.

Make byte variable in bdrv_padding_rmw_read() int64_t, as it defined
only to be passed to bdrv_aligned_preadv().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index ee38c9afb4..70b51dbd0f 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1430,16 +1430,17 @@ err:
  * reads; any other features must be implemented by the caller.
  */
 static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
-    BdrvTrackedRequest *req, int64_t offset, unsigned int bytes,
+    BdrvTrackedRequest *req, int64_t offset, int64_t bytes,
     int64_t align, QEMUIOVector *qiov, size_t qiov_offset, int flags)
 {
     BlockDriverState *bs = child->bs;
     int64_t total_bytes, max_bytes;
     int ret = 0;
-    uint64_t bytes_remaining = bytes;
+    int64_t bytes_remaining = bytes;
     int max_transfer;
 
     assert(is_power_of_2(align));
+    assert(offset >= 0 && bytes >= 0);
     assert((offset & (align - 1)) == 0);
     assert((bytes & (align - 1)) == 0);
     assert((bs->open_flags & BDRV_O_NO_IO) == 0);
@@ -1495,7 +1496,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
     }
 
     while (bytes_remaining) {
-        int num;
+        int64_t num;
 
         if (max_bytes) {
             num = MIN(bytes_remaining, MIN(max_bytes, max_transfer));
@@ -1596,7 +1597,7 @@ static int bdrv_padding_rmw_read(BdrvChild *child,
     assert(req->serialising && pad->buf);
 
     if (pad->head || pad->merge_reads) {
-        uint64_t bytes = pad->merge_reads ? pad->buf_len : align;
+        int64_t bytes = pad->merge_reads ? pad->buf_len : align;
 
         qemu_iovec_init_buf(&local_qiov, pad->buf, bytes);
 
-- 
2.21.0



Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8E5C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1FF5204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DOiGUsmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FF5204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ZSS-0000ef-5F
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 09:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6ZO0-00018O-GV; Fri, 14 Aug 2020 09:04:44 -0400
Received: from mail-db3eur04on072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::72e]:48915
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6ZNy-0006dr-3b; Fri, 14 Aug 2020 09:04:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mE7U+KDB7fu0yz703Uj4HuIS79kx+CdPPFM0qo5n/dmDKpXnNgA7sIgWFQ3BmbD0P+uck9UQWBl2jd5lic4bt+RSTp+0xmD3jFPXFEaicsK5SicuZLkFy4B2Xlj2G6djk65fpU7k4Vn0UATMgg7a6dLyH68ilAnu7V9o11wYS6rRshohHlvh42t9v7nPOHSzaaYp2VdZ8RMO/NOc2Nv6E5BixtWrNP1fHX1tQPrAf7QHOY4k60fP73gtep5OXFYhdBDWYPgGGyrmwfSp5SiNhFzcuGqh3s7muzdBV1zw6ZQ3y+fy15v2+Vk35QCL++FirCsnEZ3P6CXVABY7O1J37Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0180ISePi4giOfxzrK8nRtVyit0YCa4z0sQ/annAsEE=;
 b=Nji/zPIleq6dA5Ve9nBj/DrLVu1uOvx0xV3VhFsne5zh/MKJ+s1nytuVh95wu8Qy0wfq8FOvOSyPKxZnlTccQC3G42+foQQFYuxACItvr4PX9mkIVJA5sA/2Jb1bHfu4fgDnSYGRtW+WvG2e2cInVg9pk9N+aR3uxIVDzoUFavdLcd9zaTdT4+hT+IHcYtHiqNLcvC131Nn2wCBY481UBzzdIPuPSTpY4PnJdLyEFkvOvKtN3q4r36udGiXDBIQntp+siW/d0xf+yoY1uwiMtk00VQu4CBuVeiImu44TI+MSZxk+MAMqEs1zJT/waJhDaqz5vSTyFsOecVWVZzQZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0180ISePi4giOfxzrK8nRtVyit0YCa4z0sQ/annAsEE=;
 b=DOiGUsmhp07K5coy/x2xdXtiPtUsRPbnq5imCdgOMVDWQjF0kEW/DVu56B4NHQ0STxcP0rBQHLiP4Yb8N95NEoGjcLAlq2h4JrDjAzao23Yz60CJzjtgDeuNsKX+FvA2k3ZSmuhwHaKvpCe7mXCgdQElKAkNZDCsXvLCpy1dDAo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2981.eurprd08.prod.outlook.com (2603:10a6:209:44::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Fri, 14 Aug
 2020 13:04:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.022; Fri, 14 Aug 2020
 13:04:20 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 1/9] block: simplify comment to BDRV_REQ_SERIALISING
Date: Fri, 14 Aug 2020 16:03:40 +0300
Message-Id: <20200814130348.20625-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814130348.20625-1-vsementsov@virtuozzo.com>
References: <20200814130348.20625-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.177) by
 AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Fri, 14 Aug 2020 13:04:19 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87bf6765-fd2c-4d06-1ac9-08d840528eef
X-MS-TrafficTypeDiagnostic: AM6PR08MB2981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB29817B2CD0B67A279B1489E1C1400@AM6PR08MB2981.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hyEbepTJ84HO4Qts5MazCuNx7AAu62yAYI/GwZoSYCXcOE1vvo2X7pewo+O06wcSxJ/UkL8Y1yY+L93gd597GyMuBRsgFqwZ73JKF0j6YA+dL3/KZgEnxviNnIwpBcr91+2gsSzernZpRz/8EblAiZRxH5Dqy4KApaMqZ7RJ1YC2A604CEWrppXHU63RmEeabfoouYwQTCJ98PaVE+G14zUG2IWZxEhBhS+7GT6I5Zk5aZeBizdeGX5e2iAo6D3zogPSDyREDczEhghE0PyFCsIm9moxhUDFwxghAgrorjyVrCiYHcAg9m/SJ6Wd3ndnU8qNO7kEibdQloO6nuDlqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39840400004)(396003)(136003)(2616005)(956004)(86362001)(1076003)(6486002)(478600001)(8936002)(6512007)(6666004)(36756003)(83380400001)(5660300002)(8676002)(6506007)(16526019)(186003)(316002)(4326008)(66556008)(66476007)(66946007)(2906002)(107886003)(52116002)(6916009)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: oF0KXHCrF4gmS1QLl1HB4+QwCzmtkQea/RUMvG/cMMzkVMV5otZ0TeJurSUjcQPJOcBuzpdEwpfkBsPYZiGY1v5SsI94anJ+Jp15Wc/Hz2m0pX2sDd4zG5Az9CLzgmPiGvZTPi5aNg288GPWQAP4R6xXjSpYVPjDFEeonX+5z7jPucfBaODcGwBRqg24ttTpZMTRtWW9o6SDEvwpXwHij6XFHrsUvChgnsZ8+5u72JoewaiQWO7d4Kl3QBxUEu2uxAJO7os5DEpRqNh1BtRPEQJ+z/3uTkgdxLZiRK7vFzKEqprHXamcGfxH8LM8+zSmNdMIGaj8D+zwoLrM3nlPHGS0KyPyR2OgCGdlOmKircPJeXaRXw24QHlhmND30FsAjTcSDzd2m5Y74c7UX0NJUmJtbHtetEsIuBdQINt8/rro+ARa+UBpIqiQMuTSPsKH8XgytXGWlQPoJGehIddBe24jUMCpBAcHL5J/JF7udObEeTsXEPZa7C36vhHgkN+eFLpQC7OHDR6tAJZ9BtVOSpKxCSeoYGnGV0XkDV8AvTF3TTonMY/eYv8M5gAv4w+1uTdhf+f7DHfPHufVQ6stXLHj29dLJamd1+kDaJGUjXK6N0BkPBvXpa/pMYbgda9Z1i4C5DAVUi/PfugrwXBJAA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bf6765-fd2c-4d06-1ac9-08d840528eef
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 13:04:20.4705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JW2US/Td+pUcYpWdF/8iLMiLxQaAtRIKNDlOiVINm2lDExEbhCsSyNmG81sGWB8U13mWF16IgBdNLFa7CmWPnxi5nB70rTMLlFhu+BVhJC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2981
Received-SPF: pass client-ip=2a01:111:f400:fe0c::72e;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

1. BDRV_REQ_NO_SERIALISING doesn't exist already, don't mention it.

2. We are going to add one more user of BDRV_REQ_SERIALISING, so
   comment about backup becomes a bit confusing here. The use case in
   backup is documented in block/backup.c, so let's just drop
   duplication here.

3. The fact that BDRV_REQ_SERIALISING is only for write requests is
   omitted. Add a note.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 6e36154061..b8f4e86e8d 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -53,16 +53,7 @@ typedef enum {
      * content. */
     BDRV_REQ_WRITE_UNCHANGED    = 0x40,
 
-    /*
-     * BDRV_REQ_SERIALISING forces request serialisation for writes.
-     * It is used to ensure that writes to the backing file of a backup process
-     * target cannot race with a read of the backup target that defers to the
-     * backing file.
-     *
-     * Note, that BDRV_REQ_SERIALISING is _not_ opposite in meaning to
-     * BDRV_REQ_NO_SERIALISING. A more descriptive name for the latter might be
-     * _DO_NOT_WAIT_FOR_SERIALISING, except that is too long.
-     */
+    /* Forces request serialisation. Use only with write requests. */
     BDRV_REQ_SERIALISING        = 0x80,
 
     /* Execute the request only if the operation can be offloaded or otherwise
-- 
2.21.3



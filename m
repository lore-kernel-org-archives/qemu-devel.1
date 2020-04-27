Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DACC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:52:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D78D206CD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rHFIcAJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D78D206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT57O-0003zX-Gx
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 10:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4v9-0008IB-Ex
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4v9-0007n6-2Y
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:39:43 -0400
Received: from mail-am6eur05on2133.outbound.protection.outlook.com
 ([40.107.22.133]:24288 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jT4v2-0007iF-Ga; Mon, 27 Apr 2020 10:39:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqgw13YjOu3tePzk6vc8BcghVTz2TLPkSYDa7AkDos8914VRUS1VczuIfABZq4sJkLblbz5WcO24Uu7J3DcINzBgyN6J/xgryawbgcZ+UeYexebAQMxpfUgXjb7j8HhsDBlWQbgkojzI/dyTS7bG7M4ixioLlj5shiIIVH6fkbUlUGypMlOPRJR0gtwsa2TR/tsl9EzaHFF6R9leX7CqFuDVpbrRinEQillYEJWJDWHPqLV6QF1B0zIBI+pbhkVnNokdETezKlWYJ5nLaivwsufZJJlIR3EmdZ/u/j6cY8OtqftCoHFjCXZ6MzAau4NVKywEf6Po1nBgGaLz+Xi5uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQ35i0r1Bi+qYtXHM5DJG/eYdtQ4haVjHbJ4RnHcvlo=;
 b=BNTDa6JHMhu1E4zdwrsCZAILP44Zj3TO5Tp1CenhjikOCDlAh8xgThDzvmZEpDd8i0QlPJr17eOFYadbMy0dHZ40+c0rw2ubRgpF7HTUuQ/a1NcWzZf3B3eZrHV7jxZZicfuEvK5+Lq4+tKccbMPlrlsQmsNYuMu5MbxkHXiBQWCWXBZMK8aNBG3H/jJ639EFZVbHL/bz2R0aRZ2c1W2DrfSL7yJd4Z++JStjkkpPW5owD6eqq0JmxIwAthyMRZFDXlizu4p28r5dW2noNn0lhZ0O0pgvdqJBgz+nnRpc9q/ReYQbaSiLfPGLgQIKROcVeYEhAbvew/9shZIZccsSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQ35i0r1Bi+qYtXHM5DJG/eYdtQ4haVjHbJ4RnHcvlo=;
 b=rHFIcAJyLLqVT0I1jC7DYj6We0J/CoQAqhnDU8+lfkxuamMjrQATmgzW1I5Z3LcnzIXwlWbu+Xqp88zYU2zTjlZiEQTXpRLEvHJgZsMxGL7ToN2UORQ/KN3aGydc+qNdanEmJyiy2tFPPFaA8sKjFek/1QxScO+MOQVWN8zrHCI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5527.eurprd08.prod.outlook.com (2603:10a6:20b:de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 14:39:32 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 14:39:32 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/9] block/io: refactor bdrv_co_ioctl: move aio stuff to
 corresponding block
Date: Mon, 27 Apr 2020 17:39:00 +0300
Message-Id: <20200427143907.5710-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200427143907.5710-1-vsementsov@virtuozzo.com>
References: <20200427143907.5710-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 14:39:31 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea764120-0a4d-4542-4abd-08d7eab8cc67
X-MS-TrafficTypeDiagnostic: AM7PR08MB5527:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB552751A9327A8811AAEA7C8EC1AF0@AM7PR08MB5527.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(396003)(366004)(136003)(346002)(5660300002)(107886003)(316002)(2906002)(6512007)(478600001)(6486002)(66946007)(66476007)(66556008)(69590400007)(1076003)(2616005)(956004)(81156014)(16526019)(86362001)(6506007)(52116002)(186003)(36756003)(8676002)(8936002)(6666004)(26005)(6916009)(4326008);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SlGGn+8trawMJ1j1+ECWfuyuE6a0Y/Obd9gx5PmLfsQfEwRm9zwAhxhp0C/MRoth3tCk8+E2or8CFRRLq027TsaPruTKdTJNXhvWXmTrmkSkTaQMyiX2QC8ioO2FtjeLvJ3K/i/B0IqyFz/owdBIGVHQSvwZPcK6rvGaIgHPAR51w82lT3OW3lOt4nPwqyPqt0QNnK5wd844GNgUNYp4IPcjRQMkMrjMEO/NlfDAENYDK796OhFc6+DI24Ghiq93RnHvkaBY+tPZfa2J5Qy/8oJr5NPAU6Hb3Mipo+DzZvDUgitz1UPyLRLExISNG9yOgwWEoV0K84Ez/hjsDhDdAZh2pxKMsaccUChNaz/m993vI8ThL5HrHaTJKC9ozoQkMnFr6lsw5gETHNuXtIgUnCDLkDcQ+TxS2VwERISxXsV2Ti4Hhp+cEl/OE7nfREku1XK7ev597atb41AOx39p5r28xPhDgEunf1aTSOIwqzcBbAw1rOuEahU7uTyWn6Vw
X-MS-Exchange-AntiSpam-MessageData: Vc/ZRYpeKUTae1FRA1A8vThd2awi/AEUaQZP4tqEuKxgpGbmj3EMdDLxzibOcTt0q7vCpJDQ9MjkVX7cabp42DJSCoz0xNLViaxhAzW9d9XpIjbTkJY20SHeZg+gevdXIrn9eIhPdIG4fftD3hReeGhFju43jYNKmFMN25Re5oITEpUvIAFAPjv3yF/trNtWLmLh4ECE1xB9dK9PrmIfASLbnlk5M8yikVetZAIIt9YdBXL2Yfkrd4sS6C4+3qaTjpldgwbKprsORUOGbnmbKOo66R7pmEYrZ/XH2utGCvM9Hf1ubYynji6ftpbpBtGfjvQu/1F6WYjFQ3ZIJaGsdeozzbpsZ2MALRfdkEYgKLhRGaTF8oibbDjhADSPqPVnUSA8SEHGlQCnmjNSpOC3nB7vMsBF3AckYhNmxSI7v0457lcW2KEfs37BXloleSjCk2Z7g0apB0yBuw8ST2vOshxjy/OWtSNQY8jKLH/gCgrNNRooc9laQUqstyWvrLiT2qndiM+epyyGjzozZFQM08pJL9bfcFYqVQ3phSSKxuIZv6u9nGFVDRqAABIHW/orXRG+L/EL8tCkGG+CyCCmxhKccJN36/BQSjPIFSGAL/dF8vjDOqIF39xBtqnV6KiwibEYkpWUZcs7A371mKh+ojB56KThUy5k1p5oxng+8zTiPXCTc0fardgdd0VN7NAV9K7MfeeE1qmEsCpBaNL2IOouF4ohgO2GmQFhNCxAL6/MDI2aPvG/lVqTn74jiw4aq6QA9LkU4fT8fUyCZh3tw0eqiLNuEv/gnAewU/wmUmA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea764120-0a4d-4542-4abd-08d7eab8cc67
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 14:39:32.1652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q78Zrt3HWueWGKHxSns/u8IBMrlSFgb0anKAMXLEHViIMRT9uBz4Gw5hW9QHm17j53/9oEKdh9ILgK5Kd1AxbVUiOKrUHDt9OL9xVRPOBkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5527
Received-SPF: pass client-ip=40.107.22.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 10:39:31
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.22.133
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/block/io.c b/block/io.c
index 94ab8eaa0f..880871e691 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3125,31 +3125,38 @@ int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes)
 
 int bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf)
 {
+    int ret;
     BlockDriver *drv = bs->drv;
-    CoroutineIOCompletion co = {
-        .coroutine = qemu_coroutine_self(),
-    };
-    BlockAIOCB *acb;
 
     bdrv_inc_in_flight(bs);
+
     if (!drv || (!drv->bdrv_aio_ioctl && !drv->bdrv_co_ioctl)) {
-        co.ret = -ENOTSUP;
+        ret = -ENOTSUP;
         goto out;
     }
 
     if (drv->bdrv_co_ioctl) {
-        co.ret = drv->bdrv_co_ioctl(bs, req, buf);
+        ret = drv->bdrv_co_ioctl(bs, req, buf);
     } else {
+        CoroutineIOCompletion co = {
+            .coroutine = qemu_coroutine_self(),
+        };
+        BlockAIOCB *acb;
+
         acb = drv->bdrv_aio_ioctl(bs, req, buf, bdrv_co_io_em_complete, &co);
         if (!acb) {
-            co.ret = -ENOTSUP;
+            ret = -ENOTSUP;
             goto out;
         }
+
         qemu_coroutine_yield();
+        ret = co.ret;
     }
+
 out:
     bdrv_dec_in_flight(bs);
-    return co.ret;
+
+    return ret;
 }
 
 void *qemu_blockalign(BlockDriverState *bs, size_t size)
-- 
2.21.0



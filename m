Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD41C10DAA
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1FD20C09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NA3dHgkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1FD20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG5Rd-0005dW-6n
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 15:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5KL-0007SO-5m; Wed, 09 Sep 2020 15:00:17 -0400
Received: from mail-eopbgr00097.outbound.protection.outlook.com
 ([40.107.0.97]:61422 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5KJ-0001PE-9o; Wed, 09 Sep 2020 15:00:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YALM2lfKnSfwxOeIWLF4TFXChOrRB9dNp2ci4eTZp4z6UKXaPnlMf4kd17dRKBmSQsfAZHR4drRaahoQ0MlQMFLuyxGRs8lNuDMpjAhJxffHQEgpEVvy4rudp1fsz9fxPT+4805/LdI5U+GZfzlpBTHBo2Zr/Lb/AMz6z1mK7TEcUhIbGuaBnfMv09fU+mx+mzGURIym3hmqCAjP16fLkkDTH6LXNTE9HffClN8wa6MBNRaCZh/+Ab1S4Awi21xZlg07h85EmWWgpkTNHHxbsJGM+Whn39rGdEqp58BBC/ORdykvQIYMSj7KkvavBcizMp4RhvJyhr7v1jWxptgE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZqypv9Biw0KZykq2njpW7zzON3JmbB3iLPv0ipZUCA=;
 b=kZ9m0+H3fxx53IQdhHsEepmewkozdPcKOlB8eHBbR3Bv+cC5E7r5ZJ0YlfgjtJM6MWrHLpJJPKpbsz6HZ1148/NP3F3/0F0uglh2wFoOfoawIFkvdQGKNjb2FdXmY/swjudPm4h+/FRZNxiJ3ecOHlCn7x6RDXxgcAZ3syPJaG4dnxYwklrliDrT7MdpJsPxbNJ/HdPYkvkRwkSooYPmKKVRXYp4K5eXA7WFcblBwrBZFLCL9YGKkUrTZI03ZTIsIaAcI6coDq0DnrwU2Hj0SW70WkGQ3fJOmExcAy0K7QaNZuOnAs9jk4Fit0uctkE6NVz39e2o69KoeYPW3z+vGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZqypv9Biw0KZykq2njpW7zzON3JmbB3iLPv0ipZUCA=;
 b=NA3dHgktE6r+DL+EBqz229h7wrtn473QUjDgENqCNzSZrqyAg4iX1+cwQrXYpn+iesBER6SCr5P1Lm5trn843UbbG2eLV521QCVfEoQqZhZQFa68bPqWUOuOactBxa1a/wWrHILqqb6Ouio5lLbzn1xEvlLDzGOQMlVbxlGqhVs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Wed, 9 Sep
 2020 19:00:05 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 19:00:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH 13/14] block/qcow2: qcow2_do_open: deal with errp
Date: Wed,  9 Sep 2020 21:59:29 +0300
Message-Id: <20200909185930.26524-14-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200909185930.26524-1-vsementsov@virtuozzo.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0054.eurprd07.prod.outlook.com
 (2603:10a6:207:4::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.136) by
 AM3PR07CA0054.eurprd07.prod.outlook.com (2603:10a6:207:4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.5 via Frontend Transport; Wed, 9 Sep 2020 19:00:03 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07d87ea7-54b7-4796-2e72-08d854f28ffd
X-MS-TrafficTypeDiagnostic: AM6PR08MB4070:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB407051FD8D3C4343A8BD2B4AC1260@AM6PR08MB4070.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:374;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bryxvBnMbjxJYGDfKRWyf1NRku3EErZSphUCm57qYorWyodz+wB7Vr0y26XK+iFjrvKQNXGRrbBgvppqigzoE2QRqzH2CJEbToo9zg6uTf6HVFrPmkwulSArue2PsUuPIgC+Ul8biTiKV0pTn044v601g9IXwmNtEOGy+E02ouxgc01MyHTt/oLe2BEZKy5eIMSQHwRjeSPlZ/p2+7OpWfTWYEA6T8le023HE7x7I5sh58vuSlvhAEtI2YleNjKc1FmrDRQT6Skt+pepU1QxR+F4kiQF4r9dybzxyKOW/9bpmbcNMXEUqdF9vS1aKV8t0fIgoft6LHHa4o2Wu5EuAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(396003)(136003)(376002)(346002)(26005)(316002)(8936002)(8676002)(16526019)(186003)(478600001)(5660300002)(6506007)(7416002)(6512007)(83380400001)(6666004)(4326008)(36756003)(52116002)(2906002)(6486002)(66556008)(66476007)(956004)(6916009)(2616005)(86362001)(1076003)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: YoRlTIkYFPIfQluh3uebE2mdIOrQuzau2vUmVhtggnCtFQX+gKAuQC+9Hk8xcF7qMNaxKSjnxa+gRHlzpe0TRc9m9X92oIXmln8fNpwhAj+L2Y2eTAvuDMtCbr9D7jXfMeR2E3dCtuENNMOGO90f4SmJhp+ZBjfKIyYB0UIgbzjeWwYmuogNlAtkQCXzxm2X508tXtDL2dAeYEeQn6RyxyXP3nRR7zb0BQcE+w08lCxcagFn60EwI51ay+Nbqlbq34OLWicGKW6XIOwCee4zyoZvLXrcXZeklN/FZxupTol4Sfhhayuk7bpuyJLHOpf9ZpUZkv4pAPTLPqSPXA4KjBN6QZGkX4X6algB949kFQn6UwqdE2ASmQorfD+aLPhfIBDV3R2ReM5Q1Vv8JvN06r+sdaT4y+U9EP6pcNl/f8CKcd9N8SmSv2I1NyDqLc/bdr5u+u5ih0fR04v96mlnDD4J0qfUe3wSaCqttoAFmhjDqGOG8WPvAs4h9ms//R7vSy6Bw4hgoYqrQw4htZ2zrUFO2XTCRwx1lbWZ028uZcHrsTGU663JxSXEso0h0tFrA1z85J/ywHyeJSxoitMc6rgRCjcTJYaB0GAd/X5c2G0fcDJHtxM5J3zY3iEQwz/pIo/sE5AKD8RjGPqPC5h9lw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d87ea7-54b7-4796-2e72-08d854f28ffd
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 19:00:04.9399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4mnyWLTcb5d63gmke505i9cBQ62ZhDqZO9DMMCXaBWVy0y/V3K3Vyr7VuAGHM7gp67azYPYYOl+cOdimsQrGaW/NPDjC7VuiyqMtN9QR/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4070
Received-SPF: pass client-ip=40.107.0.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 15:00:04
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

1. Drop extra error propagation

2. Set errp always on failure. Generic bdrv_open_driver supports driver
functions which can return negative value and forget to set errp.
That's a strange thing.. Let's improve qcow2_do_open to not behave this
way. This allows to simplify code in qcow2_co_invalidate_cache().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 31dd28d19e..cc4e7dd461 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1292,6 +1292,7 @@ static int validate_compression_type(BDRVQcow2State *s, Error **errp)
 static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
                                       int flags, Error **errp)
 {
+    ERRP_GUARD();
     BDRVQcow2State *s = bs->opaque;
     unsigned int len, i;
     int ret = 0;
@@ -1426,6 +1427,8 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
         report_unsupported_feature(errp, feature_table,
                                    s->incompatible_features &
                                    ~QCOW2_INCOMPAT_MASK);
+        error_setg(errp,
+                   "qcow2 header contains unknown incompatible_feature bits");
         ret = -ENOTSUP;
         g_free(feature_table);
         goto fail;
@@ -2709,11 +2712,11 @@ static void qcow2_close(BlockDriverState *bs)
 static void coroutine_fn qcow2_co_invalidate_cache(BlockDriverState *bs,
                                                    Error **errp)
 {
+    ERRP_GUARD();
     BDRVQcow2State *s = bs->opaque;
     int flags = s->flags;
     QCryptoBlock *crypto = NULL;
     QDict *options;
-    Error *local_err = NULL;
     int ret;
 
     /*
@@ -2731,16 +2734,11 @@ static void coroutine_fn qcow2_co_invalidate_cache(BlockDriverState *bs,
 
     flags &= ~BDRV_O_INACTIVE;
     qemu_co_mutex_lock(&s->lock);
-    ret = qcow2_do_open(bs, options, flags, &local_err);
+    ret = qcow2_do_open(bs, options, flags, errp);
     qemu_co_mutex_unlock(&s->lock);
     qobject_unref(options);
-    if (local_err) {
-        error_propagate_prepend(errp, local_err,
-                                "Could not reopen qcow2 layer: ");
-        bs->drv = NULL;
-        return;
-    } else if (ret < 0) {
-        error_setg_errno(errp, -ret, "Could not reopen qcow2 layer");
+    if (ret < 0) {
+        error_prepend(errp, "Could not reopen qcow2 layer: ");
         bs->drv = NULL;
         return;
     }
-- 
2.21.3



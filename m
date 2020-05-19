Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BF2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95CD02075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="G8IBHvAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CD02075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb8M8-0002HO-Me
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 15:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb8Kf-00008A-7A; Tue, 19 May 2020 15:55:21 -0400
Received: from mail-eopbgr70137.outbound.protection.outlook.com
 ([40.107.7.137]:40771 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb8Ke-0003bR-7c; Tue, 19 May 2020 15:55:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIISfnvRFG/v2x3EeVlkLh/JJNHG3sjvNswD4YzAEjcelkM9nTHcS/WF76fKDWtFOUzm955/I/yAnqlgyJhGoHWr1C5sGmi1/PMWWbQgWJkaAXpxPi2WFUnr1teNe8PE21ZCIIwVkgNYz1c4i0dI27PUWgBIX5Qxs2WwTi9lQ4/fmk4Y5C4/uUTzrONf05zAmlM0W7R7iu+uYkp7xJM6VbzMe+jLY12quHK7Fz5+ak5NVA3N2ygGo+JU0kut5uPcfEHj1g/DmssPWFycoTjTClvNHLSLXiB6SO8FuExps/ueZsFdVjcn15Y1SfmhgnQrIe1UCArP5LhCBfBalrmc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ru8QqTVjIKN27W13rHHkI9ABX8pm8TO2y07geVT//YI=;
 b=meAA7YyoJ1j95UuMWmsjPjZpeouP7sJSQI5iRC9yKwz/YxVgc5Ozq9ndXiwIs2ckWrDtrFgVFytyp+Z1a8rA4JG7tgXwhSXoOkITR7aDu0PSzPigom2QOEu4o6BRVWwEu3OlnKufNfy7whKn1sYo4H9rw9lBppVkxNnTCiobi7IUWfdakX3C5Q6jnYGcPnZ+9QZi8Tu3X6xTKr4nrL53MUZewLWaHaQJxxmWtXj3lSjYYjddQhsDuAiZ6bj2W0M3VEs2lH2x9uviEjMoK7cJg+NIQM8nrtlESZFD9G2FPWeI/Wv5PxAZZFSqklsExWktf7KabMVdeEVeWMx9srjmpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ru8QqTVjIKN27W13rHHkI9ABX8pm8TO2y07geVT//YI=;
 b=G8IBHvAnIOMYi9YEvxpQzgE+HKDKERLEv5VlC5Bg9XNqh62wEzjlZaAbA6iKIS3YI0KuiApseCSmQZoXEuV76oTfNDsGHxA4ItRSqvxet/gXnpElWAN0o+zXc5ZQ63+hnrCYAEpS7xbI7n9Z+FC9WqzZCgsNgxEE2AiBZAp61nk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB5342.eurprd08.prod.outlook.com (2603:10a6:803:132::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Tue, 19 May
 2020 19:55:15 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 19:55:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 1/5] block/io: fix bdrv_co_block_status_above
Date: Tue, 19 May 2020 22:54:57 +0300
Message-Id: <20200519195501.29071-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200519195501.29071-1-vsementsov@virtuozzo.com>
References: <20200519195501.29071-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0093.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::34) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.178) by
 AM0PR06CA0093.eurprd06.prod.outlook.com (2603:10a6:208:fa::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Tue, 19 May 2020 19:55:13 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c310a4d-e72a-4691-7c63-08d7fc2e8c08
X-MS-TrafficTypeDiagnostic: VI1PR08MB5342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB53426B94EBBE95CBFC0388A7C1B90@VI1PR08MB5342.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T18MCaFS+Aana9pteKoeaT9fprISh+ydrL1E5U/PsePRuad0eH+BLfmQXckcx5J0yY3H4u29MDAxVXB5JXPi0aCswlP5LPQxL8dJ99uDqen4Z9NJZ8NWleb0YRqRenO0aP5xlJuzcQ31DLe8oFyAugplYae0nri+oPYvwYCZBBdryQEWZoqP/gJ016tNq4A+3PlVtlPDF2SQnBpyEhAal6n/ffbPeWQjXyhzogV2IMYOU/j+YlrUBTnyJjBkuPJ4JLPPrcBhTakXi/MFYBK79R0Ly0xSxlpWH6aKIUgY9XE3mz/igEQDHDpum4tvyHTXIvodyg/VY6kidh7WXHenLQEu8yUchVvDoRdzyy+UQgaLFpzXOm15NcfzznVvcneETMyLhVRBEFVMQrlCQ/GVnTItuBvaX8aYYYRhG0mvJi961pUpJrtm1IXNk1dgGRdzOlaOjriaeb9Sh7PEv1G2Wr1wZs8jnRsdMiRWDpQd4DOpqcvTAAsjXLIuQnT6D/AlP2uo4/95HiqzNJFNTPwWIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(396003)(346002)(376002)(366004)(136003)(6506007)(107886003)(478600001)(66556008)(6916009)(36756003)(316002)(6666004)(6512007)(8936002)(956004)(4326008)(66946007)(66476007)(2616005)(69590400007)(2906002)(6486002)(16526019)(186003)(26005)(52116002)(86362001)(5660300002)(1076003)(8676002)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vNII6mkf5pBEC2/Y5ljto2r7IllJYfPtdgTlm+S1NXTht+ByZ+OkfHaOVp62LEPd7wUo+CeWWyvSC4yDL3j8cyevahOZ7L3wXhIybKqEpllIR+aENt6yg7ZAyz61qeIRQq4XCmvZvjM5XmkUNAYSESKKKOnAP5/RNnp5OukQRTC4qygQ8QwxySZlAVG7bQgJZo3LIcWSpMSpwSuOyNFIHf2MXoONT/VzjGzRR/Wyk0cMyt2ayaZCK1M1C84nOeQLdltDB1T57NCiMfdHE5mmkU7bpw07Lt+rmNqdSyOqA4CUXYnbo56tv2VPTBrS43LQVNbP7DEr2pumnrR0Y7ZW+f3j91mFesoqzGp1Cf1WW+QcDP7ODHL8wkwXyigySnohVBZVzLUUA3bPGlO1jN24e1Rir87uluqbBQfA4pgGTrrBCtHOEgCrV/uRNjIjjMMpbcO9rDGk03iXB0driMQyKngfE6bead7CDolacZK5sSVKmhBplquAulDLLgs+D6q5
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c310a4d-e72a-4691-7c63-08d7fc2e8c08
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 19:55:14.8661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+Nsnyzdajxt8muX0xfKqj8iVVAF8He2KOM8S3AGDG9aEwHGl2pPBqdFE85Xbm/zqpWcrCCgcVtujH7dwFukpTf/rNy0q9vJetsh9i05MN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5342
Received-SPF: pass client-ip=40.107.7.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 15:55:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_co_block_status_above has several problems with handling short
backing files:

1. With want_zeros=true, it may return ret with BDRV_BLOCK_ZERO but
without BDRV_BLOCK_ALLOCATED flag, when actually short backing file
which produces these after-EOF zeros is inside requested backing
sequence.

2. With want_zero=false, it may return pnum=0 prior to actual EOF,
because of EOF of short backing file.

Fix these things, making logic about short backing files clearer.

Note that 154 output changed, because now bdrv_block_status_above don't
merge unallocated zeros with zeros after EOF (which are actually
"allocated" in POV of read from backing-chain top) and is_zero() just
don't understand that the whole head or tail is zero. We may update
is_zero to call bdrv_block_status_above several times, or add flag to
bdrv_block_status_above that we are not interested in ALLOCATED flag,
so ranges with different ALLOCATED status may be merged, but actually,
it seems that we'd better don't care about this corner case.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c                 | 38 +++++++++++++++++++++++++++++---------
 tests/qemu-iotests/154.out |  4 ++--
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/block/io.c b/block/io.c
index 121ce17a49..db990e812b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2461,25 +2461,45 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
         ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
                                    file);
         if (ret < 0) {
-            break;
+            return ret;
         }
-        if (ret & BDRV_BLOCK_ZERO && ret & BDRV_BLOCK_EOF && !first) {
+        if (*pnum == 0) {
+            if (first) {
+                return ret;
+            }
+
             /*
-             * Reading beyond the end of the file continues to read
-             * zeroes, but we can only widen the result to the
-             * unallocated length we learned from an earlier
-             * iteration.
+             * Reads from bs for the selected region will return zeroes,
+             * produced because the current level is short. We should consider
+             * it as allocated.
+             *
+             * TODO: Should we report p as file here?
              */
+            assert(ret & BDRV_BLOCK_EOF);
             *pnum = bytes;
+            return BDRV_BLOCK_ZERO | BDRV_BLOCK_ALLOCATED;
         }
-        if (ret & (BDRV_BLOCK_ZERO | BDRV_BLOCK_DATA)) {
-            break;
+        if (ret & BDRV_BLOCK_ALLOCATED) {
+            /* We've found the node and the status, we must return. */
+
+            if (ret & BDRV_BLOCK_ZERO && ret & BDRV_BLOCK_EOF && !first) {
+                /*
+                 * This level is also responsible for reads after EOF inside
+                 * the unallocated region in the previous level.
+                 */
+                *pnum = bytes;
+            }
+
+            return ret;
         }
+
         /* [offset, pnum] unallocated on this layer, which could be only
          * the first part of [offset, bytes].  */
-        bytes = MIN(bytes, *pnum);
+        assert(*pnum <= bytes);
+        bytes = *pnum;
         first = false;
     }
+
     return ret;
 }
 
diff --git a/tests/qemu-iotests/154.out b/tests/qemu-iotests/154.out
index fa3673317f..a203dfcadd 100644
--- a/tests/qemu-iotests/154.out
+++ b/tests/qemu-iotests/154.out
@@ -310,13 +310,13 @@ wrote 512/512 bytes at offset 134217728
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
 wrote 512/512 bytes at offset 134219264
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
 wrote 1024/1024 bytes at offset 134218240
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.21.0



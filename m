Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1587BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:47:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5FBA2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nkpEvC+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FBA2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlwku-0003w4-2K
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 11:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jlwfB-00043I-HY; Thu, 18 Jun 2020 11:41:13 -0400
Received: from mail-eopbgr30122.outbound.protection.outlook.com
 ([40.107.3.122]:62770 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jlwf7-0000ez-Mv; Thu, 18 Jun 2020 11:41:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sx607fInYpJpGVPmLytarqRgp2AoisQ6LG2XVmeoBhEu2sw6y80V1aqwJLUAFcXB7nYTuRQ0lMhD6h947VuFcT21yJKSmagYRmnuZWkV9LcRxAd8jR0oDF4HthC29se6gdYi/6wz1vTBwzZwK1FdKx60uw5q38ODvC87HFNXYZRCjwq9OIQKrJd+V2QalyI8BNLUKk3xrCY4NhWy4l4Caa9OEMzeTiOHXt5EWXABPW7Ytz/9kYNjzP/HyYFStFmZvqSwZpU9xFINpLxQV/aoh6v37/PovS3kInT9V6NAR9p3ulsGhtaKsZamKptSwZqR1rVZc5hIh0Xe4IUrLGkrIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPZ4HCeoxKznrmAiScktNsc4UwCStdgWxATb8Qobg6I=;
 b=Zrm45UvuevCLJKGkv9eerUpCHLZKjcQ9rpvPFn3P/BCljMZQX/lgTzOHKf0a1fj7hNmfDDdYhTmgBb/hOQqF5Lvpc9Ht9bXhlKFOO2cZJKQXWZTm20yLnYuvRAAgPO2UKAM1kaVanxq/ctlaaAxWWKZNBj227mubbhygOK/n1oGSLRRT1HBcfa7sdj+dSqMOWJ2N02FmGu6HHizKtyYFE5jTt0KjYBZN4SkAqocUx/NF3PEc2+xT5j47+1QlCtMFinrW3TvhK0m+Q3eXvMPp0uSfB4a7wgpYUWOf2tUYftoN3rku091YRWdv/eOKvQwHvSuxa+uK6s+PDil4MlAqrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPZ4HCeoxKznrmAiScktNsc4UwCStdgWxATb8Qobg6I=;
 b=nkpEvC+xcTzv66MwVZGs9hU0ioAuOtb/s7lJ+ZwNt0WXv2A7IjNj1wqa06z6vx1HQMabR8FkwEL731V9zjRv+Oy8s1XppbdwnH5tlUfwhR32tGXTvKgbok3whT0nC5ItuhZWWdx1Y4fuuZgO9zgCNBwONF1OUOGK3ov4l4EoZxw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5334.eurprd08.prod.outlook.com (2603:10a6:20b:10b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Thu, 18 Jun
 2020 15:41:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 15:41:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH] iotests: don't test qcow2.py inside 291
Date: Thu, 18 Jun 2020 18:40:52 +0300
Message-Id: <20200618154052.8629-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0076.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.236) by
 AM0PR06CA0076.eurprd06.prod.outlook.com (2603:10a6:208:fa::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 15:41:05 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.236]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b359ab11-661b-4505-127b-08d8139e036f
X-MS-TrafficTypeDiagnostic: AM7PR08MB5334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5334DA8409FD2728462DD698C19B0@AM7PR08MB5334.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGO8jelrlY7dKat7h+Eq0mOJd5H6VzcVHwVItBdhbQOQO0WflMDvgqcy6cHA3ISekH5cDMikFuWvq9AL/J+XkIwrkfVUkH2UHIlYikUskr9NCFoh5+lUE6ZeEJTiaHY8m9PihUpjTIZAkWGk3hNbPvhHckGMXbMIq0OpDpvjMR8NHjhxANKHAdxQcMHHMXk9nwgcux1M7aawdVAjUmk4BwdDD9c08EOrB/tXvjKxTq+ux2IjiCwHFsxJ4TkWo8mCyrNJMZqZ25LGjhBPw6NoSU5wHl5/yMrjBi9jUcJ1ziX13+lI1vjK2wSvU7cs+GpkpRlyQbMClz0z2qKD0aQC+KHHbQfyxkR93nV1SQ56QRP+2slqxrM7BWHFAViEOLpZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(366004)(346002)(39840400004)(136003)(66946007)(6666004)(66476007)(66556008)(86362001)(5660300002)(2616005)(956004)(4326008)(6916009)(36756003)(83380400001)(478600001)(52116002)(6512007)(2906002)(186003)(26005)(316002)(8936002)(16526019)(8676002)(6506007)(6486002)(1076003)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: M/uGNfXhP9pdcBzKmW3bhb6mfKYQFMkiSiLBr1H/zyNXUW2eN7kaYwm6vsXc2umaxWEHqkUkMtIQ/wL4xwidUh5VBFWIW6qNwZRSPuqHjGRwQ5DsNm5NaIRBnXda9v+ioHDmA9tavxtPtykXs2DlAusNttQs5XJL367Ez337vs7M9iVRLeR4F/HVvh/RVTYggwzVQNkwu1FkCotOlz5gY/DJtI2qTmtgGj2J2rrUMUeEoCcPU1Lpa3jwSnhh8QCC0q+I8sf//V8M34evJ5jq6/d4UbeCQ/MkDHqswIrO0hB9PpUkhkvctAKR5x7gnnQF9JOANIvJxTwYZDOoxJYg7YKEJEKu0MJmFM2ZYBaHt+iFMlxBK5PtlLWWvS5TU2GzzeFs4h7KAIu01NUrx2taoPmOhaBpFK4T1Kvobc4iC6ci2Oba/kpycB/DUihdvN9Gtgj4rIGNrQiksGKy3bTYTS843COWycEn1ZBRbLNqzaxHl7iN+ywRd9ahJEIwaWJV
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b359ab11-661b-4505-127b-08d8139e036f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 15:41:05.7909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yiVHgw1g9i+J3w5ZimgwHXVp+5sYzWGCAVmhVGyLIeanICu6dyVCxghMZo3FN7YX1wfPIRNUH0qbK7XNI846GkAGSkFrjd7Cti66Bks592g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5334
Received-SPF: pass client-ip=40.107.3.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 11:41:07
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, andrey.shinkevich@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

820c6bee534ec3b added testing of qcow2.;y into 291, and it breaks 291
with external data file. Actually, 291 is bad place for qcow2.py
testing, better add a separate test.

Now, drop qcow2.py testing from 291 to fix regression.

Fixes: 820c6bee534ec3b
Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/291     |  4 ----
 tests/qemu-iotests/291.out | 33 ---------------------------------
 2 files changed, 37 deletions(-)

diff --git a/tests/qemu-iotests/291 b/tests/qemu-iotests/291
index 28e4fb9b4d..1e0bb76959 100755
--- a/tests/qemu-iotests/291
+++ b/tests/qemu-iotests/291
@@ -64,8 +64,6 @@ $QEMU_IO -c 'w 1M 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG bitmap --disable -f $IMGFMT "$TEST_IMG" b1
 $QEMU_IMG bitmap --enable -f $IMGFMT "$TEST_IMG" b2
 $QEMU_IO -c 'w 2M 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
-echo "Check resulting qcow2 header extensions:"
-$PYTHON qcow2.py "$TEST_IMG" dump-header-exts
 
 echo
 echo "=== Bitmap preservation not possible to non-qcow2 ==="
@@ -92,8 +90,6 @@ $QEMU_IMG bitmap --merge tmp -f $IMGFMT "$TEST_IMG" b0
 $QEMU_IMG bitmap --remove --image-opts \
     driver=$IMGFMT,file.driver=file,file.filename="$TEST_IMG" tmp
 _img_info --format-specific
-echo "Check resulting qcow2 header extensions:"
-$PYTHON qcow2.py "$TEST_IMG" dump-header-exts
 
 echo
 echo "=== Check bitmap contents ==="
diff --git a/tests/qemu-iotests/291.out b/tests/qemu-iotests/291.out
index 08bfaaaa6b..9f661515b4 100644
--- a/tests/qemu-iotests/291.out
+++ b/tests/qemu-iotests/291.out
@@ -14,25 +14,6 @@ wrote 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 1048576/1048576 bytes at offset 2097152
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Check resulting qcow2 header extensions:
-Header extension:
-magic                     0xe2792aca (Backing format)
-length                    5
-data                      'qcow2'
-
-Header extension:
-magic                     0x6803f857 (Feature table)
-length                    336
-data                      <binary>
-
-Header extension:
-magic                     0x23852875 (Bitmaps)
-length                    24
-nb_bitmaps                2
-reserved32                0
-bitmap_directory_size     0x40
-bitmap_directory_offset   0x510000
-
 
 === Bitmap preservation not possible to non-qcow2 ===
 
@@ -84,20 +65,6 @@ Format specific information:
             granularity: 65536
     refcount bits: 16
     corrupt: false
-Check resulting qcow2 header extensions:
-Header extension:
-magic                     0x6803f857 (Feature table)
-length                    336
-data                      <binary>
-
-Header extension:
-magic                     0x23852875 (Bitmaps)
-length                    24
-nb_bitmaps                3
-reserved32                0
-bitmap_directory_size     0x60
-bitmap_directory_offset   0x520000
-
 
 === Check bitmap contents ===
 
-- 
2.21.0



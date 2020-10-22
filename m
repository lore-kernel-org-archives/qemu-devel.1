Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D390C388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7ECB24656
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CWTXf9P/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7ECB24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVfwh-0001aC-FK
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 15:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVfld-0000hL-JD; Thu, 22 Oct 2020 14:56:53 -0400
Received: from mail-am6eur05on2090.outbound.protection.outlook.com
 ([40.107.22.90]:46561 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVfla-0007YP-9h; Thu, 22 Oct 2020 14:56:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVHEReBco48VokcxOqryzsOYGjlbTNhXYAz57WxNCWgOlyYS6fSASP5FkNI4xZ2c4TzbkdZNQyka3ZSkZVRjyVa3wFCLM7djL/mG0K7TZr1Pz/7hUKo2ZIbJE/ENx3xRIVDyFi7/FeKKRBtv9scYWrKRCOfXK1uU1PekXa3xxv6doKLU4GL3I1YPHIyml0PeK3+J5vpFGKJI0FJQlUjhMhc/9/+OsQNY27cvbrvdtJwPyiuYzw/TuIxLMAmI+oJJyqp5P3nGuVwndyNFphd75uE0lvd+sk1FxM4bN34xPSGyODvUmLRiChu4nAHImwRTrjjZxz7s6zaSkv/UQDnbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+Q7SzxNQAQoCeala+KQEfdcumXt8+et+48kD+h0cuk=;
 b=XV4KdUPpPSDW3eOYDRfDp1LUs+uX56kNtKZ8OTRDm3chTsE6UH0nA1IsD0vhp6H+DxM4Lu7/DaBa8OE9dgIGbi8+34Mw+PF44Mo3IuQvYKZcVYd7WBb5AaSsTObSV+KL4PSEPk6eFCPJ1S9j0RaFWrKW08YcyvfMChjCaJuY1NiRzUTDCKlWZ974bw4jTVcBxvfDqUZWCauRnaUetdPzNcar70sg2porGs2YT2MRM6BP+ymJMFRdSJwDdo6mZtaa9xcNitU0KwtuwY8VIRw4eY2err0uU3E7Jt68eqPc7XLdPa5QqlJds9IFZ2RJHTrK8MNtyo4kp8BYGsgrcIu+Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+Q7SzxNQAQoCeala+KQEfdcumXt8+et+48kD+h0cuk=;
 b=CWTXf9P/i/YG1/xytXn5QEb+Iv6yP03YyngmBnRf3wblNSfki26VBg1fJzYBB41jN85wSPyFKds8UXNK/jzZFkwOjBRoeB0x6WNQtQfqH2RdrjLcLkDcQQFVYuIyj+VfTnA/OrXDS/wjW5ZqLvtHbVFqmCS2mCQVBHO5oMpXFa0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6309.eurprd08.prod.outlook.com (2603:10a6:20b:29f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Thu, 22 Oct
 2020 18:56:42 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 18:56:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com,
 jsnow@redhat.com
Subject: [PATCH v5 03/12] iotests: fix some whitespaces in test output files
Date: Thu, 22 Oct 2020 21:56:18 +0300
Message-Id: <20201022185627.16987-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201022185627.16987-1-vsementsov@virtuozzo.com>
References: <20201022185627.16987-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR01CA0089.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend
 Transport; Thu, 22 Oct 2020 18:56:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15d1ae0c-9395-4151-3f38-08d876bc3727
X-MS-TrafficTypeDiagnostic: AS8PR08MB6309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB630976C4DBBCA02C2294CDEBC11D0@AS8PR08MB6309.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0CNp7AMG1nIKFFgqonDNddP4AiiWTPktX92ZGw8weyz+QVss4HiLDYspwuh56rwiDAyhjHHH9w6qGX2qQJ+9S52zkpwrtbcSLfm8FsHfTXtqObZUI7Js6K4OpwlEC0KD/oDQB2rl5fQAyJQZMqFlkmgpLghAavpMoe4HSz8FjGqb60BuycqnG+QSU/V9hDjS8cnLdyUAf8wbBjTHNmQbDDtbs7tbPCxDM2h7XYrArClBW/liHA09gb/MgtLkieuapX7kUpqEROa70RvD0+TSXX9u5arcF2mR7m7jvt1vkVDWWZ8DgCN9LWc8G/0NF8TjZaPRNzrBQHEkTekr1mF0WDBNFZ1B7n+yAjivm1MH9TWWsriKCWDU9ZXcGOH+uOpx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(346002)(396003)(136003)(376002)(478600001)(6512007)(36756003)(2906002)(52116002)(4326008)(5660300002)(26005)(16526019)(2616005)(956004)(186003)(6916009)(6666004)(8936002)(66476007)(83380400001)(316002)(66946007)(1076003)(6506007)(8676002)(86362001)(66556008)(6486002)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: z6ID6H/7fPMV7JP2+xpjbW5GdH1cu2lBz4vsc/HPc7QIq3eGka1xh+Uy6ZMt2dmo35BsVbNgaSZPlmwmgRaBNdI0+CkxJC2Ufaeh4YwmVSvcRaMpWuNE57oJICwoRiFJG596GXT0XNW+GWB1BTIg97UchlNzBPl93i7F9zzrV0N/XG/76ZuvE86wcH9s/hXZXfjnow+oMWxlxAQV/3EHzBgW31S1ejbJ2nooppBwxIkdFuWIisU0AdIQKiA5BEWrltYcRpwZQQqd0G9j2GEuuhZxMVcQA3m3UQcJwZk5UyM9N49UbiHW0QfQNTbZQt3SkT7SpTuhDt4MkVWadE4Yjl0A18KHYUPLZIrRx/8rz3I/iQHtPbkmaRLE18wDiLcr3NntErMTvwqmPAtX0M1EHHEoSJPQkD7YHn95pVqsR3laDsdSFbCfpVX4MFw2E7/AUuwPPftERBZ3oxJf9CI7Gywgi+NZJhTTyXh2kAY9KNSmA506KSsk+Y+Ejvme8e9j35dbQYI5A8DHCj+Bn1d1KxU0KnrScftVL3DkClz3C3VVnc/ATGEEdwVAklNO8zjjVJBF/U4mz+8RTk8ujIcHkkDevA0Jz8OmJWEHmlRIl+0ybLsm8+D0ZgCOpeFq+Rcj384MbbKx6f4LWqS9aPqPsw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d1ae0c-9395-4151-3f38-08d876bc3727
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 18:56:42.6055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XE++vG5W+3RNimC6T58bGnN+2ZQS4yxNgDMtcm7ni7n9jmgHB8mSGpQCTPLZIh/PjwVtvcL+b8IQ7+aW2EZSiZkdaRb0d5YDiH+a4X+JeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6309
Received-SPF: pass client-ip=40.107.22.90;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 14:56:45
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We are going to be stricter about comparing test result with .out
files. So, fix some whitespaces now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/175.out |  2 +-
 tests/qemu-iotests/271.out | 12 ++++++------
 tests/qemu-iotests/287.out | 10 +++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/qemu-iotests/175.out b/tests/qemu-iotests/175.out
index 39c2ee0f62..40a5bd1ce6 100644
--- a/tests/qemu-iotests/175.out
+++ b/tests/qemu-iotests/175.out
@@ -23,4 +23,4 @@ size=4096, min allocation
 == resize empty image with block_resize ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=0
 size=1048576, min allocation
- *** done
+*** done
diff --git a/tests/qemu-iotests/271.out b/tests/qemu-iotests/271.out
index 92deb7ebb0..81043ba4d7 100644
--- a/tests/qemu-iotests/271.out
+++ b/tests/qemu-iotests/271.out
@@ -500,7 +500,7 @@ L2 entry #0: 0x8000000000050001 0000000000000001
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
 L2 entry #1: 0x8000000000060000 00000001ffffffff
-qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0x1); further corruption events will be suppressed
+qcow2: Marking image as corrupt: Invalid cluster entry found (L2 offset: 0x40000, L2 index: 0x1); further corruption events will be suppressed
 write failed: Input/output error
 
 ### Corrupted L2 entries - write test (unallocated) ###
@@ -515,14 +515,14 @@ L2 entry #0: 0x8000000000060000 0000000000000001
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
 L2 entry #0: 0x0000000000000000 0000000000000001
-qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+qcow2: Marking image as corrupt: Invalid cluster entry found (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
 write failed: Input/output error
 
 # Both 'subcluster is zero' and 'subcluster is allocated' bits set
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
 L2 entry #1: 0x0000000000000000 0000000100000001
-qcow2: Marking image as corrupt: Invalid cluster entry found  (L2 offset: 0x40000, L2 index: 0x1); further corruption events will be suppressed
+qcow2: Marking image as corrupt: Invalid cluster entry found (L2 offset: 0x40000, L2 index: 0x1); further corruption events will be suppressed
 write failed: Input/output error
 
 ### Compressed cluster with subcluster bitmap != 0 - write test ###
@@ -583,7 +583,7 @@ read 524288/524288 bytes at offset 0
 read 524288/524288 bytes at offset 524288
 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Offset          Length          Mapped to       File
-0               0x80000        0               TEST_DIR/t.qcow2.base
+0               0x80000         0               TEST_DIR/t.qcow2.base
 # backing file and preallocation=falloc
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=524288 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw preallocation=falloc
 Image resized.
@@ -592,7 +592,7 @@ read 524288/524288 bytes at offset 0
 read 524288/524288 bytes at offset 524288
 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Offset          Length          Mapped to       File
-0               0x80000        0               TEST_DIR/t.qcow2.base
+0               0x80000         0               TEST_DIR/t.qcow2.base
 # backing file and preallocation=full
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=524288 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw preallocation=full
 Image resized.
@@ -601,7 +601,7 @@ read 524288/524288 bytes at offset 0
 read 524288/524288 bytes at offset 524288
 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Offset          Length          Mapped to       File
-0               0x80000        0               TEST_DIR/t.qcow2.base
+0               0x80000         0               TEST_DIR/t.qcow2.base
 
 ### Image resizing with preallocation and backing files ###
 
diff --git a/tests/qemu-iotests/287.out b/tests/qemu-iotests/287.out
index 6b9dfb4af0..49ab6a27d5 100644
--- a/tests/qemu-iotests/287.out
+++ b/tests/qemu-iotests/287.out
@@ -10,22 +10,22 @@ incompatible_features     []
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 incompatible_features     [3]
 
-=== Testing zlib with incompatible bit set  ===
+=== Testing zlib with incompatible bit set ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 incompatible_features     [3]
 
-=== Testing zstd with incompatible bit unset  ===
+=== Testing zstd with incompatible bit unset ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 incompatible_features     []
 
-=== Testing compression type values  ===
+=== Testing compression type values ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-   0
+0
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-   1
+1
 
 === Testing simple reading and writing with zstd ===
 
-- 
2.21.3



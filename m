Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B76C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A00207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="I73MLOJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A00207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKGK-0007q6-V9
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbKCi-0000xn-Ma; Wed, 20 May 2020 04:35:56 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com
 ([40.107.8.90]:21573 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbKCh-0005RQ-JL; Wed, 20 May 2020 04:35:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKLwES4eVID+nrV1h5YaNVLORzVvnkWi6lEV07y15CIzgWnfYdocaagidB90j9Yab0DP1RoJkqEqJnFaEqNZwN2CmhBt6QxrgA75oJq+P9vmahi8f8JNdNojVXVuL/B6gdeVFfpT8qMAe7GqRsySZz9Nj7nLOAEtMvlNTjkBNqu3tkIN0eqNZI0J92PGYX2adzg1o+TutmzVghciLDnI1xpZVsP9zN9qUnDwZz86DR1UWmjveP8sZ8Q+sD1mYOSXXVaVJUwFRcc3YAId6hksp5aX+0RAgY5Mi3n5XOpsYXxOwmVcZSJ+1ZgdzBn1igLf/HJQJhOlqSdgRgwAubcm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQym2BNoGvV2r5jCdfntouMCdRWQKde3tw3sbB+xzkg=;
 b=ewOl6ls+/8olG4ywnUBC5CX+w6ia8kIKHs4704VnEHyyXa58Mgn2WCLiLNNAKMUVhl1oeXYyDK+d5iHJgS9O76btlzGu/Mqi/xF59dT3oEesDaRvob4nnGWkPRnXv1KxUHhPu3FvvUo4U410VJJ6DQrhvAbF/ONib/AHpb4JgGFX9u2bxiPjf0W2dnozWZls+ilmZ+7Ik6ALpkgLjKEGX4C6/Es2xTFODRjUgl3+HfzjgFiq+V4nVZmNZl1C7D2xK/W3hXTR7OKYyrWB0YFiCWligxYnbGHFHe9IG0/dgFh1IdPumtzFF53nRqpMmDbkoBmdKO6Tt/HWVUUHDvCwZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQym2BNoGvV2r5jCdfntouMCdRWQKde3tw3sbB+xzkg=;
 b=I73MLOJRyDlT5A09mRxnzxvZt9Pp+cNGXKGYM6S/XrEscfAsQI3i42XynVh5b+mNXFUPfwJP1EG2yQ74HVoTCdy4Qm1BHkVr1zCZofaFc2VT+hYlSCBmNGsse5okM6BI1kvYzSMeVcvk8fIjf/Pr4EsChxVVzEiAEXPYWgmZE2c=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 08:35:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 08:35:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 5/5] iotests: add commit top->base cases to 274
Date: Wed, 20 May 2020 11:35:20 +0300
Message-Id: <20200520083520.25793-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200520083520.25793-1-vsementsov@virtuozzo.com>
References: <20200520083520.25793-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0092.eurprd02.prod.outlook.com
 (2603:10a6:208:154::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.147) by
 AM0PR02CA0092.eurprd02.prod.outlook.com (2603:10a6:208:154::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Wed, 20 May 2020 08:35:45 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.147]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 280a214b-13fa-46ee-3f21-08d7fc98cad9
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54487A613584E0F4A303043BC1B60@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:61;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3BZtHNOBIlmmoMwUOHU0rRRNW0lYN1ZLrzpofb0JeSzR3M5BAIwI7W8tSmrVwrokqG8eD/HCejoKXVsqs+XyiA+VwuTg/rSGUr+PupQCO0FI78rBPKAthNbLiMQgcAxEAY9t5oKNtIxLhAdvat7UoUHSXF++tKIsXIXfig0/k9Trzwh54wdLiKhP3QIjz0//xn0gRv2tlzoAkI41XUqYkiqYC6nhw5rXSRaTvrXGJCTiYCyOkNoiYd1XH9jWWjNlvl5pFDwxgjLsqcgnlXej1TyHEHeC1TmRT4WOPF9V3kFKxFuRm+cSludN/lfbsDD6qH4OU4bo4WLHF2++W4+QYBxlYBxzwQxJw6vgmqV2XPkHowjv8DcVyfwICp/35adFf+UTauhvwxrr5T7HFmrlI3qXT8B9ifeCkQpteUxDT6F3ZN/Lob4f/H32bvupQ5tg95l48GpqRlbDCvrGNEhcYHCqBcAo9iPvNF5uzRtAkMgL26O6BFZ9RB7REm50kN27c+YnmzaoufqzS4lerYRGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39840400004)(6506007)(26005)(8676002)(6486002)(52116002)(186003)(16526019)(1076003)(2906002)(86362001)(5660300002)(8936002)(36756003)(66556008)(4326008)(316002)(107886003)(478600001)(2616005)(69590400007)(956004)(6666004)(6512007)(66476007)(6916009)(66946007)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qvEUpNYjmK+louL4PXFfBbITK720XZGTmAVnrh1QOwpf3VlBu2sPk20ykDqx0Nv6EUBRNNx0orNval83ZO/NUZH7V7SjsX18sornCyMkl0/5Kgbh6nLYkSF4JB4/gUzp1ejjS/YpDg/92u6oXS7eBSbl8ClyLGuh47pgu5BG8uClIoEM2YbqAULr2JEfJ8/HCbGqEEUSdOenE+JbiK2pJlSl8IeFAGXvrImv0Oq99WWJyetLWYfEurZv+zTilZCKdPZYsGPmiHg3QGhk5aupNrsKPo3W4mpW+T8ANY8iGSfFeHqoXANh/ksH4d80MS2BgMW7Vb09zNYJQPvgVC+OqliOTpos1lqOJJJIaxsroKC/usA3OevPZKouNLMO3gt70Y+IcBpCMUSKDJPIc83Lyjob9idJ89FjEMQz/FHNIVSuzUprEiIYIo3CrHBReYm8RbSKHG0qauaiq9w/Qy3WvF2H6eeiG3tgiBEOFXWccms=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280a214b-13fa-46ee-3f21-08d7fc98cad9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 08:35:46.6201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IND4/GVHNd/KjWL89Tpk/criDDnmugUWlDeS7su0NrHoAFEzr5vN7rm5gvUNnfbUOJiFiqKWjpehfOwdJwooJUQWekVa/Rj3s8n0vtVpn1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.8.90;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:35:42
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

These cases are fixed by previous patches around block_status and
is_allocated.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/274     | 20 ++++++++++++
 tests/qemu-iotests/274.out | 65 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/tests/qemu-iotests/274 b/tests/qemu-iotests/274
index 5d1bf34dff..e910455f13 100755
--- a/tests/qemu-iotests/274
+++ b/tests/qemu-iotests/274
@@ -115,6 +115,26 @@ with iotests.FilePath('base') as base, \
     iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, mid)
     iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_diff), mid)
 
+    iotests.log('=== Testing qemu-img commit (top -> base) ===')
+
+    create_chain()
+    iotests.qemu_img_log('commit', '-b', base, top)
+    iotests.img_info_log(base)
+    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, base)
+    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_diff), base)
+
+    iotests.log('=== Testing QMP active commit (top -> base) ===')
+
+    create_chain()
+    with create_vm() as vm:
+        vm.launch()
+        vm.qmp_log('block-commit', device='top', base_node='base',
+                   job_id='job0', auto_dismiss=False)
+        vm.run_job('job0', wait=5)
+
+    iotests.img_info_log(mid)
+    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, base)
+    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_diff), base)
 
     iotests.log('== Resize tests ==')
 
diff --git a/tests/qemu-iotests/274.out b/tests/qemu-iotests/274.out
index d24ff681af..9806dea8b6 100644
--- a/tests/qemu-iotests/274.out
+++ b/tests/qemu-iotests/274.out
@@ -129,6 +129,71 @@ read 1048576/1048576 bytes at offset 0
 read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
+=== Testing qemu-img commit (top -> base) ===
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=2097152 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+
+Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+
+wrote 2097152/2097152 bytes at offset 0
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Image committed.
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 2 MiB (2097152 bytes)
+cluster_size: 65536
+Format specific information:
+    compat: 1.1
+    compression type: zlib
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Testing QMP active commit (top -> base) ===
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=2097152 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+
+Formatting 'TEST_DIR/PID-mid', fmt=qcow2 size=1048576 backing_file=TEST_DIR/PID-base cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 size=2097152 backing_file=TEST_DIR/PID-mid cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
+
+wrote 2097152/2097152 bytes at offset 0
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+{"execute": "block-commit", "arguments": {"auto-dismiss": false, "base-node": "base", "device": "top", "job-id": "job0"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "job0"}}
+{"return": {}}
+{"data": {"device": "job0", "len": 1048576, "offset": 1048576, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "job0", "len": 1048576, "offset": 1048576, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 1 MiB (1048576 bytes)
+cluster_size: 65536
+backing file: TEST_DIR/PID-base
+Format specific information:
+    compat: 1.1
+    compression type: zlib
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
 == Resize tests ==
 === preallocation=off ===
 Formatting 'TEST_DIR/PID-base', fmt=qcow2 size=6442450944 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
-- 
2.21.0



Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DC2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9419F2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ACmacapM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9419F2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb8NW-0005SR-PN
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 15:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb8Kl-0000Nj-NK; Tue, 19 May 2020 15:55:27 -0400
Received: from mail-eopbgr60098.outbound.protection.outlook.com
 ([40.107.6.98]:52740 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb8Kk-0003c9-IJ; Tue, 19 May 2020 15:55:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiO0lPk8JG+MntRasKq0EthxU7oq1e01mQMjnYDcs+hezeQ5VTXbNu5arLBoRJ2UqrewfJXNh41v9DwLPxh88jjpaowZ48Fr8YJUUR6Vckn3iNElm8q7+asHmydgqIvwIHOPVM/2kugCeHOPWBCFSknLr/FUq8nM39JVxe8z/030jRViT3z8j8F1KkqpzZmz7m0M7NHm6rywwJ89uIWSxcIwN8biZI3VN34v+wOK43/J1/FLYNd1LCIf+6BYCIErJQJW7k/PWhwar7lIr5T1vC5Zi8abI62Eir44ImBdbwCklsy8nLHLnLVf2Oq5dgUdJQ0n7TPLQOu3C8SvVUwx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQym2BNoGvV2r5jCdfntouMCdRWQKde3tw3sbB+xzkg=;
 b=UtjKfFhEf2cClsfuZgxHPXd4+X4yoLSv2rcn188OnBanNdoHmijanUw/ZtqzfliWDzndQ1hcaaBeokttBi00/+8ArnJ4SNv8kAN0Pd8HsZWqkFk+RUtAxmypBhRpde2dZFrsEEKynCLsmeTA4sKIc8M0V40APmlRYd2FXlSP9/VdCF7Of/qXRdn7nOvIapUPAa0KW+JufOtZ83iLt6TwNzrhreLg7ginht0F9TPQCPUK7xgRWhwA5M583CEDxJqiCjIR5OSKgEwwx5P7vqzuhKQ5cKPzqEaBwvgWlFwwt4UCZZDbG3lSBwTTno1AH/zk7IAYgkIh6YYNXAVDnMvdhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQym2BNoGvV2r5jCdfntouMCdRWQKde3tw3sbB+xzkg=;
 b=ACmacapMT1k8QhDGnm/vvxpal4W1Nd+HXw+eGTt4NjYIkFID3PDPDaAUtqmYpoAI1IFGqgGhCXTlxR+Ba0OnlzD0xtepBfZ33AaYra2k9UPq/2wLaHYwXmWlh3WKIxYsAU8N5zP33nayeyTMpfS2fyEFjshH9+DSNILGzjTNnkM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB4542.eurprd08.prod.outlook.com (2603:10a6:803:fa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Tue, 19 May
 2020 19:55:19 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 19:55:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 5/5] iotests: add commit top->base cases to 274
Date: Tue, 19 May 2020 22:55:01 +0300
Message-Id: <20200519195501.29071-6-vsementsov@virtuozzo.com>
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
 15.20.3000.20 via Frontend Transport; Tue, 19 May 2020 19:55:18 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c270ad0-6bfe-4afe-90fc-08d7fc2e8eaf
X-MS-TrafficTypeDiagnostic: VI1PR08MB4542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB4542F4EF56E2CB980DDE493EC1B90@VI1PR08MB4542.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:61;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpfGOfMxx9KauBD8hHr0dSzcfNTIJ2E8ILfRIvYSXBZiW2iotZy2wYcL4FHH746dzwWJ39Buk7eWYPN4Xgy0xO0lCAuOz5hIXF5hNR4Y+HwMlhY+dnxeCIfs78liZBoN2Yz/6B9OxBxLKVweqWY/019sTOvar9J0TwqJ8mfzmS6Ud+tCqJMA8i2X4P4JbpyGl3JXu3R8JORTCjp/H+yPhXRpi3oCbXZ+wzekTbsoWnvWv58u76X3W2L+ba8U7UgiU/NFOC7+Q6q+NYIhk/Wre4YUDo/WeRsxySaOPtidGuIOyvUTybLy+0PhV2RcWWAmGyRo4ny/RYAIx3DKYs7PGYGZ/aLP2A93rbi4z/xu/FrETzfnZXSYZU5oNv54xZ3lAPm+s4Zorg5gswudQJ+U5Mq5GAOwKjzC1UQPpEm28HHs/Rt8lYZNvxU1h0Pjw0/1jb5bQQslOOfpgf2Q3LSFO6qyNXO/QWXcASgFTwh3usvTXUjAakfma0j0xIjVveK0+tzBSOGO5LnDQYEfxC5VxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39840400004)(346002)(366004)(376002)(6512007)(2906002)(69590400007)(5660300002)(52116002)(66946007)(36756003)(6666004)(107886003)(316002)(8676002)(16526019)(956004)(6916009)(186003)(8936002)(26005)(6486002)(86362001)(66556008)(66476007)(6506007)(2616005)(478600001)(4326008)(1076003)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: di2zKCVp2dWCUi26JcELq9hF6y9Dk2VgirT+Sx0W3eZMQhlKHT5aDK5MYpLuRQlwrhzhBUYw0PRsN55/w7S7s7vt3+HFz38k1Zoy1+ka5SHTRoaKbEH0NZBiGEQe4vVUbo+PcApFatrDSBPV/9X71EX9MWZIx13DTqluHXfX3xj6Ymy/dD0bLPn0ckzTOQDz6gRGLJGHxqm6lXMPvC9TIfNllM/3SGVzdxDDxhqBprqf+3gjmOV27PGKl0Z7r1ckPhAdSe5vFmLEdoGn++RqK6P3GXD8iryZWI68e3r1DzzhAiPIEl1XRfGfEmV4YnJB3rGiVK3paawtOlevpKYFR5k/nP+WQJhrYTUR0nQHR9YYXc4O6RpF8Z5Yop6z4QqUeauadYMca/vZuxTId9sQ8ki1MSmNYnneEYruwxm7DXnsFGBC96Bz+w/AC4aWlK9sdRBzWX7XLkgHAR0YedzpphUwRQO7IzHkxN9247Uqv6U=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c270ad0-6bfe-4afe-90fc-08d7fc2e8eaf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 19:55:19.0701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26BwJ0D3FYvVdeOVrFrWm98kkrMVzFNIQ1q74DX198zNMIbi3b/r23HJHF9ng8xOuPsYw2qZy5itcr8vfNCMTEoFTsep20/Kn87PrUgXfKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4542
Received-SPF: pass client-ip=40.107.6.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 15:55:18
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



Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C98C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:46:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239342220D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nMcx5gZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239342220D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLXC2-0007Hm-4K
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLX6T-0002I1-4X; Thu, 24 Sep 2020 15:40:29 -0400
Received: from mail-eopbgr30093.outbound.protection.outlook.com
 ([40.107.3.93]:8707 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLX6R-00085Q-2o; Thu, 24 Sep 2020 15:40:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZFKUdR1tAEzx6EEf5EQyunvu8YFQSqOKDXi4uBgqe6vZAVKmxVWg/2MLdfnHgpQL/YcRllQOpEa/+SRzSPKqOmXLjiVMpd/QWSjlfv04rl2ccXVYjG08xHgUbW+D9ndg0OIP2UKVuzs/HrqaSuN1+VtVL0IenbbaXn1/eJz/V+EJluqVXltAvU57ohVtZJW+GwkYY9fApZ3ITWw6i+tkMN6CRGjgGjtoxdkMPNgYhDb6sH3xqAgZzL7eXDn6bMi6oGh5+qWzr0Rx+yOjRR/+jRNG7DVbXW41tVEjEMCsEOt9lfl8i5g6mU9ruzVLtonZAiZuf10sbjSXrVwnZIDaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSWohvEYEA6sNkgXMZ64QkYiN7/w0mIqfTZzmn9ZZww=;
 b=fSaqyFR4HZpHwruO+usTh1/hRrskzXZzVi2UFUzVe3HzO1mGw3TIFe3aMg5W+9pvjXlzE8Cf780TTCVKSc0gaXJsK3xIOz3Fbmmn9+nvSz3USlN/WfWanICixxz5cfQgW8Ccne0pBfsr2NP8u6N3/0PA71s+q1iirLrfeA1PfzLbV5tH3NER22Pg2PxZsteXO1TwOfPQ1rwLtC5vgUMi1eMswZsLsBcd2iuMKPtmMgkv6UHOVFzXAgfswgBLsyXDAqw2msW9lA0p9klUpTXH+YY+HtaEWg+Wvinwxw/FJRHZVI0KKi1D0WfV5MFJlCKQZLk9QKEjoJZS8iQUq6eKXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSWohvEYEA6sNkgXMZ64QkYiN7/w0mIqfTZzmn9ZZww=;
 b=nMcx5gZp73M2Yw2ENLwO8XoGKhgm62Pxr7N5xKdHye0dCAJS769Xf61fJY0T7lg8cRKPq8onfTDH/uDarMTTrSMIoj20HhqDhqcdW4nMtP2eTuLRa2IyzJMnhDlDTs4Ljjr4LD854G/TURriMaRd/BOcTLuDCnR96PjLLW8/qdc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3288.eurprd08.prod.outlook.com (2603:10a6:209:47::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Thu, 24 Sep
 2020 19:40:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 19:40:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com, eblake@redhat.com,
 Alberto Garcia <berto@igalia.com>
Subject: [PATCH v7 5/5] iotests: add commit top->base cases to 274
Date: Thu, 24 Sep 2020 22:40:03 +0300
Message-Id: <20200924194003.22080-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200924194003.22080-1-vsementsov@virtuozzo.com>
References: <20200924194003.22080-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0112.eurprd07.prod.outlook.com
 (2603:10a6:207:7::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.94) by
 AM3PR07CA0112.eurprd07.prod.outlook.com (2603:10a6:207:7::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.14 via Frontend Transport; Thu, 24 Sep 2020 19:40:18 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c6c487d-284a-4492-f1ad-08d860c1ab0d
X-MS-TrafficTypeDiagnostic: AM6PR08MB3288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB32887F6C208375C5DCE1D3FAC1390@AM6PR08MB3288.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:61;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nza7c07hrc/nboFg+gcuHJNSkAM6jqBr2Nm8uN3PfrPRf4QtYwlp8zx8x8b+xd0N2MivrKIg/HJWGHr0oewD0TEhFD+Wubtve5RU8CVCgCodK0Dlpb8EP20brCQc9pVqmcVwkW3hw8w/Y4inO4qN3k80TJJjOkm6SAjgTakMZ/jJthURGyVcPdyBtYgZ+r32IsXyZvfrR1QlEjqWSM9BYzYz69QkvDsCVU5tVJCqiNDDynqLc0ZQsjkBpqTjYXMgNV3NKuAiMxFfFPLC/7kQT2ZYPkgvWqiK9h/YJAcL3CWxk66kxEhymKn/Megzg36d6dh9OqNsF9tx0udS5fktB10rxEaZZXvYKBhwR1ZJ0oOtIovb6ysfYrJDWU0PWyth
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(376002)(366004)(396003)(346002)(136003)(8676002)(66946007)(5660300002)(6916009)(8936002)(1076003)(26005)(66476007)(52116002)(478600001)(66556008)(4326008)(6666004)(186003)(6506007)(16526019)(6486002)(2616005)(6512007)(2906002)(36756003)(956004)(86362001)(83380400001)(316002)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rceNmgZTg5Wjmxt8b/VVAKfF+n+scpYrYP/BQvBQx9q74EQdpVlK4YwRUnmTxV3eimPBRM5Rgf90BxwEdx7l8XhZ7fq1u4PVzWfRgnP72wk0ePPyhvEySIfl7UbAVHns9oWLKDExgfZflsNOiD31ch7WbGb+B9WV2BM6P+iiT4w5d97IIh4hYYMGZ4HY/BemEJp/3gZJ0cXahZSCYFgFttj9oX9U7l7Fk3XaYQbQ62/seJigPWP9jMdv0NkWRj8bDqG34+mLAjK6Yv22+bv/QrxBMLXKZFZiSCTNBf834unb1iHIY3PH5fziI/kLZOdwdEp7Pz4D9O+9ar1dp1yOiR+mz3hAAknZs5m/LzqpgZm8ftldgScKKHwrRgsgsdPEXkkBPwgwofF1xdNBGz/RnclumqO0AicZNWxawIq08kunTqXXcChvhgowql2g8sdV4EEohXPa7o2ZB/SxvUSvgpWVGb0CFasNdjgNr1PGNjrJqDaapT6KPpo+KpBpbDP6KUACMRZArM+y37vYYDoqKXa7G74dKkW/YA0ZXvHQOVwSuXirzVUvVnF7MYboAKuvbFU+SFvZ50Yr0O45ewppkllGG7KMgDfaT+amJs84lXvdVaKiZB2LkVA3jj+rwXp39NPNYjegWw6fE1UxRKdvwA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6c487d-284a-4492-f1ad-08d860c1ab0d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 19:40:18.9210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kalUZ97UYfcCkATSSzOUEt4vKMAhxOUIFQrqjLCzhxGg7yWucQHegJ5OwIeKrcp9Ryr7ksDe/jQ5RZl1lmA3O1iMNlRunW8uyLYcex3oeOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3288
Received-SPF: pass client-ip=40.107.3.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 15:40:15
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

These cases are fixed by previous patches around block_status and
is_allocated.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/274     | 20 +++++++++++
 tests/qemu-iotests/274.out | 68 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/tests/qemu-iotests/274 b/tests/qemu-iotests/274
index d4571c5465..76b1ba6a52 100755
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
index bf5abd4c10..cfe17a8659 100644
--- a/tests/qemu-iotests/274.out
+++ b/tests/qemu-iotests/274.out
@@ -135,6 +135,74 @@ read 1048576/1048576 bytes at offset 0
 read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
+=== Testing qemu-img commit (top -> base) ===
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=2097152 lazy_refcounts=off refcount_bits=16
+
+Formatting 'TEST_DIR/PID-mid', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1048576 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=2097152 backing_file=TEST_DIR/PID-mid backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
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
+    extended l2: false
+
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Testing QMP active commit (top -> base) ===
+Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=2097152 lazy_refcounts=off refcount_bits=16
+
+Formatting 'TEST_DIR/PID-mid', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1048576 backing_file=TEST_DIR/PID-base backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
+
+Formatting 'TEST_DIR/PID-top', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=2097152 backing_file=TEST_DIR/PID-mid backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
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
+backing file format: IMGFMT
+Format specific information:
+    compat: 1.1
+    compression type: zlib
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+    extended l2: false
+
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
 == Resize tests ==
 === preallocation=off ===
 Formatting 'TEST_DIR/PID-base', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=6442450944 lazy_refcounts=off refcount_bits=16
-- 
2.21.3



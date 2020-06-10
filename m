Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCF2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:24:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B4F20691
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="B6Hjf9Bc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B4F20691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jizmB-0007z5-Ob
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 08:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jizTS-0000NQ-H2; Wed, 10 Jun 2020 08:04:54 -0400
Received: from mail-eopbgr150135.outbound.protection.outlook.com
 ([40.107.15.135]:4365 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jizTR-0004Tg-D3; Wed, 10 Jun 2020 08:04:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmtbU5dvy9OFZfppb+Z0w30YDFYr0Y9aXeMUe6WEMU1A0HHZsgj+/SqXdMVpO2IHeD8s/6nOzrGz3m60Y4js6AL6ve8CjiKAMWR6+GpRqCL9oIWZYIuVL2ViYYijJ8AkoUFCafJzP3I3oHgf3rXfIqZELcXZNXsDcBv/2QwELhnGWT96rqWgrhlA46Y1UdvRfn+CN0S4A5CI7o8YJA9WhRjhX9OShfdA+kCnvq7eXhZlUt8wTcPywS5uaeb7UwrPQqn6jj86cTBPVt22+bNN7FsH4Msu23WxbeJQCb/A2M0U2YmWhEWp/P6wzRp7xj08G7vLJjBR0eVRfDKFtGDIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSj8xoV1LcSS7ZxgDpicM6VpZf77ntYQYfRR45t1Ap0=;
 b=LbwFcXmUYeZFXbOgwu7+N/2PR4UNqL/3rPtiXQZqeKg70v+iez5l/uMhNkAjwz3ric1iip7rdx1SdUszuazqgcSfHIhbfavFOFA7U/DCIKiWPeoa6aYYTPbLKyRLEIULbTVvRcywljqbz30Q1lODZzs8/KI2LoqqaBmDp0Jk448hvGOZf6hKBwH7DUiBBt++hyekQEpH5a3vhEy79kLEpjELC4198IBNGO11s1CPOI6wkJUuoNNL8huWer8xQ4metttzuB1bQYmLXa88e3vWEJfefTOLzcRXQcU0tCUAjf4Z4ZWNRralUs73UOW4nRlOR7LEr4ssZDQ0fceFLhs2DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSj8xoV1LcSS7ZxgDpicM6VpZf77ntYQYfRR45t1Ap0=;
 b=B6Hjf9BcELZd4EKf+ScXAT/GiwG62G78W+Z49nfBhhBNdQHVb2rnPq3SHzf4Zavt+LA6GLCAw5kKB1lrcMu2gcUm5qLHe9L+hILLfddG/98HrMqiZgD9VSY3I5j3t+gmygnf8hcRiEGnxKFNwlvGhT+Y07IlwFT5gU6brQVHiy4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 12:04:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 12:04:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 5/5] iotests: add commit top->base cases to 274
Date: Wed, 10 Jun 2020 15:04:26 +0300
Message-Id: <20200610120426.12826-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200610120426.12826-1-vsementsov@virtuozzo.com>
References: <20200610120426.12826-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0104.eurprd05.prod.outlook.com
 (2603:10a6:207:1::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.166) by
 AM3PR05CA0104.eurprd05.prod.outlook.com (2603:10a6:207:1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Wed, 10 Jun 2020 12:04:45 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d60cb39d-5430-4745-d39d-08d80d3677a2
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5495E7E3B98806CC636F96ADC1830@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:61;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zoX53jjovMTvzwSJWr3YCmRulxcQJYpsGZ2MssQ/qhk64VwwfpC0dD144oV0Mu6T6nzTH2FXsG0ZBO0H6qizL+VNER53itgolrPF9PZ4F5C3zuUUHC8taIVduipZWMjXkG8ixljogBuE2XaOSUIQxvYKIEvMeIZqle0wn7WO40omjtfvwGNiap7LRaqP5d2mvIWsm/ZANgVwibNwwFDk2ZAWW9HoW9sDbAWefQDoHSE9oS94Nv8i1JTtZZ1BfiWsNMuDUvZXYr8sH6lPvGyU9S819yEJiP9CmjCdUxcNge7kIratr4EZTVd87n5u6b1yhzKbgT+nX5+9vInPrV9KJxQMUlkdRHNkfCuC89rPDUrOKAoQfc54TBVTt4atlqDi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39840400004)(366004)(86362001)(8676002)(478600001)(2616005)(107886003)(8936002)(4326008)(956004)(52116002)(83380400001)(1076003)(36756003)(66476007)(5660300002)(6506007)(2906002)(316002)(26005)(6666004)(66946007)(16526019)(6486002)(66556008)(6512007)(6916009)(186003)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: RPMR0OVa80ooSnMx1+H3B5FbJkuh0+7ynlmjBMm8Yf/AXe+DmhJ9nwexpwViXp03FuAE/4Eu2TKmImZ4ZIOVoNsbF/Hnm9rQyVfTvZ1AnswtHljRQypEveKQv5esJ8BT9xBWQ94+tHzSI4hTxCWdJgNcy8MktsowYZlFHkCVIxHzSFIEi89RL6nxKvJDWnDNGtC5sclovitfv8hyEwuBdR3Tj08+VORYbhoMdc0MuK0WTAiAixL3hRx/XLVGVbywWEe/ue8t3d9AfWfhu0rKz+xHjAR/+w/EAY1mdn2qOKJxjdm4Mi2evc8wbCzgZi+k+b+g12eGtViYZwn1jcgZXaSOfhKyg8ysIUmauWgwjVAV7gVMYeLNKmdbefI23t0Tg/fzKnzvL4WJKmvT5nu3TcKOOprwMTsTSIwkapSnroKa8PWww1uxvpNQufSRpz/AZ42Oyu8j1c44Gk8EyDEL0XZOMU8z95gBa9bkEeFEn/g=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60cb39d-5430-4745-d39d-08d80d3677a2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 12:04:46.1361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Mb2G5FGil4WDXOUsc34gSdfeN7kCccTnOsr8ECf2XC2vdAQTJacFbhlvVaegLFSy7Dz75cx0g1nPZT8ubVS6JF751XHJ0WIGJ1jX8L9aVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.15.135;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 08:04:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These cases are fixed by previous patches around block_status and
is_allocated.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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



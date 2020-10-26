Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1BBC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B212225C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wHVe3I/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B212225C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6cc-0002Cn-EL
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX69S-00082a-6r; Mon, 26 Oct 2020 13:19:22 -0400
Received: from mail-eopbgr60093.outbound.protection.outlook.com
 ([40.107.6.93]:39555 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX69O-0008NC-Il; Mon, 26 Oct 2020 13:19:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mO4Ca5z+yYxTofWw3phmcUV5esYEJaujReKg6fKCE0M3RXxbTKh3T5PMgcZS24onWrNvwXw6r2DzxHAsAa7xji4TQYdhjM+HUelVHuxmf0fovjmppGamYWM5P/FR0ESwkUWS0X+HmyOzBKHPq7Igmx6rdLD0UnHWcMO246v2nqcH5OyRZVDjl48ukVI5HpWZOrJOEOnMRZa9XKzayBeKxazZgt0YhhTQ9pwzEk4PzIaCMGTlPwLfXVU2Spw3BOuRf/OHjYVHbILdDHzDzYvCXjmqA2/ML3dYZekUh5m4PkdVvDNXP/ME8L5Jkwg0muobK7kQQRwAg2zhAiECyIGY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AErZ3RdwPEOUJ3rw8vC0Ui0sD27QI7CmRbQPHluOZ/Q=;
 b=FPy+LUyeiH44cNtHIqpRcKe5WlnXj5ZKrqNrPiaCGJsxWL2wQeSaiP7PnXpTpc0EkFBdqJtL1U6dtJo92xDpRgkL5tLSGPCpBvKexn87ShWfOE3Qoa4utao8IFYir4Vf7EFnFY2MV1CT9bfFip3T83hZrKLT+2PXcpvOuHO9GgCDky+ylzec0sEBR/XuofJeniiTEkAqaEqIo18KLDB+xF/H1Tb1aYkEG0ePYkP5BMJubkWbpzdAvpMd4ZxVf4jk/sIzPfSSOKNdeELoNaqKC9CQrjjCNnlxal+GAxGzkL0qTfbVPfVyRrtwlEuwXgpaYvBjj16CY4P45EFJRL4Mmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AErZ3RdwPEOUJ3rw8vC0Ui0sD27QI7CmRbQPHluOZ/Q=;
 b=wHVe3I/nk7yBAzJ/uiF6OgNeM9N/seXsO2bfkZ6RkqJ/P80sLbXRMNYn2XqJYQNofGLPr1xW0sUF+wKNlB+DiWfCXU9CYY4VMpwyGBlzQ0M2WfnSV4QDADDi2hsOI6jf+mOsDMeL08vdVJRxun3UK2KbY5oCkDdLqRNesHeQDQU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:52 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:52 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 24/25] simplebench: bench_block_job: add cmd_options
 argument
Date: Mon, 26 Oct 2020 20:18:14 +0300
Message-Id: <20201026171815.13233-25-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026171815.13233-1-vsementsov@virtuozzo.com>
References: <20201026171815.13233-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.99]
X-ClientProxiedBy: AM0PR02CA0101.eurprd02.prod.outlook.com
 (2603:10a6:208:154::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.99) by
 AM0PR02CA0101.eurprd02.prod.outlook.com (2603:10a6:208:154::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Mon, 26 Oct 2020 17:18:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ed2d0af-80d5-472c-795b-08d879d335a0
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB30327081ED1ADC9945ECF533C1190@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mcNpROan3IHAlWhxXBVFRn9Kty2Mj2heN5MnF3PPhloP+M6mv36d7zOdf7f9xfFywNlYovt5M2tWkWvrQW3ck+nRREMivm+KVUwfmQeprPbEpFMifLy9Zt1p3ZfYBPpyY0iUetWd8fbvK+dUOPRBVzvoZeBnEyErdp9PYoakMFJ2fzRBPzOCbuDKsPKx0gM54XXHPaqHBJg5n0jHvdHirMa8HGRYBewJbSUM4SvNNbAOO2hrYyR1eJ4O8XWCWXaqn6hpjSvFtF3Ue4LIIDXRZKOsIF5boYRFiTNFAfUixDbvkd0o0N3H5NZapNnYOEWyG/PTDpHCl5grjwlICiW4FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(66476007)(8936002)(5660300002)(316002)(6506007)(6512007)(2616005)(66946007)(956004)(66556008)(6666004)(26005)(4326008)(36756003)(478600001)(52116002)(1076003)(16526019)(83380400001)(2906002)(186003)(6916009)(8676002)(107886003)(86362001)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ebpC7ORjkM7Pt6Eb3FeZAfmbNvCYddtB4c+W8VwYeGC1wZLL4MHJtRl/YpHrj6Ai6UKJcKuYhIQRRfiIAyq4/2Hvmn8Uk6YcHyCJGXNmnTRGCw1+1hdzbnkGiIyqJlMPq98McfxYgNv8Z4431VHy5pri9eBS92I4f8lhldBPaV/7vofSGNkJxb2hpfZeA8H61fTTH+6L+SXrZyKJAStKOq5ftoHXCqeGMTZz2RfcKFfPNt18OgYKT4Xn5GRXQfZ8K8uvg0xAMELqvTKSnPVn9FWDsxyuLBffcpZUJ5C8E+mnFoyL65ZWu1sXblX0ic1gOFqNCMIiWCi6zU0J7rQftSP7+uBBM+SrsuyWVoU/85tA8ihyO7pCvuxK2b1y9qCUPfl2h326yd9gxbKLY79ZpFf3ucb3639vWpNEHI1TYNO55ld0b8kXBKmw9SK0sJ/Do+l2qgLcf1ZDqaTks7BuSTE6nrhkldS3k3xC1xkO8ZZ0b2NnZ5vrxA47Ehhg5Vg3S+oVKaR816GrYMm/bykDTOEF+/Vu1wL6B50fR04m8+zPDNYHR503/hUxERN3RqMfyPcj+ujz3WL2PuMQjuHOQbBjZ7s1IlqITQvAPx7dyyQUU/BMwfs5roBz2dS1gHqkKqgDflR5LRZk4ryRA1gB3w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed2d0af-80d5-472c-795b-08d879d335a0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:52.0253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXqtKZBgf+yW3F2NXiMCU962XGirnhYpBqmDEgqVpgk2ismZYqwPeB/ze/XZKqv0Yg1DnwIpEr9rmgY2JqPGfEe8lkV07YVL8vLQV0OFDww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.6.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:18:35
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

Add argument to allow additional block-job options.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 scripts/simplebench/bench-example.py   |  2 +-
 scripts/simplebench/bench_block_job.py | 11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/scripts/simplebench/bench-example.py b/scripts/simplebench/bench-example.py
index d9c7f7bc17..4864435f39 100644
--- a/scripts/simplebench/bench-example.py
+++ b/scripts/simplebench/bench-example.py
@@ -25,7 +25,7 @@ from bench_block_job import bench_block_copy, drv_file, drv_nbd
 
 def bench_func(env, case):
     """ Handle one "cell" of benchmarking table. """
-    return bench_block_copy(env['qemu_binary'], env['cmd'],
+    return bench_block_copy(env['qemu_binary'], env['cmd'], {}
                             case['source'], case['target'])
 
 
diff --git a/scripts/simplebench/bench_block_job.py b/scripts/simplebench/bench_block_job.py
index a0dda1dc4e..7332845c1c 100755
--- a/scripts/simplebench/bench_block_job.py
+++ b/scripts/simplebench/bench_block_job.py
@@ -78,16 +78,19 @@ def bench_block_job(cmd, cmd_args, qemu_args):
 
 
 # Bench backup or mirror
-def bench_block_copy(qemu_binary, cmd, source, target):
+def bench_block_copy(qemu_binary, cmd, cmd_options, source, target):
     """Helper to run bench_block_job() for mirror or backup"""
     assert cmd in ('blockdev-backup', 'blockdev-mirror')
 
     source['node-name'] = 'source'
     target['node-name'] = 'target'
 
-    return bench_block_job(cmd,
-                           {'job-id': 'job0', 'device': 'source',
-                            'target': 'target', 'sync': 'full'},
+    cmd_options['job-id'] = 'job0'
+    cmd_options['device'] = 'source'
+    cmd_options['target'] = 'target'
+    cmd_options['sync'] = 'full'
+
+    return bench_block_job(cmd, cmd_options,
                            [qemu_binary,
                             '-blockdev', json.dumps(source),
                             '-blockdev', json.dumps(target)])
-- 
2.21.3



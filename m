Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5A3C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 963DB2225C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vjkjUEzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963DB2225C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6ZN-00075F-KQ
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX694-0007rM-0y; Mon, 26 Oct 2020 13:18:58 -0400
Received: from mail-vi1eur05on2123.outbound.protection.outlook.com
 ([40.107.21.123]:17409 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX692-0008Ou-3X; Mon, 26 Oct 2020 13:18:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCAqR1l/v2nVXGxXDJGqxzO71wYuUm0bk7ap+R70pgNzhLXwUmGqrmoZB82aT3F/T7yvpfFQDXynwdx/0AFj8xugekZhWDrC7lvM/mqYqm+op6enJ9Ui+w2pW8AKDzSXNmmNF6yhAjxL4uyHJPXIoU7uT0E0P1b3apiY6AY7v7xY2LHj1eZrqbl6cBp0P0ouslTWABFs6bhhMFek1ThjXhLy3DzW3QzgNK5vtiP2VxQXHxBp9ACtdOw54pXoLMIpq+kFQxEwnpzrYcuOOZSGgB9cqW9tbHqvKHZjJy3Am64lo999agnwYIPNWy8n685ld35MEFzweQegAcO/trbH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpYN+l2AfTKEbgTJ0TxBN5MZZEqrVqBPTG59eQShWXA=;
 b=GSi7G5pOwFspCs6r6BjgmRgusiBKFOIgH9d/H3RW86RvOM8/xLax8OYomjRDd59qUS94iS3Kcyp8Hj8m44XhoVPsAVwN8LpcAiqfh4wrYjz4PnYXPF3TVfwCi2i+15CCD6ZfrOguTDU7R5+uZs+NpsqFoF4+8WlxJD8Ex+YCfYT4PIuoOkxk8DTpQ9gIxplYN99/z/iU0QeMssIRN7EgbeyT18kARPnPFRb8GmkKhN8K/fwEaoU3LKgFs0cOQN4hgZJzsktI8E+0Hj8ZOxWL8VO/4IcTZMT8tFyq4U3pwSNU6MLqP8L+TSKUr0lfR4qMYFEKlkyNzEb8bmWbA/RejA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpYN+l2AfTKEbgTJ0TxBN5MZZEqrVqBPTG59eQShWXA=;
 b=vjkjUEzY77YbnAIN6OH/7VAml16krASQoVx2s9IY+VS9q/gmKjGd3Stmvv/1V4cagnHfSl6F/X2OlCoxzBryHPV7JiVtEh6LIr906Xi/NvYeL8xW8ST1zMp1RLXV5/V1l+lSAcMtWiM3wexvA9LpGXMnvd46DRNSE+jpF/Irxjc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 15/25] iotests: 219: prepare for backup over block-copy
Date: Mon, 26 Oct 2020 20:18:05 +0300
Message-Id: <20201026171815.13233-16-vsementsov@virtuozzo.com>
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
 Transport; Mon, 26 Oct 2020 17:18:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3af09277-ed1f-4e9c-1f3c-08d879d3306c
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB303209304CBE91E9FC009C82C1190@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9wnUTMUNrXbwJsAFE6j/RDjz51n/3xbZ4aOQPFWwo3zkixNLlhCKSgW/aLczYc1b2++qujFvSB9vAhLT0CdtZCbmDoSAk4g2ze90q0xsPDBQBcGFYKOvkiIGy51UOe72uW9TibWiD+Jh+6hf/dcT50B8Ff6TLONtgAy35UDBx4Eau49Gmd3Ci7wrT5ET5LuweKFGjb1EU4YR8LQoKBYr6j/BLQn99asbLEKmYJ+ep6V30TF1noMc9+UF12M3UQcya/e/Gp/eHHR+z9Uf+MBsnc2kYDK5pF0UmZ362ilHdUqPKTsXJdSypAhVWAWovoNT18rW6laA3vSQx4PUGFE2TQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39840400004)(66476007)(8936002)(5660300002)(316002)(6506007)(6512007)(2616005)(66946007)(956004)(66556008)(6666004)(26005)(4326008)(36756003)(478600001)(52116002)(1076003)(16526019)(83380400001)(2906002)(186003)(6916009)(8676002)(107886003)(86362001)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: wnmGV8F4QFBuiJky4h4wU06I9tTkO3eUJ8A8z9zlcf8XnqBWWNpvpEr6ebbibb5ebyK6Y+6RP0Ec7W9qZQ1ZYQOdVm6Bh9fspDG3oiRRSjiQ4NHd7F1BiiaqEmM1YiApBFMLEz8NPUYDoiMgRBH+c4bNlNzpPxdf2QBJ6w781RRVIWfUOW0IpEQz4757pnB3iTkyjs1IGxgd3F5y6S8rUAfPKXa3MEAixgUgL75Vjfcmv1vFZ7J32r8WtSI21U8YTRMhqZic70Zwhr0SBheiq8Hw9zpdjBjjbVDdEoZZT0uVo7Ash8SwPX4u8DPlw5aZZ0w0+AhXTdFUeuzU3mulIMQL1RvcnmfB0aEVYYHz0Ww63Irdp3Xy4LXoqqgamBP9gGxluy+RMddTW6+pAGRrAAIBjgrD9f2CUkil0j1sXetoSdqivMxNcnVZer0/QCOcENY24k7eMZpsYquoKtouMvjHyNMN/rKvvsNZwnv/rzQczq0xk+OmwByuqtO444IP99p05kmM2Z8rRlO7RNbTA81kllrkNEgi3RssMVySkSvYUaDPY0st+HSO1fs1TnaEQncpK0fHDMaelSDr3Jatd6j370KEYPzvkYkdWUuNPpwe3LTFc8/EANzmV06GYxReJFR59STlXFPhxsPJKCpBjg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af09277-ed1f-4e9c-1f3c-08d879d3306c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:43.1692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moEkj23HqfjhdCGGGWJ2huTeoy2UtCR1Wlg2tTabZnQ8ZdZKyAO0z2Tnj7f2sD1GbycF5IqHbXaU/hPsTxCLwLfqklWKxzM6kJ7OQ/615MQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.21.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:18:43
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

The further change of moving backup to be a one block-copy call will
make copying chunk-size and cluster-size two separate things. So, even
with 64k cluster sized qcow2 image, default chunk would be 1M.
Test 219 depends on specified chunk-size. Update it for explicit
chunk-size for backup as for mirror.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/219 | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/219 b/tests/qemu-iotests/219
index db272c5249..d7b177bf09 100755
--- a/tests/qemu-iotests/219
+++ b/tests/qemu-iotests/219
@@ -203,13 +203,13 @@ with iotests.FilePath('disk.img') as disk_path, \
     # but related to this also automatic state transitions like job
     # completion), but still get pause points often enough to avoid making this
     # test very slow, it's important to have the right ratio between speed and
-    # buf_size.
+    # copy-chunk-size.
     #
-    # For backup, buf_size is hard-coded to the source image cluster size (64k),
-    # so we'll pick the same for mirror. The slice time, i.e. the granularity
-    # of the rate limiting is 100ms. With a speed of 256k per second, we can
-    # get four pause points per second. This gives us 250ms per iteration,
-    # which should be enough to stay deterministic.
+    # Chose 64k copy-chunk-size both for mirror (by buf_size) and backup (by
+    # x-max-chunk). The slice time, i.e. the granularity of the rate limiting
+    # is 100ms. With a speed of 256k per second, we can get four pause points
+    # per second. This gives us 250ms per iteration, which should be enough to
+    # stay deterministic.
 
     test_job_lifecycle(vm, 'drive-mirror', has_ready=True, job_args={
         'device': 'drive0-node',
@@ -226,6 +226,7 @@ with iotests.FilePath('disk.img') as disk_path, \
                 'target': copy_path,
                 'sync': 'full',
                 'speed': 262144,
+                'x-perf': {'max-chunk': 65536},
                 'auto-finalize': auto_finalize,
                 'auto-dismiss': auto_dismiss,
             })
-- 
2.21.3



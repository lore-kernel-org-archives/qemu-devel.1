Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844F1C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5301F20738
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BTPjQHN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5301F20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k092S-0003Ra-Je
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091W-0001az-1y; Mon, 27 Jul 2020 15:42:58 -0400
Received: from mail-eopbgr80131.outbound.protection.outlook.com
 ([40.107.8.131]:43617 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091U-0003fa-Dq; Mon, 27 Jul 2020 15:42:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBpfaaXyePCQSKV2ICTVlQse1V0q/SYtk2AiIG02YLuq0HFUfYyM/5v2A/73gJ6xNFUxIHXOrqLBkG7aWRglCFfDWcTbI9SdmOVajlFjOw0woxce28ZhxmWUeStHtkQLls6ZFCGInOhymeIquraKsWDfPapj/mvV8iukvyVSBnEtBw2Buul0zOox990uqif8J2Y7dUhMSITeP536D8kX3OVFgPxK3YwDJ70l2OnGHGMkZenGMSIpe9id0B88WsIU3Q77hJ5Kf4c9dxeHRKrc+q5rYH3MDhKQV3he69LJIy0MpW2YsxTT7zh84vYHKngZyVorxyuo7tlp3m9v2KQXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Odri3oiMlHPsdhi9EGmWChrvQIlTbMAAjFcunhZoRM=;
 b=loeUI8iuWBHNoufIF16nYLkxgXQqBQwlXVzV+1erTE7WCk7AptyKSBoNfYBGqpgXOGxCHAv2QHVs0XDZyElpwKk+Fn/hFnsY1ekra2Y4Wa1jOcH6sYUN6aY7aFr3gyBYyHqcxMeyRNOwCd+H/kw1pphd/LK6vELf3TtifqXrBMi9EJ9JSmNB5JZNCeNE5AEevhbfwkWu9ZERxS9xrlyF1DeN2eAamlTS7PDj+fjm2vj+209xOPvt6/V/Uje5VMmW39dfREd9iulHeHtk0x5/chJhNMIGqyqQRmDFFXPLh9Z4tdvxFKlvkFUeZq9h1bLgteELI/lKwfgcJVczKimqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Odri3oiMlHPsdhi9EGmWChrvQIlTbMAAjFcunhZoRM=;
 b=BTPjQHN36Kg2VnYQUpkrOOB5oZo1KWQLQX8B0kSI04e8u0LAiFuZDBbBPr2dz4RUi/wHWHhKSyoecW36gvlwF53w7+ttwAEB84uwj8OAKoNnmFXlWGS0eK8dPvuG9x+pe8/up5sL9VbuKaN3yE5gTWWVo1vUeeUkP9knoA1nwdQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:42:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:42:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 01/21] qemu-iotests/199: fix style
Date: Mon, 27 Jul 2020 22:42:16 +0300
Message-Id: <20200727194236.19551-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200727194236.19551-1-vsementsov@virtuozzo.com>
References: <20200727194236.19551-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0084.eurprd05.prod.outlook.com
 (2603:10a6:208:136::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.158) by
 AM0PR05CA0084.eurprd05.prod.outlook.com (2603:10a6:208:136::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend
 Transport; Mon, 27 Jul 2020 19:42:49 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebb81506-5098-4908-fc84-08d832653f1b
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2610509C1746AF7363516628C1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cd5DY6QP/BuBq7oSpJMgoXoAb8BJH8VhPdzPGuyY9tqsuGmHojlLt39K2/UNf0ySXMFwzn0htU23BTsYtRunxoBm8tU+wkW1eTxTNWi9ZyeDzJCs96ipibuO3h5d/7V1VdReWuBZ0pi5A7/zqFVQVRImSed71fTSwkMcOi5cmTay6TEj49VELN8vC6eB3Zek1cGbOpYGZqakmcrJjilDbVLmRQ935ev8LbiiYWvGq+2zZw2XC1NS9/Ve3aONXyFvo4rHZx2tFEvDiJ02HsJLbRPMhf48hLvWNvgdsc49VTT++Nucuxcedco5YbBoQ10NOPXIHwtu/mbx6EyXcyVEbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39840400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: TDLUlhcwlqtWlA7YJxdWVdNQwXM/IEVh7eSk8hexbY5mitSZdpJE6hu7xCysT935rTsc7jPzbsUUum9A4Esm8Olw/Y4MIEznuxd7WwFi5Ojs+U73iaT7ZZxvhDA3GTRpph9FkO8gsVBCgv13ZMcxAG7lCkD6NFNiqG/fEdK+dG818+ht0/VoruWxkjAH8VsAkYp0J4BCSV6LvFucSvVmH/H1kDySvmhsNQlvGdq/uaegHzbRTGK3LjyhdZdoQOgjuE4UaOq6iPyFLzj/eWHbkQ8wbJmgoGdOynsNjs91KsJFGCIAAeABbyy3p6iqbV3WYHzRBHZ65nj1N5X3iKdXtThLaVmSVbsksnf/H+Kdrm0n6kP0Iyzr025SsNYqIbObk6+nPVwuHYiKn/CNZRRJrGdwzm7rRLObnXWVMblY2zTSI4wUbwbZ/EHimIXvSWgnqfEtpniIF2FUP2fMLBQ83FB4v0uWptj64TujArEnE74=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb81506-5098-4908-fc84-08d832653f1b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:42:50.6721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0O1ZCEtL4uvHzMebawjp8/C/zJl3q4h/Qo/7+9zHo9wEzy9XsvnnCHuigPkKxIgABGD5VVJjOhyiSWI6/j5gBFnqe9J5aSrAtFTJeVZmUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2610
Received-SPF: pass client-ip=40.107.8.131;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:42:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 stefanha@redhat.com, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 den@openvz.org, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mostly, satisfy pep8 complaints.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Tested-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/199 | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index 40774eed74..de9ba8d94c 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -28,8 +28,8 @@ disk_b = os.path.join(iotests.test_dir, 'disk_b')
 size = '256G'
 fifo = os.path.join(iotests.test_dir, 'mig_fifo')
 
-class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
+class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
     def tearDown(self):
         self.vm_a.shutdown()
         self.vm_b.shutdown()
@@ -54,7 +54,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
         result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
                                name='bitmap', granularity=granularity)
-        self.assert_qmp(result, 'return', {});
+        self.assert_qmp(result, 'return', {})
 
         s = 0
         while s < write_size:
@@ -71,7 +71,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
         result = self.vm_a.qmp('block-dirty-bitmap-clear', node='drive0',
                                name='bitmap')
-        self.assert_qmp(result, 'return', {});
+        self.assert_qmp(result, 'return', {})
         s = 0
         while s < write_size:
             self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
@@ -104,15 +104,16 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
             self.vm_b.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
             s += 0x10000
 
-        result = self.vm_b.qmp('query-block');
+        result = self.vm_b.qmp('query-block')
         while len(result['return'][0]['dirty-bitmaps']) > 1:
             time.sleep(2)
-            result = self.vm_b.qmp('query-block');
+            result = self.vm_b.qmp('query-block')
 
         result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
                                node='drive0', name='bitmap')
 
-        self.assert_qmp(result, 'return/sha256', sha256);
+        self.assert_qmp(result, 'return/sha256', sha256)
+
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'], supported_cache_modes=['none'],
-- 
2.21.0



Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3AAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 22:10:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34735206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 22:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="a3JdMmO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34735206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbtON-0001km-Dh
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 18:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbtLP-00041t-Dp; Thu, 21 May 2020 18:07:15 -0400
Received: from mail-eopbgr70104.outbound.protection.outlook.com
 ([40.107.7.104]:17734 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbtLN-0007vC-2C; Thu, 21 May 2020 18:07:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvOr9Ih/+oZP4RC5x0JS4aRiNu+lxkrAWr0rGE+tGmhBPJ7euHuTrWLNoYkzTukMjV40bFiGZNR9jzCv7S+y9UBvjjd40DJBMtorbhsCzYE5pYi2GJjWzNVf7UG245ZfzRJCdOTdmetHZQ++Oq6hoxPfvffJjtGg00sJB7P2uCFyYVv7S8/Z3WMGWrBDGGmenVhqjYXEwUgcE9Kh57EiUQX6ZK/PBgEPrvuxHwaXJV/Mm5wbSwLsdMWHu90Qu8CnH04BuMd84JnNsm2136TD5mEqO/6H0T7Q386lplWjZDfgd2jCjsFtufoxWRFbbtwL9SIiIfhgqH7JOayeIGivWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD+Bkjmvw9RdSffluhresqeBdKvrHcftxCYn55nTEao=;
 b=jdSsANHg5+HseaSCe/HPex8NTwANU1yBTyJnj3EMUIgY9mc//x1ss/Axc8lScr2NX2RAPs9Lz+hjsPxPerpSf++A5xJEr/w5BmlRlFWQwgNGvFENcLPu4jOQBqIu7CL8bGHMDkZQlhV/2jiwzN179vcslC3imWe+4ebUCvwBqMKcu3+xahaojRbeE4rc2itBtkN05eAeEavUZX3dppciibApXp/fb/oMVkZa/h2+KEJd193GPvCa9VKQ6AAkR9InEhq6uCx/WRWEfcGPYftWb8jv1bwBbFDUJf4Idygu4teLU5U7JYJBFIdkDazf64mMcaBee3zQPUkSwEKjpEq6pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD+Bkjmvw9RdSffluhresqeBdKvrHcftxCYn55nTEao=;
 b=a3JdMmO6gkeE2bQtZoJ6zezx04w3MUe5ZBVWnNU1pI7dmhrv0YRngVkiG6ffWy+C/Z3BmlBU/l5fus7i2mlWovDEJitGZodfpM0431KY+dJnXqkTHXNf4MhPsE+l3Ae7wqgBgBmUM5aLcc2bJOpT6obwaOfYgFvk/a7EtAlYyLQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5512.eurprd08.prod.outlook.com (2603:10a6:20b:de::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Thu, 21 May
 2020 22:07:05 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 22:07:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 4/6] iotests: 194: test also migration of dirty bitmap
Date: Fri, 22 May 2020 01:06:46 +0300
Message-Id: <20200521220648.3255-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200521220648.3255-1-vsementsov@virtuozzo.com>
References: <20200521220648.3255-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0137.eurprd07.prod.outlook.com
 (2603:10a6:207:8::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.167) by
 AM3PR07CA0137.eurprd07.prod.outlook.com (2603:10a6:207:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.12 via Frontend Transport; Thu, 21 May 2020 22:07:04 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f078956-3ad2-4e39-8c52-08d7fdd34bd9
X-MS-TrafficTypeDiagnostic: AM7PR08MB5512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5512EF131C1EF5E5BD497F0EC1B70@AM7PR08MB5512.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MoGgSQH0DbHg7NFtk3XQ9CLHLE1x2OrtTeVPm+A7wxPU4DLERsU0aLu+gm1IvE3TA8Qsw9yOejxhcOL5rE1b7Hol9pK7ebjVUIyCOCcjj+o5GCGC6+i3ldcL/NeVhAxtPEzz75PhERp8kjWdJ2AqNlKtjfs1ZIwhi8mDzr9sNJ7Fu2JQtvAKA2tuXFOCpBNPG8lpxKqWbqD4kxLSvwqu496sFJQbI9tvSQoBrW1l76JErTLjhbJ6rlvUjxWe9KNAppZ+WNtqE9Q7d3PPkx3eIJ/ZSHvKKyGK+gopd/QrxyKd6GPEY6aVaZCQUXHqeGtqlF3iWI5OA62XfgLilX75sKpZRyTIXaIjsQ0YeBlZpae4Uy++b0lwQ/VYEVFFv0cz0rFy/LbosiNf+usQKTxg7v3cmHCuL9NN999Qsp2lXRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39840400004)(8676002)(6512007)(186003)(26005)(6666004)(2906002)(7416002)(16526019)(316002)(6916009)(8936002)(6486002)(36756003)(6506007)(1076003)(107886003)(478600001)(4326008)(66556008)(66476007)(86362001)(5660300002)(66946007)(52116002)(2616005)(69590400007)(956004)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: sN82Oh3qAAUjjbxR7uF1I9lJ+i0qGHFJ4LirMUlXdl2d/U4Eb6crKPl2HlYjVFS6JRhK7R/PN5xven8zl3VPnL+7Ltm+O/GebodXkMr2oaJI2SCgm1uf+JPYF3jUW0WviDtocPnbM96Cvpa3RetVoG6BgUV/CcJ1dHaiWSeUUxlO9L/VLG+8nszCW2/yw4a4hY9gKqXYvHmSPRfBblPn4C6DjJ7Vi1iAEtazcuOIidFF5ENsC9QL6tT108SicGsz4uZAOF3ySqjkkMYZe2L9WUKYAMG2K3A/Cp/ldRgZ1G2yB1BLgJJeTSnznm8zM5615F0XrLwCOEcFLpXul0F/NYWJL/EA2cJMTmn060x6d4yyHEvqZNWOFyMMqmar9yKxrWF+VUn2leeaSuaJKzgmsKAOBKh3viqKpe4dINAJccfjBblNm3lpd8UBbVNNP3BMPBC0sUVDV2hFq3A115CC+x4y4XcFrOjzAXgI6PgF2XU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f078956-3ad2-4e39-8c52-08d7fdd34bd9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 22:07:05.0571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UE4QB1TMJfXJfQWNtglutnYT+qc1ikR9J2uWpLt4bCrGw6KKPl/xlgZ1G4+Bhsy3jymgjg+mgRnyt6KStKYHzj5J0xGKPzBRHch50T4/RnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5512
Received-SPF: pass client-ip=40.107.7.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 18:07:01
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
 quintela@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test that dirty bitmap migration works when we deal with mirror.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/194     | 14 ++++++++++----
 tests/qemu-iotests/194.out |  6 ++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index 8b1f720af4..3fad7c6c1a 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -42,6 +42,8 @@ with iotests.FilePath('source.img') as source_img_path, \
             .add_incoming('unix:{0}'.format(migration_sock_path))
             .launch())
 
+    source_vm.qmp_log('block-dirty-bitmap-add', node='drive0', name='bitmap0')
+
     iotests.log('Launching NBD server on destination...')
     iotests.log(dest_vm.qmp('nbd-server-start', addr={'type': 'unix', 'data': {'path': nbd_sock_path}}))
     iotests.log(dest_vm.qmp('nbd-server-add', device='drive0', writable=True))
@@ -61,12 +63,14 @@ with iotests.FilePath('source.img') as source_img_path, \
                 filters=[iotests.filter_qmp_event])
 
     iotests.log('Starting migration...')
-    source_vm.qmp('migrate-set-capabilities',
-                  capabilities=[{'capability': 'events', 'state': True}])
-    dest_vm.qmp('migrate-set-capabilities',
-                capabilities=[{'capability': 'events', 'state': True}])
+    capabilities = [{'capability': 'events', 'state': True},
+                    {'capability': 'dirty-bitmaps', 'state': True}]
+    source_vm.qmp('migrate-set-capabilities', capabilities=capabilities)
+    dest_vm.qmp('migrate-set-capabilities', capabilities=capabilities)
     iotests.log(source_vm.qmp('migrate', uri='unix:{0}'.format(migration_sock_path)))
 
+    source_vm.qmp_log('migrate-start-postcopy')
+
     while True:
         event1 = source_vm.event_wait('MIGRATION')
         iotests.log(event1, filters=[iotests.filter_qmp_event])
@@ -82,3 +86,5 @@ with iotests.FilePath('source.img') as source_img_path, \
             iotests.log('Stopping the NBD server on destination...')
             iotests.log(dest_vm.qmp('nbd-server-stop'))
             break
+
+    iotests.log(source_vm.qmp('query-block')['return'][0]['dirty-bitmaps'])
diff --git a/tests/qemu-iotests/194.out b/tests/qemu-iotests/194.out
index 71857853fb..dd60dcc14f 100644
--- a/tests/qemu-iotests/194.out
+++ b/tests/qemu-iotests/194.out
@@ -1,4 +1,6 @@
 Launching VMs...
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap0", "node": "drive0"}}
+{"return": {}}
 Launching NBD server on destination...
 {"return": {}}
 {"return": {}}
@@ -8,11 +10,15 @@ Waiting for `drive-mirror` to complete...
 {"data": {"device": "mirror-job0", "len": 1073741824, "offset": 1073741824, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 Starting migration...
 {"return": {}}
+{"execute": "migrate-start-postcopy", "arguments": {}}
+{"return": {}}
 {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "postcopy-active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 Gracefully ending the `drive-mirror` job on source...
 {"return": {}}
 {"data": {"device": "mirror-job0", "len": 1073741824, "offset": 1073741824, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 Stopping the NBD server on destination...
 {"return": {}}
+[{"busy": false, "count": 0, "granularity": 65536, "name": "bitmap0", "persistent": false, "recording": true, "status": "active"}]
-- 
2.21.0



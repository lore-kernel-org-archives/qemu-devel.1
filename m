Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1617C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65FD02074D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PT2C4ZVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FD02074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZi6-00006N-Gz
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZZeB-0002LN-P3; Fri, 15 May 2020 08:41:03 -0400
Received: from mail-eopbgr150102.outbound.protection.outlook.com
 ([40.107.15.102]:11310 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZZeA-0008VJ-5h; Fri, 15 May 2020 08:41:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiAK3fT/t66DKsWRpzpMZJDAkSwRTsRj20g9tvc/Cv18Q8V474+UUOPbTHHxZaQBVsxXM4x3z1a/c8LpDHRP9/KX6oDhC1MNOsHh+jJyfCfr4szmMpP3ktnAOfxQQgw9/fVQsPr7T5QN+eYC/gNua/DslGPMDnCpIqbxDhM0inwwrq2JcAn52uRGaPfw4LLi0zKL4e1tQ2guLSFTmwDMhJtR2UqBojzaSOaMVOaNIe5uSqfaPJNHGA1eMgzXPyzbqAJ58/4rgFDcBCqgJAbDXT6la8CD7ZS9LfxtnClheeXbXZf9Co8C38Ds/Pxb5av9+KY0FZkOEB/Cq8uT5UHZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkZGicmZkEkWBSrAs6IV5fxCC8gFscTRY0mZLskPr+A=;
 b=hfhwqP9g9gcwISBGU7Ouik1ZlOMMwPD8lC+61Fteswq17efbwcNX6MDTZolaLpBmA2ICgPZaKljQUyOM3DHF1EWt9JbwJNc4y81+yPBRt/5ku7eJnVfALDTDMgniYNOQ14j+3TtKJ752q6rlek9jI+3Ghtj6rhAAUYkqMkLmF2LLyd/amg2Z7l3eT4GjnKAHcfwxtBLF/jNGLDZivHpJcczvfjZaEvMrnEfSrjxW0o7d22ZkRCIzH5pl7agVCiQ8Vu4WcS1EtqPV9sZ0J2v5LkNJuxPWfvyUJSp1e0Ql2gRIUio29vF4ahFdGjRkaNOzZ+QMJu5oCemu1YGayV/vqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkZGicmZkEkWBSrAs6IV5fxCC8gFscTRY0mZLskPr+A=;
 b=PT2C4ZVT1zTGYnvZ6/Ps4rJ0pOzuan3st44sCe0R05E0/Own+IDqEaoWOHM5EA9ki2ttqWfayCGMq/r5txQagzjeUmfZJDr9GnxgWKS1WcWhzF70yLtebPRu2SfHjQinPtV44JmQzdGX+4ki6fEuK6qi3+i6Q5kz1CUVzo3MtUo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 12:40:56 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Fri, 15 May 2020
 12:40:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 5/7] iotests: 194: test also migration of dirty bitmap
Date: Fri, 15 May 2020 15:40:22 +0300
Message-Id: <20200515124024.3491-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200515124024.3491-1-vsementsov@virtuozzo.com>
References: <20200515124024.3491-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0039.eurprd03.prod.outlook.com (2603:10a6:208::16)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.184) by
 AM0PR03CA0039.eurprd03.prod.outlook.com (2603:10a6:208::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 12:40:55 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e152baf-9163-411e-bd06-08d7f8cd36af
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5381DB163701382E4A75032CC1BD0@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UsbvVEDHbFuYRlOlS0cE71lDq3y8CvnPKDWFFqikQsE7zC0y/iY9/BrvAQfzDnMzp7z+4F9e86UvB5rnZcp52JAlfe04Ct0Hmbgaeed6JG6QrYsk911rKSz4EIr5NPzHrZkI0BCO8tOw6mISOcB9zrk80QGrDl9oIfrS69pD7kbWS6mrZvNXwUzv4W3+hdrK9o06iR76FaASRIgpJ04tVVHgqsNHGBmc9IErbIXs8CLsFGCiPoM4YdrcwZB//dPE/v6v7ClGHmEdpFiMZWIhVPSuq6GdkfZVAF+/O8nIwxNlmXrQY+5N/rtrqahko8nPVJMtnlwYjUpWyE/xd66Xdgij1YsIMbm/CzN1R70DZ9OVU0b1OjdxxHL+HEbYbfjjCJjA/YNTBMK8HErxSRy89aClXAQCjLzH6KtpMf9T0lxHpLSCSRonoCuK3TqjKiysPyIwbYtLHWZziycN9JCX85IO/UvYWZyBcrnRhy9szmn7AMV81/Bj3YiP8G9xH555
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39840400004)(52116002)(6486002)(36756003)(8676002)(7416002)(8936002)(6916009)(478600001)(6666004)(86362001)(6512007)(4326008)(316002)(26005)(5660300002)(16526019)(186003)(6506007)(2616005)(2906002)(1076003)(956004)(66556008)(66946007)(66476007)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +tRW/FVFtnI8N5zOKHc8p0rc0pyuy3jLyqjyHieNhgcMLLp62+70BIS4hZyzoqek9UPr9mkdNO/tSP/j8JsqnJOJgAyOi+dQIsZBSYm/iNajiPk2FGlyQ+xSpYiGRfzWYDclLblOUHbgNj/SqdjPC7cpPBOSJHf0AteZdPUTuf3GsD3vARScMAd9CEBZJUnrPcR8f7v8h1olmYawwzBylqPq9FUeBSo2jqJlwdBZhwy8tf4Y9x2BN80RU3QFOXihuXOlviliuY8KduISMJ/d/VnFFrmEL6WZOvfH4BULHFtGM0ofYLQXA4x5JlbCMgRzKZZ2SZd4KMyLF6f50cYBcduPeznl6MAjtehpfSwe6ccdInG2b7EOOioXYACaGtWD8E35fVDoLDpKCOD4JHI0HFvx8766U5PpEx6C9ZRwySA2ytmsf6fRKWhKeIvbFWWlXu3q44FB/TbKLBDeHey3WwmgvQGicPpy7uX5hJDdTSo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e152baf-9163-411e-bd06-08d7f8cd36af
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 12:40:56.7238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpyEOUTaIVwd81FKYUZqDWuxLiaV2cecbr8hAarDkHYjj4kwDOl35FA03TlFmBmUS7jMw965xdO4kjVVSj9W86sYrks9ghV/HN0UGaTfFTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
Received-SPF: pass client-ip=40.107.15.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 08:40:51
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
 stefanha@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, mreitz@redhat.com, pavel.dovgaluk@ispras.ru,
 den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test that dirty bitmap migration works when we deal with mirror.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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



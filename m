Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5296BC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FEE120714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="r0Iri2La"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEE120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGlco-0002Os-9l
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 11:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGlbn-0000aN-7X
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGlbm-0005eC-8L
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:36:51 -0400
Received: from mail-eopbgr70133.outbound.protection.outlook.com
 ([40.107.7.133]:6087 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGlbm-0005br-0h; Tue, 24 Mar 2020 11:36:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQL6I26j9PYQeJBn07pnY5rzVclfxl0GKtYgZAlv5hDKB2w3aP8/GmqYyqfVgzoCe9QxztYfxDLe00kTyQduPsYSDWO+7Stjjt2a1Iu8I8KgY8L5M8eQ5dr7GmWc71qNLETVSuIH1Z62dhsuuPrHRL7M4gWYJY/vCMEAydu1rUkHoCbQhJ0C0fgsuEwjI3eXoxYxsXi3QhXeRIZxQnonkfsCOSSII1ZRbYJ+3oxkZQie3qQbjXNDd6RYD+lx0OHsmiZRV2xQSKz2+b4wvq/kR3gjOkXiOB4jTWZwWB4UyXBJlXxS79zvvexNnnaUunFRNsv1/+fE8ClHDAMeCaNBgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYBMXaxkWtGuXY3v1HX6eWulhTKmq4Xs2iCFQb0SZAI=;
 b=XqW0A69t+bxdy3cSKJHMjF1wajmRaBgG40i3EjP+NwTZ4ldD2Whp7grlp99EntOZmGWZTh16Wx8RVZIpZ5q3fg8P1Y5vJ2uMrteYUihXF5x5w7rOpWcav9G4ofxtfw8cWd0BR4a4NOj9elm+fXyAzT2akDrjjdi6efo3Jliv392eeFLZpKMDcvuVubutCSJ/M2hW64TZVKV5Dw602JIWkQ8YduiOzFWNQ1CkCA/7u1o3d/BvTfc/3RtZpN0wu6lZJ4i3/KtHwCjgWqWRk1zfAAiffaxuO8aiWhujFUAEBosd4E2tDW+Y8I87b9UdvhmwuUqjRCmkdZCU7tYck79z/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYBMXaxkWtGuXY3v1HX6eWulhTKmq4Xs2iCFQb0SZAI=;
 b=r0Iri2LaO+DPXmzc7se+Gwwfw4f5vKCR7CGLjeEUY+5x8iqBAYxBWMY25QaJBLMkSkLflGvwkZNEtg1L8+GGqCYzVaSbjDn/waj1qv0uCC/OkzWmQngFsE1HUhFuDVC7VSw44hYmWtAZJqXZBU/qrx59xg6OfLeLVQ/W6hw8dgo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5336.eurprd08.prod.outlook.com (10.141.172.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Tue, 24 Mar 2020 15:36:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 15:36:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] block/mirror: fix use after free of local_err
Date: Tue, 24 Mar 2020 18:36:26 +0300
Message-ID: <20200324153630.11882-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200324153630.11882-1-vsementsov@virtuozzo.com>
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0401CA0062.eurprd04.prod.outlook.com
 (2603:10a6:3:19::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.15) by
 HE1PR0401CA0062.eurprd04.prod.outlook.com (2603:10a6:3:19::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Tue, 24 Mar 2020 15:36:47 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39839de3-f2a9-4685-5a37-08d7d0092aeb
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53361412D2904AF17AD7AB55C1F10@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(366004)(376002)(39850400004)(396003)(66946007)(81166006)(66556008)(5660300002)(4326008)(66476007)(2906002)(81156014)(8676002)(16526019)(6666004)(4744005)(107886003)(26005)(8936002)(186003)(316002)(6512007)(6486002)(52116002)(36756003)(6506007)(1076003)(478600001)(956004)(86362001)(6916009)(2616005)(7416002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5336;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bEFh0Go9C/6nWS+sLxJP5kFP+XQRqZCHX1aS9ZRy2HeiZbOWOY4kp/I6fNd7DxQz665qYV7kZJZ0mpAHRbX5PIOA8KuCbslkHkzVrGWb/yl9T4oHsc1RY1PDVYIiqVn+btUhB1g+x5BaRf0qc8IIlQwet69ugs3UY7F9Ci8t6lDxi6nibrzSMx9QaoNCIrdnLMkV4AIXy1K32GBFSmegPcpRHFJP3MA9JwTyoXGS0h3B1uqZHzsjHoG/LSGo0NE3dDjPyXNgjRbc1P0Gz5M2cquMdNS62l8vY3tGGnskPN/xc7RLRWzeHkYQGSNfPZzcKu8UtLhtJqlixktbNPIoLhtd/Ny0nEdmXJvfigZk9R9nmKhCLXB8Pj9akQVa0hJtvIhXWA0BuVZDYZ86ZyO1FDbVQ/BLJyViNycDn/EM5krzIwfniwTBanNFgZhmE5rJ
X-MS-Exchange-AntiSpam-MessageData: 9tNFkZWk5kOEwExTyGZJSKoadqLDIOWbYo3Xz9XZ1tAy/zDcVJxNbBjJfK7k56SNFrNMN/HRQ5JsVHx5PIDhpFlPQg5pBkxpf2HLkPv1mKv2c2RUXI6/cVgYAvRm1HDx7Y3/JhWOhq5F4B+qZHwJmQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39839de3-f2a9-4685-5a37-08d7d0092aeb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 15:36:49.1774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIkppl9WQPdVUe16gyvIU/cGnW4LMOdw/UeJhzYRayhAFQi+ZRXlZfrJY8cPt3jaX6sFfTTJI+HjC2qPhL/guzv2SQ+hknwCed5uZjahdRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.133
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, zhang.zhanghailiang@huawei.com,
 qemu-block@nongnu.org, quintela@redhat.com, armbru@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, den@openvz.org,
 marcandre.lureau@redhat.com, jsnow@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

local_err is used again in mirror_exit_common() after
bdrv_set_backing_hd(), so we must zero it. Otherwise try to set
non-NULL local_err will crash.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/mirror.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/mirror.c b/block/mirror.c
index 447051dbc6..6203e5946e 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -678,6 +678,7 @@ static int mirror_exit_common(Job *job)
             bdrv_set_backing_hd(target_bs, backing, &local_err);
             if (local_err) {
                 error_report_err(local_err);
+                local_err =3D NULL;
                 ret =3D -EPERM;
             }
         }
--=20
2.21.0



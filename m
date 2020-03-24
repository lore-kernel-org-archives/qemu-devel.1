Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8CFC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F262073E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Kmv9aW5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F262073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGlfa-0008BL-Iw
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 11:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGlbq-0000bW-Fp
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGlbp-0005ht-GT
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:36:54 -0400
Received: from mail-eopbgr70132.outbound.protection.outlook.com
 ([40.107.7.132]:20336 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGlbp-0005fj-8y; Tue, 24 Mar 2020 11:36:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlwvjhpSs7bvGbHVUpc/V5OY4+FOCh/H3eU/1KmXuswciLED80QLty/JJxklysbSTrGZsMFNBw5r6qGvtm8RebYAEj0+wai7nXH7HkbAL6Vg1S7Ab4zeld+PlKY5RsDhPJUJhqPEeHC/kzoYHzVHB7uFJI5wpzxVbUbdceRsOEfSjBUzQyfIHk8u1TFsQ8orO6GcCwLWFBKStZ6TAO+WGv5P4vpFGcuSPUwc12EXlACnM73hrqtz6gWIdpHhtFvWr0bTXsbC+3o78Mbfxm4LFgce0/ozQEKlbL1IVFlS7qKqJpMS7YRH9+p9FQDac2offQTNeQtS4YCm8YiQCzPJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SlD7INHF2fuHGL8EHihFCP40LyPoL2LWIw1mPvnZH8=;
 b=G166tZNyo59PJImbcNdVsImwUQ8Xq7dkcmMq5nq+B7s+uTZzsqyfn02iJEEAGUGf4PHmcBlC3bHyeFYFtyAD7dPZFELoGIX2m6rom4l+QS1qxDjL2+Zp1yE7SGqE0oK6DP+fzdnTY4TOcw3She76VNABOdQSiVVXsPcy37IB7p0gy3MBQukMIVLbgI666YJtPBNXEYFj88taxdiWBaknWa05eRs5dmTCpNqceZcKlbPq4D3aVvDhvPcKOF6BH6Tv1dd68+FD5gj9YamsUac7CFp205+tJmIefkVVyuFXSfcBiUWB+OfKDFPqOPIM4wSiRdWivJnablYOwiML+hndNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SlD7INHF2fuHGL8EHihFCP40LyPoL2LWIw1mPvnZH8=;
 b=Kmv9aW5foC/h8USrzcmykfcaUicvPRCvY0HZuI20ZQE2/o9wdcXKtZWlJHtYFdaH74dFgVu9uJHWBjpCGDV0UmE+2VPCgG5fv9Ggy6YEcbjLPxy8bNGNE/Ug0vEZ7oMM/GrjU7rDvNnhL4vYTln0+t1a86uh5ABQzqlnl5gU8Gk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5336.eurprd08.prod.outlook.com (10.141.172.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Tue, 24 Mar 2020 15:36:52 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 15:36:52 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] migration/colo: fix use after free of local_err
Date: Tue, 24 Mar 2020 18:36:28 +0300
Message-ID: <20200324153630.11882-5-vsementsov@virtuozzo.com>
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
 15.20.2835.20 via Frontend Transport; Tue, 24 Mar 2020 15:36:50 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8eb99ad-7b27-4d2b-dca2-08d7d0092c9b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53369DFE62F6925A82A249ECC1F10@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
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
X-Microsoft-Antispam-Message-Info: hjt+QYJ4UwAEK/A/2dLyRY+ohKfA0mt4c5BkSF+jnB6sxMarSZ4dND5wVT0KXM2ms/CK6+e74Z4tFn0MC3vtnheZtS3972A9crRy7bjq+P1m6QVFIGbnukDu32ZUZkeCxqYpooGjZn6IWV3Z28yuUK0/csgLPae8Mu1RWF/xV8y3KjNeqXCbNtS8wcx83KGpD+cCbRD/6a4P6C/jwA/2SwBa6Hru1urzd8Qw5pE9KgaoTRjrIX2JFxCrXQZpmRnF1pd0PA1gL/EJB1bB0qmwUAVKWQZ7FhkKAOrtq2kMlHQw/rGMXGaicEHChBM0e5a3oCcUTPf4TQXgIQvMdyMZLW6fuilLDH5kWhznMb/1ROYOO7apwqPrY1NFhGFllJU8HC0ipLddCcTxUGcYXJSZqkiK8BhlJ3/EtzNRbkt57ltiQB3iwoufiHeAPbd0Htun
X-MS-Exchange-AntiSpam-MessageData: ub9PlDHY0UkzBL8IODtRG0406M4elNTof15X39qUbHJtt28WhQgSjXmYgJ1GLI3tBTiLIDctiUIzfHcIUPnWUgWcmAjfmmtkQU+S9HYn5q58i3en+wYcJ3MAy0NM1QvMp2o4w4ct4JX3Jkz3U8ULKw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8eb99ad-7b27-4d2b-dca2-08d7d0092c9b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 15:36:51.9821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfrdLEUkI038cWm+sR01ow03c9D4KB+DoU5qZ3ETpiyjVbZNhWHvRq6SX1w9X/f+Bb3glGWmArfosfXeMYgldecU0n1zBopOJBARAnb6WUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.132
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

local_err is used again in secondary_vm_do_failover() after
replication_stop_all(), so we must zero it. Otherwise try to set
non-NULL local_err will crash.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 migration/colo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/colo.c b/migration/colo.c
index 44942c4e23..a54ac84f41 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -93,6 +93,7 @@ static void secondary_vm_do_failover(void)
     replication_stop_all(true, &local_err);
     if (local_err) {
         error_report_err(local_err);
+        local_err =3D NULL;
     }
=20
     /* Notify all filters of all NIC to do checkpoint */
--=20
2.21.0



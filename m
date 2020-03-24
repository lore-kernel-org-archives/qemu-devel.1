Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0829C41621
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F35220774
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SUYIsado"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F35220774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGlcv-0002eI-JR
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 11:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGlbs-0000gj-Ok
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGlbr-0005ju-N8
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:36:56 -0400
Received: from mail-eopbgr70127.outbound.protection.outlook.com
 ([40.107.7.127]:12801 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGlbr-0005iH-EF; Tue, 24 Mar 2020 11:36:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSrOqIv1oGbOPcFrvs4XvVPodGl6NElHkPe+Nwo/GMqE9mdnToY3lnLWlvnEnykjSzP/adl+PhvMF3aGRkgnWfdYEbE+IpNma9Drc1BBfe3F/oy8GTVHif0h1HdyoWvmYVu33o8845KFt5Sc6LpmNFjp8LxfKBwD802I6vzIfOO7xKskumMIx6YVPNI+nvirM/HJs0uG7SwutK3eQQ/IHcgyJ7/iIkwPGWoZuQpoR89doC84J9EPIfsbP/6waJnvoUfCeUqYlNxITTbqt6FcWt0RMzDljFqQ6yz0gsKLwFgxstBSriYSwHvTXx4S1Gjn5U5OjphHFpgN8ZRv4jprOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ9ykL5Eu6wTJhnMicriYMBQcLEOE7O58yzOYjdgtcg=;
 b=hzWraIgEQPib/49zXLMe6JmJJ1koXpkeeNEI7XW12UFmPM7BkjedEuUvTEq7SBZo4ApHXwL8TUKvCoS/TxhdngGt3oSP0VhtJMvL8cONFWS2xUWAPCvOVo2Kt90w7bvVr3WLBUOmDU/73vlCEZNgMaO2CG7cD69iIZ8fgj2DcDBPLP2Rqwb4qz7NtkG98xar7lmrbR+S/YttAmm1GEyvJpC95GquJS6CdJ29y5WP2Lh4gL/E9c4K58sdN+NTWgea49UQXCF/lpSgmxQIZJPF5jwN0RdbzMNGBEXdBew0d+y0jKr8ilqH90+25t1G2O3rp6xTol6iQMmA/4JdR2iFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ9ykL5Eu6wTJhnMicriYMBQcLEOE7O58yzOYjdgtcg=;
 b=SUYIsadopzIjvszyULbjlolp7fXqEJyhekPzV02GWQnHSR/OA+7gk0jnqCigO9CDWGQdYCfIGSXzJ5rFkdyXgiEHVSV3BnGifi4aTsITwK1IbdpcV4n9OHxyYEzUTgVpseM9y+q9V0O0aPXHCYxst4gsp0eaozu6sF3XzoEOT4c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5336.eurprd08.prod.outlook.com (10.141.172.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Tue, 24 Mar 2020 15:36:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 15:36:53 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] migration/ram: fix use after free of local_err
Date: Tue, 24 Mar 2020 18:36:29 +0300
Message-ID: <20200324153630.11882-6-vsementsov@virtuozzo.com>
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
 15.20.2835.20 via Frontend Transport; Tue, 24 Mar 2020 15:36:52 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7339a7e0-51f2-488f-e38a-08d7d0092d73
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB533682E7CCAE7C128D1634E3C1F10@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
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
X-Microsoft-Antispam-Message-Info: P1mweofcacsc9D7xAbokXlu1rA6cRzzPT+oOHgtklNquPfMKTUG9lIa4CI37Wyq90sCkfPQaj00eLZmyHMT2rxjOUWnh+WREHivFpXuNCW86b4oukD8mpz2QrQywsYp/Dni1G28o2RQz47akHlHJ2F2f61HnZUZIW4yKStZ9bfv1TX9zrQmC9sHzBkeVq8CJwrTwchYjk0DKWtvr9XxxHiGUVr3FO308Y2FG6soHxbPntVa5ROrlmrvxZ3m08ZjhTDxc+HIYWXV0ypAdu5XkNTTFVGPOjfsn2ozMiZwyTo9heNeDe7gB7GdkME3SWQ6p2J8JrBQI3Uxf8eZXuytFZ+Tb/019p3aFEMfaTLL/duwOn8wA1iODRemKLoOzju0AlpSeDurtUvFeYhOtrmx4sr35t+iBxQdrUPwSHnH5P/eS6qzMd1FFZmr3zVbGjO+C
X-MS-Exchange-AntiSpam-MessageData: AefSAE1gSJrMC7KREGGRmXwhITCTfCbS1dZhRmgjXHWxShsZ98LgbvyJSRGzFeVHnq6ErYjUv0y6RWEIkXgevi2SfT5aTBUZo1B4jq+NaHnBuSnojvdPN7fXilgvLvmeqXBNvQ/nRi7Upe7u2vwlUg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7339a7e0-51f2-488f-e38a-08d7d0092d73
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 15:36:53.4128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nctyixmrp8tDQ34MoPMq6Dz+KI5kPueYNOeBhgalBm9W1+Lex2DjDTT4oaDjiTL8Tzdd5UdppdVX3nZZGKwRZZST1Bhs5arQ3gvkP6wyXRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.127
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

local_err is used again in migration_bitmap_sync_precopy() after
precopy_notify(), so we must zero it. Otherwise try to set
non-NULL local_err will crash.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 migration/ram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/ram.c b/migration/ram.c
index c12cfdbe26..04f13feb2e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -980,6 +980,7 @@ static void migration_bitmap_sync_precopy(RAMState *rs)
      */
     if (precopy_notify(PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC, &local_err)) {
         error_report_err(local_err);
+        local_err =3D NULL;
     }
=20
     migration_bitmap_sync(rs);
--=20
2.21.0



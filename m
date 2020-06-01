Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A286C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22AC32073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZHdk2Fqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22AC32073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfp6S-0004Ik-9S
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouf-0005LM-4j; Mon, 01 Jun 2020 14:11:53 -0400
Received: from mail-eopbgr70093.outbound.protection.outlook.com
 ([40.107.7.93]:39047 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfoud-00026c-Q2; Mon, 01 Jun 2020 14:11:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6q7eIRtXjm6FX5PzSVDcqv/lPuSoLtoPO+2eoTwj0gOd6JtvLGkPbxEkVwVP3kKh54aswpuNSKY6LC/JdlMqJKADJFwMYFEKJaFe0A9SKN//DnPrg4oFF9+Pnl6YK8DyEb2xFJi/hUojz3s12lUHUtyY26z1ovAouA0tHub53xNHqF/DLDY9Hud7Gxq5pryOMkTfFWGUFNHrzbU6KRJJIix3c2rn+1H+kEBkKIiuZLttB0suIUxZj/QFmdu5+JBxNhbZaURDXIYpShpJgd5kKjn3DBC1veyTVRL5BxQR7Wt+DBt8A82zdjl6oDQZohiXY6esQbSDZ8E8KMl34mKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEmTw/MGWdYe/BXRntGy32gBtnGzhZ0d0m59CkgT4Ts=;
 b=NUuDjIwO3k2gEKahMksBpOADo2BOWsXWS9ut/CsujgzY/1oE1+3iQSmlY2tpkg7z7dMsdtUTf21ULKO/b6TGamW3CaU9Csr98YoiMgt2bKDfsAJ4qmM59L4TJHmAQrrjr0vP/4c3E83suRhK/3DkgRux0hRwEkmXRY7U/PNDwF31u87Lm6CO+4WY/R4l4TczXTYa5iif0KFBntVhIundgQb89CWkAliCjAUB5T8wOPpKdTm3JZlBVeUk09M0rZnxWVznUOiEkX79PvisQ8YJlbOhSfS9H61SmY2PXgnAMwTwXZpI4XeWPMCKZLO2FFYOJNZBb0ZWd0DICnx9UvhB1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEmTw/MGWdYe/BXRntGy32gBtnGzhZ0d0m59CkgT4Ts=;
 b=ZHdk2FquOqS7MNLAZe0fKZT6CfEWZXyrlite7n/rdPIVmWc+iLaAbFxXYltr4PxY8boi0uhe+R6/gWCA9Yc8y9tLJZxlEHc2J2W6Du60bNwchL2EKe7eYRry8echHBvf1lYXlJVCz97vKM9NMPhDscRtrnNTZO5hSUJsn7AzpHM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 18:11:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 18:11:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 15/20] iotests: 219: prepare for backup over block-copy
Date: Mon,  1 Jun 2020 21:11:13 +0300
Message-Id: <20200601181118.579-16-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200601181118.579-1-vsementsov@virtuozzo.com>
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.170) by
 AM0P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.18 via Frontend Transport; Mon, 1 Jun 2020 18:11:43 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 591ccf68-4fbc-4d3b-d80c-08d806573de5
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5317249EED290ED6D8A68C86C18A0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RxQmX3/121rD/onmRuckNFR00ifDBFkYDkccieMhQhBpl9szQV8QjRBgDAB1qoomkW1eAtVWaRKWdUA7iAxY5uItn1saGfqRwQRE0tbYvqFKSSis8TRnRpNKeF6Ik3mBV8n+7nMT6mUqqDCJrJa40Gbflp0G6ITn1mf5/Buyhrdu8PfNB6we0sjWwBGMi6cvt3806ZBXaFiV7ica/WtMDD5HzJRM3c6HPxrSsbmA+ObGIxYnS7HBvhvMsBHJYSjuv6zSTL5iA/kIBRCkS61ln2XhsXltyRTu0sakfqHCK+WBktV0FC2vqfdIDpsxd3/v8iumSyR9N+Nn65Yk9BeBzTEpJIcCI5F7snRAFIcVTbV6m4BTnLDEX2qGQ1VT9ocG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(186003)(16526019)(8936002)(2906002)(8676002)(26005)(107886003)(36756003)(316002)(6916009)(52116002)(2616005)(956004)(478600001)(4326008)(86362001)(6486002)(66946007)(66476007)(66556008)(6512007)(6666004)(1076003)(69590400007)(5660300002)(83380400001)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: S0JYWNkhnxplrMjSC/9LZeMSRLrv6yD36TyeZqnryNl9xlyEWM2Czw6l/Hn0tvpjY5KcaVjRlRgfFCCnydb0ZV5813+tIbHAMaEkUlSY9CCbLA/GtTvxpuLFrJxlIfM7pT7WDrkZcu9hRwCV2lbhAD63779qCGEfUPfxv9cTWZSWQGXxFL3Ub4mfZAdd1/8Si7FKmSYOGBtACyKm/VhaNl/Hq8sGJfo/WBqHH6fSMunwWydAUx/5zBUJQnYbn7Zh+o64WR/UHLaaZqs4sRC5nLQwtv4/sGHJKwwDuIBOyy7sraNKriBkoR0p5ZkRuIJEYm27Sepzvu/HuDBx43Cosh4KaSDzNWDL+DXhD4IkzjXPRIPNbCbumrk7PGH44Q8d6mTHOr9Msnmx1uFO7OQVUwt5fmMBNJrg3aZvqsyDOzGPEMzMr1jAEeL+RNfRiREHFCatRU4HPqaM69WM1EYTu1gGEsRt0iDrfBbDe80iS9A=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591ccf68-4fbc-4d3b-d80c-08d806573de5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 18:11:44.4763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlLPgy5hrjVNEhq8+tmzmusXQT3O2GJpeN/fG8IAnZI+22tTRarpNOr6ZWzaf+tMvZLZ9BQ5kAfhJy4WNqAZu/Lf2E9Fk0LuWIOXaA1qcpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.7.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 14:11:32
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The further change of moving backup to be a on block-copy call will
make copying chunk-size and cluster-size a separate things. So, even
with 64k cluster sized qcow2 image, default chunk would be 1M.
Test 219 depends on specified chunk-size. Update it for explicit
chunk-size for backup as for mirror.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/219 | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/219 b/tests/qemu-iotests/219
index db272c5249..2bbed28f39 100755
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
+                'x-max-chunk': 65536,
                 'auto-finalize': auto_finalize,
                 'auto-dismiss': auto_dismiss,
             })
-- 
2.21.0



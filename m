Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55713C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:47:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E21520674
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="b5yTRGbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E21520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytMC-0007KY-7m
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJ9-0001bM-74; Fri, 24 Jul 2020 04:43:59 -0400
Received: from mail-am6eur05on2134.outbound.protection.outlook.com
 ([40.107.22.134]:63329 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJ7-0008OD-Fj; Fri, 24 Jul 2020 04:43:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIUkExYo6K0VGzeR7d5eoN1DqHNM1J+m/2cWCkhCnqQvAT+zJu5sxpVcIoNmdUD7fxZvVKSeZu9UUFssIQ4+QM35n8umFYWHq9eCUWIOGE30tY9ZCpNiqeAYeVOdt61kCDxA1c4rm4ysjfKwWkKW0yOOxHGOU5WQVjw0t0Kt5dzg5PGIXzqo3HdOwZ2B10XcoEa1YHvHbkZ1E33OhMlXDjxygEbID9Xb1xLRgXuzl3YlFS9YIKhaBlhRSbQw3QgEBMMEwrCGlA3OASsqGvM/WF/8RGdCQBqbFdZJtHHeretf+QTTEkWGDBPo+bmVDNpoS5J0GXRRLFUc7hrfZQPNxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mxrv6VHSCBvfmATXPuwKnZrLPO+yfUl9uzJeH96iVK8=;
 b=f1AtSW8+hsUOfPZyIH3/p61f2CLeA939SGGI8ETH/8JBnLtZMRSlVxpxW1dpMMUwcq52h7k7BegJioA2M6U+y4EuxSGTnsJzc6ZDjRk1MwnkggT/U7DDm/xn+DhP9PbcjiTnIu9R6w4uq3PQZQtkmqFOgT6I4T8NE94ZJl5wXRqwHAIRJi1B3qzLB4cStw2BaAe3Msf1c53L01rvltTd1GChtTQRdPjxdrDdBOxdeyD/fA6SGHj+GDZLo2jC+LfcOsCFEOo9FKa89WnYXzXCcMVChA9LYqEtqhcOiQFQbH2fdMyTbVWf6kcj3uGtwxh0eBWSNacLSJRV9vPirW+/8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mxrv6VHSCBvfmATXPuwKnZrLPO+yfUl9uzJeH96iVK8=;
 b=b5yTRGbWArRxrczAcbYRTrP1a5hmaDEC/ZA7V0XF1n6vrrsaI2hch7kwi5RvWrpRgpB1dOn0ik63TVpToAvswKGWm/m06nbBFP9CVMyrdNB/fWCR9oVxNp25YN8t5UptF/RwEXhKb9XOGqIxnMzFul9qCxQIzxqb6pIb4n8bVDg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4534.eurprd08.prod.outlook.com (2603:10a6:20b:ba::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 24 Jul
 2020 08:43:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 08:43:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 07/21] migration/block-dirty-bitmap: fix
 dirty_bitmap_mig_before_vm_start
Date: Fri, 24 Jul 2020 11:43:13 +0300
Message-Id: <20200724084327.15665-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200724084327.15665-1-vsementsov@virtuozzo.com>
References: <20200724084327.15665-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0160.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.156) by
 AM0PR01CA0160.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Fri, 24 Jul 2020 08:43:48 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78c55da1-0797-4d88-aa15-08d82fadaf7d
X-MS-TrafficTypeDiagnostic: AM6PR08MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4534D9E6768DD0D4C701034FC1770@AM6PR08MB4534.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vnCscGU3m+3/DBzhWyn7XsWjMv1s7AILC93Y+XTXw+ZYx3GFdhhhBexGo8JzfngOoesV27j0hrp6Dwimvaa2E/Au6vufbm+ggO7dB4m1hJNBtnnoI6AoSmmICEfTiqmzhwB2KQndOYcPZEZhiIePZxnn/hsb+ys5Vu3Ov1KRT1PcwWAPQTX7SZHBCEuetlYhfXPNfwACk2l+6QtZqoDIEe3oRaucbqEEScWLbv7cRdSrDfkBFarNkgaVtkxqUzjACftDislCZzczTuRwR9jkThYaHlj/Fap2mnyf7xQuUhKYjMlLDV1SOC3+kbnuKs9dzseobXQRDE1S+2AEz6nvnD3t6qrpBQPLviZEDlREgibROpKRNYqiCCBCPBeZ1hwO+0m0mRoIH0a6gNnJWkDuDR3ORySadeDLJPnDCXaJ1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(396003)(136003)(39840400004)(376002)(6512007)(6916009)(66476007)(8676002)(66556008)(52116002)(66946007)(4326008)(83380400001)(6506007)(36756003)(6486002)(956004)(26005)(6666004)(2616005)(69590400007)(7416002)(186003)(4744005)(5660300002)(478600001)(8936002)(2906002)(16526019)(86362001)(316002)(1076003)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: iHBBwnnPJ3nthMz2puOE+fE5xO1BjQcwt5+lNvW5JUOY1y7RzPToUHfJV0f9qwdUbZLOK4uNxQka/hljKpEnUKM2WlHMHgRmPG+ublriOGXiDPDkAAg1AYojOPKTFxXlWPkPJ1HCXXmYpFKEzmstx5/bs8KG+W9oAyaRE94ZQGUN6JQtK+wqfupfdVs1IGyxG+Do5/AwTfrKWQihQnkBf5VYJj95aFQRPpjObBfATGVOv13eN1FiZXd5wcmrsD6VeqrOtcfe/aLRIMfs3muJ/07wfaE+M7wzWS1+Ep849MirBECRFOSuG3pHGLxOZykYi56Nt4ry0XrQTNx60cdhq3aF0drigNfbxtMrtM4cpC2V27TQfK+xB24i1Ik7Vecbw5CLapZ6VMuwe2oitinu1uwp2Ym615Fryxv3gb1JJ0hWokGaOD2TjSsIeK4I9ddWFE6vxgdaDR047j+4M1bwyuGcyQyjN6zLbKce2kz+ajc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c55da1-0797-4d88-aa15-08d82fadaf7d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:43:49.4325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7zlZRDPOub8k3JSfz7rFm79STFY1pvkyjBryXi/IAdUUjLWyVztb+uEECgd++G6mQNi1akszWVBbxXp90IjbdFak5qa5TyivdC9ShIzI0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4534
Received-SPF: pass client-ip=40.107.22.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 04:43:47
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
 quintela@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 dgilbert@redhat.com, stefanha@redhat.com, andrey.shinkevich@virtuozzo.com,
 den@openvz.org, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No reason to use _locked version of bdrv_enable_dirty_bitmap, as we
don't lock this mutex before. Moreover, the adjacent
bdrv_dirty_bitmap_enable_successor do lock the mutex.

Fixes: 58f72b965e9e1q
Cc: qemu-stable@nongnu.org # v3.0
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 migration/block-dirty-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index b0dbf9eeed..0739f1259e 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -566,7 +566,7 @@ void dirty_bitmap_mig_before_vm_start(void)
         DirtyBitmapLoadBitmapState *b = item->data;
 
         if (b->migrated) {
-            bdrv_enable_dirty_bitmap_locked(b->bitmap);
+            bdrv_enable_dirty_bitmap(b->bitmap);
         } else {
             bdrv_dirty_bitmap_enable_successor(b->bitmap);
         }
-- 
2.21.0



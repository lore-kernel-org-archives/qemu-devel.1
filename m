Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DD6C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99993221EC
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Z1BZXyHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99993221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLB0-0000rF-DW
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJL05-0007PX-Kz; Fri, 18 Sep 2020 14:20:49 -0400
Received: from mail-eopbgr40122.outbound.protection.outlook.com
 ([40.107.4.122]:8096 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJKzx-0004bq-2l; Fri, 18 Sep 2020 14:20:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U00POU5+R4MxFivxJM+qUoYRUaytRiSG1+MAypl0bK4PyY20uGxJrdTozccKbbxmMppP8Iejmjv93zIX7Z4Pfk6GOQOm55NHMZYi6+Ud/4cV1UtjMesPlc+R5JNbzvu4sXkCOhV0M8Yg4078EiIZpnabe0DSo4usrnzuGtbrxsEY7++JOUA5TKWpy2BCmKAyJJe9SXDuuVQXu5GP4o08pQhEV8V/B/FklaJHGHLV7+yCyJsZQbzBdCBPelccbwyP7M/DLIMFZUeDaEe+kk8iSa0Rq3QSmNfL70OXa4odTwm6RlmFbPa34UviG2OxUFbqsdXl5W+itzDWSff2vzcWhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHUGkqGe89HhWhkUXB4TbywcCFFX9NQ/duPuWlFW7YA=;
 b=ktz1Z/KF2ECbFkoR3HUNScv3mfckhvMw9RWomGEbrGlLYiSsOSNPGzke4I2dH9B2C4S3EHQMhVWhdA+Yd0yl9sDWyOY0yw9cd9qX5pEOhVztYK6kuQTwS+uHnjyPKvLZypemMxf7pmFnb3X1mWZoQMr+wFif1IfG5O11blFbn+7lXvLHeTm2vy9URk1kypkgzI1fCGmLSRy2WmpyGuhJMv8SP/ByIUMJNAAX0Ik88+EJ2RBVIZlvCZx+GpZP7Fl6t3KkZUV0g4BOqNGBF91L6GV5Ymu6WkbacHU/kRQaADaF30GDIe88RXcRScqbEOFyJb0BDdPIyvA96M1PmoE+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHUGkqGe89HhWhkUXB4TbywcCFFX9NQ/duPuWlFW7YA=;
 b=Z1BZXyHyBWhJOsa1qBXsssrpjnBfufb7doSpClN26yaP65htV1aqq5erEqwiBaMfeVXMHlG70e2BKOy91/dqW/Z1ov98IMMgZ4cWP2IIUyohjbOWSNno8dGYsssCD0RV7cKX2zaa4lrwGjf6uNvxHfOCQiQnoGjeE+eCx8O18Ko=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1905.eurprd08.prod.outlook.com (2603:10a6:203:43::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 18:20:12 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 18:20:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, armbru@redhat.com,
 eblake@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Subject: [PATCH v6 07/15] block: bdrv_check_perm(): process children anyway
Date: Fri, 18 Sep 2020 21:19:43 +0300
Message-Id: <20200918181951.21752-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200918181951.21752-1-vsementsov@virtuozzo.com>
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.106) by
 AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Fri, 18 Sep 2020 18:20:11 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 443c538f-6aa1-4318-e0f6-08d85bff7b48
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1905100F9A3EA429ABE611C3C13F0@AM5PR0801MB1905.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yiQkXFQIIg7sxcYip+y/WeVwlpeFuShZhI7/MJb+mGZCh3nrMd0GuncQ95yYR1RWkj9JNQQC9J33wXg1Qr1FJKCbhVkCGubYaK6xZrVKajHFBUtZ2ZVLpA4FYoKPaYv6DKAHuD74zt8q1kdaeTIbM0mz/poHPSOIFN4DeaK5YI8AEwOqq9YobuffOLN+Di+Oq2Pes/PR6jmjmO+1/a9GKGsB5/ZNtI4S9li/fy9Eddihn4iFfSpOCvjtIfTtZB6s/GNzCZveyfCKgdGNSFxBAxUTb+w5r6Y4JFHjysnQRdQqcZX9cs6Hpm6XJ7DHU7gqKb03nxzD4B4vjsTGcEpYpIs0Oegj+fSsmI7od7/lujw0PBegjcULeuXovZb8vOs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39830400003)(396003)(376002)(366004)(136003)(346002)(66556008)(8936002)(66946007)(66476007)(107886003)(6506007)(2616005)(5660300002)(2906002)(83380400001)(6486002)(956004)(6666004)(1076003)(186003)(8676002)(52116002)(4326008)(316002)(86362001)(6916009)(478600001)(26005)(36756003)(16526019)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Qo38O5+2E/ztE2Z6zNtxrhoskQBl1jgOSLM78rrtLc+MzqPJCfS1g3w2zrN8dhK4GBfPiQoOIXCCKTyfLlzyIGSYO8P9WqF8MqUbhcS8XMCXB+64jtscvWD45/pflugtAJ45ngxz6lhKH+l/h8fDfvK4blY2sh/fb51OuJQLTAEl5ReFPdA/KERHAq898o58QPes3Dme7dAw/qHf8O8ARaOeLyV+j7/nNvIuM+GMqfeHsbxXV2Ns5IhSRgQDENuSvPsKr8Ea8v6+u5GBvWY25a3M1q+ZAdB0NFzf23ZkW2AAm3eXUGEWBztCAFCVzu10yXR5Zc0f8sVe5Nh9W8FdpNrEu04lWxic6oWc68Zsia9fQf3N0x1M3Vf50PyK2hhyHzszzsqXfB1rTa0zZM+siEsoS/5LrSRgbH/aLPBU0yPTfVRvJ5iOZBgJFHnhGRHvpFrT0xoJP3f4tH0luFqEchY7SdEAgBYa8GDXl1vEJBn82pgjA4u3YBsVAGDRntwLFSYGnp1PpF1DHha9mML8O7WtfCCSyo1a2GsnE7pHzL8xbbrCuGJSRKWtp3KmclJ2qrVXqDlpjVvS7T/tcUYRaqxEIpYX3CTuQmyATWcMHIxNCsfwH2JsWCgxFCm4ePqpdxGFm0q9aaSfqqu/v+xgvw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443c538f-6aa1-4318-e0f6-08d85bff7b48
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 18:20:12.0975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2sBzyXCJfVhM6DyB5o9eHHUL3hkj+BTSOKGbwBCGwDikKIPLrgbuOQLIKzT4w3WhxAWupvrG3GbnWjcRg/+mbz9n6aZG1ue73+vuWupNgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1905
Received-SPF: pass client-ip=40.107.4.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 14:20:06
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

Do generic processing even for drivers which define .bdrv_check_perm
handler. It's needed for further preallocate filter: it will need to do
additional action on bdrv_check_perm, but don't want to reimplement
generic logic.

The patch doesn't change existing behaviour: the only driver that
implements bdrv_check_perm is file-posix, but it never has any
children.

Also, bdrv_set_perm() don't stop processing if driver has
.bdrv_set_perm handler as well.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index 9538af4884..165c2d3cb2 100644
--- a/block.c
+++ b/block.c
@@ -1964,8 +1964,7 @@ static void bdrv_child_perm(BlockDriverState *bs, BlockDriverState *child_bs,
 /*
  * Check whether permissions on this node can be changed in a way that
  * @cumulative_perms and @cumulative_shared_perms are the new cumulative
- * permissions of all its parents. This involves checking whether all necessary
- * permission changes to child nodes can be performed.
+ * permissions of all its parents.
  *
  * Will set *tighten_restrictions to true if and only if new permissions have to
  * be taken or currently shared permissions are to be unshared.  Otherwise,
@@ -2047,8 +2046,11 @@ static int bdrv_check_perm(BlockDriverState *bs, BlockReopenQueue *q,
     }
 
     if (drv->bdrv_check_perm) {
-        return drv->bdrv_check_perm(bs, cumulative_perms,
-                                    cumulative_shared_perms, errp);
+        ret = drv->bdrv_check_perm(bs, cumulative_perms,
+                                   cumulative_shared_perms, errp);
+        if (ret < 0) {
+            return ret;
+        }
     }
 
     /* Drivers that never have children can omit .bdrv_child_perm() */
-- 
2.21.3



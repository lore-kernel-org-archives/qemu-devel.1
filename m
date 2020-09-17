Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF162C43464
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CBA2065E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Nnmulu/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CBA2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ0Ck-0007Cr-Gx
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 16:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00k-00032y-Ee; Thu, 17 Sep 2020 15:56:06 -0400
Received: from mail-eopbgr30122.outbound.protection.outlook.com
 ([40.107.3.122]:56995 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00i-0005tE-Dg; Thu, 17 Sep 2020 15:56:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAtHGQg9GopdwvvdmykW/+zd6hd7YdatOn4giViHUiwdCwJoJUYh2NtiNkdXoPZzYpkFSvIIj3c36NQyGIk822htev5yL83Rvf/XHpOvAhcQYWYTrz/JlQqLa2CaZsvblOYrpH3r2WpWYqs+jxK0F+trrzp9ivJN6nUkLCm+LhsJvwPUT54GgsWoRUkIHF9xY4s3JuPjPNU9eMWcPuf+aipPsvDs9JPZ5CFZTONjIAi/sTH5XuhbKSDTFGTV/OPNVmW8EUXZPE23zfjlI8GdywJYn61Gw5r8Um/2iFPhfBuOAb6sJgIZoID0ncRuu94w31EPU0kzu+0QMFTj8Hvp0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qwss/iVZ7aLV9PX8IZRjKZkV6AnQbKhHJtGE8Dkw4Ig=;
 b=i5V5TYBVMJv9pivlR3k80ycGIiW+kPyWdU087hlClg1piwkmlDB3NT3n2SV0b0qlgLY4ZoH1jI/YfyFWYgSmxRv0Bg8H32SU+N6YQUTnTtwUA1WIQsL36/EIc3AB54T8mq3kFPpneW4aTd6p9zEBqRh7t5UviZ9uHbLy1zS+iHWwSr2aj7q3A5ftH2HupBqwpAVnf4ilfn++AYHAv7HdqHP25+w5NOKTKNk4ilSO73K+J06KI8tO+cP0Lg6kKmrtMnHpEOeYuuOS2ea986MnsT3WNd7d8Dky64QddnVNbDZYlTS5Q7bi+h8dWn45lR8tGVEpzI7Czp4n5FVKufh0JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qwss/iVZ7aLV9PX8IZRjKZkV6AnQbKhHJtGE8Dkw4Ig=;
 b=Nnmulu/hLkB1lQhrqfZr+VtfyjiQQtbiOSim5p1MdW9j/MrUAs2D7Tg3Q9McrC++s7V+/XKymCM/RnGTy1aiihVLYn6dHxVuX+/jK1+Y1XWeoznjj3N0z4RGhZgUv7yB+A/TkoK9Uqbx+kR+6QLsEaQLCNmU727xUQtV5b5Y2Wc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5254.eurprd08.prod.outlook.com (2603:10a6:20b:d6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 19:55:47 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 19:55:47 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH v2 12/13] block/qcow2: simplify qcow2_co_invalidate_cache()
Date: Thu, 17 Sep 2020 22:55:18 +0300
Message-Id: <20200917195519.19589-13-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200917195519.19589-1-vsementsov@virtuozzo.com>
References: <20200917195519.19589-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.75) by
 AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 19:55:46 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38485a10-e946-4e1e-066e-08d85b43ab85
X-MS-TrafficTypeDiagnostic: AM6PR08MB5254:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5254C3F7418E1647E9BDDC33C13E0@AM6PR08MB5254.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4v85kKL7ZA+AdsojagGevtN2HMEbW7dm5P2H+Xnuzn1SwYSCmMHUPtync00rqIHHgTeiQlGQ4nWvRZQwSTr9xYWr3oxuzDwQiobjZNe5++rL7Ajym66KWc92J489jxBgtcS+8BshT06HsDp+Zz0TQeAtaBJLmze1PT9bABr3Sp1nYAQmx5sMlhTEZJ9fb6ju05d+6hplfh/j4BG2n2QIJrVjAcCvW7oLRbm0TpXqfyvmLBDaK0v4MOmA1UduWCbnhKYCC3OVQIkE3T8RRVczha5zI8d+RXeQqtpnkbWBrQ69BB8GW2XHXGWmEnUSxaWLQmk5KkfoxE4r0adYHHIhvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(346002)(376002)(366004)(396003)(136003)(6486002)(316002)(6666004)(16526019)(186003)(6916009)(8936002)(8676002)(26005)(2906002)(7416002)(52116002)(6506007)(478600001)(6512007)(4326008)(86362001)(66556008)(66476007)(36756003)(66946007)(956004)(2616005)(83380400001)(1076003)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dTgwHf14N470V3S9YJ7xCLd5ibxtoRhT5qSLSP827IToE+FdsI63DpDkiIDs790YJHR7N7hjif1uMY981q948rX5g8A8prFZuftx8eSwu5AkgQ3kDbRxASndehmNrrFJidFpyFnPOrxN+A1QxeNi4r+8pkPNV8jXrl7jx065voNwudX0NT6ZTLt7TsHPKlFamdCdQNtjokD4a3k7M9c467dnQ/tTdHnLgG0kaRII341HYtIJ2eArSFpqoeVGYtdsmc/bR+dScOpxo8I/Jnp7Or+9vQ0jtMI7AioiQNfR93zx4q6pmF/9xKIcux8FdGf0c0EQ+VjGIT4aGqy992GGCPCYiM4wJW4o4gPg5PSY0NDofiqdV+hvI5NzHX3JN3Tgykf6Zko7vAyB6U3NBSU4537IsGZ/29pa0A297d+1m7MoeyaeMDTqu2fKZnbFr5TR/tvilchr8ax2eBekb7kV7V+GhO+CMoXZNhaYFjpu4NnD0S0spOmiEnx8MTwbchTFMjl9ZZhlSEXvcTf9DIMPIhV+B0wG9vJjj2VCxrjlFXyOA0JPSFsq6Ao+RXZqZXYTBho0cD2X/C9wEUlw1qew2DlWo7sA4JQQgY3rVJGRTT+xA6cOH0D5+OmnCct8afNNVhA94/37VivW3GUXOo4AoA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38485a10-e946-4e1e-066e-08d85b43ab85
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 19:55:47.2877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzDRf+q7IKbA3UOIgf4ChMGx8dNfCa/peLQebBTm6W4gtPO2cMveBIAJSrDmWXzL1xMjCtkgCbuwiYDdZ5RY82+JIZ+xsUcUKwo/okFJJnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5254
Received-SPF: pass client-ip=40.107.3.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 15:55:46
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qcow2_do_open correctly sets errp on each failure path. So, we can
simplify code in qcow2_co_invalidate_cache() and drop explicit error
propagation. We should use ERRP_GUARD() (accordingly to comment in
include/qapi/error.h) together with error_append() call which we add to
avoid problems with error_fatal.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 2b6ec4b757..cd5f48d3fb 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2702,11 +2702,11 @@ static void qcow2_close(BlockDriverState *bs)
 static void coroutine_fn qcow2_co_invalidate_cache(BlockDriverState *bs,
                                                    Error **errp)
 {
+    ERRP_GUARD();
     BDRVQcow2State *s = bs->opaque;
     int flags = s->flags;
     QCryptoBlock *crypto = NULL;
     QDict *options;
-    Error *local_err = NULL;
     int ret;
 
     /*
@@ -2724,16 +2724,11 @@ static void coroutine_fn qcow2_co_invalidate_cache(BlockDriverState *bs,
 
     flags &= ~BDRV_O_INACTIVE;
     qemu_co_mutex_lock(&s->lock);
-    ret = qcow2_do_open(bs, options, flags, &local_err);
+    ret = qcow2_do_open(bs, options, flags, errp);
     qemu_co_mutex_unlock(&s->lock);
     qobject_unref(options);
-    if (local_err) {
-        error_propagate_prepend(errp, local_err,
-                                "Could not reopen qcow2 layer: ");
-        bs->drv = NULL;
-        return;
-    } else if (ret < 0) {
-        error_setg_errno(errp, -ret, "Could not reopen qcow2 layer");
+    if (ret < 0) {
+        error_prepend(errp, "Could not reopen qcow2 layer: ");
         bs->drv = NULL;
         return;
     }
-- 
2.21.3



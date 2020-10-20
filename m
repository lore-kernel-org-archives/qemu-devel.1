Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A06C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:15:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA2922265
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WiV57fDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA2922265
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUrUA-0008RP-Ba
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrJ0-0001op-6X; Tue, 20 Oct 2020 09:03:58 -0400
Received: from mail-vi1eur05on2136.outbound.protection.outlook.com
 ([40.107.21.136]:23328 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrIy-0005aC-7u; Tue, 20 Oct 2020 09:03:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqV1MVYlyTFOv/ytPZRvkW3eVzA65cx8SdShwlr5PBB3zeed1hAnFhMzFmDeSyeuMOnJ8nqhD23wm+GlC2Ut07r+SXpeMut5+TXaScRd+rC/YLxCYQUfnbpEMYLADd6u8q60GzJvE8so9EPsYhY818hZ9tm/KvdMYDBWIZu/b7VeDCi3D+3VRbGm+0viQXOosI7t9l+O8yHxwXSIzGuG1/3eyM3XOYiIccB+/kOFm9ahW8oEBr3unncfoDeeFj0abocYmrrrVO5YUxCZsT85dwpx49FCYH56gfGaNSjO61otJctH7Fs0I2upF+ht/bkjInWTRcvF6ZeFus6U/eEK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP8RMQTp6N7zerfZfVM/iIM3BAuZsUJ4N3aLrbyGI6o=;
 b=fKbVafPmRrNFzBK5KW1OnKy/qWtJ3LY8y3xOXrF5mLzRVrJVkGorsCT/6Ypfbl4hGPxt2JQBpwE7ZANLg5/heDVpxCIz+XFw76BaDCoQqwoKKm7Q7StFzD0k7+TrpA2JdPyhk8varDjAU7+PemdwxWSubndgtA3QSGBIqT5ucMNP2pZxUg8oiYvtu3sFASnl3uiHdaTGEuVmIn8UxCd+BjIQB6fXvixG2pK5iiqqOVrRzyu5tS4Gj19WvkC9LR96nR4JZ2Tl2Hcs5JoBnZHWxbR3uFQhBxLHE055KxKU6MxvIc8CvpBHpCc993XrU3fCuDksLmLI4febum42pZjgHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP8RMQTp6N7zerfZfVM/iIM3BAuZsUJ4N3aLrbyGI6o=;
 b=WiV57fDT1Imolkb8rlTJkWsHlnlhkB4f07a+C/M3oW3O65f7ywk0ONjp5edKPhhQxdd9DdJc/CzhHi9qZXKjtkRw+TeA20lJm2/llH8S7HFA+W7y2oCYxo3weMMkTCUkGdkjxhQR7Ge9MeGi8J+0kZ1UIKzOjx9W3JJmTjvY2bo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6168.eurprd08.prod.outlook.com (2603:10a6:20b:294::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 20 Oct
 2020 13:03:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Tue, 20 Oct 2020
 13:03:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v4 12/14] block/qcow2: simplify qcow2_co_invalidate_cache()
Date: Tue, 20 Oct 2020 16:03:09 +0300
Message-Id: <20201020130311.14311-13-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201020130311.14311-1-vsementsov@virtuozzo.com>
References: <20201020130311.14311-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.66]
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.66) by
 FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Tue, 20 Oct 2020 13:03:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31e1ebb8-5667-424f-4941-08d874f88faf
X-MS-TrafficTypeDiagnostic: AS8PR08MB6168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB616883A6BF265E64915E9206C11F0@AS8PR08MB6168.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cbmTAyRLRXrEG5aDpZEdyTk8R/aeSy6f1PyjC5nWdvnqTla0btzYPxPxBd3lBFAhqP7EOCfoltOighGe7qjfT2J6CA2ZdAbBtLL6ORDja4e8AX/kDeTIVbeQ6TahPCeYmXnSrlaGGy6/Zxud0lV5kin4XIDMAXt053AkfLLbepZnUqwBmRGLmDuGLssNu0FGU7aMv+V43EjCBwM0HAMc+VOkiwoBkLmdjJJPCnHBR/VfRO4RUyFyJj8J5UqtM+ar8egCTDDDt3DsBcZWK7fEPWnQOvBCuKOlmR0NXYdwevKSUB/ZOJ5K6F1xX8+n89D5tkJMSfsRUA1ZZH8DHxEimw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(136003)(376002)(346002)(396003)(8676002)(66946007)(16526019)(478600001)(8936002)(186003)(5660300002)(52116002)(6506007)(6486002)(2906002)(6916009)(316002)(83380400001)(36756003)(2616005)(26005)(7416002)(956004)(1076003)(86362001)(66556008)(4326008)(6512007)(6666004)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: YIXB62AgdBF1IU4652SZDQhGHmxKaJngMzfr6C89JoRLw56M8BU8u4VxY8e6rqPt++pHSW3VJwBrXNeXZPtlywlt+LOUhKUkfT9xx9BF6/P1DvqrE2QziHOnFVLoiJ5GX4Pz5Hl6wnkMcxYNwwY7/ICt5uD59fk2K3f+mwwaD8qWS6ggw5UFwDFTrZZD9fcJ06AOZZ3qB43qFY8M6h37ZmOk99lOEzKwEKGHCPZua+Ryb7lwjeRlehz//zn+UtgF1P5BcQak5C8LVjIfzJ3LaGCvzwP3BwViXSvhD6hklwYyIW1q2dwPugEV87X7KrJu+sI6VEhRVWkz64h3CWmcceYmvcwk7A12iDSW6CIZHNePUFkttGnW4BH05b9NZfcRRQV02xP0KPQN3lRZw287Upim+oSXSkRdcTvxxr+j+cMNAXGB8i408DF/LNdPOI6tGnx4vyHHCYt7N5cbrOtoSh1Zu4oCwEFnoEkWl/kJjXGjzUFgt1sHELHcdeUivQiff8PgOB8f3m6eQU485vBj1yieKI9x+s/RSgS7uvEdRlrQ/m1YQIr/rC3Ts3vkrJdeYqGt9WcbOE10pfPdfJBo1r8y+rTdml8c7EVaZbHmCTbSryrxIINNbdfEfDY5VOtTHIJqAJxYMguf//CIQOj9pA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e1ebb8-5667-424f-4941-08d874f88faf
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 13:03:38.5928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ya5G+urHz+vP7BnZAvWDHaRfMHnLTiww58vosd9aP2r44n+jiR9DDCLy0SK3vOdZUFifWt2ZoQV/HiwEI6B38nMDPma67QZefjHjnsecRnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6168
Received-SPF: pass client-ip=40.107.21.136;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 09:03:34
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
propagation.

Add ERRP_GUARD() as mandated by the documentation in
include/qapi/error.h so that error_prepend() is actually called even if
errp is &error_fatal.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
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



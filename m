Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153E1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 624CE20E65
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="j9cQAjHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624CE20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTTXC-0002pb-DN
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 13:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGa-0003Y9-9g; Fri, 16 Oct 2020 13:11:45 -0400
Received: from mail-eopbgr130103.outbound.protection.outlook.com
 ([40.107.13.103]:44775 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGW-0007Ot-Rt; Fri, 16 Oct 2020 13:11:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0Sj30RanSh8JADNiAZz5uUYZqnU3XpdWmXE4a/iCHpaP5KpGtlWOdrb2Kkfh/OUc4UWIun1d90cjvO97tq2n5+scKz4s3H/JoJrtitAATHfHKBNaPiUCm0k9w4miq28igbYSHaTqmJVTG7GwLDGyRN4ezfd04ry7n8yVP/mSiI+gP9eHsOnRnEpZrTSd4cjFF4iLRfzi7CRxD4IMBCQ8pKYujhyfZLVGQAK9MPBYUb4/+O9LXYcElLtmMsGT4P9pRtlfWDrQqfuNgIzGfisixHqRImMu/sboM27aPcBhvlHCjbrzpisJKx0heMGVHLk41OkL6Oyjpry3jHgitUxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP8RMQTp6N7zerfZfVM/iIM3BAuZsUJ4N3aLrbyGI6o=;
 b=N8qnJy1isoGzy8mYZBSyF6uPOkETTsxYDbuSc3dVnqGZ3+0RnXwV4JOoYPTZz/AjzUTrVhoEH4Xoj9MSvOlIMbg4kFJm7COchsaPlp4VnxkEdbOFKgXlHVmRbQoxgIL5hq6iqB7YK6c9cQGmi8qmlzJcOyv2IRPejsNOqKIlABszV4HRabjd0UL2gap+3HgtSddybzUr9VUIFwek/TRDzoA4sDKbOQy+CJZ5kCzZg9jrmngXTHV2SQ1BrahcmfaZZu9dqCzOiGuCFwMNpTQvn7Nb00tWfQLAsrSedEQdKiejrGNbCtzILG5Z12zPXbe0g0QUf9oDh+d8Pm6QmvyOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP8RMQTp6N7zerfZfVM/iIM3BAuZsUJ4N3aLrbyGI6o=;
 b=j9cQAjHyivXbCOC15BgbuOdmD7hT3C4/lm92Crp78KfBvmhMVoL2ih1Cl8x+bDyniRU1/JHh912wleFN7UixNm+W6bZ3Y9A5d/uK2SrATjqVFB2bzsbFyhm8MGZv1UWWQS3rOh7ZBhjiwNcAVIkz4H20/jsu9Jwy2HON37PPe/k=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Fri, 16 Oct
 2020 17:11:24 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Fri, 16 Oct 2020
 17:11:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v3 12/13] block/qcow2: simplify qcow2_co_invalidate_cache()
Date: Fri, 16 Oct 2020 20:10:56 +0300
Message-Id: <20201016171057.6182-13-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016171057.6182-1-vsementsov@virtuozzo.com>
References: <20201016171057.6182-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.69]
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.69) by
 FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Fri, 16 Oct 2020 17:11:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c06b394-a888-4a13-3609-08d871f682d5
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5495690864802DD40DF0D4E2C1030@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5rNhEeI5EU6F8yv1PDzOjk2/s7GvlaZhM4MkwHaQ9HAi2HteEkhojmDmuiZQMhnGxMyLQlDowNrDQFWYt54Eimjsv+Sl7FeFGtn/1t5viwCzZ9Q2FoE64EsAAbqCx5Nb2TAHzCkoHOSMN1P+7n9DxPjvpzBOf+boDHaMdP4B7QzCau0qqixm5dwUg/xL2+QM8KhJzmmnoFyGmBhtetzAMaKaBqWpEPesC977r1S1ugp3E4RM7K4mMDYAARrlOdLt9Sw/KnyikOmX1XgrUbpxG+AYrN3gZ28wZ7811mF5klEVIPEkulbFvncTw6K1GB+ysBGYsQMts+qdYLfLzrOB42lXtAb/rLH+uFR1vO6u8c9kab1TAMbnvax5sIgp+sEB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39840400004)(376002)(346002)(136003)(66556008)(316002)(8936002)(36756003)(26005)(5660300002)(2616005)(6506007)(66946007)(86362001)(16526019)(7416002)(6916009)(66476007)(478600001)(34490700002)(6666004)(186003)(6486002)(2906002)(52116002)(956004)(83380400001)(1076003)(4326008)(8676002)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: yzZfAqaRUPXXolSGsnZXCR43mOGm4zfogqAI/xqnmQRlwWh9Uum9Ag8y0Ajt1yOAYv3k462QrzfhbGsWMW7ZsutSMIYsMeNz7XZjGQbKb1iR0lpcAQ8qoUERvZyNMMvgZMfWdPG9yO8yEEq5xdI7lYVW2q8XwZrWzT6LZDES5TLtF8OK2HEY+4w9sZ70M+/vjrFs4aAyv8l3XU7kwUXPDSy1kFxlwkVEBIxd8V4Ko0lpx6I/RW/XXEUyPnS0e5ydXDtvjU0K1JZyMfuIAeI1aP+gP8JFs0LwnhPGRPG1U9SgSl2GwtOj+QVh1NBu5F1e6WJzzibd7dLoOsL6QnlOSvnw+KFgEC8obkhaW3MngBo0HGYqK8gM4DwXT+nJ3ZODas8sJ649Z3I0CoVDKnibT24nHUSBZA+tELPNZtYuAhiOFXGqqjW3fVu2j360/J56/X19HifquwruyF4eC8+s6j7eo6dtL2F6eUFn+VbDCmImJNx33r6oCC9wyNHakIkUC9iWG5B6aNtbUAkIbLMyhb68VpxR8DMtrfTn624RyoKvnDbQPhNITlH7TsYVpmK+NzBT+UnFHUmdHXojRlskX/MeJl2dGtNflaCYIeZgSJn9eSgSZF3aNQQiM+mx4g17wSVRKZVTXR1vpUtHPnWBJg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c06b394-a888-4a13-3609-08d871f682d5
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 17:11:24.5114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xw1vuAA39b87nzpMybh0jVEPrD9ofYH11QHpsgRU8DYAIPsvlZv4/4LTGnXwu0O424phG2ZuA8UBJ59LPqWDNLalT2JpRnD+w8Xw7yFChfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.13.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 13:11:27
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



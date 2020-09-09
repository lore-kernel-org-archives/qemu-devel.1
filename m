Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B99C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E44A20C09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vUPgHRJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E44A20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG5Pu-0002RK-M3
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 15:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5KG-0007H1-Rm; Wed, 09 Sep 2020 15:00:12 -0400
Received: from mail-eopbgr70097.outbound.protection.outlook.com
 ([40.107.7.97]:14387 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5KB-0001M1-C4; Wed, 09 Sep 2020 15:00:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWG5AnNMS9NRYo8knccG3kiBii6kK6i/Rj+2TKypsLGW5Cn0Og163C1aZ7M4orhV1rl5LBLcn33pVnC8XwHjMEjbjwNix/Iy4bfyyfjdSoZhszUya0VD/bFjnNiBxxuT1BP5niPSSU6BOdz2TUXNxBn1jbLda7hn0smDXYaLPItwwa1nyj18IRgP+FTmSZNK4SLsJmEtCYmgzlo+QgQYTi3z1aL5+7nXm74m7v61mEjrSLjS6EqjrB4mZXi41IO4d202Z0LmLqyB/jusubru/zDHf+nVatH6GBm3sy8DN2QaCbsKYt2avL1ZEvNCXd6OBr6fM2ixoeiseXxlHvZ4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuL85wcEsZ+6kWz/akHPCGVdlhyfs3rAadrkTKWuzgE=;
 b=NfVukdob3/bxCtvvhoqN8OQA2Ovg5tRMv3SXVGhTpnP5o9QW0Nwos6Pit3Esqahc6OpJ5qsuE7/ITe4LkayFbSrenmG6aYHiLKN3UykT35w7bszsFX7b43g7UIATAPbMjQzlQ64y9sZJS0CTVxr7NVbjXvHjhxaj+KFWMwI4OtEiowOF4WOZ6IuoXtTkoZVoCNOI73kgE7Q0z4lTqGzt8HKc0ISSZ/9NlC7usZwgyaIZQ0uqEyZ0X/0TGw1Yja0+pU4hR7w2RrGWzEsSiFURDbkAr+VoPVA4Zk5eNoaCH3P3xOUFPz/AM72Kd6krccURdaGLjv7Bj1ADQV5ho2Sn6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuL85wcEsZ+6kWz/akHPCGVdlhyfs3rAadrkTKWuzgE=;
 b=vUPgHRJ8VCoL5nSySZfCokTb5Rx6B97Ibv1Zy3yDNdxUtB0Xb1T4l65N7VAmRUGLU8fg/DwBDLeaYpD/1fWFRNAw8ME4rDH2sIGJXQUImtq09DILS959eaDJyPiW+A61cNLuTdig1zzGH/A1V198mioBkimur7qzbNJmrN/kosI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3445.eurprd08.prod.outlook.com (2603:10a6:20b:43::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 18:59:57 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 18:59:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH 06/14] block/mirror: drop extra error propagation in
 commit_active_start()
Date: Wed,  9 Sep 2020 21:59:22 +0300
Message-Id: <20200909185930.26524-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200909185930.26524-1-vsementsov@virtuozzo.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0054.eurprd07.prod.outlook.com
 (2603:10a6:207:4::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.136) by
 AM3PR07CA0054.eurprd07.prod.outlook.com (2603:10a6:207:4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.5 via Frontend Transport; Wed, 9 Sep 2020 18:59:56 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b79b850c-6da4-4af6-b88f-08d854f28b75
X-MS-TrafficTypeDiagnostic: AM6PR08MB3445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB34453E76B86436ECFA74CB1AC1260@AM6PR08MB3445.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:268;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QKC5J2lGHEa9qSI79ypaZQqXhjA8mCMhnllL+LwSa/As6YfVb4QeLaGxf0kZkpopc1yISklNdeb4VIFQTNgvBRJP39NJrTjyFJkNmwywgxyCSR6deN25+GVptebC5/Mrm2addzmF5i4sxKm25Ca1TDtVUypbV+QDo0EkEi/amIsKYD8nB0gobk37osVyzmzMUV6shSTZzPoVe7mrd50ZZbXRmPxTyA3/qdHqxHPcmfQv2QidDCowFCn3mWMwCDvsNLlmC/0FGOK6VpvUb83AsRXg1yfjbBiF44d65qv+FJiG2RVbSFyWyZ/RaCu/JwTb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39840400004)(376002)(346002)(66946007)(52116002)(83380400001)(2616005)(956004)(2906002)(6666004)(8676002)(6512007)(1076003)(86362001)(5660300002)(26005)(36756003)(6916009)(478600001)(6506007)(8936002)(316002)(16526019)(66556008)(186003)(66476007)(7416002)(6486002)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: wzu6FxRN2KrZ69GaNKeaoFeLP8qK3krL74e0q7molEqLdvblyJAt21uM9arpgfagn0yQfUrlNKhZc93hA2GyWY/5Ln9W6A8NjNyIq5LtCc972hO0UvCPnwmKdXuoUEhafLsIrvTrRFKRgEGh4NxzVhojL/aOjGK17Dt+nSVDZjK70yA/Owiw+aGTLC0ediyIh5GJlhBa/uooku8j/yWBXTs6lhOLBwB6EERjJqj9MxTmUMivpHpicEvBIu2pxwp2VZv8rjhnQ6Z8hF7YMTQJo4bTTRxPTIx7Ck8fUo47sPjC3g41ZHojDaWNYkhda1rSR5+qgXOx7toPQzXamFfC2We//EOEm+ySbNIp2x2Q3ch4EWglaDoYqV2fd1wcHJceCEaKsNZym0tLTZuJsWJDI1tdZ7VaOOVN1HYV7upe2jscFQqrmMP38E6YEXAmNhwXASgBlm/vQLvJR4A49xMpfqTA9scxUxURE2uCdHDNLuF/6zArCfUhOg/H+9ozicLDUf3nsW6iA78M2z4x6lt2Y+lDGctIcB/ismsjjtAxv8VbgBBAIV8WnzQv/f6zIQF9f3HwAMDwi/Z6KA5JU61hiLAlnoU8oxqHWegmjjD1xDoMvV9omcMmiiFrc5wt9l+6NdfpcmhHZvQVasnMWXdh9w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79b850c-6da4-4af6-b88f-08d854f28b75
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 18:59:57.3134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9SRh1XpZs784TSJ33rGP+oaPaAO6YpqBklA6jsLZL8ARr9DbNJdd/hlhzOY5nEy6KQ+BY5eOX39kdDEuA6R4+PxzJChSt67KoStPBlLUAy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3445
Received-SPF: pass client-ip=40.107.7.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 14:59:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Let's check return value of mirror_start_job to check for failure
instead of local_err.

Rename ret to job, as ret is usually integer variable.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/mirror.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index ca250f765d..529ba12b2a 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1788,8 +1788,7 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
                               bool auto_complete, Error **errp)
 {
     bool base_read_only;
-    Error *local_err = NULL;
-    BlockJob *ret;
+    BlockJob *job;
 
     base_read_only = bdrv_is_read_only(base);
 
@@ -1799,19 +1798,18 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
         }
     }
 
-    ret = mirror_start_job(
+    job = mirror_start_job(
                      job_id, bs, creation_flags, base, NULL, speed, 0, 0,
                      MIRROR_LEAVE_BACKING_CHAIN, false,
                      on_error, on_error, true, cb, opaque,
                      &commit_active_job_driver, false, base, auto_complete,
                      filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
-                     &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                     errp);
+    if (!job) {
         goto error_restore_flags;
     }
 
-    return ret;
+    return job;
 
 error_restore_flags:
     /* ignore error and errp for bdrv_reopen, because we want to propagate
-- 
2.21.3



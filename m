Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514ADC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:10:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9076522404
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bXkisl/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9076522404
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUrPf-0002g6-Gn
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrIm-0001Ua-2G; Tue, 20 Oct 2020 09:03:44 -0400
Received: from mail-vi1eur05on2136.outbound.protection.outlook.com
 ([40.107.21.136]:23328 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrIk-0005aC-1D; Tue, 20 Oct 2020 09:03:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TISWG4CXlNmVU/DMOtPaKhsC5bCPd2ijlnHNG78UZeqOAdxEKEHpAM9sgJImz8FHO4KSsvuQf+k3PC2MkOkFiLwLz2uq9ibDfypr39k+ybAjdC1/iVeJSXTz8aVqI0MGTAT0EEx4ESSPr7NujEtSA6XUozGEadCgabPdJsIzQOs5MN5lhSEF+cXEmXAQ4LVgRA/wB4Nxe+15qTrUe9E2Xvr6nVxhxLTs8StewQPnNmr5KSdq7VCEq6IOu9pWn3t43NqN3zXCompvUCcRemtsm8QaRtDCs+vs1A85v4MZs5Q0vrPTb0kgnRDQFQ7HhkDlm8u7Asy4XGafUH8KbKeDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCFLgn5Xww5/RSYpUvMtPBR8is4a2W5v9OGtAvqZfyc=;
 b=D4NGNQbBi+gjYO/MJrfB5alYKjg688HzhQfumfIIcdDwMuaoZYBjpRhGy/PtfbljR6UJTfWQqoSAjKa6KGl+eyT6FSEEl5rqVW2xVPRtiMYB7/WgCRbUJNAhLVWF5hGtO4V7nENhNhHctm1+KW9spWyYJzHFDWRecRc5O5I6ayrZDYsZhosJTFXmJQjubl399W5VJutRze/7M8PtdADfrPKt3ai80xOZ/Bfw5Ep/D1x7QqnDm2l62HDRuUVj8v9xlnsTn/YQQNVfiA4/9ZOTH3HCHLBSqwPQNO/YVm6LxhoQdtmzVlsFgykSGJxM+xEXpbOjET/f57bN8TuDE1XKWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCFLgn5Xww5/RSYpUvMtPBR8is4a2W5v9OGtAvqZfyc=;
 b=bXkisl/37FLYRSlTTqiKTpxRgDkYBDfifRB8HKAIMuc2cp24xS1S7HSCq19Y93hbbjddv33eYfQIAsbD0i1CfU6G5ODvX/KfSV+bSbJuSyasI5rf5iC1PYjxEMLnlBojETV3gdOBMjXeyBi70OWOhXiV0DzyQS3SR9sZMqwy6WM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6168.eurprd08.prod.outlook.com (2603:10a6:20b:294::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 20 Oct
 2020 13:03:32 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Tue, 20 Oct 2020
 13:03:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v4 06/14] block/mirror: drop extra error propagation in
 commit_active_start()
Date: Tue, 20 Oct 2020 16:03:03 +0300
Message-Id: <20201020130311.14311-7-vsementsov@virtuozzo.com>
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
 15.20.3499.9 via Frontend Transport; Tue, 20 Oct 2020 13:03:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17ec1096-3cd5-4e70-96f6-08d874f88bb3
X-MS-TrafficTypeDiagnostic: AS8PR08MB6168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB6168E4B2F71EB3589A6073C2C11F0@AS8PR08MB6168.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:268;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gWkDfo881d8V/deGuHM4KGsHx+uQn3GGw6VxtD3yGRuUFsE9AO9tY2Hp0713rO1tbwULHvkGkVmgpztvEKpBa1ajXvmKfJGLH2MtClDfYC6Z1Oa7Rg8pBHjwQT9rUNY3KfgM30rL8urmHFmAHuKU1aved10WgmGONaWi3mOq6CVsQfityMEDF7Jv4DIo1XcUQrUL7AFtBpBOXuQnh1hPwkKq9BpisAoD0QAepljFEgxkBQpuz3RPWkPw/NhWCNklgZgAE2qN8osme10+i7OI8KZBlTaJdItSOVmsg9eRRj4Now9xfsVu4avrM33kp8ZI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(136003)(376002)(346002)(396003)(8676002)(66946007)(16526019)(478600001)(8936002)(186003)(5660300002)(52116002)(6506007)(6486002)(2906002)(6916009)(316002)(83380400001)(36756003)(2616005)(26005)(7416002)(956004)(1076003)(86362001)(66556008)(4326008)(6512007)(6666004)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nSfzUsRYk8sJIiEyRYWfl/6C2ZrWuncVgvh+g3jvJl17P9s785IrE31UugcWs2hivxdxoD95h5IaJQgFyfPi9GU9A91VcyJgT7WK369cPYQFQVjboeapFJvrA6hrHwukNj2l7BPbAGlBX1dkmH0PWOpmNWWzyeIRogR6KMvjL7RA//kzS3JOsKUysDPDQKCoPCWSBaHQO9WO1MUbBvDi2nKo0NxiqMfNOP56xuL67Jtq3gNBCs/cc9YbwetZBkoz0vJNK6TVkVJfacWIWjemumKvA8rQS4cXcmDNtt7sLLPenv3PVoz+/aUwp1bbi29UZkqQQj2TaOX0xGIElco+1xIllJZLhfeQyg3Akb4etgPvHplZ6zVbZkUg79m1PBq2caMMGxe80bK9PK7taFCfj+M4NRqH0wgSh5F+0E60YVHovjL+9lnRIshAWet0yHGiYuczIEWHQ3NMcVvMPnTBiuZv/CifBiPRqK+iFEMmMyDNzfRe4EQXni/nKFAyOp52VDVePAkPIfTTGUmb+jSRg9DSgetl2nvTOJZ0jKqMm0f3O68TItRvU8V7dCqww9Hq8coDGFDTF+zhSE1uLoZh9ywEZP9MsuhlGDSAjIDjgvKq74m3Qk4EON6zHlYhuluOj/Lchny/gOK25v63hTTelw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ec1096-3cd5-4e70-96f6-08d874f88bb3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 13:03:31.8962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxeJeJg+W07BUxPf9WrTLfi3ESSWx+1t3nBkNHRyDNRj+VP3aWB1r1pNh/OjeQ4p2cSkIRbJsdCc64hIRV6/S15djeJX8eReDj8LJcFdCrM=
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

Let's check return value of mirror_start_job to check for failure
instead of local_err.

Rename ret to job, as ret is usually integer variable.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/mirror.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index b3778248b8..f7c624d6a9 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1851,8 +1851,7 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
                               bool auto_complete, Error **errp)
 {
     bool base_read_only;
-    Error *local_err = NULL;
-    BlockJob *ret;
+    BlockJob *job;
 
     base_read_only = bdrv_is_read_only(base);
 
@@ -1862,19 +1861,18 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
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



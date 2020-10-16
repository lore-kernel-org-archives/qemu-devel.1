Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E480C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0734420789
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dGmHDSbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0734420789
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTTTO-0007It-W4
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 13:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGO-0003As-Ft; Fri, 16 Oct 2020 13:11:32 -0400
Received: from mail-eopbgr130103.outbound.protection.outlook.com
 ([40.107.13.103]:44775 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGL-0007Ot-CO; Fri, 16 Oct 2020 13:11:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORfHr1W5HlF0w0q46CK7cjCCGwLvS6/JpLm3hPkprzaKhCNqgZxRFyhkNnpaJtyEkLDsBsFg7Xe0JMvrvUmmAUH0uL9VTrUC+Edy5rEy+AF7Ya0Tj1J+lO+TsqeFFzaX9cj9HL+sSvxVgkO8PoEHqI2byH38DkiQbPT1CuLMbR519j/4q5Rpkfyx5+wnBUdISIoF7fww49Zcqwtf3dxtpqGrz7YCshchYEsNchFk2LT9j2mRjUqvbPtn2bmIfk11hGooAMxPNrln7wajXDgOnVQOxNoXvkQ9b8WcD/1hZgtX4ualsHj3awLyIzZ65o1KLmYaI3iLEakWmq4zVyI4DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCFLgn5Xww5/RSYpUvMtPBR8is4a2W5v9OGtAvqZfyc=;
 b=bDW4PLE4b/4LHZqS1Bkr3BhorquhgfhsBfcUuUWuesU3Gx8wiCHgX0Lw5Gz91gNUbMKs41DT2ckyShdohbfBBLLLUex0wkArlK4ddtHqiQsfJqgpsWl8ouTWITqiKbK+g7LUJd0ScwJwz8il5AjNxgoZQZbm7kRjTXsqDdmRDns8IxNIl16hsLly+481nnKiGhah3fNQCLQq8HN5NJsOZhCm1mK3vBOzQ1PChsU1rSZj1ORFOZ/6PjqQ3bgC1ZTkSAHAQ1CoFid8E/6AM0Gpg6FT2ALm8bd3U7JGY1iNol1H3I73e30AfI418bvHs87WGFQawwhTA9GPJA3dwi1hUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCFLgn5Xww5/RSYpUvMtPBR8is4a2W5v9OGtAvqZfyc=;
 b=dGmHDSbhwT9B8wOemVdSB45buNqvwL4Sy1cTufXGx5W9L0cfuX+m7ktxFuAKHAyXpWbFUR04MvjAD8GrqRJROMEwec3Faf3krj9qrKqWzjR9Kjw5pSmYIETQPedT2LQlT96/wfghxdp1yeSaKVgc9NRDzAs1ibvBCdJljGGXCec=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Fri, 16 Oct
 2020 17:11:18 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Fri, 16 Oct 2020
 17:11:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v3 06/13] block/mirror: drop extra error propagation in
 commit_active_start()
Date: Fri, 16 Oct 2020 20:10:50 +0300
Message-Id: <20201016171057.6182-7-vsementsov@virtuozzo.com>
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
 15.20.3499.9 via Frontend Transport; Fri, 16 Oct 2020 17:11:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e9f38e9-8333-43b5-627f-08d871f67eef
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54958471A01D302D7E87B33CC1030@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:268;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjlbEZORebCf+z8MuTN4Hb+S4qeQfP3nN/URO4DAC2NGf7eWXJQ9KvFNDTZxSHPBSIpWrv5xeNknTX7iGMAadvJQZvOPWhTwk6WF55Akt9nC0cCUo9UFEKfblQtNCW96kIdtg6wFiBi4WNWOQQ9vJMdEPGhtz/IcE8Bv+yHk16gyD0TgurOotbR6gx3VVNvCL0/l1gfVgWJOc6jvYcxL/wjQLyiaUSVJf1LSD8cFuBjzOw0zWRHS8vzACpgZPAArr9+Vk7Jv9cnbv4hMh16SnPU/3ruS+qw6G9v7GPiLw42n2/7NAGTg4BlRrw0FbOQjr6kc1jj22Hc1ckERaH/CRfuE578q8UpU5E+z/ucTKzzXFftYkqDDzOncDpmT9GhA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39840400004)(376002)(346002)(136003)(66556008)(316002)(8936002)(36756003)(26005)(5660300002)(2616005)(6506007)(66946007)(86362001)(16526019)(7416002)(6916009)(66476007)(478600001)(34490700002)(6666004)(186003)(6486002)(2906002)(52116002)(956004)(83380400001)(1076003)(4326008)(8676002)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 9Kx0lIisE5gqrgyLCT+TRWVOR/mT5g5C3erfric4BZRYYsxkX/EuKLacVLWezwt8EKS/+FKgCltKn0JbVfhqTAyx2efvBFllCEBDaYgfo1sJH2n6e3pkTXdvuBY9oXgj8NkUMXX4mvTySQFDdF3udcz737YyuTHkhFShV1OQPUoMrfcUapln1jRXblJN0QMSneRTBOsnP0mFW9RYRqAbQYEmNY5DrOwYntu0aFuE7O/IXG9TtQOld//V49JSBTgSMxB5gqWhYqg2igNO8aOCS/Iugu27+c8qhLm8mU8QxM8T2M1yxfrgJ0D/9cfS26tqKSPU4bmVBvSfxEuyNWwrM6pMV/ANvkI+0Nd2j278PLIe2/jHlVrpidKK4bZaSqkHaTKg+/aCKP33CijKO9yjyFCfNlMM1chKAQvtpJ6U9qAqZl+jVpxfD7LV8z9IDWeXmk67fNTLBBirA2nZ0NZyk1YJwY9B+pWZ9QK0aJv8E+ulq65/3w6SjPjg0qwFjslGlukKX2yxjegkpqVIODcUKP6Q5rb0pmm5Jiru4UJlcd4j5VxFeICy13bW8HTS0zHf2FOuyDiJ0vYA7h17LKjkh677OY77L/l3f/CsxFFGiUjy/h+kWRdJlkePpeDEsZm+lv6kGEYVZSDtjNqr51c3mQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9f38e9-8333-43b5-627f-08d871f67eef
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 17:11:17.9899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgpG+Zg2HtAirXeL0eJSth/rZ74EHxjINpzPqmGXHPepEJQ1xp4DJGdneBiVQ4NlmN9i1mHzDOYdPfNUK6fKupnwamjSnfKLkHJkFsre/m0=
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



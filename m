Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B472C56202
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C7722281
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ctZ4Idxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C7722281
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6XJ-0004Fk-W2
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68t-0007Y8-D2; Mon, 26 Oct 2020 13:18:48 -0400
Received: from mail-eopbgr60093.outbound.protection.outlook.com
 ([40.107.6.93]:39555 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68q-0008NC-9O; Mon, 26 Oct 2020 13:18:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkhlOYgKWN27fypWiWZ2+trKNaRgUrbBWpMihgd/018jZpDJOppuTdtKuI5dCW58qUA+HJlwqIItYc54AOpmVtuRvyNioXsyslXL5WBNxFbGGnd0hWc0iyZi1LYllTTX6TPJ9W0gpveHwmyxY66UFxa4ByHaH91N1LPMZUQbwe+S4R2YsKOE4CqJBS+ObSjiBpEnerWMQpTkzL+qSYYYfoi9CoVLcoI2nnLdrXLAMkjCk8PAvASytQ0gAnsnlCnC+UxUbYxzjZk9wOoqCSozq8hrBIQAOs2VAh4gCDhdpIKRt3T2ITk4wSYKtbevEypBgay83myjkjtHv+TavIX64A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uo3lPvSWoICg4mWpyysOfZpppQDoSRAWD6WvkMvBuGY=;
 b=BJ/LsUhgWuTz9Y8OAbeuBj5GBhwuRUasHAPdbS5AbSNAfZWTEmCLEvfuBO1sSVZKZuB8ToPiD6wbts7uck1InXJ5/NJEi9yRlR2+nub6EQRpTm8CV/WU5wurADTniirvSOHMqNFoy4uJoQ6Y+orqKha1GTXp9ffYIYJpqiHoUD84be5su4a04EeYw5rin4fS9nZ12BlJPxe2NMA0K0B2hKTrzYZPwbVp1A12MUcRY/57a2VtDUkZ5T+K+TNj53VfSQANPzkEa0zpX5l7cfZqhzCqs2X++kEexUv1hsLoGD23QUHB4Q4rdWSwRsZN8dOxn+t8RaLtUDHbaODt4vwrmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uo3lPvSWoICg4mWpyysOfZpppQDoSRAWD6WvkMvBuGY=;
 b=ctZ4IdxgKLUsFlQbv8KKGt7Ueap53Ny1krMstEGPpb/4PgB2Kt9UKOJ0T9DjUYLcFeg0WszIENcwoerRUkCbmYBmTjk+JGiu0lddeLK5k57b/5TkXatl+cj0UONtV5G75gkiQMvKXqx6ryfXybjH4YrGrdNx0Futnscyo3LVaWo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 08/25] block/block-copy: add block_copy_cancel
Date: Mon, 26 Oct 2020 20:17:58 +0300
Message-Id: <20201026171815.13233-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026171815.13233-1-vsementsov@virtuozzo.com>
References: <20201026171815.13233-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.99]
X-ClientProxiedBy: AM0PR02CA0101.eurprd02.prod.outlook.com
 (2603:10a6:208:154::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.99) by
 AM0PR02CA0101.eurprd02.prod.outlook.com (2603:10a6:208:154::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Mon, 26 Oct 2020 17:18:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c686fb0d-1c80-4cb5-0433-08d879d32caf
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB303268FB1A75E55C3B535BF0C1190@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:233;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f4SmKdTtipe1RXg6P+8icZso/isgi2DvzGRV5WS8ELG6oGEWDuryvX8E6/YgkPhVbxNClC+aFw74+3IlfViCk7OAPxA5l2wYEDMs+D9xx/TWELKKhE8Vl3IK8Y3BvOyUp7f10l9qDXy6sOTNfGgWlhK2Qmi6wt+xkFPTsthi1qYIqoWcpN2BXtpQjBaFNLahTpRMhwj6saAu6jtetewMyYuWbcW9PTe5l70DrakRo6CQGM1EW+bo2HktCOa4rYNmyi5Erjcs6XOl0mh3PP3AX4rTiEECJ1mqV7skQx1gIQFMPX+hSqKSTVH57RG09UahTwv34m/gdHPg4VJGGO3Elw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39840400004)(66476007)(8936002)(5660300002)(316002)(6506007)(6512007)(2616005)(66946007)(956004)(66556008)(6666004)(26005)(4326008)(36756003)(478600001)(52116002)(1076003)(16526019)(83380400001)(2906002)(186003)(6916009)(8676002)(107886003)(86362001)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: yroLyZ4w2bWwN8aBsBPEK+GhFl4rMOXICigRM60lbybXw3O/sEQTEAjjdzODueqP9obqMfNKo4B1f+5aLQiFh4AxUBaZ0/DA2AWtbZ/+ZtMDvqONG84fzk3+JrReiST+Qp0BcHtx7mYDOvYNAteRuDw4oUfgVm87e+3u2mnLIBmskU7qt3uthtiWdfLVZWhEehmAVFiRTtBq513e3Y3MzADNELLEqBj4oXSKXa6iTdNMG8x50yvyyol1Q7bzMmSFFQQIzF8jXwKqIXGUUOP1JaVTvcMmR/6T4PFwACYo9gIY4K9AtwwTPPUvS+659GeLkaSEnrRJmYEztdjqbSgavmC1Z/41LCFJDFcsUSsuDJY9CK0ay3MR7Mkx0rlJjYMtpCyZ/a7RS+q6PV5D7sjJgYbrMNUMkjBb0n2TqezhS/dF+15pkGJ8yo3FPqj59NB/Zmu1NPo07Cxrl17SQTrjaqMC4++OcVW11VkTi/eYjdSGroxjl0ANHMROxrs3aPKijO2uWpJT+QJB+eKcl8ltJ/thTRtF1eT4JX/TIEZPH7AkL5IyXkoTU278dg/RTvONo7O6KDZO79arjPmiP+iBYlFcZjYPb77FAxZLBM+ebo1GAr9VIAe1Vhp7M6mwC26cklz46BwydC/Pp5ydVai2PA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c686fb0d-1c80-4cb5-0433-08d879d32caf
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:36.9006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dmlg6BoPa1Dxq3303oR4rDWaXLdE/Muom2x7rsldU8iq+N6RdcfiyNOs/PwsxduEoU4DbKP2hHu5ud9qqgG9RxHday+rjx598IqaMvr2hJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.6.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:18:35
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

Add function to cancel running async block-copy call. It will be used
in backup.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block-copy.h | 13 +++++++++++++
 block/block-copy.c         | 24 +++++++++++++++++++-----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 0fab64e12a..8f5013d0aa 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -71,11 +71,24 @@ void block_copy_call_free(BlockCopyCallState *call_state);
 bool block_copy_call_finished(BlockCopyCallState *call_state);
 bool block_copy_call_succeeded(BlockCopyCallState *call_state);
 bool block_copy_call_failed(BlockCopyCallState *call_state);
+bool block_copy_call_cancelled(BlockCopyCallState *call_state);
 int block_copy_call_status(BlockCopyCallState *call_state, bool *error_is_read);
 
 void block_copy_set_speed(BlockCopyState *s, uint64_t speed);
 void block_copy_kick(BlockCopyCallState *call_state);
 
+/*
+ * Cancel running block-copy call.
+ *
+ * Cancel leaves block-copy state valid: dirty bits are correct and you may use
+ * cancel + <run block_copy with same parameters> to emulate pause/resume.
+ *
+ * Note also, that the cancel is async: it only marks block-copy call to be
+ * cancelled. So, the call may be cancelled (block_copy_call_cancelled() reports
+ * true) but not yet finished (block_copy_call_finished() reports false).
+ */
+void block_copy_call_cancel(BlockCopyCallState *call_state);
+
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
 void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
 
diff --git a/block/block-copy.c b/block/block-copy.c
index fa27450b14..82cf945693 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -51,6 +51,7 @@ typedef struct BlockCopyCallState {
     int ret;
     bool finished;
     QemuCoSleepState *sleep_state;
+    bool cancelled;
 
     /* OUT parameters */
     bool error_is_read;
@@ -594,7 +595,7 @@ block_copy_dirty_clusters(BlockCopyCallState *call_state)
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
 
-    while (bytes && aio_task_pool_status(aio) == 0) {
+    while (bytes && aio_task_pool_status(aio) == 0 && !call_state->cancelled) {
         BlockCopyTask *task;
         int64_t status_bytes;
 
@@ -707,7 +708,7 @@ static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
     do {
         ret = block_copy_dirty_clusters(call_state);
 
-        if (ret == 0) {
+        if (ret == 0 && !call_state->cancelled) {
             ret = block_copy_wait_one(call_state->s, call_state->offset,
                                       call_state->bytes);
         }
@@ -721,7 +722,7 @@ static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
          * 2. We have waited for some intersecting block-copy request
          *    It may have failed and produced new dirty bits.
          */
-    } while (ret > 0);
+    } while (ret > 0 && !call_state->cancelled);
 
     call_state->finished = true;
 
@@ -801,12 +802,19 @@ bool block_copy_call_finished(BlockCopyCallState *call_state)
 
 bool block_copy_call_succeeded(BlockCopyCallState *call_state)
 {
-    return call_state->finished && call_state->ret == 0;
+    return call_state->finished && !call_state->cancelled &&
+        call_state->ret == 0;
 }
 
 bool block_copy_call_failed(BlockCopyCallState *call_state)
 {
-    return call_state->finished && call_state->ret < 0;
+    return call_state->finished && !call_state->cancelled &&
+        call_state->ret < 0;
+}
+
+bool block_copy_call_cancelled(BlockCopyCallState *call_state)
+{
+    return call_state->cancelled;
 }
 
 int block_copy_call_status(BlockCopyCallState *call_state, bool *error_is_read)
@@ -818,6 +826,12 @@ int block_copy_call_status(BlockCopyCallState *call_state, bool *error_is_read)
     return call_state->ret;
 }
 
+void block_copy_call_cancel(BlockCopyCallState *call_state)
+{
+    call_state->cancelled = true;
+    block_copy_kick(call_state);
+}
+
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s)
 {
     return s->copy_bitmap;
-- 
2.21.3



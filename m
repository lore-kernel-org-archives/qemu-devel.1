Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7679C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5141921D42
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Q6kHrkCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5141921D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6QS-00058f-Ay
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68p-0007S4-MC; Mon, 26 Oct 2020 13:18:43 -0400
Received: from mail-eopbgr60093.outbound.protection.outlook.com
 ([40.107.6.93]:39555 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68l-0008NC-QE; Mon, 26 Oct 2020 13:18:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILqDE0rGROTCU3D78huYBLykIM2HLeiW9YsFR+ELXpfTxi4f574vi0ZzBUScR5CY3Oh6zoMA7YXxJFNfdhIuYic0BZIqQCwX9nsFUzgF7PJT/9rIkiShPFItVPeYg1m2qwI+mZtOQOThq6P8A+NzTHn06dItpY1w/iVwmuJPP6V3qIA+GxbhTNIXpkGhGyHSptcnQYIQRo/fvIBsRaefluIVCkcUl2cSjRc3bzX1GSp9UEDMUNIbWfk5tAxcmay2KOco6j2/jVRESyxqVP+VCcjQTjbHdqTKf4PMVf3iRHxACBBMxyBBXaQH3KYSFyC00gSyBOMm9J6EP+YMzqa6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHGHPR5jS1zihkhcfonrcWsWS7tIO8SZQ43cO2jc6nc=;
 b=BDkJVaxEzYRWT/DmcISmhTZ14ffXzVYDqE1SIrMLQFVxt/O/0OnlvX9CUuYHHZSrmjP4In3ARuZ5FeiUits01gAEX+ifB5Nxpe2QbpvcEUz9CeQL2PjiOYNcrnJqYtibOMxcE7OsRCvgrhk4O3nJoH8RSjqGdt2CrSPVOgOvDmt1OtuSzBFlOC4oNdgl0RfJAu9snp7Z+WEip6w1BbSW2ZSXV0FCq0izVWw96xEs1Mki+5urCOn1zQ58ppXspPeg1r3Tsyat1p9UmdwmcvY+Y3YOCz0TK02Bw9kpGnI7jMdAZ1FzbgNMUa3dXfo3MLz8aNl0//ou5Y9z4Xaf6jpqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHGHPR5jS1zihkhcfonrcWsWS7tIO8SZQ43cO2jc6nc=;
 b=Q6kHrkCkKGWV7Xyk5L2ph7xbofEc6cg2gp5QjKgTI901ncavoUgXVozwDktWL7YHWRmrpgUSJlnQCNs8lPa+R93h0Ui3FK7XK8gQ1jNZlOkYWhC+ZeyZ+OUbXq4k6nyAEDHcbB3ZqhNkFbwyHGoiEpQ0Syo2wEUT8MdV1j+HqtA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:35 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 06/25] block/block-copy: add list of all call-states
Date: Mon, 26 Oct 2020 20:17:56 +0300
Message-Id: <20201026171815.13233-7-vsementsov@virtuozzo.com>
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
 Transport; Mon, 26 Oct 2020 17:18:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c420c41-9b21-4300-f691-08d879d32ba1
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032CE09A79D6AB906148019C1190@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2zudI+nVpUkthG6f0ApuGsJWyNrCu+NBTObjctvNCt9FtVYpFTADdwPfJmDPIs0KSRJvd6x9CWxdXdY41F9mIuC+ZjN0xjizsI82RbXGhXXq50Y0L/Sf4TTLV3knXfORFNFxxARiLp4EOCYPFy2WhXekPQGEYRv1HaAA+yGpxpM8PiEZgae+8YqMY8C8iEpDqaGHW9bjVoagKmbiKMUW2akrxvAUeknrJNroXve5bMnKh++bTP5fnlUtbLGN9/eUM2nIQzQm+HIcWcxs3dOe7nTTkpZKePeCcsJU0R0+OXH4LRP24oCsK4iGwLKG07JHge4s67uv0h6JMbMjIKe2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39840400004)(66476007)(8936002)(5660300002)(316002)(6506007)(6512007)(2616005)(66946007)(956004)(66556008)(6666004)(26005)(4326008)(36756003)(478600001)(52116002)(1076003)(16526019)(83380400001)(2906002)(186003)(6916009)(8676002)(107886003)(86362001)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UQaSU24oRKrA58Pl01o0DXh6yUVIAK3/n9KuKVz8P04rj7DihGdzeWOIxUUkIpkbdWemQJWDWrveXMZG7F+gWlxoHqZi2QU2mLmAwI8TRTxrD7Pf79XyYIzGX44ClvDJ9cW+j5O94gP240Ofmqm5RYEbBq3ihVDUTBvC7xssXCoUqOgQ+ZQ2tw9kfcJILPtMYfMldYJ8yGuFDYQwH73eJzD+OZD3yaj4pxKeWu5yz9T+Vo8BB0vFae8xW3C1ZgO++XikeLC87DEYzdYO1FQ9orqdJFGep8TQaA1+CIkkCmAH/AjmRQoIykiRtHBIUvm7a4X2ZC+7UF0yls9LztR0800u1mVEg5PgvQ9nSLPFPyiC1NqeY47Lf9Wwns7crpWARPTPHsW8OpkMpuD+bFMxIKyLFqRFdFE1oJGcAOUgpj0rzwhLXoGjGSz/241CtvyNNSLKtxm0QELdeSADS9kk9GkMXOC0KZ78RQcLL+phECnWw957tlCnDVDNbyFKQA1ypDCFZptQhLHzLOTAz8dK07+MOsHLN8TW23Ez8r9Ul3S4lQVeJeMlDduvLMI73d77u1O2Hk7TidVdNeuGhJyAg6eLrlwi+EhRYJ+S98uR8CykjPOzY+X3x6MMCjVC3WFvzSKvHmh6hhUSe7ra7zq+yw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c420c41-9b21-4300-f691-08d879d32ba1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:35.1503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWAoiGIqSGwcr7WonqkuHZa4A5OwnVOn57FfiaEo5OEWlxvIlp+JMkyBwd6ecSBvjVWk6SBklqFP7BQC9nOKGt/uACN1pLD0NC52x6YmZwA=
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

It simplifies debugging.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-copy.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 35213bd832..6bf1735b93 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -42,6 +42,9 @@ typedef struct BlockCopyCallState {
     /* Coroutine where async block-copy is running */
     Coroutine *co;
 
+    /* To reference all call states from BlockCopyState */
+    QLIST_ENTRY(BlockCopyCallState) list;
+
     /* State */
     int ret;
     bool finished;
@@ -81,7 +84,8 @@ typedef struct BlockCopyState {
     bool use_copy_range;
     int64_t copy_size;
     uint64_t len;
-    QLIST_HEAD(, BlockCopyTask) tasks;
+    QLIST_HEAD(, BlockCopyTask) tasks; /* All tasks from all block-copy calls */
+    QLIST_HEAD(, BlockCopyCallState) calls;
 
     BdrvRequestFlags write_flags;
 
@@ -282,6 +286,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
     }
 
     QLIST_INIT(&s->tasks);
+    QLIST_INIT(&s->calls);
 
     return s;
 }
@@ -669,6 +674,8 @@ static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
 {
     int ret;
 
+    QLIST_INSERT_HEAD(&call_state->s->calls, call_state, list);
+
     do {
         ret = block_copy_dirty_clusters(call_state);
 
@@ -694,6 +701,8 @@ static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
         call_state->cb(call_state->cb_opaque);
     }
 
+    QLIST_REMOVE(call_state, list);
+
     return ret;
 }
 
-- 
2.21.3



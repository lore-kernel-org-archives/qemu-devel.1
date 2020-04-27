Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10FAC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA0A20656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PwBQnxwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA0A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT4wj-0001zM-Jv
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 10:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4v3-00088d-T5
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4v3-0007kC-7L
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:39:37 -0400
Received: from mail-am6eur05on2133.outbound.protection.outlook.com
 ([40.107.22.133]:24288 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jT4v1-0007iF-6c; Mon, 27 Apr 2020 10:39:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtmSjwNeZY64L81+1zGxMwdXM60mQLbndKaCAXNcltdIyu4u5OJrtHOaD0YOgUaNg9pciqDcN71/rCcD2qn/pIRA3poZ3MVBtQQEdSD21R1t5plHj1up4mQHUBDnqnpIbziw6d+xAD0cMsVnnlw971+8laZdDEwtrZ01aIOct4wl8W4W8OogWK3Ye5ZhZCoovxwvmKtOp3iLMP9k4w/QwTbpdMCUnY9RTVJdn4YFUU1ruJbC9AKXKGfZVWNzXcMmy16KnxGrmyZy54Y4NJTtnbZ5Z2AV4V2wdHV2FYaNRe5o9Hwt9Po6o3QHPhxw7agFpj3N+SZM/ZHxTD+aeLADqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErVBdh1cF9BloFlIPWQR4KJ9no3velI5wxrkcsnsz10=;
 b=gPfssuudhts8JQZe8K+LqW//JSxB3UuiUNfbAaK2On2hHE7bxhh6UfQ9WKIimRqguEw28AfA/CfRwgu/rrGIbkIqliQtlRIp1xen/uDMRI7n9KyQsJRddAT4WgsodVYWCyDaVdqtkv3VoCWfN3CsmMqrzSdmaFIUTe7YtcI8/x5BK1ss0paYYgISnZXhda4DxHFKyVzSfzyfbl0LVU7XYJHhFAAKUnNzIewwlI9VhqxBbkvReks3trV32wQ134kS0ftWz8nhV2Fo3svaigvynKXipomJl7Qdu8GEfZQLp3R5Sbjo/dCCzJYIE38oTbdcOOj1iTE8F+eNek+jSFM1sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErVBdh1cF9BloFlIPWQR4KJ9no3velI5wxrkcsnsz10=;
 b=PwBQnxwi03Nge20My+bDPshC448qiPpMC7ayEUWMTwYNZ+E8YwqS2IvwrSe3YLqojJU87wW54dCrJSYpBGCmpbi7/LT+3+v29m5Y+u9EY4ith5oXSn9SvCLElXJYEGruFJYQOPNRQMo/jESSn9KJgpElQ2F8bp5dd4f7qyTLaMk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5527.eurprd08.prod.outlook.com (2603:10a6:20b:de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 14:39:31 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 14:39:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 1/9] block/io: refactor bdrv_is_allocated_above to run only
 one coroutine
Date: Mon, 27 Apr 2020 17:38:59 +0300
Message-Id: <20200427143907.5710-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200427143907.5710-1-vsementsov@virtuozzo.com>
References: <20200427143907.5710-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 14:39:30 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5f691e0-cb14-4127-3321-08d7eab8cbf5
X-MS-TrafficTypeDiagnostic: AM7PR08MB5527:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5527C81F01B1B36CA6D2DE2DC1AF0@AM7PR08MB5527.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(396003)(366004)(136003)(346002)(5660300002)(107886003)(316002)(2906002)(6512007)(478600001)(6486002)(66946007)(66476007)(66556008)(69590400007)(1076003)(2616005)(956004)(81156014)(16526019)(86362001)(6506007)(52116002)(186003)(36756003)(8676002)(8936002)(6666004)(26005)(6916009)(4326008);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vr875pw0KFLFfNWddvBO0qpCI++kCvRvdgj293M0gsoygzPrtih9h/XbMyTBPnpO+heylPoYYDO0nGMBeYbzIA25YnT/Tka+RTunUPN7r9vMdUpcBG20QpdwGciOV1EIa3yu85dHmcbTlKCmbZIIaARc7kUjHATNpEfICaGcB4zPqb2g/quRng7nfSzQNXjTse8e4kO7+/uXzShhwddBrdu9FOnhtggedSdOC/bYqZPaf7OFXIm/S2P6QiX2R0N/sG5AH+HVZtabFsM+eztZAOX9QumRzeG7lnPpA1aFzo+Or2HYgmlw5WIoVpAS9D5ckUikXYTkalndYldEZUgTtKOfwkvzDDZBNCwrlMlwV1Bs8xD7eAEXwpJJxUotwMID6quryqZIvmPLqSereP/UXqivI09nBHIaATnyI3QCKnPkKfUPoPEsxa7c1BuWPkkmbQ7x0uB2QrHOXMf7sfOW+AbUVjeXQOcDzLCf/XyH1WK0PAyyOya+H82dtu8YmlFV
X-MS-Exchange-AntiSpam-MessageData: Pay+4kQ4H0fJK1e5JriQyZVh6lxRQhMNhMiDEDzliHEpBT3gEHQQEq/i24OhJ0zCvz+CXOhA+0QDXaoOtQBASvDvDW65Oi7s17NIlrJZCShdiFjmkBPpbsG/g9a5t8TqLav3foFotkT/pwQRrtU1GkPwn14T+f82wLSx4zXvlmieXm2eqolhvQJ2y9AeBiCaPIbUZwkTM8u5+EQGtfPEt8PcGL2ubKrGqVwJqxEQoQnI6hn20qaEjrqlL/UIWhhfGkUMjoyiwABY3VEQWgB9CFQaGr9hQz4Ag1IxUxFN6b6GiVTgvGXPxWmzNk7RbN6Oc1F6gr9l57mSeX+jM4ExQs+khbcIVH1OPE16mwVcuGpC5GNkW8tYKG1WKitrM3RrHf/wAcqdoAdL3T1RKe4eHwgAX4OPyqKZPBpvIgKKhpNFhWAOtAM3OqRxBzDXiv1Y64AdcNTuE3MfdRE9iWZ0NQgZB783/Mif2oO4Y2US2cDytsdITmn7yL6t2DjzJnxg5bxwss61EFFD3cGFAjxdCppz3fEViPvIOm8o1xYLKOIpXyBzsRUdig7dkN5/ztrR1sOx8f0rDouG0ekqzdP/uAjfF18M0YXcScNzPbWfzb7KPvTEJZJkcKGAapJ4wJzEGC16gQ5dOR7l/gv+Z0jp/ZwXgG1OQbxPfpyzvKHBgDXSffVC/qniZ/K5EPDuMZ8/KB/qJPOyBvtiVpf4fpoVTE+Xyv88lEa/xQrMGTjcW8A3ZkD5hTvPiUnzMPfmznZLMjxtrXAotYY3cnqMIyjBxDxVQPHOf2euDsSSnqv2eLs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f691e0-cb14-4127-3321-08d7eab8cbf5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 14:39:31.4404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krA8otFK1fQlwC6ubbvbQE6aV94iffzoLCogxvNQQtMk1Z5xJ5Dwtcwf0BxfQfBY83hr6eFoAJGWvJxjlWDLzeOzZUnxtaGdb+36SiGu1W0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5527
Received-SPF: pass client-ip=40.107.22.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 10:39:31
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.22.133
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
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_is_allocated_above creates new coroutine on each iteration if
called from non-coroutine context. To simplify expansion of in_flight
inc/dec sections in further patch let's refactor it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index aba67f66b9..94ab8eaa0f 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2482,6 +2482,22 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
     return ret;
 }
 
+static int coroutine_fn bdrv_co_is_allocated(BlockDriverState *bs,
+                                             int64_t offset, int64_t bytes,
+                                             int64_t *pnum)
+{
+    int ret;
+    int64_t dummy;
+
+    ret = bdrv_co_block_status_above(bs, backing_bs(bs), false, offset,
+                                     bytes, pnum ? pnum : &dummy, NULL,
+                                     NULL);
+    if (ret < 0) {
+        return ret;
+    }
+    return !!(ret & BDRV_BLOCK_ALLOCATED);
+}
+
 /* Coroutine wrapper for bdrv_block_status_above() */
 static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
 {
@@ -2578,10 +2594,10 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
  * but 'pnum' will only be 0 when end of file is reached.
  *
  */
-int bdrv_is_allocated_above(BlockDriverState *top,
-                            BlockDriverState *base,
-                            bool include_base, int64_t offset,
-                            int64_t bytes, int64_t *pnum)
+static int coroutine_fn
+bdrv_co_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
+                           bool include_base, int64_t offset, int64_t bytes,
+                           int64_t *pnum)
 {
     BlockDriverState *intermediate;
     int ret;
@@ -2595,7 +2611,7 @@ int bdrv_is_allocated_above(BlockDriverState *top,
         int64_t size_inter;
 
         assert(intermediate);
-        ret = bdrv_is_allocated(intermediate, offset, bytes, &pnum_inter);
+        ret = bdrv_co_is_allocated(intermediate, offset, bytes, &pnum_inter);
         if (ret < 0) {
             return ret;
         }
@@ -2624,6 +2640,56 @@ int bdrv_is_allocated_above(BlockDriverState *top,
     return 0;
 }
 
+typedef struct BdrvCoIsAllocatedAboveData {
+    BlockDriverState *top;
+    BlockDriverState *base;
+    bool include_base;
+    int64_t offset;
+    int64_t bytes;
+    int64_t *pnum;
+    int ret;
+    bool done;
+} BdrvCoIsAllocatedAboveData;
+
+static void coroutine_fn bdrv_is_allocated_above_co_entry(void *opaque)
+{
+    BdrvCoIsAllocatedAboveData *data = opaque;
+
+    data->ret = bdrv_co_is_allocated_above(data->top, data->base,
+                                           data->include_base,
+                                           data->offset, data->bytes,
+                                           data->pnum);
+    data->done = true;
+    aio_wait_kick();
+}
+
+int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
+                            bool include_base, int64_t offset, int64_t bytes,
+                            int64_t *pnum)
+{
+    Coroutine *co;
+    BdrvCoIsAllocatedAboveData data = {
+        .top = top,
+        .base = base,
+        .include_base = include_base,
+        .offset = offset,
+        .bytes = bytes,
+        .pnum = pnum,
+        .done = false,
+    };
+
+    if (qemu_in_coroutine()) {
+        /* Fast-path if already in coroutine context */
+        bdrv_is_allocated_above_co_entry(&data);
+    } else {
+        co = qemu_coroutine_create(bdrv_is_allocated_above_co_entry, &data);
+        bdrv_coroutine_enter(top, co);
+        BDRV_POLL_WHILE(top, !data.done);
+    }
+
+    return data.ret;
+}
+
 typedef struct BdrvVmstateCo {
     BlockDriverState    *bs;
     QEMUIOVector        *qiov;
-- 
2.21.0



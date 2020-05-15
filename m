Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B823C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:42:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8FC62074D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EH6ktoqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8FC62074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZfT-00048Q-1O
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZZe8-0002GH-6W; Fri, 15 May 2020 08:41:00 -0400
Received: from mail-eopbgr150102.outbound.protection.outlook.com
 ([40.107.15.102]:11310 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZZe7-0008VJ-C2; Fri, 15 May 2020 08:40:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPxYtKYD3wTT0zxzP5qJbw7b5HNHdexxrKywFZZ3L4odM5dHlzNgbYnCdzSrjEpS7/ZED1J29rsgsP5gJm/YuqHM6q7OlH3JYdTfFLXx4oUsegk15Dq6D8eFswNMDyOmqBprBleWM3T8wNgYRVN3oaLQw01nJhRLhJzbwQdPAgdANzAnrJ7Hnqmrv0y4LpE1bHSLdjnGWVmmPqqfWFv9fuhZMaif+mChwfS7x0pxt4/X9QCZ2J09D6I9eULUPhzogqFyNpDYzSUgWdL9a2Ko2DgE5rra6FdY/oMFgi8boJMG1/JgcfmDQrfNwhAEWUhnGjMUez4z1WbDhIGpC5YK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2j3vYlF8ouVHCyr0TlU8c2rQmh/Y1bVh8akJN12+3SE=;
 b=EFxrDHdOqP9nyjUjvCzN6/SJFxeVBIJM5nIRMdHR2XKGW/j5AenuppkOJBYgSfSx+XFD4VqDAyrITgZiWhEX8DfIpycH/CLTHzLhnCEkWWP3MgspNtBEdLfDTb2dnZB5SLRqg6oBSp8D0RuY8d4FPOe5ue0osyYAC9BO99i7Egy5CXlXIK1MXJrYt/jyXUoQh0Rv5wtSWznudXcgxkS3GYruKyrWQxdW4JcbJQoklkcRryhFPLRw8GlsXs2v8C0oRu4FRkHOzd+RrdVA63UQeIR77mgaxZ9IKPzeoY4uNiHWZv5KvUckvT1vAujgVGLGn9Wg+psHhKTiXBMorNcKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2j3vYlF8ouVHCyr0TlU8c2rQmh/Y1bVh8akJN12+3SE=;
 b=EH6ktoqvvGJcXzQStlGQPh53BPY6AzuC01YeoIGZe5CkcWXiyyLAK6ImB1Yfx2hCQQawN704ZfYgfXY10kUuElhky0e4NAUqUCvBVbbR1/Q9OJDEsRTKf4SjloPISVmJOMpQYsVSkCdWIEz4ePCF9FkHVPhklLhMQCp8Mm8QRus=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 12:40:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Fri, 15 May 2020
 12:40:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 3/7] block/dirty-bitmap: add bdrv_has_named_bitmaps helper
Date: Fri, 15 May 2020 15:40:20 +0300
Message-Id: <20200515124024.3491-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200515124024.3491-1-vsementsov@virtuozzo.com>
References: <20200515124024.3491-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0039.eurprd03.prod.outlook.com (2603:10a6:208::16)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.184) by
 AM0PR03CA0039.eurprd03.prod.outlook.com (2603:10a6:208::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 12:40:52 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 563e9b7c-29ce-4daf-35f6-08d7f8cd34ff
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB538107AE31BBF893164EA2D1C1BD0@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:18;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D5cli5e+nbm+RqnpoT9JYlnexO2ic38so+vOmWN+M3+VFKOUWoC6F2jJ1cQL705MufJLNQaVk3Irn25+wlqWAnucImdqVqQvOTyuT8oNg/qbOPJmbt6aEsxZZ6G3W9p4mqOc3McJ9TFZ7x0KB45vLovA2JGM2uFaXEu4Nxn7ei46wtlvE+K+rnOl+TwARMepFakFgpfJcPPxMJiguPfk1WFWxcngKP5cY9iK8zBnmCksPmeJ9FAJV4XZYfGlVycBXilPZdnNSqzsFlvD+O7L0gwiubug+Dh0qPAGNEzRvvlcSXjUHR3WdG8//LR9/tllTQbwowsuX1mctZ3rqtPRs2jv40PstMPks7Y58R/BYjhapZaKsehgoZKSDM0U/BOvNhb4UBVfrZOEfmqDqNIlE3Lm5kSdNRX306kt323Db8mzfw2Fgqgvxal9wIc3opQX1dcelwfQmxGYdLCu8YGximiD8maZ1qXkz8s1Oyqj7SpyiQrXgo+8zwI12zKRKVPp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39840400004)(52116002)(6486002)(36756003)(8676002)(7416002)(8936002)(6916009)(478600001)(6666004)(86362001)(6512007)(4326008)(316002)(107886003)(26005)(5660300002)(16526019)(186003)(6506007)(2616005)(2906002)(1076003)(956004)(66556008)(66946007)(66476007)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Mzx3wQ/DZv9mb3oJxwp0LVogn3y4lhIz9YLSRPZvN/5u+thBNEtCbFQHZ4Ai0PQP41DY3qqAibmwO2mtXRrFyCaVCrW8KSnbf0z54AtwAK4Qz/U8QeKSM7qSVtYy7rXPJNu6XSdbP6XhE1SbU0TM+iyH6VySO/9ySDIhboG1eyzSnCU3RgiKlVjQzKmibtnxSmvu6gIRjEJ4winehr+cJjo1C67N2oaa47ZBEIAflBsb6cKtMZ5e2GJ/sUwIjUmnUdGyX0kXBV6zqpkqkLi1y6xxT6WYGzfpPdW315BVuXQ1boBt+V9J+ET+FWKlj++Ar1tWrsLJRQ5dXIFANnN6ONjGlmRi/F1nGZ7ncuQh9G27vkvasdm7nHfN/RT0NfaObBJbyWFDq9Jnvpl3hiCnkb7h8+lS+Bu2hwBVEOTBKqMu1SJiFaOnvCNz643/B5lPCMgRf5ODpdRJHu6qoKrLvbmPmZLtmRT3U3p21sbM3u8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563e9b7c-29ce-4daf-35f6-08d7f8cd34ff
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 12:40:53.9031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnymRgIWMWOrpTlaPFY6Eiu1nO4aQA09jWQKUL26HjqbDyBwVFxEU78i4WPjm+87CyFNguFiqJHPd9z3CdPLEPTR3TZb/wJNAh2av6GdXCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
Received-SPF: pass client-ip=40.107.15.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 08:40:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 stefanha@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, mreitz@redhat.com,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, pavel.dovgaluk@ispras.ru,
 den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To be used for bitmap migration in further commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/dirty-bitmap.h |  1 +
 block/dirty-bitmap.c         | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 8a10029418..eee70df873 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -94,6 +94,7 @@ int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_bitmap_truncate(BlockDriverState *bs, int64_t bytes);
 bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
 bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
+bool bdrv_has_named_bitmaps(BlockDriverState *bs);
 bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_get_persistence(BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_inconsistent(const BdrvDirtyBitmap *bitmap);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 063793e316..c788ca7c69 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -809,6 +809,19 @@ bool bdrv_has_readonly_bitmaps(BlockDriverState *bs)
     return false;
 }
 
+bool bdrv_has_named_bitmaps(BlockDriverState *bs)
+{
+    BdrvDirtyBitmap *bm;
+
+    QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
+        if (bdrv_dirty_bitmap_name(bm)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 /* Called with BQL taken. */
 void bdrv_dirty_bitmap_set_persistence(BdrvDirtyBitmap *bitmap, bool persistent)
 {
-- 
2.21.0



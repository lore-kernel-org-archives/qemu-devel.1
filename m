Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3CBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 22:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52330206F6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 22:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XzyCpb/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52330206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbtMS-0005mm-F0
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 18:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbtLQ-00045L-R2; Thu, 21 May 2020 18:07:16 -0400
Received: from mail-eopbgr70104.outbound.protection.outlook.com
 ([40.107.7.104]:17734 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbtLP-0007vC-Vd; Thu, 21 May 2020 18:07:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8tGf0qqNm4z3Yg+iGZQJvlcXaLUAr6tmqJoDdih+gPY1tA7e/3Rub6IroTkBqh9GOMmuGWsgNMBHwwqM2q2m7Ov9YAfVT7e5GLSB9J10Fbt3VqJM+ZJaw61uuxdsHm0UyY9Ramm2FJpdw7DiQN7nLMV4EHJ2/jsfjQXDLYsQVGJ/Vi2vV70SaSeUAR8LcHAa/82EfUyMvMNUbBnYT1cWP/1MIxh0rCnTQ2l/LzAXMajQupvUCqEBEn3BIp4/NNMT1z1xZ95jtEPfu8Oo5UvRdx2AuR6x9do0vAT8fxuV8B2yQpkvWwHoofwofLbKXF09OlCnq/b1mf5kNTM0e8azA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Gdvh6TdoVGPfRVPYfBGlJxZ/AR9HXnns9XBE2Igtcw=;
 b=hnJ/2LmvLpmSOCcAxVmOE023QwJc+yBi03IFotL52fhHbLRqj37MvA/YA0aSU+2ifUEFJ5h3XWcd3U+tJFRZLXDDOXVEXCxty2poBmc4nG5CbwEVuCbofuBHaxPTJrUsvk6aXGv7qNZQuoCo4zzsCIgB06Q+Gps8xl5+HJ0ywHKar1/d0ZJmOqYFcQ0Z1hUEaykIz/yMvMhRmtT6Mh8nMkwarpUIaZ4PqkQC4dMQVn9nDzOk83cAMUmycjls+Rtq5CMHW5nkjWm4ksAg3nYLb/bJc8PICWqIZipG2AkCtbBvNY53eY/d5siwTtcDBSMg54eZk6hARCndxvAP9AzFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Gdvh6TdoVGPfRVPYfBGlJxZ/AR9HXnns9XBE2Igtcw=;
 b=XzyCpb/y0H5gf+I1bdpj3Kd3HyibgwMFXJd4GH69FpqWGjIoSu06Cezaw03G17K7dI8TYlM1HakzRsbcEVSz2uiWet1zQtG7BF/+49lGtwCEliI093nb9AHgUOuLGQei75jT5t1oeGJFNsWlPish7ZsY8WoBz1QlprUCdaY72vg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5512.eurprd08.prod.outlook.com (2603:10a6:20b:de::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Thu, 21 May
 2020 22:07:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 22:07:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 5/6] migration/block-dirty-bitmap: add_bitmaps_to_list:
 check disk name once
Date: Fri, 22 May 2020 01:06:47 +0300
Message-Id: <20200521220648.3255-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200521220648.3255-1-vsementsov@virtuozzo.com>
References: <20200521220648.3255-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0137.eurprd07.prod.outlook.com
 (2603:10a6:207:8::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.167) by
 AM3PR07CA0137.eurprd07.prod.outlook.com (2603:10a6:207:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.12 via Frontend Transport; Thu, 21 May 2020 22:07:05 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a9ca918-4932-4d93-68bb-08d7fdd34c7c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB55123E198984ED421E975E34C1B70@AM7PR08MB5512.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/O0tYKSR9ZPP01m18SFqPswVaOvAiQj6/yMAHnp/U3FXRXkbXqsA4Q7Pw9OjZnX/oUhooxvTLl+htFsPxuQRWa5h6LMzOVuqHZbOXkh9//4M/ibG4Gp5Cugx3CZIzZKKHDVT38eCIXSojmwdiVeVjEb2VOWgO8WiB8fKbQR6WLn0YjjFlmMSzxJ+OyP/vIO3POUhfLFvkn+q64wq2KF2b9tOf2W/jflJRvsR4HCOzntuV8WNOgevhn38Jz3HTaQq7WCg/+PIPzrHX8ptQr7+8gx2yJw1NFV4ELK6ulbY0kCtuU83petRtMEci41Rx02TAHkhtGPPo5qaMazOBpJvyeu5L3HU+jWtqpBOL0VGbFIojeg4+d3PVRH36ZYBnlm5HXxpnor+axjlVnKjwGipw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39840400004)(8676002)(6512007)(186003)(26005)(6666004)(2906002)(7416002)(16526019)(316002)(6916009)(8936002)(6486002)(36756003)(6506007)(1076003)(107886003)(478600001)(4326008)(66556008)(66476007)(86362001)(5660300002)(66946007)(52116002)(2616005)(69590400007)(956004)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nD7I+RAWJPCMQV4RIcspw97bV0rGlOaUbB9QiIrIvkKZMKi9vHYlTfWT2wKnxBuoKgc8enWo6O8MPOXtr6Ty3t16NLV4GApCASJQ3pKZ9aW9CKsmShqB5xjIf1rE7q7MStQE0fONs3IhH7LPwQA6REi/9lu3C5QUw0RstPB9Ef4+MepQTE1LR8F82lUGpgE0NcLKAL2sXWzUcsGZ0YBSeNMjLdx7qIdsL4/DSQMdDZzQ/ukNw/JRPn38/Y6VxIBPU1DiFiaPxpUWnA2EwSUajCTJyNatVzFZsa8N3lOzwextjsFecy+mySFJahD+TV8q6J+g034Xnc6xhyt4tgYvq4SeYX5W2+Taxzvjlztigq0RkF25pQnoFERLys0BhYCmH0itSMKss8OT/q6WRAIbrac1eSKJoJBEjnyTwPbk5T8PhG+N8NJI+BtTpKvivUiMaYGVs5Ndb6AUDxtaDwS4UU8VDVIIstjxdiK2EgE5ymo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9ca918-4932-4d93-68bb-08d7fdd34c7c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 22:07:06.1145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSCGBNGt07VAxpWZY68v/MZ4WJXLlQZeEqnZP8MUWh/l/sV6om95UAFN71P+BIzq4w+5Qw76QzAWxXsv+GlDTa5M9OUAjJX2/NkF572jSts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5512
Received-SPF: pass client-ip=40.107.7.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 18:07:01
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
 quintela@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 den@openvz.org, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 migration/block-dirty-bitmap.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 04a5525fd1..65f2948f07 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -274,17 +274,22 @@ static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
     DirtyBitmapMigBitmapState *dbms;
     Error *local_err = NULL;
 
+    bitmap = bdrv_dirty_bitmap_first(bs);
+    if (!bitmap) {
+        return 0;
+    }
+
+    if (!bs_name || strcmp(bs_name, "") == 0) {
+        error_report("Bitmap '%s' in unnamed node can't be migrated",
+                     bdrv_dirty_bitmap_name(bitmap));
+        return -1;
+    }
+
     FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
         if (!bdrv_dirty_bitmap_name(bitmap)) {
             continue;
         }
 
-        if (!bs_name || strcmp(bs_name, "") == 0) {
-            error_report("Found bitmap '%s' in unnamed node %p. It can't "
-                         "be migrated", bdrv_dirty_bitmap_name(bitmap), bs);
-            return -1;
-        }
-
         if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, &local_err)) {
             error_report_err(local_err);
             return -1;
-- 
2.21.0



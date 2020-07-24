Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022A7C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0DF920674
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wGoygAbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DF920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytMe-0008Q7-14
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJD-0001nA-Ij; Fri, 24 Jul 2020 04:44:03 -0400
Received: from mail-eopbgr80095.outbound.protection.outlook.com
 ([40.107.8.95]:31299 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJB-0008Pz-JF; Fri, 24 Jul 2020 04:44:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKfLPpxbaaVFyoBV4fiuJEWw2eb0B1T67cfQUC9HS1RY/ngMjHwwHFyRKbHDcsVh3SDiY5AHCnk9cXKzitgyOpV5fACZ82cnmNKfSLSbZbZ5bcSJggvUhV2CHPyHYL5+oSWtJbktPx/ZrDuJmFMgQwXE0747RlRrGps6G6YTCOZhPTOuNCv9QozZz2p6AJRNEhJDeOWRbc27z7rnxFG9VeMsKBt3CD/INxoqdOdYfbvY4cj2TVGCoS62agf9P0uYl/w6vaOZlBg98jR2WouhFIWB9ScbR8K1DlgK3tITOtmK2zY47VtGNGgA3KtmXcneX4rrdMAqPGleFiYpD2M9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoAXJX19H5DPBudqTwRPImRFql1ccIfcjIodlpzIyyA=;
 b=kiqpZ4i6jzvh9ky3Sj0SPQf+r8StVZenMaXne840B4WHvtAR3RbgEN9WYIwTEIFkuNTuyYPlOjFMGBYa1Yq/Ie2F+Ra0TQDvV4pfIFV916DRrUh/YRwXu620hwZ6RVnilw+B1N6O5ClSMStYX9Se5EHXLA1U1JLeLlsSz2cNgmPUkezN0REsKvlCgqn2vbwZ4xveTlNer0clXBKdk2IGHLcovaBY11qvgdA33EIQSuBH3oe0nGayi2XmCMawC9vGan/U+r7YtPOMoMoSe4grJ+jz7f3TGY02R9f7KMvvwgXUZYF5LescwjIMur0l0l4ZnQr76jvhLjpL3q+Y14YA2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoAXJX19H5DPBudqTwRPImRFql1ccIfcjIodlpzIyyA=;
 b=wGoygAbbMlKcrn8QKcDYlNfYQOBWTPaA/RgaWbKNBdff908ec6ONefot0IPX6srRfWO39ZoUF7bwukcvZqsVL+3FjlQVL2NcCFHQ9nD/bPqYEeoiqElNl/h4NknyQTf/yp6o+gYwZTWc9C4ngjLIB5HCnv5keuZyKXvFpZjkGXU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4534.eurprd08.prod.outlook.com (2603:10a6:20b:ba::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 24 Jul
 2020 08:43:51 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 08:43:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 09/21] migration/block-dirty-bitmap: rename
 dirty_bitmap_mig_cleanup
Date: Fri, 24 Jul 2020 11:43:15 +0300
Message-Id: <20200724084327.15665-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200724084327.15665-1-vsementsov@virtuozzo.com>
References: <20200724084327.15665-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0160.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.156) by
 AM0PR01CA0160.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Fri, 24 Jul 2020 08:43:50 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97d43326-d2c5-49ca-3311-08d82fadb0a1
X-MS-TrafficTypeDiagnostic: AM6PR08MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4534CF66751D6430B726DA3BC1770@AM6PR08MB4534.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NO0CO8Mv56Zrqy1CGcYYT0KkcztBwm3EXcBaXYaRqwyGETXClUQEMNIyNGN5RVo/gnBAnczVtJlKhe/kQCDL2ZftREz+65+RYhfwqqh4m6qAOsEKFzVaqMYOD1/W6GEcFoNDY4SU94X/Q19C0g4g0pU7EkhkyQSSdtra5y9oL4dEuU8Pf4dC4aZ5E0j3B+TT8UWK5AoPaVTwB60+wfqXEEKVRdo/44ym2Xo13SUkM2VPs3P/obRHz2YixmXH0kNvwfv7mIfvs7tQgsx2EPEmZtFciVORQQnNTJYv+CY6Qa9L9tKKUOaW4PHOH8QfWFBm5iiNP2BrluNvOBO1lnxpPXalf8+h+wtrvqbUBwC3M3imHIxwohPnNhj9qFo1Ldd3K5m/HGuMag9+ZWS90Orkl4R2AVngp2OZjTifxzAohiY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(396003)(136003)(39840400004)(376002)(6512007)(6916009)(66476007)(8676002)(66556008)(52116002)(66946007)(4326008)(83380400001)(6506007)(36756003)(6486002)(956004)(26005)(6666004)(2616005)(69590400007)(7416002)(186003)(5660300002)(478600001)(8936002)(2906002)(107886003)(16526019)(86362001)(316002)(1076003)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fMqVHhAW3H0pUwyXwITyHO8yg+6kTO98AXu35LZMOJc+NdgKrnT4EDmvrmDLrFWTJ1AptlQqKL/KYhQeH4nB3ghzyGxrrzBFnTZ7I0Uxn0F+i143KS9q7BUm17Br518FR+T7f0TDyw3ITaUHanifrcMG6Ar2m96em7Or8XLDYhq/UAF0H9RT7FozUw5JaamARFRw41Md+znK1yriPglONh22pBK2RSaOxzrBWQG0AMwY5FlZMUSYKybtxV1SCgQM0sdg4BLfrrNlu8zpidz7UucCGjcNjnET473P4WMviMJ671nBw8dfACv9TjuQdXx1YyBYqphEHtd4OhuV3KdFw19VP93ARhwM6nI7pBFARrouNK6b6x1HYg0xg5PC9Iz/si3TZ8L9ntr/5q1C1YFPBDz6Udz9NU39qBaqp/3EA5J1RzJoD/1AcaFQxev0eBgT6u2nL1aYkHvEEj6q+a2zcvIFg+kpA2niUaIlSLkUqXo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d43326-d2c5-49ca-3311-08d82fadb0a1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:43:51.3551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mP0ppvRJvbAy/miyQ8yad3IihkzkluVa7OX0IhJ8fna/Pi1f/K9JsBooz4dIdFQlLljCO+tM5tJ6aBzVdLg3b6kaeG1uYq754mbEv38AL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4534
Received-SPF: pass client-ip=40.107.8.95;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 04:43:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 stefanha@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename dirty_bitmap_mig_cleanup to dirty_bitmap_do_save_cleanup, to
stress that it is on save part.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 migration/block-dirty-bitmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 1d57bff4f6..01a536d7d3 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -259,7 +259,7 @@ static void send_bitmap_bits(QEMUFile *f, SaveBitmapState *dbms,
 }
 
 /* Called with iothread lock taken.  */
-static void dirty_bitmap_mig_cleanup(void)
+static void dirty_bitmap_do_save_cleanup(void)
 {
     SaveBitmapState *dbms;
 
@@ -406,7 +406,7 @@ static int init_dirty_bitmap_migration(void)
 
 fail:
     g_hash_table_destroy(handled_by_blk);
-    dirty_bitmap_mig_cleanup();
+    dirty_bitmap_do_save_cleanup();
 
     return -1;
 }
@@ -445,7 +445,7 @@ static void bulk_phase(QEMUFile *f, bool limit)
 /* for SaveVMHandlers */
 static void dirty_bitmap_save_cleanup(void *opaque)
 {
-    dirty_bitmap_mig_cleanup();
+    dirty_bitmap_do_save_cleanup();
 }
 
 static int dirty_bitmap_save_iterate(QEMUFile *f, void *opaque)
@@ -480,7 +480,7 @@ static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
 
     trace_dirty_bitmap_save_complete_finish();
 
-    dirty_bitmap_mig_cleanup();
+    dirty_bitmap_do_save_cleanup();
     return 0;
 }
 
-- 
2.21.0



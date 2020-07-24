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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D03C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 230A1206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uWL8/c3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230A1206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytOf-0003c3-BX
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJF-0001r7-0t; Fri, 24 Jul 2020 04:44:05 -0400
Received: from mail-am6eur05on2134.outbound.protection.outlook.com
 ([40.107.22.134]:63329 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJC-0008OD-Iw; Fri, 24 Jul 2020 04:44:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvDBF3bTRIXOTwDR5ka+FcJLUORW04/lsu+SpLawSPsnKMbSUlfeJHLwAH2LE8NNqVV04epWL7Sw6iSHMgRe4wUTfTpPM8IayG3bLJ9Hajq1ed5MdVdvoemRB7wLbR9qHLWXR3SZPrmSAzP0aG/H1N4UNqCPK1VqdQUnuLVf4305tWzmkPZ0heQLcLuBshx/QHAp4dAJV4YDmFVdfsy9Af3Dz5gpkZ+Pa+QIiAjeCGJ3YTQeZzHzyoM5QgYEjWe8eGhPt4wMq+EaX/9D3j4uvGgDeUdZ2i/mtcbR1RH7GUYDlLg8ThsDEH+NM304/ksBDg1k4SzQvHFf0/AJel00Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=io3tFOkKpzTbPb3JQ7N3yjrDorjhgOPeMsrQHBAWBrU=;
 b=V0x7uSRyoMgvlpIn6+xtkRDliyN7ziFLkPFD4LyxM4cgFmsor8zjG0oXHFtM1G4ywUcA8LBvkgzWwJjdjGeON+Jc8QpRMlAWMwRzqYDyPORHnpnlK6SdC/BbfoQ/XRViQ3W8jyQMBKmCfmtJgJ6J3MO2FV4Xv0HZdQHy++5sDho9FQB/7z1LKPoJ8yxri4SGsWNtulmFqSMnaghtLB8YimHMT8Uy8eoVcYtxj+mmlyBWAGWoUn2tEN43J05qM6DL1tv0qSeRdL3VG14ezkj65fgyVRH2rTPYEfM3ALrbAQdJ7xre+90VLSgq2clqYjhnc9YuNvIL1c/6O4hCcX9yiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=io3tFOkKpzTbPb3JQ7N3yjrDorjhgOPeMsrQHBAWBrU=;
 b=uWL8/c3L3FxKEcLabDVM3HO3JInBavygceu74sOKVIPWk5wjchjmzX9MGozt3NZ6PVahz4nlFYwpTbXPv2ISejb82JgoYaX8QVJ9pcUCOywiq47OonoCLlAxf6ayGe/+p5nw6M+EWyUIMMkuZKJLVGJuGBNI13Pk+DiQqq7vmCI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4534.eurprd08.prod.outlook.com (2603:10a6:20b:ba::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 24 Jul
 2020 08:43:52 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 08:43:52 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 10/21] migration/block-dirty-bitmap: move mutex init to
 dirty_bitmap_mig_init
Date: Fri, 24 Jul 2020 11:43:16 +0300
Message-Id: <20200724084327.15665-11-vsementsov@virtuozzo.com>
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
 Transport; Fri, 24 Jul 2020 08:43:51 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23554cd1-b5ad-4c32-012a-08d82fadb130
X-MS-TrafficTypeDiagnostic: AM6PR08MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4534CB0BAB3718983FBAF0BAC1770@AM6PR08MB4534.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tltSaCF5SszFoMU4BazddftDTIpGqyuOJU5YaOPwIV3M28zAX4SQUYKkflaOSvezCA5gEgWohRBZaHz7y285dTo6w9LOsfXNvH2QU3VI+wDKA4yOwrHiIyxR0TfNrP7KCA5VP9cTwFpXP2MKr05Iq3iKTGc0epd+JCHuNeZsoTIZWqWNV4MgeySo6F3+3keq4aQvi5Lj8MlAYDQQhQ/3q5AlfXTAb1pA9OqpPCTuTFt7KVkNtpcqTzrMRk6UpATPgreq83REQXEKLn/q8iM0aLkKuVTElu6YwNuSS0FF0bteI2xGNbG4JBPP1PfwKibV4ZxvEJPA41sZrWCUHW9llZ7yKipgaKGM7zhR+n5HEFD7KcJZJ/pYDv7KQBPV6rvmbHDyFDMCkytd6eoSdl2qsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(396003)(136003)(39840400004)(376002)(6512007)(6916009)(66476007)(8676002)(66556008)(52116002)(66946007)(4326008)(83380400001)(6506007)(36756003)(6486002)(956004)(26005)(6666004)(2616005)(69590400007)(7416002)(186003)(5660300002)(478600001)(8936002)(2906002)(107886003)(16526019)(86362001)(316002)(1076003)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: JULAZBZ6Z2Jipjyd5Hwq4E/W2s6Iq5Omk2VvpO3XZTUmHoAXUk0iTToc39SRtOwUu1sJH3vVxHy+SBGk1EWZ2mrOy2zZsA+OvjbYNpgdYzYbIgN/COQWl8bFKQicfIl4BrAWRpGhiuM/weUQOiI7QCtjioQqWzBiVr+M3dta9yNYqvr5k9NWrRfTIeAwK4DfIrmIYaEhTmMHgSb4mIzccYOCvFW0VP+CJvXG0pYbxZCyx97WE89OJ7ICRRzJqZq4TqiKsdFBL8k5RpGKFbYr2noQaKegnn0Jh+j1KP4EwKWNvJguY1S88tw2Cyzh1jpQohN4FdoNVA4uVA6MCfAuFOzuQU/My30o0k5oApLz6zNbW8W2QMsnLPuotrGMUY6fyMoXLmbU/ikgxCbRbcHLjRYqYNlC1gOy3CZgGB5YYmI/XXfQ51uSQ7ydGYMcvQD0wGU4AhE6OR9OYCVtydZccM6i1AXh9Xr2fpaq0m3ETJk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23554cd1-b5ad-4c32-012a-08d82fadb130
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:43:52.2720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/Ob5T1FT4BIE8cAJC7jiokfiTOkGwcZ2dBzA3NUsNmFeLSy81rI60rtL+qx4DVt5FOUOi1wp4d4yniIhtea7Z4SrPdVAb6TLouj4MaPZ10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4534
Received-SPF: pass client-ip=40.107.22.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 04:43:47
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

No reasons to keep two public init functions.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 migration/migration.h          | 1 -
 migration/block-dirty-bitmap.c | 6 +-----
 migration/migration.c          | 2 --
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index f617960522..ab20c756f5 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -335,7 +335,6 @@ void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
 void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
 
 void dirty_bitmap_mig_before_vm_start(void);
-void init_dirty_bitmap_incoming_migration(void);
 void migrate_add_address(SocketAddress *address);
 
 int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 01a536d7d3..4b67e4f4fb 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -148,11 +148,6 @@ typedef struct LoadBitmapState {
 static GSList *enabled_bitmaps;
 QemuMutex finish_lock;
 
-void init_dirty_bitmap_incoming_migration(void)
-{
-    qemu_mutex_init(&finish_lock);
-}
-
 static uint32_t qemu_get_bitmap_flags(QEMUFile *f)
 {
     uint8_t flags = qemu_get_byte(f);
@@ -801,6 +796,7 @@ static SaveVMHandlers savevm_dirty_bitmap_handlers = {
 void dirty_bitmap_mig_init(void)
 {
     QSIMPLEQ_INIT(&dirty_bitmap_mig_state.dbms_list);
+    qemu_mutex_init(&finish_lock);
 
     register_savevm_live("dirty-bitmap", 0, 1,
                          &savevm_dirty_bitmap_handlers,
diff --git a/migration/migration.c b/migration/migration.c
index 2ed9923227..1c61428988 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -165,8 +165,6 @@ void migration_object_init(void)
     qemu_sem_init(&current_incoming->postcopy_pause_sem_dst, 0);
     qemu_sem_init(&current_incoming->postcopy_pause_sem_fault, 0);
 
-    init_dirty_bitmap_incoming_migration();
-
     if (!migration_object_check(current_migration, &err)) {
         error_report_err(err);
         exit(1);
-- 
2.21.0



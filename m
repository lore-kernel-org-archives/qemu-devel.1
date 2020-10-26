Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5409DC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7B222071A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GVKqBRYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B222071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6MA-00006T-G3
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68w-0007bu-Gr; Mon, 26 Oct 2020 13:18:50 -0400
Received: from mail-eopbgr60093.outbound.protection.outlook.com
 ([40.107.6.93]:39555 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68u-0008NC-IM; Mon, 26 Oct 2020 13:18:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+v/rryiRIU4bV+7PwYuvXVFYlJZ1M/izEKNo5RstOfSyH+RlvQ7hm4RpSiYv0Zs8mki/WfUAYTmOdytVLbjBXDNWZxBnlW/uDwAareMXDOFEMY8VFfKyJ8x/731vadSe1u9FglZ/h3NQVri3uOQsKe4EU74Oel3wTuT1M68QXdXDrkVnItrC8gIKX8+GM+sadNhuFnwLAaaHAoy5RsDGylqWDE1/x3ZXYlbPYHsDGg13HIayJBa3hRCLf7chV2rl5LDe9wXDtl63Gc08BHJ4rzhk0eZr5N95MSp1NeXkKrNkinEry0wXaLr0QY6IfgABPMGJZD1NZbm0kIE8IRA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtTME5o0UhFe7j6lZBXPH7TdbO6DkBIv6DtoVdADcxM=;
 b=WGUzlROfTdeuTZM9QM6uDvBukDqE4NEUe0NgNIAkqGnMRCuOSYDZ06rwiJ8x/HIgAiVEb7G7AKT8ogkxnB4MPBN5/I0dnu39EkiBBQ9iFE0emJlOxPHPdRnDVscCkIF33d2icZ5os27dUZz2/RWX+TBq72RFnXwAIDIBR7XrMyOb9FVSYSsjyOJuV6hctVz2qsgdwy7Jb+2PibOgiy4L3+j9J7leH5x8Ul8o8sULDI2Msb/rXAg9JODxmOYNlaUEPtEQ9pwC5znv8LmQAZE262QtUV+goWuyeTXGMqU2TrPhxK6ivjYdfOTH05FyYP6zfSc+6F9BX8EejX6w8sHlOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtTME5o0UhFe7j6lZBXPH7TdbO6DkBIv6DtoVdADcxM=;
 b=GVKqBRYm66zZ1bQLJ2n9zNLYycNqtV981u7f5Udle9MSpzKqrNivsypBhUSlVM8QO54yYEVanRI4SbIAwXxwkaYIUqtOyV441EjGnVaFN2cXIjgABRzakwBU8GK3f/OhxiFcqjhqWHyyNIXhWU5wTz/H31R9As8U16ohuTliKjQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 09/25] blockjob: add set_speed to BlockJobDriver
Date: Mon, 26 Oct 2020 20:17:59 +0300
Message-Id: <20201026171815.13233-10-vsementsov@virtuozzo.com>
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
 Transport; Mon, 26 Oct 2020 17:18:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d98e2d0-07bc-4f70-644f-08d879d32d3b
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032B10AD5D785FE253CBE90C1190@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S6ZhjlDUA9i1XUuhUvGvYJro5DKTiYH+JvgfxAGCQMEvjMtY08sOUDO6HBjkXhrypa8NC58y09WKX5Nph06E9FpeeyAX2y/88/vSPF2cDGBqgTSDULHd57XbqHrfH6nCys1GUSx8YKBoUqczBGYu3RUY+WuUx5BCgSRRnkDIO61gdwNdUlsveEUE/j8QGJM5mCBG/TeI/TWSN//Ha4g0XlImc0GP+eEiRlpgnJgCun29I7ZzTZFKi/SVlAL+KhQykMy9fWX8LLIa4VxvICQRm9wRvlfMyj/oHaD2//gMEOYGbWGf9MY8DIdTXPpXxDdvh+i1z9tZzNbuQ3HznawT7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39840400004)(66476007)(8936002)(5660300002)(316002)(6506007)(6512007)(2616005)(66946007)(956004)(66556008)(6666004)(26005)(4326008)(36756003)(478600001)(52116002)(1076003)(16526019)(83380400001)(2906002)(186003)(6916009)(8676002)(107886003)(86362001)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: w57WsYySrdsvqDLO1UB6T+Vi+SnApAQUo1qvIX+WzY0RjsYao2oW18nfvhChoruhhqH3/q41X/mU2JACKC8EvfiITKIazxX0H5q5bodOiOP/fzbslAuJfNKfD1VHG2pADKIXx7kxMooYJiYiwIRlPnELOoXON0q8OpgEHT/eslTXxKvjMuBtW9Tm6JEsefiwC/wa94iDIrbkC2DmAy7qvvyWYNnkc45o2cOWrqQNzoh1Xsx83UTDvLneaJcun5jWcGGUn70IDB/ZGK2x0D/zSFyX9I/dXD3b/6yU8YoXrJEe2WX0mmc/fSmAhqPfv2jz3hkXVyMJ/OHd7KeFc+j2KG2x2fwIZFJeUs7NJncUUJeVHHh/AA3z1iP2Mx8ez/EJL9Mfk7bY5bmaS9uVMyLVFfZz+Mx3kLX2dyCCnQRcQtW/tjJJnq5yvSe7iUvBaMZwNtI81CmJLpYEhemZheUq0MHgL85YmdHdr1uJcmEyiXmzxN5W6CYjzNO/u3NkVDaOrTElnHLH33jCLg9QEEIMm8L1WfAP3g+slT7TGJmiPiKPQouuNDWWTEztqAj1qRwxhJK7K+bZ+2mLEqnyX+20TFyzUh4oP/qPslgZ8ZcQ3CY4APwPrmNbu0O9W8eCV48oO8DgnNDayy59gmUDS7qysQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d98e2d0-07bc-4f70-644f-08d879d32d3b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:37.8176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOL6RbGCRUhdYhylVMeB74pLia3JEw7h5TCSPwH1iTYib7x+ahkVhrE3qKHBoHxDn8p2RFKTYY+Mao6G4Sg6IrnrsZyjETucTzPWJtpaNoQ=
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

We are going to use async block-copy call in backup, so we'll need to
passthrough setting backup speed to block-copy call.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/blockjob_int.h | 2 ++
 blockjob.c                   | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index e2824a36a8..6633d83da2 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -52,6 +52,8 @@ struct BlockJobDriver {
      * besides job->blk to the new AioContext.
      */
     void (*attached_aio_context)(BlockJob *job, AioContext *new_context);
+
+    void (*set_speed)(BlockJob *job, int64_t speed);
 };
 
 /**
diff --git a/blockjob.c b/blockjob.c
index 98ac8af982..db3a21699c 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -256,6 +256,7 @@ static bool job_timer_pending(Job *job)
 
 void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
 {
+    const BlockJobDriver *drv = block_job_driver(job);
     int64_t old_speed = job->speed;
 
     if (job_apply_verb(&job->job, JOB_VERB_SET_SPEED, errp)) {
@@ -270,6 +271,11 @@ void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
     ratelimit_set_speed(&job->limit, speed, BLOCK_JOB_SLICE_TIME);
 
     job->speed = speed;
+
+    if (drv->set_speed) {
+        drv->set_speed(job, speed);
+    }
+
     if (speed && speed <= old_speed) {
         return;
     }
-- 
2.21.3



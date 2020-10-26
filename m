Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1904CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83132207F7
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qXjez5gh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83132207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6HV-0002lg-CL
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68m-0007Kk-Ag; Mon, 26 Oct 2020 13:18:40 -0400
Received: from mail-eopbgr60108.outbound.protection.outlook.com
 ([40.107.6.108]:26030 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68j-0008Ma-Of; Mon, 26 Oct 2020 13:18:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VphG3vcWBQNkYUxExP4vY7VhSWFLlClMQyHDDpoAnMjBhkSuBh5NaZb1N6Vld0YnkgVBdzM+5Y9vDn0eNWVtMhxl7Kk/Fv5ktCBxomTaR+dynKVtU4K1nEfS7NdlCBvWltyUMN3HXUUdMvX8bwm98P63OY3UMCX3xOPIZUatvYLrJEyw13Mi/3stPFwnB6KANYuHHV8dqK+M+F79vfg4+dd5AX2GQyiMVAJ7nPMMeIEewnd5/UnO/GILZ9bonbgaCDKHDe5hIpq+ZseUlummqa82hAXSYOtlwwRATFOlicVMHMDRreuK4gpASei7+u+ed8+w4Of6fx++Nxv/p9p/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88hyOsjzyQ4zATbbMpV2IBFUipKVkBuxs8teh8Zkj4I=;
 b=nbv//gCAvDtx768k28zAfDfV1E22Q7pNe0DqTgjA6N6SEw94sj48qYRxj2xFibJnvQv8wZAqC2mxb/0DDWnTd2WY8/pWQIIhyVP9HyCEKmtsgtvBVAmGdkzeQhN/C/SecwCyUiJh201Pwk7v98IzK+h2mLnii8WPLH2/blicH+R4i0pvWL00cwWZ+2wPQSaSSkwM0Y3xGKLIwm0b7XQ4gSlBtbwegllFLylAN9CN+ty+N3ZKpzNu8MJo2ciAM9zGaZOyN88nfcxCAG2rhKY/stIhdBVO9B63uLD8fc2Ou7RVL0oQJ5O4gcVAV7aufvap+mC/Zem+E8TQprcRK3byIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88hyOsjzyQ4zATbbMpV2IBFUipKVkBuxs8teh8Zkj4I=;
 b=qXjez5ghIXk2YXlpbvuftSABfgASEROuryetwvWQRdJ0DOcMSeEHZnTK9IsjrKcUsthifow7BZkO0KaQGzDMwgzMRqP/w9JofRGJ4URuZ51qPIdUS5IrgI4CsqqEdaH4Ri8Xa4+iXnqWIn6KtMUPU5SzQjouL2BBoUn/7Ic4NYM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5031.eurprd08.prod.outlook.com (2603:10a6:20b:ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:31 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 02/25] qapi: backup: add perf.use-copy-range parameter
Date: Mon, 26 Oct 2020 20:17:52 +0300
Message-Id: <20201026171815.13233-3-vsementsov@virtuozzo.com>
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
 Transport; Mon, 26 Oct 2020 17:18:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26bb347e-a04a-46df-0549-08d879d32981
X-MS-TrafficTypeDiagnostic: AM6PR08MB5031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5031D7ECAD392E343EE18992C1190@AM6PR08MB5031.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VIoGTeGZjtQ3zx+2g+E1634mdVoiocuRD8Y/W1QBwdVAbxecJ4004FTMZZuhXqb47BZPZ8xcdsqZTEn0MYJIhDQxi373tK0ndNM9Cz4x8h+sq3yM/dbBhYkH/pCIbbdnvjIJsyxF1NRLYWLMtF3UcVkDL0usClAXvJEqkreODphC0hGB1b1xUsyTUHskb1pCkzTXbA3dvqnUcyYF+xTRRP2UwnV9BSCciXYE+t4H/X4xhKIHxG7joAPqllRgMkUrLEPnM57AITQrKFA7CmCJDurn8U53+QJ42N9DYy1xeqUM3xZ94xTfyJl9mDC+tAHS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39840400004)(346002)(376002)(396003)(83380400001)(5660300002)(1076003)(316002)(2616005)(478600001)(6506007)(4326008)(6666004)(66946007)(26005)(66556008)(956004)(36756003)(6486002)(6512007)(186003)(66476007)(8936002)(52116002)(2906002)(16526019)(107886003)(8676002)(6916009)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: me/3NgBFlBpGYJgGPzKD6NpR+Vu6849OfJf7BcMVGPsnPfjREXKG/hiJV01tkD8m4/UMU4PPacMTr3zzRUigKKhvHmaisxop0WIcRQPadnkGd3KglxQhSvyij54h9yGW/8qyQWeWOct38TN7GiuuK9DK5IMk+/+fJ1fXsPjImcf+/yRgUGKgldVJV5F1UcrlpK2XTm6c2UppUZm6RBM5azsAFLRus6WK7e9PUT3FQTLD4FVVIAQ0VDtnNXL43QWXZEGX+UFc1186Kow1/b/mkHAfuhkuXlzE/FfXBVYEA0CPqTDhHG5tDWU1KRs12shlsrKcGv1e0qKcecnhoI38T7xAw+GCaIpSAtISrOMnCpDDyMA+fvRyfoXstaBfLroYpgk+J7pSUihHtZeZbo6otRLpv4GH/vz242tjKh0v1l92KDlhYOTfmyF4kje7Sok2u9wlhbhjtaZoiGFJpXZEoHK2tra+iqr5nVMC+Fth5sro+zfXNoy8CLamFa1mRPcx+UISBDAqidYml1cyF/n/c0i8m3serPWwr6o42PnAmRapEn9pLD1FkElLFC5xIxC2T7QkDon4Cxp9xShj7OZVLEuFqgypHZDf8TG/ZANm4wWxFtnyAFT4lfcVV9NqM5osJi9IV403OcRw0clKmmiaqg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bb347e-a04a-46df-0549-08d879d32981
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:31.6089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijt3rtlLuQgEkczIeaJTroSjay25j0Nh5RlheS0eYbzf19CJ3f/VaHi51jZ46TH0BUcxZEdd7EY8LO9ckgj7/HkV8y0tdii7W18Vwmr4FbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5031
Received-SPF: pass client-ip=40.107.6.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:18:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Experiments show, that copy_range is not always making things faster.
So, to make experimentation simpler, let's add a parameter. Some more
perf parameters will be added soon, so here is a new struct.

For now, add new backup qmp parameter with x- prefix for the following
reasons:

 - We are going to add more performance parameters, some will be
   related to the whole block-copy process, some only to background
   copying in backup (ignored for copy-before-write operations).
 - On the other hand, we are going to use block-copy interface in other
   block jobs, which will need performance options as well.. And it
   should be the same structure or at least somehow related.

So, there are too much unclean things about how the interface and now
we need the new options mostly for testing. Let's keep them
experimental for a while.

In do_backup_common() new x-perf parameter handled in a way to
make further options addition simpler.

We add use-copy-range with default=true, and we'll change the default
in further patch, after moving backup to use block-copy.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json       | 17 ++++++++++++++++-
 block/backup-top.h         |  1 +
 include/block/block-copy.h |  2 +-
 include/block/block_int.h  |  3 +++
 block/backup-top.c         |  4 +++-
 block/backup.c             |  6 +++++-
 block/block-copy.c         |  4 ++--
 block/replication.c        |  2 ++
 blockdev.c                 |  8 ++++++++
 9 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index e74669159c..71e6faa15c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1370,6 +1370,19 @@
 { 'struct': 'BlockdevSnapshot',
   'data': { 'node': 'str', 'overlay': 'str' } }
 
+##
+# @BackupPerf:
+#
+# Optional parameters for backup. These parameters don't affect
+# functionality, but may significantly affect performance.
+#
+# @use-copy-range: Use copy offloading. Default true.
+#
+# Since: 5.2
+##
+{ 'struct': 'BackupPerf',
+  'data': { '*use-copy-range': 'bool' }}
+
 ##
 # @BackupCommon:
 #
@@ -1425,6 +1438,8 @@
 #                    above node specified by @drive. If this option is not given,
 #                    a node name is autogenerated. (Since: 4.2)
 #
+# @x-perf: Performance options. (Since 5.2)
+#
 # Note: @on-source-error and @on-target-error only affect background
 #       I/O.  If an error occurs during a guest write request, the device's
 #       rerror/werror actions will be used.
@@ -1439,7 +1454,7 @@
             '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
-            '*filter-node-name': 'str' } }
+            '*filter-node-name': 'str', '*x-perf': 'BackupPerf'  } }
 
 ##
 # @DriveBackup:
diff --git a/block/backup-top.h b/block/backup-top.h
index e5cabfa197..b28b0031c4 100644
--- a/block/backup-top.h
+++ b/block/backup-top.h
@@ -33,6 +33,7 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
                                          BlockDriverState *target,
                                          const char *filter_node_name,
                                          uint64_t cluster_size,
+                                         BackupPerf *perf,
                                          BdrvRequestFlags write_flags,
                                          BlockCopyState **bcs,
                                          Error **errp);
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index aac85e1488..6397505f30 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -22,7 +22,7 @@ typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaque);
 typedef struct BlockCopyState BlockCopyState;
 
 BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
-                                     int64_t cluster_size,
+                                     int64_t cluster_size, bool use_copy_range,
                                      BdrvRequestFlags write_flags,
                                      Error **errp);
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 887b0668d8..dc1ed349df 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1248,6 +1248,8 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
  * @sync_mode: What parts of the disk image should be copied to the destination.
  * @sync_bitmap: The dirty bitmap if sync_mode is 'bitmap' or 'incremental'
  * @bitmap_mode: The bitmap synchronization policy to use.
+ * @perf: Performance options. All actual fields assumed to be present,
+ *        all ".has_*" fields are ignored.
  * @on_source_error: The action to take upon error reading from the source.
  * @on_target_error: The action to take upon error writing to the target.
  * @creation_flags: Flags that control the behavior of the Job lifetime.
@@ -1266,6 +1268,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                             BitmapSyncMode bitmap_mode,
                             bool compress,
                             const char *filter_node_name,
+                            BackupPerf *perf,
                             BlockdevOnError on_source_error,
                             BlockdevOnError on_target_error,
                             int creation_flags,
diff --git a/block/backup-top.c b/block/backup-top.c
index fe6883cc97..789acf6965 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -186,6 +186,7 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
                                          BlockDriverState *target,
                                          const char *filter_node_name,
                                          uint64_t cluster_size,
+                                         BackupPerf *perf,
                                          BdrvRequestFlags write_flags,
                                          BlockCopyState **bcs,
                                          Error **errp)
@@ -244,7 +245,8 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
 
     state->cluster_size = cluster_size;
     state->bcs = block_copy_state_new(top->backing, state->target,
-                                      cluster_size, write_flags, &local_err);
+                                      cluster_size, perf->use_copy_range,
+                                      write_flags, &local_err);
     if (local_err) {
         error_prepend(&local_err, "Cannot create block-copy-state: ");
         goto fail;
diff --git a/block/backup.c b/block/backup.c
index 9afa0bf3b4..4b07e9115d 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -46,6 +46,7 @@ typedef struct BackupBlockJob {
     uint64_t len;
     uint64_t bytes_read;
     int64_t cluster_size;
+    BackupPerf perf;
 
     BlockCopyState *bcs;
 } BackupBlockJob;
@@ -335,6 +336,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                   BitmapSyncMode bitmap_mode,
                   bool compress,
                   const char *filter_node_name,
+                  BackupPerf *perf,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   int creation_flags,
@@ -441,7 +443,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                   (compress ? BDRV_REQ_WRITE_COMPRESSED : 0),
 
     backup_top = bdrv_backup_top_append(bs, target, filter_node_name,
-                                        cluster_size, write_flags, &bcs, errp);
+                                        cluster_size, perf,
+                                        write_flags, &bcs, errp);
     if (!backup_top) {
         goto error;
     }
@@ -464,6 +467,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     job->bcs = bcs;
     job->cluster_size = cluster_size;
     job->len = len;
+    job->perf = *perf;
 
     block_copy_set_progress_callback(bcs, backup_progress_bytes_callback, job);
     block_copy_set_progress_meter(bcs, &job->common.job.progress);
diff --git a/block/block-copy.c b/block/block-copy.c
index cd9bc47c8f..63398a171c 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -218,7 +218,7 @@ static uint32_t block_copy_max_transfer(BdrvChild *source, BdrvChild *target)
 }
 
 BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
-                                     int64_t cluster_size,
+                                     int64_t cluster_size, bool use_copy_range,
                                      BdrvRequestFlags write_flags, Error **errp)
 {
     BlockCopyState *s;
@@ -260,7 +260,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
          * We enable copy-range, but keep small copy_size, until first
          * successful copy_range (look at block_copy_do_copy).
          */
-        s->use_copy_range = true;
+        s->use_copy_range = use_copy_range;
         s->copy_size = MAX(s->cluster_size, BLOCK_COPY_MAX_BUFFER);
     }
 
diff --git a/block/replication.c b/block/replication.c
index 0c70215784..22ffc811ee 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -454,6 +454,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
     int64_t active_length, hidden_length, disk_length;
     AioContext *aio_context;
     Error *local_err = NULL;
+    BackupPerf perf = { .use_copy_range = true };
 
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
@@ -558,6 +559,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         s->backup_job = backup_job_create(
                                 NULL, s->secondary_disk->bs, s->hidden_disk->bs,
                                 0, MIRROR_SYNC_MODE_NONE, NULL, 0, false, NULL,
+                                &perf,
                                 BLOCKDEV_ON_ERROR_REPORT,
                                 BLOCKDEV_ON_ERROR_REPORT, JOB_INTERNAL,
                                 backup_job_completed, bs, NULL, &local_err);
diff --git a/blockdev.c b/blockdev.c
index fe6fb5dc1d..b71ed08a3b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2788,6 +2788,7 @@ static BlockJob *do_backup_common(BackupCommon *backup,
 {
     BlockJob *job = NULL;
     BdrvDirtyBitmap *bmap = NULL;
+    BackupPerf perf = { .use_copy_range = true };
     int job_flags = JOB_DEFAULT;
 
     if (!backup->has_speed) {
@@ -2812,6 +2813,12 @@ static BlockJob *do_backup_common(BackupCommon *backup,
         backup->compress = false;
     }
 
+    if (backup->x_perf) {
+        if (backup->x_perf->has_use_copy_range) {
+            perf.use_copy_range = backup->x_perf->use_copy_range;
+        }
+    }
+
     if ((backup->sync == MIRROR_SYNC_MODE_BITMAP) ||
         (backup->sync == MIRROR_SYNC_MODE_INCREMENTAL)) {
         /* done before desugaring 'incremental' to print the right message */
@@ -2885,6 +2892,7 @@ static BlockJob *do_backup_common(BackupCommon *backup,
                             backup->sync, bmap, backup->bitmap_mode,
                             backup->compress,
                             backup->filter_node_name,
+                            &perf,
                             backup->on_source_error,
                             backup->on_target_error,
                             job_flags, NULL, NULL, txn, errp);
-- 
2.21.3



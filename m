Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15DBC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 02:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C40423D3A
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 02:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="jq6Vi32s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C40423D3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmpSK-0000d2-RO
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 22:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1jmpR9-0007RE-Ms
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 22:10:23 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:34840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1jmpR7-0002Xz-Et
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 22:10:23 -0400
Received: by mail-pj1-x1044.google.com with SMTP id i4so6657357pjd.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 19:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=eJtbvtc4HSwCbqYdU83U7eA8UzAD1t/5C/DVX5jowMQ=;
 b=jq6Vi32sBTiPp/7Hi1HEZpvYViN/pkdb/bUgQ1yCBS9OytcEkKAAtWHf+9ui9jhGHp
 eo9elJgu/IinGbTyyzYsP/5y8igVr66vF0+GnT9AucLmuCBoOA/6H8K+GTsOgbSgEQYD
 slg0xHpNh/5VXQwZX03RyYOXm/aknBk811Mj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=eJtbvtc4HSwCbqYdU83U7eA8UzAD1t/5C/DVX5jowMQ=;
 b=cT+0VDXrhf+T2ztLE80AGBspAdWHfFalBR3q2c9Xn9CE8w7pYTx5D/H2VVsI9zw0pT
 9FuHNa/KPDydrFCzJga5KVigOfdZkrJyZXonYXWCCr+s5G6l/ZbTT4P30/LsbvhfdxzQ
 XyTQd/ATciposud88J0ZxAt0d2Hj0wJ4bl6u0taNPGuVXwFikTAIGFdt31zW3WvW2luz
 xl8cWgCMWYa+Yt4hR3xjm2DIsmV4C38bF2heAuBeAMhwsdMeyVY2QPRD/ROCbTJ7nyGu
 aspe1ClfbH5sXMseYQm6hz218CcEQyEzJoaaEJJc6WFA73CBLbDxGQouFtxIHq9TX/9T
 MG4Q==
X-Gm-Message-State: AOAM533Tz4uRB6oic4V81odxaOjIqzG0zwyJDL8FMrp+Asuc1ScohQlV
 3PA5qy2rwPuUPqNUT5cIOYFkWvrY5fogwQ==
X-Google-Smtp-Source: ABdhPJz1uigXxZdJKLeaGjMcxkvxan3VL8mIpHBAOztwIVIj03PNQv9aajo7BEC6E91vRYesmt4/dA==
X-Received: by 2002:a17:90a:3608:: with SMTP id
 s8mr11483802pjb.86.1592705419602; 
 Sat, 20 Jun 2020 19:10:19 -0700 (PDT)
Received: from localhost.localdomain (202-39-79-13.HINET-IP.hinet.net.
 [202.39.79.13])
 by smtp.gmail.com with ESMTPSA id q6sm9589537pff.79.2020.06.20.19.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 19:10:19 -0700 (PDT)
From: Derek Su <dereksu@qnap.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/1] migration/colo.c: migrate dirty ram pages before colo
 checkpoint
Date: Sun, 21 Jun 2020 10:10:04 +0800
Message-Id: <20200621021004.5559-2-dereksu@qnap.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200621021004.5559-1-dereksu@qnap.com>
References: <20200621021004.5559-1-dereksu@qnap.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=dereksu@qnap.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: zhang.zhanghailiang@huawei.com, chyang@qnap.com, quintela@redhat.com,
 Derek Su <dereksu@qnap.com>, dgilbert@redhat.com, ctcheng@qnap.com,
 jwsu1986@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To reduce the guest's downtime during checkpoint, migrate dirty
ram pages as many as possible before colo checkpoint.

If the iteration count reaches COLO_RAM_MIGRATE_ITERATION_MAX or
ram pending size is lower than 'x-colo-migrate-ram-threshold',
stop the ram migration and colo checkpoint.

Signed-off-by: Derek Su <dereksu@qnap.com>
---
 migration/colo.c       | 79 ++++++++++++++++++++++++++++++++++++++++++
 migration/migration.c  | 20 +++++++++++
 migration/trace-events |  2 ++
 monitor/hmp-cmds.c     |  8 +++++
 qapi/migration.json    | 18 ++++++++--
 5 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index ea7d1e9d4e..a0c71d7c56 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -46,6 +46,13 @@ static Notifier packets_compare_notifier;
 static COLOMode last_colo_mode;
 
 #define COLO_BUFFER_BASE_SIZE (4 * 1024 * 1024)
+#define COLO_RAM_MIGRATE_ITERATION_MAX 10
+
+typedef enum {
+    COLO_MIG_ITERATE_RESUME = 0,  /* Resume migration iteration */
+    COLO_MIG_ITERATE_BREAK  = 1,  /* Break migration loop */
+} COLOMigIterateState;
+
 
 bool migration_in_colo_state(void)
 {
@@ -398,6 +405,68 @@ static uint64_t colo_receive_message_value(QEMUFile *f, uint32_t expect_msg,
     return value;
 }
 
+static int colo_migrate_ram_iteration(MigrationState *s, Error **errp)
+{
+    int64_t threshold_size = s->parameters.x_colo_migrate_ram_threshold;
+    uint64_t pending_size, pend_pre, pend_compat, pend_post;
+    Error *local_err = NULL;
+    int ret;
+
+    if (threshold_size == 0) {
+        return COLO_MIG_ITERATE_BREAK;
+    }
+
+    qemu_savevm_state_pending(s->to_dst_file, threshold_size,
+                              &pend_pre, &pend_compat, &pend_post);
+    pending_size = pend_pre + pend_compat + pend_post;
+
+    trace_colo_migrate_pending(pending_size, threshold_size,
+                               pend_pre, pend_compat, pend_post);
+
+    /* Still a significant amount to transfer */
+    if (pending_size && pending_size >= threshold_size) {
+        colo_send_message(s->to_dst_file, COLO_MESSAGE_MIGRATE_RAM, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return COLO_MIG_ITERATE_BREAK;
+        }
+
+        qemu_savevm_state_iterate(s->to_dst_file, false);
+        qemu_put_byte(s->to_dst_file, QEMU_VM_EOF);
+
+        ret = qemu_file_get_error(s->to_dst_file);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to send dirty pages");
+            return COLO_MIG_ITERATE_BREAK;
+        }
+
+        return COLO_MIG_ITERATE_RESUME;
+    }
+
+    trace_colo_migration_low_pending(pending_size);
+
+    return COLO_MIG_ITERATE_BREAK;
+}
+
+static void colo_migrate_ram_before_checkpoint(MigrationState *s, Error **errp)
+{
+    Error *local_err = NULL;
+    int iterate_count = 0;
+
+    while (iterate_count++ < COLO_RAM_MIGRATE_ITERATION_MAX) {
+        COLOMigIterateState state;
+
+        state = colo_migrate_ram_iteration(s, &local_err);
+        if (state == COLO_MIG_ITERATE_BREAK) {
+            if (local_err) {
+                error_propagate(errp, local_err);
+            }
+
+            return;
+        }
+    };
+}
+
 static int colo_do_checkpoint_transaction(MigrationState *s,
                                           QIOChannelBuffer *bioc,
                                           QEMUFile *fb)
@@ -405,6 +474,11 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
     Error *local_err = NULL;
     int ret = -1;
 
+    colo_migrate_ram_before_checkpoint(s, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
     colo_send_message(s->to_dst_file, COLO_MESSAGE_CHECKPOINT_REQUEST,
                       &local_err);
     if (local_err) {
@@ -819,6 +893,11 @@ static void colo_wait_handle_message(MigrationIncomingState *mis,
     case COLO_MESSAGE_CHECKPOINT_REQUEST:
         colo_incoming_process_checkpoint(mis, fb, bioc, errp);
         break;
+    case COLO_MESSAGE_MIGRATE_RAM:
+        if (qemu_loadvm_state_main(mis->from_src_file, mis) < 0) {
+            error_setg(errp, "Load ram failed");
+        }
+        break;
     default:
         error_setg(errp, "Got unknown COLO message: %d", msg);
         break;
diff --git a/migration/migration.c b/migration/migration.c
index 481a590f72..390937ae5d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -88,6 +88,7 @@
 
 /* The delay time (in ms) between two COLO checkpoints */
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
+#define DEFAULT_COLO_MIGRATE_RAM_THRESHOLD (100 * 1024 * 1024UL)
 #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
 #define DEFAULT_MIGRATE_MULTIFD_COMPRESSION MULTIFD_COMPRESSION_NONE
 /* 0: means nocompress, 1: best speed, ... 9: best compress ratio */
@@ -800,6 +801,9 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->downtime_limit = s->parameters.downtime_limit;
     params->has_x_checkpoint_delay = true;
     params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
+    params->has_x_colo_migrate_ram_threshold = true;
+    params->x_colo_migrate_ram_threshold =
+            s->parameters.x_colo_migrate_ram_threshold;
     params->has_block_incremental = true;
     params->block_incremental = s->parameters.block_incremental;
     params->has_multifd_channels = true;
@@ -1223,6 +1227,8 @@ static bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     /* x_checkpoint_delay is now always positive */
 
+    /* x_colo_migrate_ram_threshold is zero or positive */
+
     if (params->has_multifd_channels && (params->multifd_channels < 1)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "multifd_channels",
@@ -1356,6 +1362,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         dest->x_checkpoint_delay = params->x_checkpoint_delay;
     }
 
+    if (params->has_x_colo_migrate_ram_threshold) {
+        dest->x_colo_migrate_ram_threshold =
+            params->x_colo_migrate_ram_threshold;
+    }
+
     if (params->has_block_incremental) {
         dest->block_incremental = params->block_incremental;
     }
@@ -1463,6 +1474,11 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         }
     }
 
+    if (params->has_x_colo_migrate_ram_threshold) {
+        s->parameters.x_colo_migrate_ram_threshold =
+                params->x_colo_migrate_ram_threshold;
+    }
+
     if (params->has_block_incremental) {
         s->parameters.block_incremental = params->block_incremental;
     }
@@ -3622,6 +3638,9 @@ static Property migration_properties[] = {
     DEFINE_PROP_UINT32("x-checkpoint-delay", MigrationState,
                       parameters.x_checkpoint_delay,
                       DEFAULT_MIGRATE_X_CHECKPOINT_DELAY),
+    DEFINE_PROP_UINT64("x-colo-migrate-ram-threshold", MigrationState,
+                      parameters.x_colo_migrate_ram_threshold,
+                      DEFAULT_COLO_MIGRATE_RAM_THRESHOLD),
     DEFINE_PROP_UINT8("multifd-channels", MigrationState,
                       parameters.multifd_channels,
                       DEFAULT_MIGRATE_MULTIFD_CHANNELS),
@@ -3724,6 +3743,7 @@ static void migration_instance_init(Object *obj)
     params->has_max_bandwidth = true;
     params->has_downtime_limit = true;
     params->has_x_checkpoint_delay = true;
+    params->has_x_colo_migrate_ram_threshold = true;
     params->has_block_incremental = true;
     params->has_multifd_channels = true;
     params->has_multifd_compression = true;
diff --git a/migration/trace-events b/migration/trace-events
index 4ab0a503d2..32bf42cdb3 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -295,6 +295,8 @@ migration_tls_incoming_handshake_complete(void) ""
 colo_vm_state_change(const char *old, const char *new) "Change '%s' => '%s'"
 colo_send_message(const char *msg) "Send '%s' message"
 colo_receive_message(const char *msg) "Receive '%s' message"
+colo_migrate_pending(uint64_t size, uint64_t max, uint64_t pre, uint64_t compat, uint64_t post) "pending size %" PRIu64 " max %" PRIu64 " (pre = %" PRIu64 " compat=%" PRIu64 " post=%" PRIu64 ")"
+colo_migration_low_pending(uint64_t pending) "%" PRIu64
 
 # colo-failover.c
 colo_failover_set_state(const char *new_state) "new state %s"
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index e03adf0d4d..ebca533960 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -450,6 +450,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_X_CHECKPOINT_DELAY),
             params->x_checkpoint_delay);
+        assert(params->has_x_colo_migrate_ram_threshold);
+        monitor_printf(mon, "%s: %" PRIu64 "\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_X_COLO_MIGRATE_RAM_THRESHOLD),
+            params->x_colo_migrate_ram_threshold);
         assert(params->has_block_incremental);
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_BLOCK_INCREMENTAL),
@@ -1330,6 +1334,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_x_checkpoint_delay = true;
         visit_type_int(v, param, &p->x_checkpoint_delay, &err);
         break;
+    case MIGRATION_PARAMETER_X_COLO_MIGRATE_RAM_THRESHOLD:
+        p->has_x_colo_migrate_ram_threshold = true;
+        visit_type_int(v, param, &p->x_colo_migrate_ram_threshold, &err);
+        break;
     case MIGRATION_PARAMETER_BLOCK_INCREMENTAL:
         p->has_block_incremental = true;
         visit_type_bool(v, param, &p->block_incremental, &err);
diff --git a/qapi/migration.json b/qapi/migration.json
index d5000558c6..30576c038c 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -600,6 +600,9 @@
 # @x-checkpoint-delay: The delay time (in ms) between two COLO checkpoints in
 #                      periodic mode. (Since 2.8)
 #
+# @x-colo-migrate-ram-threshold: the threshold (in bytes) of the COLO ram migration's
+#                                pending size before COLO checkpoint. (Since 5.0)
+#
 # @block-incremental: Affects how much storage is migrated when the
 #                     block migration capability is enabled.  When false, the entire
 #                     storage backing chain is migrated into a flattened image at
@@ -651,7 +654,8 @@
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'cpu-throttle-tailslow',
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
-           'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
+           'downtime-limit', 'x-checkpoint-delay',
+           'x-colo-migrate-ram-threshold', 'block-incremental',
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle', 'multifd-compression',
@@ -740,6 +744,9 @@
 #
 # @x-checkpoint-delay: the delay time between two COLO checkpoints. (Since 2.8)
 #
+# @x-colo-migrate-ram-threshold: the threshold in bytes of the COLO ram migration's
+#                                pending size before COLO checkpoint. (Since 5.0)
+#
 # @block-incremental: Affects how much storage is migrated when the
 #                     block migration capability is enabled.  When false, the entire
 #                     storage backing chain is migrated into a flattened image at
@@ -804,6 +811,7 @@
             '*max-bandwidth': 'int',
             '*downtime-limit': 'int',
             '*x-checkpoint-delay': 'int',
+            '*x-colo-migrate-ram-threshold': 'int',
             '*block-incremental': 'bool',
             '*multifd-channels': 'int',
             '*xbzrle-cache-size': 'size',
@@ -915,6 +923,9 @@
 #
 # @x-checkpoint-delay: the delay time between two COLO checkpoints. (Since 2.8)
 #
+# @x-colo-migrate-ram-threshold: the threshold in bytes of the COLO ram migration's
+#                                pending size before COLO checkpoint. (Since 5.0)
+#
 # @block-incremental: Affects how much storage is migrated when the
 #                     block migration capability is enabled.  When false, the entire
 #                     storage backing chain is migrated into a flattened image at
@@ -978,6 +989,7 @@
             '*max-bandwidth': 'size',
             '*downtime-limit': 'uint64',
             '*x-checkpoint-delay': 'uint32',
+            '*x-colo-migrate-ram-threshold': 'uint64',
             '*block-incremental': 'bool' ,
             '*multifd-channels': 'uint8',
             '*xbzrle-cache-size': 'size',
@@ -1116,12 +1128,14 @@
 #
 # @vmstate-loaded: VM's state has been loaded by SVM.
 #
+# @migrate-ram: Send dirty pages as many as possible before COLO checkpoint.
+#
 # Since: 2.8
 ##
 { 'enum': 'COLOMessage',
   'data': [ 'checkpoint-ready', 'checkpoint-request', 'checkpoint-reply',
             'vmstate-send', 'vmstate-size', 'vmstate-received',
-            'vmstate-loaded' ] }
+            'vmstate-loaded', 'migrate-ram' ] }
 
 ##
 # @COLOMode:
-- 
2.17.1



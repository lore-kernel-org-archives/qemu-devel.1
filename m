Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216CAC433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1162206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLFt2n5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1162206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GA9-0006zp-5H
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G72-0001eW-CR
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:29:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37481
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G70-0001CW-BN
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597336193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7UtbIIB/8AW+Dzn5uvnP3+ycZ/DiyZJ0vPwihVSFY1Q=;
 b=FLFt2n5n76rgwchFh/zhhYOq9/f3GDswv38EMNEuACoTnj4BczxRZdgUoRH5nP9XX8XI6v
 wXZ+3XaWdGPQLsxem4cLP48T9bsld//fe6pFzg8SO4bg8ThgYVOBA4fSajZkI+rKu8KXpI
 Lcd+tGqiJ3HpdrK9nf1LxrjdaChWhvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-270Wm3eHNeGL-yUHkql1kA-1; Thu, 13 Aug 2020 12:29:52 -0400
X-MC-Unique: 270Wm3eHNeGL-yUHkql1kA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DAEF1005504;
 Thu, 13 Aug 2020 16:29:51 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E16B05C1A3;
 Thu, 13 Aug 2020 16:29:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 03/22] qapi: Rename BlockExport to BlockExportOptions
Date: Thu, 13 Aug 2020 18:29:16 +0200
Message-Id: <20200813162935.210070-4-kwolf@redhat.com>
In-Reply-To: <20200813162935.210070-1-kwolf@redhat.com>
References: <20200813162935.210070-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:45:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The name BlockExport will be used for the struct containing the runtime
state of block exports, so change the name of export creation options.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-export.json         | 12 ++++++------
 block/monitor/block-hmp-cmds.c |  6 +++---
 blockdev-nbd.c                 |  2 +-
 qemu-storage-daemon.c          |  8 ++++----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 62f4938e83..9332076a05 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -54,7 +54,7 @@
             '*tls-authz': 'str'} }
 
 ##
-# @BlockExportNbd:
+# @BlockExportOptionsNbd:
 #
 # An NBD block export.
 #
@@ -75,7 +75,7 @@
 #
 # Since: 5.0
 ##
-{ 'struct': 'BlockExportNbd',
+{ 'struct': 'BlockExportOptionsNbd',
   'data': {'device': 'str', '*name': 'str', '*description': 'str',
            '*writable': 'bool', '*bitmap': 'str' } }
 
@@ -90,7 +90,7 @@
 # Since: 1.3.0
 ##
 { 'command': 'nbd-server-add',
-  'data': 'BlockExportNbd', 'boxed': true }
+  'data': 'BlockExportOptionsNbd', 'boxed': true }
 
 ##
 # @NbdServerRemoveMode:
@@ -156,17 +156,17 @@
   'data': [ 'nbd' ] }
 
 ##
-# @BlockExport:
+# @BlockExportOptions:
 #
 # Describes a block export, i.e. how single node should be exported on an
 # external interface.
 #
 # Since: 4.2
 ##
-{ 'union': 'BlockExport',
+{ 'union': 'BlockExportOptions',
   'base': { 'type': 'BlockExportType' },
   'discriminator': 'type',
   'data': {
-      'nbd': 'BlockExportNbd'
+      'nbd': 'BlockExportOptionsNbd'
    } }
 
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index fb9d87ee89..56bc83ac97 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -398,7 +398,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
     Error *local_err = NULL;
     BlockInfoList *block_list, *info;
     SocketAddress *addr;
-    BlockExportNbd export;
+    BlockExportOptionsNbd export;
 
     if (writable && !all) {
         error_setg(&local_err, "-w only valid together with -a");
@@ -431,7 +431,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
             continue;
         }
 
-        export = (BlockExportNbd) {
+        export = (BlockExportOptionsNbd) {
             .device         = info->value->device,
             .has_writable   = true,
             .writable       = writable,
@@ -458,7 +458,7 @@ void hmp_nbd_server_add(Monitor *mon, const QDict *qdict)
     bool writable = qdict_get_try_bool(qdict, "writable", false);
     Error *local_err = NULL;
 
-    BlockExportNbd export = {
+    BlockExportOptionsNbd export = {
         .device         = (char *) device,
         .has_name       = !!name,
         .name           = (char *) name,
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 0f6b80c58f..98ee1b6170 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -148,7 +148,7 @@ void qmp_nbd_server_start(SocketAddressLegacy *addr,
     qapi_free_SocketAddress(addr_flat);
 }
 
-void qmp_nbd_server_add(BlockExportNbd *arg, Error **errp)
+void qmp_nbd_server_add(BlockExportOptionsNbd *arg, Error **errp)
 {
     BlockDriverState *bs = NULL;
     BlockBackend *on_eject_blk;
diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
index ed9d2afcf3..ed26097254 100644
--- a/qemu-storage-daemon.c
+++ b/qemu-storage-daemon.c
@@ -150,7 +150,7 @@ static void init_qmp_commands(void)
                          qmp_marshal_qmp_capabilities, QCO_ALLOW_PRECONFIG);
 }
 
-static void init_export(BlockExport *export, Error **errp)
+static void init_export(BlockExportOptions *export, Error **errp)
 {
     switch (export->type) {
     case BLOCK_EXPORT_TYPE_NBD:
@@ -235,14 +235,14 @@ static void process_options(int argc, char *argv[])
         case OPTION_EXPORT:
             {
                 Visitor *v;
-                BlockExport *export;
+                BlockExportOptions *export;
 
                 v = qobject_input_visitor_new_str(optarg, "type", &error_fatal);
-                visit_type_BlockExport(v, NULL, &export, &error_fatal);
+                visit_type_BlockExportOptions(v, NULL, &export, &error_fatal);
                 visit_free(v);
 
                 init_export(export, &error_fatal);
-                qapi_free_BlockExport(export);
+                qapi_free_BlockExportOptions(export);
                 break;
             }
         case OPTION_MONITOR:
-- 
2.25.4



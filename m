Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6738BC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B564F20855
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8n8cBPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B564F20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRdo-0004ks-LU
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGRCo-0005u6-Kx
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22483
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGRCa-000372-Cm
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599762103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/K3E4AQB9Wyo8p40roP4rTMm1MIlAuiE6H9hhreumsE=;
 b=e8n8cBPON2brOTxccxRKzAhwtHtwxo2JU16fsP/UvEJCLlZj0q3tcJEH46whd8dVHwrhPI
 +JhowHgtyj/acAW5I/C2SCH77pU755HJxcB/WdkG2UlTqjI5pBuI3IPf1bzn/lrvhSgK+p
 HgmQmfREzqnrszWCQFbNmVkMpTS66ek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-pyZfWwn7PiiGdpVbrXqPTQ-1; Thu, 10 Sep 2020 14:21:41 -0400
X-MC-Unique: pyZfWwn7PiiGdpVbrXqPTQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA6AD18B9F09;
 Thu, 10 Sep 2020 18:21:40 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CB7B5C1BD;
 Thu, 10 Sep 2020 18:21:40 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 21/33] filter-rewriter: Rename FILTER_COLO_REWRITER to
 FILTER_REWRITER
Date: Thu, 10 Sep 2020 14:21:00 -0400
Message-Id: <20200910182112.4030917-22-ehabkost@redhat.com>
In-Reply-To: <20200910182112.4030917-1-ehabkost@redhat.com>
References: <20200910182112.4030917-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the type checking macro name consistent with the TYPE_*
constant.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Message-Id: <20200902224311.1321159-41-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 net/filter-rewriter.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 113e293207..44f6021dd8 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -25,7 +25,7 @@
 
 #define TYPE_FILTER_REWRITER "filter-rewriter"
 typedef struct RewriterState RewriterState;
-DECLARE_INSTANCE_CHECKER(RewriterState, FILTER_COLO_REWRITER,
+DECLARE_INSTANCE_CHECKER(RewriterState, FILTER_REWRITER,
                          TYPE_FILTER_REWRITER)
 
 #define FAILOVER_MODE_ON  true
@@ -47,7 +47,7 @@ static void filter_rewriter_failover_mode(RewriterState *s)
 
 static void filter_rewriter_flush(NetFilterState *nf)
 {
-    RewriterState *s = FILTER_COLO_REWRITER(nf);
+    RewriterState *s = FILTER_REWRITER(nf);
 
     if (!qemu_net_queue_flush(s->incoming_queue)) {
         /* Unable to empty the queue, purge remaining packets */
@@ -252,7 +252,7 @@ static ssize_t colo_rewriter_receive_iov(NetFilterState *nf,
                                          int iovcnt,
                                          NetPacketSent *sent_cb)
 {
-    RewriterState *s = FILTER_COLO_REWRITER(nf);
+    RewriterState *s = FILTER_REWRITER(nf);
     Connection *conn;
     ConnectionKey key;
     Packet *pkt;
@@ -350,7 +350,7 @@ static gboolean offset_is_nonzero(gpointer key,
 static void colo_rewriter_handle_event(NetFilterState *nf, int event,
                                        Error **errp)
 {
-    RewriterState *rs = FILTER_COLO_REWRITER(nf);
+    RewriterState *rs = FILTER_REWRITER(nf);
 
     switch (event) {
     case COLO_EVENT_CHECKPOINT:
@@ -370,7 +370,7 @@ static void colo_rewriter_handle_event(NetFilterState *nf, int event,
 
 static void colo_rewriter_cleanup(NetFilterState *nf)
 {
-    RewriterState *s = FILTER_COLO_REWRITER(nf);
+    RewriterState *s = FILTER_REWRITER(nf);
 
     /* flush packets */
     if (s->incoming_queue) {
@@ -381,7 +381,7 @@ static void colo_rewriter_cleanup(NetFilterState *nf)
 
 static void colo_rewriter_setup(NetFilterState *nf, Error **errp)
 {
-    RewriterState *s = FILTER_COLO_REWRITER(nf);
+    RewriterState *s = FILTER_REWRITER(nf);
 
     s->connection_track_table = g_hash_table_new_full(connection_key_hash,
                                                       connection_key_equal,
@@ -392,7 +392,7 @@ static void colo_rewriter_setup(NetFilterState *nf, Error **errp)
 
 static bool filter_rewriter_get_vnet_hdr(Object *obj, Error **errp)
 {
-    RewriterState *s = FILTER_COLO_REWRITER(obj);
+    RewriterState *s = FILTER_REWRITER(obj);
 
     return s->vnet_hdr;
 }
@@ -401,14 +401,14 @@ static void filter_rewriter_set_vnet_hdr(Object *obj,
                                          bool value,
                                          Error **errp)
 {
-    RewriterState *s = FILTER_COLO_REWRITER(obj);
+    RewriterState *s = FILTER_REWRITER(obj);
 
     s->vnet_hdr = value;
 }
 
 static void filter_rewriter_init(Object *obj)
 {
-    RewriterState *s = FILTER_COLO_REWRITER(obj);
+    RewriterState *s = FILTER_REWRITER(obj);
 
     s->vnet_hdr = false;
     s->failover_mode = FAILOVER_MODE_OFF;
-- 
2.26.2



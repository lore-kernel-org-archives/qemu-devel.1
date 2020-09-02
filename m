Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDE7C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1628C20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9c7m5Yl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1628C20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbly-0006H5-5Z
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVL-0004xb-9s
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55648
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVJ-0000CD-FN
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/2DODI8OntZcNPlthzwtjp0XaiS5weuJi4lOpWaDxQ=;
 b=D9c7m5YlacaBZ7jaGF1zb0hdlif/bs1N9bi7x8e3fQYQMkABA5IFShLjcaqdWjexWW/BRt
 swj9FwdqopKvAgD821AKafHU3h8DTJg+uXmwVQbKPkEFEA3TJnuFKeKLQnLZeOez7q4vgi
 DThh3JcCt5PSI/2CqBKXxRCoPiFKIXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-TgoLJCsvMZu-sqcFY7OGYw-1; Wed, 02 Sep 2020 18:45:19 -0400
X-MC-Unique: TgoLJCsvMZu-sqcFY7OGYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 197761DE02;
 Wed,  2 Sep 2020 22:45:18 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8EA05D9CC;
 Wed,  2 Sep 2020 22:45:17 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 46/63] renesas: Rename RTMR to RENESAS_TMR
Date: Wed,  2 Sep 2020 18:42:54 -0400
Message-Id: <20200902224311.1321159-47-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 17:27:52
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
Cc: Magnus Damm <magnus.damm@gmail.com>, berrange@redhat.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the name of
the type checking macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: qemu-devel@nongnu.org
---
 include/hw/timer/renesas_tmr.h | 6 +++---
 hw/rx/rx62n.c                  | 2 +-
 hw/timer/renesas_tmr.c         | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/timer/renesas_tmr.h b/include/hw/timer/renesas_tmr.h
index caf7eec0dc..5f2f156160 100644
--- a/include/hw/timer/renesas_tmr.h
+++ b/include/hw/timer/renesas_tmr.h
@@ -13,10 +13,10 @@
 #include "hw/sysbus.h"
 #include "qom/object.h"
 
-#define TYPE_RENESAS_TMR "renesas-tmr"
+#define TYPE_RTMR "renesas-tmr"
 typedef struct RTMRState RTMRState;
-DECLARE_INSTANCE_CHECKER(RTMRState, RTMR,
-                         TYPE_RENESAS_TMR)
+DECLARE_INSTANCE_CHECKER(RTMRState, RENESAS_TMR,
+                         TYPE_RTMR)
 
 enum timer_event {
     cmia = 0,
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index 6eb4eea700..0f564c4dfb 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -166,7 +166,7 @@ static void register_tmr(RX62NState *s, int unit)
     int i, irqbase;
 
     object_initialize_child(OBJECT(s), "tmr[*]",
-                            &s->tmr[unit], TYPE_RENESAS_TMR);
+                            &s->tmr[unit], TYPE_RTMR);
     tmr = SYS_BUS_DEVICE(&s->tmr[unit]);
     qdev_prop_set_uint64(DEVICE(tmr), "input-freq", s->pclk_freq_hz);
     sysbus_realize(tmr, &error_abort);
diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
index 446f2eacdd..53733586c2 100644
--- a/hw/timer/renesas_tmr.c
+++ b/hw/timer/renesas_tmr.c
@@ -396,7 +396,7 @@ static void timer_event1(void *opaque)
 
 static void rtmr_reset(DeviceState *dev)
 {
-    RTMRState *tmr = RTMR(dev);
+    RTMRState *tmr = RENESAS_TMR(dev);
     tmr->tcr[0]   = tmr->tcr[1]   = 0x00;
     tmr->tcsr[0]  = 0x00;
     tmr->tcsr[1]  = 0x10;
@@ -411,7 +411,7 @@ static void rtmr_reset(DeviceState *dev)
 static void rtmr_init(Object *obj)
 {
     SysBusDevice *d = SYS_BUS_DEVICE(obj);
-    RTMRState *tmr = RTMR(obj);
+    RTMRState *tmr = RENESAS_TMR(obj);
     int i;
 
     memory_region_init_io(&tmr->memory, OBJECT(tmr), &tmr_ops,
@@ -462,7 +462,7 @@ static void rtmr_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo rtmr_info = {
-    .name = TYPE_RENESAS_TMR,
+    .name = TYPE_RTMR,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(RTMRState),
     .instance_init = rtmr_init,
-- 
2.26.2



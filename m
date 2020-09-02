Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67B7C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85FDA20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdqwB2kS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FDA20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbp7-0003Xs-MW
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVD-0004ce-Rd
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56534
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVC-00006J-1X
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NimDQSh7M1pb+P0kvk0qzYf5tPeR0EJphD4KuxuwwMI=;
 b=HdqwB2kSkx40JbcCdGUmYiDbIGi2A+8/ir2pCeoCv6DZM7P3FY9KtcxCksZ5UJDpDt61Qk
 lQcg0tu5yFVGA6anSji8WyxKVctoKIKwc54Km69/DgVzj91CMhYrngPyzDfW5DS4UIK143
 0H5z87wu5X4ie2xjBnwSBIUqf4ac7qY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-9c1eSvoqPbCqvW4SgUbkjQ-1; Wed, 02 Sep 2020 18:45:11 -0400
X-MC-Unique: 9c1eSvoqPbCqvW4SgUbkjQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B884418A2257;
 Wed,  2 Sep 2020 22:45:10 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 834FE18B59;
 Wed,  2 Sep 2020 22:45:10 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 42/63] lasi_i82596: Rename SYSBUS_I82596 to LASI_82596
Date: Wed,  2 Sep 2020 18:42:50 -0400
Message-Id: <20200902224311.1321159-43-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 16:20:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Jason Wang <jasowang@redhat.com>, berrange@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the type checking macro name consistent with the TYPE_*
constant.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Richard Henderson <rth@twiddle.net>
Cc: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/hw/net/lasi_82596.h | 2 +-
 hw/net/lasi_i82596.c        | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/net/lasi_82596.h b/include/hw/net/lasi_82596.h
index 7b62b04833..6b94726652 100644
--- a/include/hw/net/lasi_82596.h
+++ b/include/hw/net/lasi_82596.h
@@ -14,7 +14,7 @@
 
 #define TYPE_LASI_82596 "lasi_82596"
 typedef struct SysBusI82596State SysBusI82596State;
-DECLARE_INSTANCE_CHECKER(SysBusI82596State, SYSBUS_I82596,
+DECLARE_INSTANCE_CHECKER(SysBusI82596State, LASI_82596,
                          TYPE_LASI_82596)
 
 struct SysBusI82596State {
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 820b63f350..20f85946a1 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -109,7 +109,7 @@ static const VMStateDescription vmstate_lasi_82596 = {
 
 static void lasi_82596_realize(DeviceState *dev, Error **errp)
 {
-    SysBusI82596State *d = SYSBUS_I82596(dev);
+    SysBusI82596State *d = LASI_82596(dev);
     I82596State *s = &d->state;
 
     memory_region_init_io(&s->mmio, OBJECT(d), &lasi_82596_mem_ops, d,
@@ -128,7 +128,7 @@ SysBusI82596State *lasi_82596_init(MemoryRegion *addr_space,
 
     qemu_check_nic_model(&nd_table[0], TYPE_LASI_82596);
     dev = qdev_new(TYPE_LASI_82596);
-    s = SYSBUS_I82596(dev);
+    s = LASI_82596(dev);
     s->state.irq = lan_irq;
     qdev_set_nic_properties(dev, &nd_table[0]);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -141,14 +141,14 @@ SysBusI82596State *lasi_82596_init(MemoryRegion *addr_space,
 
 static void lasi_82596_reset(DeviceState *dev)
 {
-    SysBusI82596State *d = SYSBUS_I82596(dev);
+    SysBusI82596State *d = LASI_82596(dev);
 
     i82596_h_reset(&d->state);
 }
 
 static void lasi_82596_instance_init(Object *obj)
 {
-    SysBusI82596State *d = SYSBUS_I82596(obj);
+    SysBusI82596State *d = LASI_82596(obj);
     I82596State *s = &d->state;
 
     device_add_bootindex_property(obj, &s->conf.bootindex,
-- 
2.26.2



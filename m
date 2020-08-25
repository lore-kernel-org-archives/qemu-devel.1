Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6689BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 370C22075E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3ln69/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370C22075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeph-0007yU-Er
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeX5-0001nY-1a
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeX3-0006Iz-5E
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598383376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gVfQpBLlwz0/drEsGYMbc4Hl34sefwuj2gXgdeecpu4=;
 b=X3ln69/jP1DnecEArTJRba4rgm05d/qI5wLPh2cH9Pi9pvZOiqLL0fOabavp+TwSUBerNH
 I6JzLrC8Mpj9rIByg1IYLAOr/zQGlVzA/rOezRjyeP/NDvZQn1aZXbyimSc5fkdlrkzLD9
 qZaYJVG4JMBbdglTN5u4CRnI+vad6Yo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-DU5oDRQ7P_SLwk8rzMSuSw-1; Tue, 25 Aug 2020 15:22:52 -0400
X-MC-Unique: DU5oDRQ7P_SLwk8rzMSuSw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 420ED85B67B;
 Tue, 25 Aug 2020 19:22:51 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0467174E33;
 Tue, 25 Aug 2020 19:22:49 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 45/74] mos6522: Rename QOM macros
Date: Tue, 25 Aug 2020 15:20:41 -0400
Message-Id: <20200825192110.3528606-46-ehabkost@redhat.com>
In-Reply-To: <20200825192110.3528606-1-ehabkost@redhat.com>
References: <20200825192110.3528606-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename the MOS6522_DEVICE_CLASS and MOS6522_DEVICE_GET_CLASS
macros to be consistent with the TYPE_MOS6522 and MOS6522 macros.

This will make future conversion to OBJECT_DECLARE* easier.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes series v2 -> v3: new patch added to series v3

---
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org
---
 include/hw/misc/mos6522.h |  4 ++--
 hw/misc/mac_via.c         | 14 +++++++-------
 hw/misc/macio/cuda.c      |  6 +++---
 hw/misc/macio/pmu.c       |  6 +++---
 hw/misc/mos6522.c         |  8 ++++----
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
index 97384c6e02..6b25ffd439 100644
--- a/include/hw/misc/mos6522.h
+++ b/include/hw/misc/mos6522.h
@@ -140,9 +140,9 @@ typedef struct MOS6522DeviceClass {
     uint64_t (*get_timer2_load_time)(MOS6522State *dev, MOS6522Timer *ti);
 } MOS6522DeviceClass;
 
-#define MOS6522_DEVICE_CLASS(cls) \
+#define MOS6522_CLASS(cls) \
     OBJECT_CLASS_CHECK(MOS6522DeviceClass, (cls), TYPE_MOS6522)
-#define MOS6522_DEVICE_GET_CLASS(obj) \
+#define MOS6522_GET_CLASS(obj) \
     OBJECT_GET_CLASS(MOS6522DeviceClass, (obj), TYPE_MOS6522)
 
 extern const VMStateDescription vmstate_mos6522;
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index d76d7b28d3..6db62dab7d 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -328,7 +328,7 @@ static void via1_VBL(void *opaque)
 {
     MOS6522Q800VIA1State *v1s = opaque;
     MOS6522State *s = MOS6522(v1s);
-    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(s);
+    MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(s);
 
     s->ifr |= VIA1_IRQ_VBLANK;
     mdc->update_irq(s);
@@ -340,7 +340,7 @@ static void via1_one_second(void *opaque)
 {
     MOS6522Q800VIA1State *v1s = opaque;
     MOS6522State *s = MOS6522(v1s);
-    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(s);
+    MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(s);
 
     s->ifr |= VIA1_IRQ_ONE_SECOND;
     mdc->update_irq(s);
@@ -352,7 +352,7 @@ static void via1_irq_request(void *opaque, int irq, int level)
 {
     MOS6522Q800VIA1State *v1s = opaque;
     MOS6522State *s = MOS6522(v1s);
-    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(s);
+    MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(s);
 
     if (level) {
         s->ifr |= 1 << irq;
@@ -367,7 +367,7 @@ static void via2_irq_request(void *opaque, int irq, int level)
 {
     MOS6522Q800VIA2State *v2s = opaque;
     MOS6522State *s = MOS6522(v2s);
-    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(s);
+    MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(s);
 
     if (level) {
         s->ifr |= 1 << irq;
@@ -1183,7 +1183,7 @@ static TypeInfo mac_via_info = {
 static void mos6522_q800_via1_reset(DeviceState *dev)
 {
     MOS6522State *ms = MOS6522(dev);
-    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(ms);
+    MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(ms);
 
     mdc->parent_reset(dev);
 
@@ -1226,7 +1226,7 @@ static void mos6522_q800_via2_portB_write(MOS6522State *s)
 static void mos6522_q800_via2_reset(DeviceState *dev)
 {
     MOS6522State *ms = MOS6522(dev);
-    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(ms);
+    MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(ms);
 
     mdc->parent_reset(dev);
 
@@ -1246,7 +1246,7 @@ static void mos6522_q800_via2_init(Object *obj)
 static void mos6522_q800_via2_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
-    MOS6522DeviceClass *mdc = MOS6522_DEVICE_CLASS(oc);
+    MOS6522DeviceClass *mdc = MOS6522_CLASS(oc);
 
     dc->reset = mos6522_q800_via2_reset;
     mdc->portB_write = mos6522_q800_via2_portB_write;
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 286e7a55f4..edbd4186b2 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -96,7 +96,7 @@ static void cuda_set_sr_int(void *opaque)
     CUDAState *s = opaque;
     MOS6522CUDAState *mcs = &s->mos6522_cuda;
     MOS6522State *ms = MOS6522(mcs);
-    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(ms);
+    MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(ms);
 
     mdc->set_sr_int(ms);
 }
@@ -592,7 +592,7 @@ static void mos6522_cuda_portB_write(MOS6522State *s)
 static void mos6522_cuda_reset(DeviceState *dev)
 {
     MOS6522State *ms = MOS6522(dev);
-    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(ms);
+    MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(ms);
 
     mdc->parent_reset(dev);
 
@@ -603,7 +603,7 @@ static void mos6522_cuda_reset(DeviceState *dev)
 static void mos6522_cuda_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
-    MOS6522DeviceClass *mdc = MOS6522_DEVICE_CLASS(oc);
+    MOS6522DeviceClass *mdc = MOS6522_CLASS(oc);
 
     dc->reset = mos6522_cuda_reset;
     mdc->portB_write = mos6522_cuda_portB_write;
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 09022995ad..71924d4768 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -75,7 +75,7 @@ static void via_set_sr_int(void *opaque)
     PMUState *s = opaque;
     MOS6522PMUState *mps = MOS6522_PMU(&s->mos6522_pmu);
     MOS6522State *ms = MOS6522(mps);
-    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(ms);
+    MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(ms);
 
     mdc->set_sr_int(ms);
 }
@@ -834,7 +834,7 @@ static void mos6522_pmu_reset(DeviceState *dev)
     MOS6522State *ms = MOS6522(dev);
     MOS6522PMUState *mps = container_of(ms, MOS6522PMUState, parent_obj);
     PMUState *s = container_of(mps, PMUState, mos6522_pmu);
-    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(ms);
+    MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(ms);
 
     mdc->parent_reset(dev);
 
@@ -847,7 +847,7 @@ static void mos6522_pmu_reset(DeviceState *dev)
 static void mos6522_pmu_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
-    MOS6522DeviceClass *mdc = MOS6522_DEVICE_CLASS(oc);
+    MOS6522DeviceClass *mdc = MOS6522_CLASS(oc);
 
     dc->reset = mos6522_pmu_reset;
     mdc->portB_write = mos6522_pmu_portB_write;
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 19e154b870..ac4cd1d58e 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -54,7 +54,7 @@ static void mos6522_update_irq(MOS6522State *s)
 
 static uint64_t get_counter_value(MOS6522State *s, MOS6522Timer *ti)
 {
-    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(s);
+    MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(s);
 
     if (ti->index == 0) {
         return mdc->get_timer1_counter_value(s, ti);
@@ -65,7 +65,7 @@ static uint64_t get_counter_value(MOS6522State *s, MOS6522Timer *ti)
 
 static uint64_t get_load_time(MOS6522State *s, MOS6522Timer *ti)
 {
-    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(s);
+    MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(s);
 
     if (ti->index == 0) {
         return mdc->get_timer1_load_time(s, ti);
@@ -313,7 +313,7 @@ uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size)
 void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
 {
     MOS6522State *s = opaque;
-    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(s);
+    MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(s);
 
     trace_mos6522_write(addr, val);
 
@@ -498,7 +498,7 @@ static Property mos6522_properties[] = {
 static void mos6522_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
-    MOS6522DeviceClass *mdc = MOS6522_DEVICE_CLASS(oc);
+    MOS6522DeviceClass *mdc = MOS6522_CLASS(oc);
 
     dc->reset = mos6522_reset;
     dc->vmsd = &vmstate_mos6522;
-- 
2.26.2



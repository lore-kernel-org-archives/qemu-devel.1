Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FA3C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 109FE20786
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTiQyG96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109FE20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDRLV-0003pc-2z
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 07:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDRKZ-00021T-Vo
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:53:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28596
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDRKX-0006u8-WF
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599047613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ITs2sYXu0wJiB5Wf7RkuSYxTqdVyvMj12F/8Chnd3so=;
 b=OTiQyG96wHi8vDkbz2d4ezSn5Z69NRUDVC4DR4qZWvLqM2mOMiDtRbDwSE/4tK/nvLKbKB
 4rU4SH7darnrngFvgSa26ppa00fbB82kpjdFJeM3TueMbms7vP9tOWSJ5mPWgEJDavpp0B
 qw5gqI7t85zY5eYxINIUtC560sEi3oo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-1Jva-7fWPFyUBAcog95epw-1; Wed, 02 Sep 2020 07:53:29 -0400
X-MC-Unique: 1Jva-7fWPFyUBAcog95epw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2154510ABDBF;
 Wed,  2 Sep 2020 11:53:28 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAB8C7E333;
 Wed,  2 Sep 2020 11:53:27 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/20] mos6522: Rename QOM macros
Date: Wed,  2 Sep 2020 07:53:05 -0400
Message-Id: <20200902115323.850385-3-ehabkost@redhat.com>
In-Reply-To: <20200902115323.850385-1-ehabkost@redhat.com>
References: <20200902115323.850385-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:33:32
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename the MOS6522_DEVICE_CLASS and MOS6522_DEVICE_GET_CLASS
macros to be consistent with the TYPE_MOS6522 and MOS6522 macros.

This will make future conversion to OBJECT_DECLARE* easier.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20200825192110.3528606-46-ehabkost@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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



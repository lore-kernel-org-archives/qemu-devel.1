Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56967C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3542075E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4YZLThw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3542075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAep3-0006Yc-T7
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeXH-0002Ml-Ue
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:23:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26070
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeXG-0006Kc-9C
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598383389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tnPkPywknZThwcy5hE+qExHNKvieeAP0ovslwzk0UWw=;
 b=C4YZLThwvUrBj4luJ9z1S2fP2LPT48F3sYaIt23rbcvj6Jvfwp/1EOwdPWVjGN3i+mi1/F
 H+HAuadKpTKboOj6/mPtrN6IOhQAv7dxBB9pdnYLab8Px4bBhFsecI/A7Tfg3198WBgYc4
 JTjH5AnenmFnJibjUGxF2pvufKoitw4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-aO_CWl9kPVuCuuNVsr4DMw-1; Tue, 25 Aug 2020 15:23:05 -0400
X-MC-Unique: aO_CWl9kPVuCuuNVsr4DMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4709085B685;
 Tue, 25 Aug 2020 19:23:04 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31D666198B;
 Tue, 25 Aug 2020 19:23:03 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 49/74] swim: Rename struct SWIM to Swim
Date: Tue, 25 Aug 2020 15:20:45 -0400
Message-Id: <20200825192110.3528606-50-ehabkost@redhat.com>
In-Reply-To: <20200825192110.3528606-1-ehabkost@redhat.com>
References: <20200825192110.3528606-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 qemu-block@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently we have a SWIM typedef and a SWIM type checking macro,
but OBJECT_DECLARE* would transform the SWIM macro into a
function, and the function name would conflict with the SWIM
typedef name.

Rename the struct and typedef to "Swim". This will make future
conversion to OBJECT_DECLARE* easier.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes series v2 -> v3: new patch added to series v3

---
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/block/swim.h |  6 +++---
 hw/block/swim.c         | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/hw/block/swim.h b/include/hw/block/swim.h
index 6add3499d0..9d8b65c561 100644
--- a/include/hw/block/swim.h
+++ b/include/hw/block/swim.h
@@ -67,10 +67,10 @@ struct SWIMCtrl {
 };
 
 #define TYPE_SWIM "swim"
-#define SWIM(obj) OBJECT_CHECK(SWIM, (obj), TYPE_SWIM)
+#define SWIM(obj) OBJECT_CHECK(Swim, (obj), TYPE_SWIM)
 
-typedef struct SWIM {
+typedef struct Swim {
     SysBusDevice parent_obj;
     SWIMCtrl     ctrl;
-} SWIM;
+} Swim;
 #endif
diff --git a/hw/block/swim.c b/hw/block/swim.c
index 74f56e8f46..20133a814c 100644
--- a/hw/block/swim.c
+++ b/hw/block/swim.c
@@ -387,7 +387,7 @@ static const MemoryRegionOps swimctrl_mem_ops = {
 
 static void sysbus_swim_reset(DeviceState *d)
 {
-    SWIM *sys = SWIM(d);
+    Swim *sys = SWIM(d);
     SWIMCtrl *ctrl = &sys->ctrl;
     int i;
 
@@ -408,7 +408,7 @@ static void sysbus_swim_reset(DeviceState *d)
 static void sysbus_swim_init(Object *obj)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    SWIM *sbs = SWIM(obj);
+    Swim *sbs = SWIM(obj);
     SWIMCtrl *swimctrl = &sbs->ctrl;
 
     memory_region_init_io(&swimctrl->iomem, obj, &swimctrl_mem_ops, swimctrl,
@@ -418,7 +418,7 @@ static void sysbus_swim_init(Object *obj)
 
 static void sysbus_swim_realize(DeviceState *dev, Error **errp)
 {
-    SWIM *sys = SWIM(dev);
+    Swim *sys = SWIM(dev);
     SWIMCtrl *swimctrl = &sys->ctrl;
 
     qbus_create_inplace(&swimctrl->bus, sizeof(SWIMBus), TYPE_SWIM_BUS, dev,
@@ -460,7 +460,7 @@ static const VMStateDescription vmstate_sysbus_swim = {
     .name = "SWIM",
     .version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_STRUCT(ctrl, SWIM, 0, vmstate_swim, SWIMCtrl),
+        VMSTATE_STRUCT(ctrl, Swim, 0, vmstate_swim, SWIMCtrl),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -477,7 +477,7 @@ static void sysbus_swim_class_init(ObjectClass *oc, void *data)
 static const TypeInfo sysbus_swim_info = {
     .name          = TYPE_SWIM,
     .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(SWIM),
+    .instance_size = sizeof(Swim),
     .instance_init = sysbus_swim_init,
     .class_init    = sysbus_swim_class_init,
 };
-- 
2.26.2



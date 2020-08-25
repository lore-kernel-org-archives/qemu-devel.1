Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225A3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB82F2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3GHLY4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB82F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAerD-0002sK-8K
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeXF-0002G6-Ik
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:23:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36116
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeXD-0006Jz-T7
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598383387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VjxeJ9BzGMkGV1SE9TDzsM2n1mANptvL9g+g5D4ipE4=;
 b=e3GHLY4A95uwqQCiDceMw8vBH75oKOjpRfH/exsQfkdX1ermaiH+45YbonifcEWhKoRGc0
 cR7e0NTUKBKK/xH/aQaVP3GGKLU57cN8zVn6KOM96CihbgR/XmzJEDutgiEytcNKeRCzca
 0qLS+qFWXlPGwVoTyHy3OU+/sW/0Ss8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-ybcLCmRVPcapeTx3tYjqmg-1; Tue, 25 Aug 2020 15:23:03 -0400
X-MC-Unique: ybcLCmRVPcapeTx3tYjqmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 544BD807330;
 Tue, 25 Aug 2020 19:23:02 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A6DA709C4;
 Tue, 25 Aug 2020 19:22:59 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 48/74] s390-virtio-ccw: Rename S390_MACHINE_CLASS macro
Date: Tue, 25 Aug 2020 15:20:44 -0400
Message-Id: <20200825192110.3528606-49-ehabkost@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename it to be consistent with S390_CCW_MACHINE and
TYPE_S390_CCW_MACHINE.

This will make future conversion to OBJECT_DECLARE* easier.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes series v2 -> v3: new patch added to series v3

---
Cc: Richard Henderson <rth@twiddle.net>
Cc: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org
---
 include/hw/s390x/s390-virtio-ccw.h |  2 +-
 hw/s390x/s390-virtio-ccw.c         | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index cd1dccc6e3..caf4962d29 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -18,7 +18,7 @@
 #define S390_CCW_MACHINE(obj) \
     OBJECT_CHECK(S390CcwMachineState, (obj), TYPE_S390_CCW_MACHINE)
 
-#define S390_MACHINE_CLASS(klass) \
+#define S390_CCW_MACHINE_CLASS(klass) \
     OBJECT_CLASS_CHECK(S390CcwMachineClass, (klass), TYPE_S390_CCW_MACHINE)
 
 typedef struct S390CcwMachineState {
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index f4ea6a9545..3106bbea33 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -596,7 +596,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     NMIClass *nc = NMI_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
-    S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
+    S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
 
     s390mc->ri_allowed = true;
     s390mc->cpu_model_allowed = true;
@@ -677,7 +677,7 @@ static S390CcwMachineClass *get_machine_class(void)
         * be called for the 'none' machine. The properties will
         * have their after-initialization values.
         */
-        current_mc = S390_MACHINE_CLASS(
+        current_mc = S390_CCW_MACHINE_CLASS(
                      object_class_by_name(TYPE_S390_CCW_MACHINE));
     }
     return current_mc;
@@ -786,7 +786,7 @@ bool css_migration_enabled(void)
     static void ccw_machine_##suffix##_instance_init(Object *obj)             \
     {                                                                         \
         MachineState *machine = MACHINE(obj);                                 \
-        current_mc = S390_MACHINE_CLASS(MACHINE_GET_CLASS(machine));          \
+        current_mc = S390_CCW_MACHINE_CLASS(MACHINE_GET_CLASS(machine));          \
         ccw_machine_##suffix##_instance_options(machine);                     \
     }                                                                         \
     static const TypeInfo ccw_machine_##suffix##_info = {                     \
@@ -898,7 +898,7 @@ static void ccw_machine_3_0_instance_options(MachineState *machine)
 
 static void ccw_machine_3_0_class_options(MachineClass *mc)
 {
-    S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
+    S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
 
     s390mc->hpage_1m_allowed = false;
     ccw_machine_3_1_class_options(mc);
@@ -965,7 +965,7 @@ static void ccw_machine_2_9_instance_options(MachineState *machine)
 
 static void ccw_machine_2_9_class_options(MachineClass *mc)
 {
-    S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
+    S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
     static GlobalProperty compat[] = {
         { TYPE_S390_STATTRIB, "migration-enabled", "off", },
     };
@@ -1001,7 +1001,7 @@ static void ccw_machine_2_7_instance_options(MachineState *machine)
 
 static void ccw_machine_2_7_class_options(MachineClass *mc)
 {
-    S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
+    S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
 
     s390mc->cpu_model_allowed = false;
     ccw_machine_2_8_class_options(mc);
@@ -1016,7 +1016,7 @@ static void ccw_machine_2_6_instance_options(MachineState *machine)
 
 static void ccw_machine_2_6_class_options(MachineClass *mc)
 {
-    S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
+    S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
     static GlobalProperty compat[] = {
         { TYPE_S390_IPL, "iplbext_migration", "off", },
          { TYPE_VIRTUAL_CSS_BRIDGE, "css_dev_path", "off", },
-- 
2.26.2



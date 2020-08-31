Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB7FC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA792067C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fILRbhvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA792067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCr5G-0001EL-UF
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kCr2h-00050Y-UQ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:08:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54958
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kCr2c-0000AY-7L
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598908117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xrWoitSvz9YuRsnnfywphA9dYFgl5WlCvOUyAhl9mMY=;
 b=fILRbhvBAyRe9RijsH8rxWyx88XnBVgX0FSlK7mfv/kaKYbQ9U+maO+aF0qww6fBfpee2j
 bo8BSffbzkLKX/sqqSAfm7KXRp6XBzIoVKh5cCHzj0v6UB+zdiXHkebh+8rceWc4+qNOQt
 UZIacOzBKc1u34SSSpBWQGLdwn6en6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-y_z_g5VZM1uTrGq0ecVc1A-1; Mon, 31 Aug 2020 17:08:35 -0400
X-MC-Unique: y_z_g5VZM1uTrGq0ecVc1A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E41F51074641;
 Mon, 31 Aug 2020 21:08:33 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 736B278B26;
 Mon, 31 Aug 2020 21:08:33 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 09/18] [automated] Move QOM typedefs and add missing
 includes (pass 2)
Date: Mon, 31 Aug 2020 17:07:31 -0400
Message-Id: <20200831210740.126168-10-ehabkost@redhat.com>
In-Reply-To: <20200831210740.126168-1-ehabkost@redhat.com>
References: <20200831210740.126168-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 02:13:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Juan Quintela <quintela@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some typedefs and macros are defined after the type check macros.
This makes it difficult to automatically replace their
definitions with OBJECT_DECLARE_TYPE.

Patch generated using:

 $ ./scripts/codeconverter/converter.py -i \
   --pattern=QOMStructTypedefSplit $(git grep -l '' -- '*.[ch]')

which will split "typdef struct { ... } TypedefName"
declarations.

Followed by:

 $ ./scripts/codeconverter/converter.py -i --pattern=MoveSymbols \
    $(git grep -l '' -- '*.[ch]')

which will:
- move the typedefs and #defines above the type check macros
- add missing #include "qom/object.h" lines if necessary

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v3 -> v4: none

Changes series v2 -> v3: this is a new patch added in series v3

The script was re-run after rebase and after additional patches
were added to this series.

This is being submitted as a separate patch to make review
easier, but it can be squashed into the previous patch once it
gets reviewed.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

---
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org
---
 include/hw/block/swim.h    |  6 ++++--
 include/hw/display/macfb.h | 18 ++++++++++-------
 include/hw/ppc/xive.h      | 41 +++++++++++++++++++++++---------------
 include/hw/rdma/rdma.h     |  5 +++--
 migration/migration.h      |  6 ++++--
 target/rx/cpu-qom.h        |  6 ++++--
 hw/arm/integratorcp.c      | 16 +++++++++------
 hw/arm/versatilepb.c       |  6 ++++--
 hw/arm/vexpress.c          | 11 ++++++----
 hw/sd/pl181.c              |  6 ++++--
 10 files changed, 76 insertions(+), 45 deletions(-)

diff --git a/include/hw/block/swim.h b/include/hw/block/swim.h
index 9d8b65c561..f013d634f7 100644
--- a/include/hw/block/swim.h
+++ b/include/hw/block/swim.h
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "qom/object.h"
 
 #define SWIM_MAX_FD            2
 
@@ -67,10 +68,11 @@ struct SWIMCtrl {
 };
 
 #define TYPE_SWIM "swim"
+typedef struct Swim Swim;
 #define SWIM(obj) OBJECT_CHECK(Swim, (obj), TYPE_SWIM)
 
-typedef struct Swim {
+struct Swim {
     SysBusDevice parent_obj;
     SWIMCtrl     ctrl;
-} Swim;
+};
 #endif
diff --git a/include/hw/display/macfb.h b/include/hw/display/macfb.h
index 347871b623..d330ee9823 100644
--- a/include/hw/display/macfb.h
+++ b/include/hw/display/macfb.h
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "exec/memory.h"
 #include "ui/console.h"
+#include "qom/object.h"
 
 typedef struct MacfbState {
     MemoryRegion mem_vram;
@@ -31,34 +32,37 @@ typedef struct MacfbState {
 } MacfbState;
 
 #define TYPE_MACFB "sysbus-macfb"
+typedef struct MacfbSysBusState MacfbSysBusState;
 #define MACFB(obj) \
     OBJECT_CHECK(MacfbSysBusState, (obj), TYPE_MACFB)
 
-typedef struct {
+struct MacfbSysBusState {
     SysBusDevice busdev;
 
     MacfbState macfb;
-} MacfbSysBusState;
+};
 
+#define TYPE_NUBUS_MACFB "nubus-macfb"
+typedef struct MacfbNubusDeviceClass MacfbNubusDeviceClass;
+typedef struct MacfbNubusState MacfbNubusState;
 #define NUBUS_MACFB_CLASS(class) \
     OBJECT_CLASS_CHECK(MacfbNubusDeviceClass, (class), TYPE_NUBUS_MACFB)
 #define NUBUS_MACFB_GET_CLASS(obj) \
     OBJECT_GET_CLASS(MacfbNubusDeviceClass, (obj), TYPE_NUBUS_MACFB)
 
-typedef struct MacfbNubusDeviceClass {
+struct MacfbNubusDeviceClass {
     DeviceClass parent_class;
 
     DeviceRealize parent_realize;
-} MacfbNubusDeviceClass;
+};
 
-#define TYPE_NUBUS_MACFB "nubus-macfb"
 #define NUBUS_MACFB(obj) \
     OBJECT_CHECK(MacfbNubusState, (obj), TYPE_NUBUS_MACFB)
 
-typedef struct {
+struct MacfbNubusState {
     NubusDevice busdev;
 
     MacfbState macfb;
-} MacfbNubusState;
+};
 
 #endif
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 2c42ae92d2..8ef9af1969 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -143,6 +143,7 @@
 #include "sysemu/kvm.h"
 #include "hw/sysbus.h"
 #include "hw/ppc/xive_regs.h"
+#include "qom/object.h"
 
 /*
  * XIVE Notifier (Interface between Source and Router)
@@ -153,21 +154,23 @@ typedef struct XiveNotifier XiveNotifier;
 #define TYPE_XIVE_NOTIFIER "xive-notifier"
 #define XIVE_NOTIFIER(obj)                                     \
     INTERFACE_CHECK(XiveNotifier, (obj), TYPE_XIVE_NOTIFIER)
+typedef struct XiveNotifierClass XiveNotifierClass;
 #define XIVE_NOTIFIER_CLASS(klass)                                     \
     OBJECT_CLASS_CHECK(XiveNotifierClass, (klass), TYPE_XIVE_NOTIFIER)
 #define XIVE_NOTIFIER_GET_CLASS(obj)                                   \
     OBJECT_GET_CLASS(XiveNotifierClass, (obj), TYPE_XIVE_NOTIFIER)
 
-typedef struct XiveNotifierClass {
+struct XiveNotifierClass {
     InterfaceClass parent;
     void (*notify)(XiveNotifier *xn, uint32_t lisn);
-} XiveNotifierClass;
+};
 
 /*
  * XIVE Interrupt Source
  */
 
 #define TYPE_XIVE_SOURCE "xive-source"
+typedef struct XiveSource XiveSource;
 #define XIVE_SOURCE(obj) OBJECT_CHECK(XiveSource, (obj), TYPE_XIVE_SOURCE)
 
 /*
@@ -177,7 +180,7 @@ typedef struct XiveNotifierClass {
 #define XIVE_SRC_H_INT_ESB     0x1 /* ESB managed with hcall H_INT_ESB */
 #define XIVE_SRC_STORE_EOI     0x2 /* Store EOI supported */
 
-typedef struct XiveSource {
+struct XiveSource {
     DeviceState parent;
 
     /* IRQs */
@@ -198,7 +201,7 @@ typedef struct XiveSource {
     MemoryRegion    esb_mmio_kvm;
 
     XiveNotifier    *xive;
-} XiveSource;
+};
 
 /*
  * ESB MMIO setting. Can be one page, for both source triggering and
@@ -304,6 +307,7 @@ void xive_source_set_irq(void *opaque, int srcno, int val);
  */
 
 #define TYPE_XIVE_TCTX "xive-tctx"
+typedef struct XiveTCTX XiveTCTX;
 #define XIVE_TCTX(obj) OBJECT_CHECK(XiveTCTX, (obj), TYPE_XIVE_TCTX)
 
 /*
@@ -319,7 +323,7 @@ void xive_source_set_irq(void *opaque, int srcno, int val);
 
 typedef struct XivePresenter XivePresenter;
 
-typedef struct XiveTCTX {
+struct XiveTCTX {
     DeviceState parent_obj;
 
     CPUState    *cs;
@@ -329,20 +333,22 @@ typedef struct XiveTCTX {
     uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
 
     XivePresenter *xptr;
-} XiveTCTX;
+};
 
 /*
  * XIVE Router
  */
 typedef struct XiveFabric XiveFabric;
 
-typedef struct XiveRouter {
+struct XiveRouter {
     SysBusDevice    parent;
 
     XiveFabric *xfb;
-} XiveRouter;
+};
+typedef struct XiveRouter XiveRouter;
 
 #define TYPE_XIVE_ROUTER "xive-router"
+typedef struct XiveRouterClass XiveRouterClass;
 #define XIVE_ROUTER(obj)                                \
     OBJECT_CHECK(XiveRouter, (obj), TYPE_XIVE_ROUTER)
 #define XIVE_ROUTER_CLASS(klass)                                        \
@@ -350,7 +356,7 @@ typedef struct XiveRouter {
 #define XIVE_ROUTER_GET_CLASS(obj)                              \
     OBJECT_GET_CLASS(XiveRouterClass, (obj), TYPE_XIVE_ROUTER)
 
-typedef struct XiveRouterClass {
+struct XiveRouterClass {
     SysBusDeviceClass parent;
 
     /* XIVE table accessors */
@@ -365,7 +371,7 @@ typedef struct XiveRouterClass {
     int (*write_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx,
                      XiveNVT *nvt, uint8_t word_number);
     uint8_t (*get_block_id)(XiveRouter *xrtr);
-} XiveRouterClass;
+};
 
 int xive_router_get_eas(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_idx,
                         XiveEAS *eas);
@@ -391,19 +397,20 @@ typedef struct XiveTCTXMatch {
 #define TYPE_XIVE_PRESENTER "xive-presenter"
 #define XIVE_PRESENTER(obj)                                     \
     INTERFACE_CHECK(XivePresenter, (obj), TYPE_XIVE_PRESENTER)
+typedef struct XivePresenterClass XivePresenterClass;
 #define XIVE_PRESENTER_CLASS(klass)                                     \
     OBJECT_CLASS_CHECK(XivePresenterClass, (klass), TYPE_XIVE_PRESENTER)
 #define XIVE_PRESENTER_GET_CLASS(obj)                                   \
     OBJECT_GET_CLASS(XivePresenterClass, (obj), TYPE_XIVE_PRESENTER)
 
-typedef struct XivePresenterClass {
+struct XivePresenterClass {
     InterfaceClass parent;
     int (*match_nvt)(XivePresenter *xptr, uint8_t format,
                      uint8_t nvt_blk, uint32_t nvt_idx,
                      bool cam_ignore, uint8_t priority,
                      uint32_t logic_serv, XiveTCTXMatch *match);
     bool (*in_kernel)(const XivePresenter *xptr);
-} XivePresenterClass;
+};
 
 int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
                               uint8_t format,
@@ -417,28 +424,30 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
 #define TYPE_XIVE_FABRIC "xive-fabric"
 #define XIVE_FABRIC(obj)                                     \
     INTERFACE_CHECK(XiveFabric, (obj), TYPE_XIVE_FABRIC)
+typedef struct XiveFabricClass XiveFabricClass;
 #define XIVE_FABRIC_CLASS(klass)                                     \
     OBJECT_CLASS_CHECK(XiveFabricClass, (klass), TYPE_XIVE_FABRIC)
 #define XIVE_FABRIC_GET_CLASS(obj)                                   \
     OBJECT_GET_CLASS(XiveFabricClass, (obj), TYPE_XIVE_FABRIC)
 
-typedef struct XiveFabricClass {
+struct XiveFabricClass {
     InterfaceClass parent;
     int (*match_nvt)(XiveFabric *xfb, uint8_t format,
                      uint8_t nvt_blk, uint32_t nvt_idx,
                      bool cam_ignore, uint8_t priority,
                      uint32_t logic_serv, XiveTCTXMatch *match);
-} XiveFabricClass;
+};
 
 /*
  * XIVE END ESBs
  */
 
 #define TYPE_XIVE_END_SOURCE "xive-end-source"
+typedef struct XiveENDSource XiveENDSource;
 #define XIVE_END_SOURCE(obj) \
     OBJECT_CHECK(XiveENDSource, (obj), TYPE_XIVE_END_SOURCE)
 
-typedef struct XiveENDSource {
+struct XiveENDSource {
     DeviceState parent;
 
     uint32_t        nr_ends;
@@ -448,7 +457,7 @@ typedef struct XiveENDSource {
     MemoryRegion    esb_mmio;
 
     XiveRouter      *xrtr;
-} XiveENDSource;
+};
 
 /*
  * For legacy compatibility, the exceptions define up to 256 different
diff --git a/include/hw/rdma/rdma.h b/include/hw/rdma/rdma.h
index fd3d70103d..aef82e58db 100644
--- a/include/hw/rdma/rdma.h
+++ b/include/hw/rdma/rdma.h
@@ -19,6 +19,7 @@
 
 #define INTERFACE_RDMA_PROVIDER "rdma"
 
+typedef struct RdmaProviderClass RdmaProviderClass;
 #define RDMA_PROVIDER_CLASS(klass) \
     OBJECT_CLASS_CHECK(RdmaProviderClass, (klass), \
                        INTERFACE_RDMA_PROVIDER)
@@ -31,10 +32,10 @@
 
 typedef struct RdmaProvider RdmaProvider;
 
-typedef struct RdmaProviderClass {
+struct RdmaProviderClass {
     InterfaceClass parent;
 
     void (*print_statistics)(Monitor *mon, RdmaProvider *obj);
-} RdmaProviderClass;
+};
 
 #endif
diff --git a/migration/migration.h b/migration/migration.h
index ae497bd45a..4103e549bb 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -21,6 +21,7 @@
 #include "qemu/coroutine_int.h"
 #include "io/channel.h"
 #include "net/announce.h"
+#include "qom/object.h"
 
 struct PostcopyBlocktimeContext;
 
@@ -114,6 +115,7 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info);
 
 #define TYPE_MIGRATION "migration"
 
+typedef struct MigrationClass MigrationClass;
 #define MIGRATION_OBJ_CLASS(klass) \
     OBJECT_CLASS_CHECK(MigrationClass, (klass), TYPE_MIGRATION)
 #define MIGRATION_OBJ(obj) \
@@ -121,10 +123,10 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info);
 #define MIGRATION_OBJ_GET_CLASS(obj) \
     OBJECT_GET_CLASS(MigrationClass, (obj), TYPE_MIGRATION)
 
-typedef struct MigrationClass {
+struct MigrationClass {
     /*< private >*/
     DeviceClass parent_class;
-} MigrationClass;
+};
 
 struct MigrationState
 {
diff --git a/target/rx/cpu-qom.h b/target/rx/cpu-qom.h
index 9054762326..dd96469e04 100644
--- a/target/rx/cpu-qom.h
+++ b/target/rx/cpu-qom.h
@@ -20,12 +20,14 @@
 #define RX_CPU_QOM_H
 
 #include "hw/core/cpu.h"
+#include "qom/object.h"
 
 #define TYPE_RX_CPU "rx-cpu"
 
 #define TYPE_RX62N_CPU RX_CPU_TYPE_NAME("rx62n")
 
 typedef struct RXCPU RXCPU;
+typedef struct RXCPUClass RXCPUClass;
 #define RX_CPU_CLASS(klass) \
     OBJECT_CLASS_CHECK(RXCPUClass, (klass), TYPE_RX_CPU)
 #define RX_CPU(obj) \
@@ -40,14 +42,14 @@ typedef struct RXCPU RXCPU;
  *
  * A RX CPU model.
  */
-typedef struct RXCPUClass {
+struct RXCPUClass {
     /*< private >*/
     CPUClass parent_class;
     /*< public >*/
 
     DeviceRealize parent_realize;
     DeviceReset parent_reset;
-} RXCPUClass;
+};
 
 #define CPUArchState struct CPURXState
 
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index fe7c2b9d4b..75e608e68e 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -26,12 +26,14 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sd/sd.h"
+#include "qom/object.h"
 
 #define TYPE_INTEGRATOR_CM "integrator_core"
+typedef struct IntegratorCMState IntegratorCMState;
 #define INTEGRATOR_CM(obj) \
     OBJECT_CHECK(IntegratorCMState, (obj), TYPE_INTEGRATOR_CM)
 
-typedef struct IntegratorCMState {
+struct IntegratorCMState {
     /*< private >*/
     SysBusDevice parent_obj;
     /*< public >*/
@@ -51,7 +53,7 @@ typedef struct IntegratorCMState {
     uint32_t int_level;
     uint32_t irq_enabled;
     uint32_t fiq_enabled;
-} IntegratorCMState;
+};
 
 static uint8_t integrator_spd[128] = {
    128, 8, 4, 11, 9, 1, 64, 0,  2, 0xa0, 0xa0, 0, 0, 8, 0, 1,
@@ -326,10 +328,11 @@ static void integratorcm_realize(DeviceState *d, Error **errp)
 /* Primary interrupt controller.  */
 
 #define TYPE_INTEGRATOR_PIC "integrator_pic"
+typedef struct icp_pic_state icp_pic_state;
 #define INTEGRATOR_PIC(obj) \
    OBJECT_CHECK(icp_pic_state, (obj), TYPE_INTEGRATOR_PIC)
 
-typedef struct icp_pic_state {
+struct icp_pic_state {
     /*< private >*/
     SysBusDevice parent_obj;
     /*< public >*/
@@ -340,7 +343,7 @@ typedef struct icp_pic_state {
     uint32_t fiq_enabled;
     qemu_irq parent_irq;
     qemu_irq parent_fiq;
-} icp_pic_state;
+};
 
 static const VMStateDescription vmstate_icp_pic = {
     .name = "icp_pic",
@@ -465,10 +468,11 @@ static void icp_pic_init(Object *obj)
 /* CP control registers.  */
 
 #define TYPE_ICP_CONTROL_REGS "icp-ctrl-regs"
+typedef struct ICPCtrlRegsState ICPCtrlRegsState;
 #define ICP_CONTROL_REGS(obj) \
     OBJECT_CHECK(ICPCtrlRegsState, (obj), TYPE_ICP_CONTROL_REGS)
 
-typedef struct ICPCtrlRegsState {
+struct ICPCtrlRegsState {
     /*< private >*/
     SysBusDevice parent_obj;
     /*< public >*/
@@ -477,7 +481,7 @@ typedef struct ICPCtrlRegsState {
 
     qemu_irq mmc_irq;
     uint32_t intreg_state;
-} ICPCtrlRegsState;
+};
 
 #define ICP_GPIO_MMC_WPROT      "mmc-wprot"
 #define ICP_GPIO_MMC_CARDIN     "mmc-cardin"
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 9127579984..0e2d74cef2 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -26,6 +26,7 @@
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
 #include "hw/sd/sd.h"
+#include "qom/object.h"
 
 #define VERSATILE_FLASH_ADDR 0x34000000
 #define VERSATILE_FLASH_SIZE (64 * 1024 * 1024)
@@ -34,10 +35,11 @@
 /* Primary interrupt controller.  */
 
 #define TYPE_VERSATILE_PB_SIC "versatilepb_sic"
+typedef struct vpb_sic_state vpb_sic_state;
 #define VERSATILE_PB_SIC(obj) \
     OBJECT_CHECK(vpb_sic_state, (obj), TYPE_VERSATILE_PB_SIC)
 
-typedef struct vpb_sic_state {
+struct vpb_sic_state {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
@@ -46,7 +48,7 @@ typedef struct vpb_sic_state {
     uint32_t pic_enable;
     qemu_irq parent[32];
     int irq;
-} vpb_sic_state;
+};
 
 static const VMStateDescription vmstate_vpb_sic = {
     .name = "versatilepb_sic",
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 95405f5940..4c2c377823 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -44,6 +44,7 @@
 #include "hw/cpu/a15mpcore.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/sd/sd.h"
+#include "qom/object.h"
 
 #define VEXPRESS_BOARD_ID 0x8e0
 #define VEXPRESS_FLASH_SIZE (64 * 1024 * 1024)
@@ -166,16 +167,18 @@ static hwaddr motherboard_aseries_map[] = {
 
 typedef struct VEDBoardInfo VEDBoardInfo;
 
-typedef struct {
+struct VexpressMachineClass {
     MachineClass parent;
     VEDBoardInfo *daughterboard;
-} VexpressMachineClass;
+};
+typedef struct VexpressMachineClass VexpressMachineClass;
 
-typedef struct {
+struct VexpressMachineState {
     MachineState parent;
     bool secure;
     bool virt;
-} VexpressMachineState;
+};
+typedef struct VexpressMachineState VexpressMachineState;
 
 #define TYPE_VEXPRESS_MACHINE   "vexpress"
 #define TYPE_VEXPRESS_A9_MACHINE   MACHINE_TYPE_NAME("vexpress-a9")
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 579d68ad83..cb2ef0fb39 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -18,15 +18,17 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "trace.h"
+#include "qom/object.h"
 
 #define PL181_FIFO_LEN 16
 
 #define TYPE_PL181 "pl181"
+typedef struct PL181State PL181State;
 #define PL181(obj) OBJECT_CHECK(PL181State, (obj), TYPE_PL181)
 
 #define TYPE_PL181_BUS "pl181-bus"
 
-typedef struct PL181State {
+struct PL181State {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
@@ -56,7 +58,7 @@ typedef struct PL181State {
     /* GPIO outputs for 'card is readonly' and 'card inserted' */
     qemu_irq card_readonly;
     qemu_irq card_inserted;
-} PL181State;
+};
 
 static const VMStateDescription vmstate_pl181 = {
     .name = "pl181",
-- 
2.26.2



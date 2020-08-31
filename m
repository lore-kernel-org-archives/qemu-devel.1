Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97432C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547BE20866
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKjbChgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547BE20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrAH-0007wN-7r
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kCr2j-000553-Jl
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:08:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28638
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kCr2h-0000Aq-4J
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598908121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Drboy62O1LBCh7uah3AZ0Zl6FneOi0JiDtImU/qB8Yk=;
 b=IKjbChgW5lMmLbFiFyNQjE+UwMcMw6YJe4N8IIQyyamDgSxzOc9AC91bC0wtrj/hLhmoA5
 KP9aPzh1gnTxOPvhIONs98PcJzyDDVdlnK1ZeAP9VJjel8lCZWrf4GPJuSZKmKZNL6zfX8
 Ce+Abkq576NGFCytE2TOvEgieSSRiM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-MH3ZqCvYNoSPf-v-uik8Iw-1; Mon, 31 Aug 2020 17:08:39 -0400
X-MC-Unique: MH3ZqCvYNoSPf-v-uik8Iw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C73971074644;
 Mon, 31 Aug 2020 21:08:37 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CE055D9D3;
 Mon, 31 Aug 2020 21:08:34 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 10/18] [automated] Move QOM typedefs and add missing
 includes (pass 3)
Date: Mon, 31 Aug 2020 17:07:32 -0400
Message-Id: <20200831210740.126168-11-ehabkost@redhat.com>
In-Reply-To: <20200831210740.126168-1-ehabkost@redhat.com>
References: <20200831210740.126168-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 15:02:38
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-riscv@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
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

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes series v3 -> v4: this is a new patch added in series v4

The script was re-run after series rebase.

This is being submitted as a separate patch to make review
easier, but it can be squashed into the previous patch once it
gets reviewed.
---
Cc: Richard Henderson <rth@twiddle.net>
Cc: Helge Deller <deller@gmx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: qemu-riscv@nongnu.org
---
 include/hw/arm/armsse.h            | 11 +++++++----
 include/hw/riscv/spike.h           |  6 ++++--
 include/hw/virtio/vhost-user-blk.h |  6 ++++--
 hw/hppa/lasi.c                     |  6 ++++--
 4 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index 347b977ae5..e5788e9d3c 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -105,8 +105,11 @@
 #include "hw/or-irq.h"
 #include "hw/core/split-irq.h"
 #include "hw/cpu/cluster.h"
+#include "qom/object.h"
 
 #define TYPE_ARM_SSE "arm-sse"
+typedef struct ARMSSE ARMSSE;
+typedef struct ARMSSEClass ARMSSEClass;
 #define ARM_SSE(obj) OBJECT_CHECK(ARMSSE, (obj), TYPE_ARM_SSE)
 
 /*
@@ -140,7 +143,7 @@
 #define RAM3_PPU 6
 #define NUM_PPUS 7
 
-typedef struct ARMSSE {
+struct ARMSSE {
     /*< private >*/
     SysBusDevice parent_obj;
 
@@ -215,14 +218,14 @@ typedef struct ARMSSE {
     uint32_t init_svtor;
     bool cpu_fpu[SSE_MAX_CPUS];
     bool cpu_dsp[SSE_MAX_CPUS];
-} ARMSSE;
+};
 
 typedef struct ARMSSEInfo ARMSSEInfo;
 
-typedef struct ARMSSEClass {
+struct ARMSSEClass {
     SysBusDeviceClass parent_class;
     const ARMSSEInfo *info;
-} ARMSSEClass;
+};
 
 #define ARM_SSE_CLASS(klass) \
     OBJECT_CLASS_CHECK(ARMSSEClass, (klass), TYPE_ARM_SSE)
diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index b0a18a9c94..121396d07a 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -21,15 +21,17 @@
 
 #include "hw/riscv/riscv_hart.h"
 #include "hw/sysbus.h"
+#include "qom/object.h"
 
 #define SPIKE_CPUS_MAX 8
 #define SPIKE_SOCKETS_MAX 8
 
 #define TYPE_SPIKE_MACHINE MACHINE_TYPE_NAME("spike")
+typedef struct SpikeState SpikeState;
 #define SPIKE_MACHINE(obj) \
     OBJECT_CHECK(SpikeState, (obj), TYPE_SPIKE_MACHINE)
 
-typedef struct {
+struct SpikeState {
     /*< private >*/
     MachineState parent;
 
@@ -37,7 +39,7 @@ typedef struct {
     RISCVHartArrayState soc[SPIKE_SOCKETS_MAX];
     void *fdt;
     int fdt_size;
-} SpikeState;
+};
 
 enum {
     SPIKE_MROM,
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index 292d17147c..9d38877907 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -20,14 +20,16 @@
 #include "chardev/char-fe.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user.h"
+#include "qom/object.h"
 
 #define TYPE_VHOST_USER_BLK "vhost-user-blk"
+typedef struct VHostUserBlk VHostUserBlk;
 #define VHOST_USER_BLK(obj) \
         OBJECT_CHECK(VHostUserBlk, (obj), TYPE_VHOST_USER_BLK)
 
 #define VHOST_USER_BLK_AUTO_NUM_QUEUES UINT16_MAX
 
-typedef struct VHostUserBlk {
+struct VHostUserBlk {
     VirtIODevice parent_obj;
     CharBackend chardev;
     int32_t bootindex;
@@ -41,6 +43,6 @@ typedef struct VHostUserBlk {
     struct vhost_virtqueue *vhost_vqs;
     VirtQueue **virtqs;
     bool connected;
-} VHostUserBlk;
+};
 
 #endif
diff --git a/hw/hppa/lasi.c b/hw/hppa/lasi.c
index 194aa3e619..1acb9ce631 100644
--- a/hw/hppa/lasi.c
+++ b/hw/hppa/lasi.c
@@ -26,6 +26,7 @@
 #include "hw/input/lasips2.h"
 #include "exec/address-spaces.h"
 #include "migration/vmstate.h"
+#include "qom/object.h"
 
 #define TYPE_LASI_CHIP "lasi-chip"
 
@@ -52,10 +53,11 @@
 #define ICR_BUS_ERROR_BIT  LASI_BIT(8)  /* bit 8 in ICR */
 #define ICR_TOC_BIT        LASI_BIT(1)  /* bit 1 in ICR */
 
+typedef struct LasiState LasiState;
 #define LASI_CHIP(obj) \
     OBJECT_CHECK(LasiState, (obj), TYPE_LASI_CHIP)
 
-typedef struct LasiState {
+struct LasiState {
     PCIHostState parent_obj;
 
     uint32_t irr;
@@ -70,7 +72,7 @@ typedef struct LasiState {
     time_t rtc_ref;
 
     MemoryRegion this_mem;
-} LasiState;
+};
 
 static bool lasi_chip_mem_valid(void *opaque, hwaddr addr,
                                 unsigned size, bool is_write,
-- 
2.26.2



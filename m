Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364C7C282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 23:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD8F2175B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 23:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD8F2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48087 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCY6I-0007j8-5E
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 19:18:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0x-0003cR-53
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0v-0004Bh-SM
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:51 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:33522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hCY0v-000460-Gk
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:49 -0400
Received: by mail-qt1-f181.google.com with SMTP id k14so9397614qtb.0
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 16:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=vK3yaPLdYYb5ETwr4kpHs35UbWNpRazmDUFVC0GM/hU=;
	b=j+BSZaPxomaxuj3bv5rSum2z3k4YcWZGuQJpn3br18V55EHreIKQIc2ixb0Y0p3iqb
	k4arYaHa/oiaKUgxwIBm3tu1tLu60TBgXVcilt0Awe4+QSgJjJ2/Kbh1TSDpHyRVP/dR
	igj3kPxlW5ou0xmtmDShkXyokRcrmWTUCS/GMjq44dgVkK2rUzzt4QYd+QopBaVmVsth
	SEvcFkYKV7aGqUXN9TLOxQ5r5INCGim4BwAjcmvCWjzgmRW/FqbYMyKp0fD1eK3UCCCt
	EnxMxZtm6UPs2jYmq4wRXJTc/aTOaxuPqVwDvE08mgSV9YdKB8S1YRbKHe3/C9t/FEV7
	mG5w==
X-Gm-Message-State: APjAAAXfx5h3b+JZ29P1ZRjwnMvPknFqPkC6Chv1giFraupK9PWcTeJI
	HDV9s+3Cu0lOQuCOVmoZRh4mPrBUulo=
X-Google-Smtp-Source: APXvYqw993kIccVqXEqfu0w7P//MhtrLjmC6dqxBOCiI35fz2sPoOM4/kuc+EHSWGPjP1XXhLt290g==
X-Received: by 2002:aed:3f51:: with SMTP id q17mr13093186qtf.346.1554505968486;
	Fri, 05 Apr 2019 16:12:48 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net.
	[173.76.246.42]) by smtp.gmail.com with ESMTPSA id
	x191sm12639958qka.78.2019.04.05.16.12.47
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Apr 2019 16:12:47 -0700 (PDT)
Date: Fri, 5 Apr 2019 19:12:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190329061422.7926-3-peterx@redhat.com>
References: <20190405231225.30165-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190405231225.30165-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.181
Subject: [Qemu-devel] [PULL 5/5] intel_iommu: Drop extended root field
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Yi L <yi.l.liu@intel.com>,
	Eduardo Habkost <ehabkost@redhat.com>, Liu@redhat.com,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405231246.Zwg4VvnctDSHgB-EtwArhmFlG_UQTZADlo8tF_Ce2Gc@z>

From: Peter Xu <peterx@redhat.com>

VTD_RTADDR_RTT is dropped even by the VT-d spec, so QEMU should
probably do the same thing (after all we never really implemented it).
Since we've had a field for that in the migration stream, to keep
compatibility we need to fill the hole up.

Please refer to VT-d spec 10.4.6.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190329061422.7926-3-peterx@redhat.com>
Reviewed-by: Liu, Yi L <yi.l.liu@intel.com>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 1 -
 include/hw/i386/intel_iommu.h  | 1 -
 hw/i386/intel_iommu.c          | 6 ++----
 hw/i386/trace-events           | 2 +-
 4 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 1160618177..c1235a7063 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -171,7 +171,6 @@
 #define VTD_CCMD_FM(val)            (((val) >> 32) & 3ULL)
 
 /* RTADDR_REG */
-#define VTD_RTADDR_RTT              (1ULL << 11)
 #define VTD_RTADDR_SMT              (1ULL << 10)
 #define VTD_RTADDR_ADDR_MASK(aw)    (VTD_HAW_MASK(aw) ^ 0xfffULL)
 
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 536f62667b..12f3d266e2 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -234,7 +234,6 @@ struct IntelIOMMUState {
     bool scalable_mode;             /* RO - is Scalable Mode supported? */
 
     dma_addr_t root;                /* Current root table pointer */
-    bool root_extended;             /* Type of root table (extended or not) */
     bool root_scalable;             /* Type of root table (scalable or not) */
     bool dmar_enabled;              /* Set if DMA remapping is enabled */
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 9318854c51..2558f48fe6 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1718,12 +1718,11 @@ error:
 static void vtd_root_table_setup(IntelIOMMUState *s)
 {
     s->root = vtd_get_quad_raw(s, DMAR_RTADDR_REG);
-    s->root_extended = s->root & VTD_RTADDR_RTT;
     s->root &= VTD_RTADDR_ADDR_MASK(s->aw_bits);
 
     vtd_update_scalable_state(s);
 
-    trace_vtd_reg_dmar_root(s->root, s->root_extended);
+    trace_vtd_reg_dmar_root(s->root, s->root_scalable);
 }
 
 static void vtd_iec_notify_all(IntelIOMMUState *s, bool global,
@@ -2982,7 +2981,7 @@ static const VMStateDescription vtd_vmstate = {
         VMSTATE_UINT16(next_frcd_reg, IntelIOMMUState),
         VMSTATE_UINT8_ARRAY(csr, IntelIOMMUState, DMAR_REG_SIZE),
         VMSTATE_UINT8(iq_last_desc_type, IntelIOMMUState),
-        VMSTATE_BOOL(root_extended, IntelIOMMUState),
+        VMSTATE_UNUSED(1),      /* bool root_extended is obsolete by VT-d */
         VMSTATE_BOOL(dmar_enabled, IntelIOMMUState),
         VMSTATE_BOOL(qi_enabled, IntelIOMMUState),
         VMSTATE_BOOL(intr_enabled, IntelIOMMUState),
@@ -3503,7 +3502,6 @@ static void vtd_init(IntelIOMMUState *s)
     memset(s->womask, 0, DMAR_REG_SIZE);
 
     s->root = 0;
-    s->root_extended = false;
     s->root_scalable = false;
     s->dmar_enabled = false;
     s->intr_enabled = false;
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 83f8369778..c8bc464bc5 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -45,7 +45,7 @@ vtd_pt_enable_fast_path(uint16_t sid, bool success) "sid 0x%"PRIu16" %d"
 vtd_irq_generate(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PRIx64
 vtd_reg_read(uint64_t addr, uint64_t size) "addr 0x%"PRIx64" size 0x%"PRIx64
 vtd_reg_write(uint64_t addr, uint64_t size, uint64_t val) "addr 0x%"PRIx64" size 0x%"PRIx64" value 0x%"PRIx64
-vtd_reg_dmar_root(uint64_t addr, bool extended) "addr 0x%"PRIx64" extended %d"
+vtd_reg_dmar_root(uint64_t addr, bool scalable) "addr 0x%"PRIx64" scalable %d"
 vtd_reg_ir_root(uint64_t addr, uint32_t size) "addr 0x%"PRIx64" size 0x%"PRIx32
 vtd_reg_write_gcmd(uint32_t status, uint32_t val) "status 0x%"PRIx32" value 0x%"PRIx32
 vtd_reg_write_fectl(uint32_t value) "value 0x%"PRIx32
-- 
MST



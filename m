Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BCEC282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 23:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2BE2175B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 23:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2BE2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48030 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCY2V-0004fv-MB
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 19:14:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0v-0003ay-4n
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0t-0003ye-Vp
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:49 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:39404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hCY0t-0003tm-FD
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:47 -0400
Received: by mail-qt1-f180.google.com with SMTP id t28so9347676qte.6
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 16:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=YcIECYUacC8ciIbRCOhPOjquOYu2uaBFmQkJ1RUK5bI=;
	b=p7hh+m5mOZkygVs5r7NUHrL4jAgJTDer5jmaa2oM2l2mUUIBgtj6RyacQ0rqjCQ58O
	0U+umYrHlFzCjf0kxcIGTF0ZTONBIhx1NMJr7gzF6mTzMem7J5bcvniJ+4zOZjk3hxrE
	NOumK9BHiQyMku5YCNCYJWzohnNAP3h+Oh9ZZWKGUnt50hAy0Bk73/4A2OO878BHGPiS
	WKGaz9jCMrOGyF/vxJLDO1ABel6YrhRTaPmq4GlyivSKiuyUIiIFjXK2BYpAbtebrTUC
	5UdFwlM3T7g5J4fmMqiyjyCyMVEToNYXCJaBCo45X0TeG8JAMYi07TlH6PuA2Gz109qr
	CZ6w==
X-Gm-Message-State: APjAAAUruXFVsPeUMOUy/JEMOKdVp244XuLR9nZlPm1BveiQiikDcD+4
	dQQEjTuWed5ejqNnCe31gMddbarmyaw=
X-Google-Smtp-Source: APXvYqz5B1WaD1COQsOk1XWsynL81bIPEktvqEY2EnlzLgeX122jqvWZegBjP+sMuhU8xHYg+mCVfg==
X-Received: by 2002:a0c:9637:: with SMTP id 52mr12743524qvx.11.1554505966632; 
	Fri, 05 Apr 2019 16:12:46 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net.
	[173.76.246.42]) by smtp.gmail.com with ESMTPSA id
	m46sm15607398qtk.95.2019.04.05.16.12.45
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Apr 2019 16:12:45 -0700 (PDT)
Date: Fri, 5 Apr 2019 19:12:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190329061422.7926-2-peterx@redhat.com>
References: <20190405231225.30165-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190405231225.30165-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.180
Subject: [Qemu-devel] [PULL 4/5] intel_iommu: Fix root_scalable migration
 breakage
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yi Sun <yi.y.sun@linux.intel.com>,
	Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405231244.eVettwXxs3ECUuB3wyDqPag_7YEAkuyM-YXhDdLdSPM@z>

From: Peter Xu <peterx@redhat.com>

When introducing the initial support for scalable mode we added a
new field into vmstate however we blindly migrate that field without
notice.  That'll break migration no matter forward or backward.

The normal way should be that we use something like
VMSTATE_UINT32_TEST() or subsections for the new vmstate field however
for this case of vt-d we can even make it simpler because we've
already migrated all the registers and it'll be fairly simple that we
re-generate root_scalable field from the register values during post
load of the device.

Fixes: fb43cf739e ("intel_iommu: scalable mode emulation")
Reviewed-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190329061422.7926-2-peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 146cd16dd2..9318854c51 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -162,6 +162,15 @@ static inline void vtd_iommu_unlock(IntelIOMMUState *s)
     qemu_mutex_unlock(&s->iommu_lock);
 }
 
+static void vtd_update_scalable_state(IntelIOMMUState *s)
+{
+    uint64_t val = vtd_get_quad_raw(s, DMAR_RTADDR_REG);
+
+    if (s->scalable_mode) {
+        s->root_scalable = val & VTD_RTADDR_SMT;
+    }
+}
+
 /* Whether the address space needs to notify new mappings */
 static inline gboolean vtd_as_has_map_notifier(VTDAddressSpace *as)
 {
@@ -1710,11 +1719,10 @@ static void vtd_root_table_setup(IntelIOMMUState *s)
 {
     s->root = vtd_get_quad_raw(s, DMAR_RTADDR_REG);
     s->root_extended = s->root & VTD_RTADDR_RTT;
-    if (s->scalable_mode) {
-        s->root_scalable = s->root & VTD_RTADDR_SMT;
-    }
     s->root &= VTD_RTADDR_ADDR_MASK(s->aw_bits);
 
+    vtd_update_scalable_state(s);
+
     trace_vtd_reg_dmar_root(s->root, s->root_extended);
 }
 
@@ -2945,6 +2953,15 @@ static int vtd_post_load(void *opaque, int version_id)
      */
     vtd_switch_address_space_all(iommu);
 
+    /*
+     * We don't need to migrate the root_scalable because we can
+     * simply do the calculation after the loading is complete.  We
+     * can actually do similar things with root, dmar_enabled, etc.
+     * however since we've had them already so we'd better keep them
+     * for compatibility of migration.
+     */
+    vtd_update_scalable_state(iommu);
+
     return 0;
 }
 
@@ -2966,7 +2983,6 @@ static const VMStateDescription vtd_vmstate = {
         VMSTATE_UINT8_ARRAY(csr, IntelIOMMUState, DMAR_REG_SIZE),
         VMSTATE_UINT8(iq_last_desc_type, IntelIOMMUState),
         VMSTATE_BOOL(root_extended, IntelIOMMUState),
-        VMSTATE_BOOL(root_scalable, IntelIOMMUState),
         VMSTATE_BOOL(dmar_enabled, IntelIOMMUState),
         VMSTATE_BOOL(qi_enabled, IntelIOMMUState),
         VMSTATE_BOOL(intr_enabled, IntelIOMMUState),
-- 
MST



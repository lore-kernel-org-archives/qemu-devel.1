Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6688FC2D0C3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309B6218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFZ/D6wU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309B6218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUoB-0004er-W2
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihUX9-0006tv-Hb
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:18:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihUX7-0003ol-2U
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:18:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31495
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihUX6-0003lY-V5
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576657091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n/OmQfNuIfCdF7J9e+osTcpQv9FggwcAnVFk1+xrsXc=;
 b=bFZ/D6wUfOIPwJ++J4V85W/6oxlYT3SJoBSMD4pzVk5eqVeXJxr1E4iw/+QGZAbz+w/9pL
 +L87g2sNgogSHIU56PvDc54tB/CddRhx2yTpSRMVX1uCtE2zAurRkHz9CL4jZENJTpY5tW
 0GQW+xI1ylC9Cdv4ixDMKpaB5/az9DY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-S0c8Z5AAO1W_Zk1agbc9YA-1; Wed, 18 Dec 2019 03:17:28 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33F0A107ACCA
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 08:17:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53C8F68882;
 Wed, 18 Dec 2019 08:17:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7FCDA11384DA; Wed, 18 Dec 2019 09:17:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 12/35] error: Clean up unusual names of Error * variables
Date: Wed, 18 Dec 2019 09:16:58 +0100
Message-Id: <20191218081721.23520-13-armbru@redhat.com>
In-Reply-To: <20191218081721.23520-1-armbru@redhat.com>
References: <20191218081721.23520-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: S0c8Z5AAO1W_Zk1agbc9YA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Local Error * variables are conventionally named @err or @local_err,
and Error ** parameters @errp.  Naming local variables like parameters
is confusing.  Clean that up.

Naming parameters like local variables is also confusing.  Left for
another day.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20191204093625.14836-17-armbru@redhat.com>
---
 hw/intc/s390_flic_kvm.c    | 10 +++++-----
 hw/ppc/spapr_pci.c         | 16 ++++++++--------
 hw/ppc/spapr_pci_nvlink2.c | 10 +++++-----
 tests/test-blockjob.c      | 16 ++++++++--------
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index c9ee80eaae..30d50c2369 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -582,10 +582,10 @@ static void kvm_s390_flic_realize(DeviceState *dev, E=
rror **errp)
     struct kvm_create_device cd =3D {0};
     struct kvm_device_attr test_attr =3D {0};
     int ret;
-    Error *errp_local =3D NULL;
+    Error *err =3D NULL;
=20
-    KVM_S390_FLIC_GET_CLASS(dev)->parent_realize(dev, &errp_local);
-    if (errp_local) {
+    KVM_S390_FLIC_GET_CLASS(dev)->parent_realize(dev, &err);
+    if (err) {
         goto fail;
     }
     flic_state->fd =3D -1;
@@ -593,7 +593,7 @@ static void kvm_s390_flic_realize(DeviceState *dev, Err=
or **errp)
     cd.type =3D KVM_DEV_TYPE_FLIC;
     ret =3D kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd);
     if (ret < 0) {
-        error_setg_errno(&errp_local, errno, "Creating the KVM device fail=
ed");
+        error_setg_errno(&err, errno, "Creating the KVM device failed");
         trace_flic_create_device(errno);
         goto fail;
     }
@@ -605,7 +605,7 @@ static void kvm_s390_flic_realize(DeviceState *dev, Err=
or **errp)
                                             KVM_HAS_DEVICE_ATTR, test_attr=
);
     return;
 fail:
-    error_propagate(errp, errp_local);
+    error_propagate(errp, err);
 }
=20
 static void kvm_s390_flic_reset(DeviceState *dev)
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f6fbcf99ed..723373de73 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2042,13 +2042,13 @@ void spapr_phb_dma_reset(SpaprPhbState *sphb)
 static void spapr_phb_reset(DeviceState *qdev)
 {
     SpaprPhbState *sphb =3D SPAPR_PCI_HOST_BRIDGE(qdev);
-    Error *errp =3D NULL;
+    Error *err =3D NULL;
=20
     spapr_phb_dma_reset(sphb);
     spapr_phb_nvgpu_free(sphb);
-    spapr_phb_nvgpu_setup(sphb, &errp);
-    if (errp) {
-        error_report_err(errp);
+    spapr_phb_nvgpu_setup(sphb, &err);
+    if (err) {
+        error_report_err(err);
     }
=20
     /* Reset the IOMMU state */
@@ -2326,7 +2326,7 @@ int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhbSt=
ate *phb,
                                 cpu_to_be32(phb->numa_node)};
     SpaprTceTable *tcet;
     SpaprDrc *drc;
-    Error *errp =3D NULL;
+    Error *err =3D NULL;
=20
     /* Start populating the FDT */
     _FDT(bus_off =3D fdt_add_subnode(fdt, 0, phb->dtbusname));
@@ -2408,9 +2408,9 @@ int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhbSt=
ate *phb,
         return ret;
     }
=20
-    spapr_phb_nvgpu_populate_dt(phb, fdt, bus_off, &errp);
-    if (errp) {
-        error_report_err(errp);
+    spapr_phb_nvgpu_populate_dt(phb, fdt, bus_off, &err);
+    if (err) {
+        error_report_err(err);
     }
     spapr_phb_nvgpu_ram_populate_dt(phb, fdt);
=20
diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
index 4aa89ede23..8332d5694e 100644
--- a/hw/ppc/spapr_pci_nvlink2.c
+++ b/hw/ppc/spapr_pci_nvlink2.c
@@ -57,7 +57,7 @@ struct SpaprPhbPciNvGpuConfig {
     uint64_t nv2_atsd_current;
     int num; /* number of non empty (i.e. tgt!=3D0) entries in slots[] */
     SpaprPhbPciNvGpuSlot slots[NVGPU_MAX_NUM];
-    Error *errp;
+    Error *err;
 };
=20
 static SpaprPhbPciNvGpuSlot *
@@ -153,7 +153,7 @@ static void spapr_phb_pci_collect_nvgpu(PCIBus *bus, PC=
IDevice *pdev,
             spapr_pci_collect_nvnpu(nvgpus, pdev, tgt, MEMORY_REGION(mr_np=
u),
                                     &local_err);
         }
-        error_propagate(&nvgpus->errp, local_err);
+        error_propagate(&nvgpus->err, local_err);
     }
     if ((pci_default_read_config(pdev, PCI_HEADER_TYPE, 1) !=3D
          PCI_HEADER_TYPE_BRIDGE)) {
@@ -187,9 +187,9 @@ void spapr_phb_nvgpu_setup(SpaprPhbState *sphb, Error *=
*errp)
     pci_for_each_device(bus, pci_bus_num(bus),
                         spapr_phb_pci_collect_nvgpu, sphb->nvgpus);
=20
-    if (sphb->nvgpus->errp) {
-        error_propagate(errp, sphb->nvgpus->errp);
-        sphb->nvgpus->errp =3D NULL;
+    if (sphb->nvgpus->err) {
+        error_propagate(errp, sphb->nvgpus->err);
+        sphb->nvgpus->err =3D NULL;
         goto cleanup_exit;
     }
=20
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 7844c9ffcb..e670a20617 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -34,13 +34,13 @@ static BlockJob *mk_job(BlockBackend *blk, const char *=
id,
                         int flags)
 {
     BlockJob *job;
-    Error *errp =3D NULL;
+    Error *err =3D NULL;
=20
     job =3D block_job_create(id, drv, NULL, blk_bs(blk),
                            0, BLK_PERM_ALL, 0, flags, block_job_cb,
-                           NULL, &errp);
+                           NULL, &err);
     if (should_succeed) {
-        g_assert_null(errp);
+        g_assert_null(err);
         g_assert_nonnull(job);
         if (id) {
             g_assert_cmpstr(job->job.id, =3D=3D, id);
@@ -48,9 +48,9 @@ static BlockJob *mk_job(BlockBackend *blk, const char *id=
,
             g_assert_cmpstr(job->job.id, =3D=3D, blk_name(blk));
         }
     } else {
-        g_assert_nonnull(errp);
+        g_assert_nonnull(err);
         g_assert_null(job);
-        error_free(errp);
+        error_free(err);
     }
=20
     return job;
@@ -80,9 +80,9 @@ static BlockBackend *create_blk(const char *name)
     bdrv_unref(bs);
=20
     if (name) {
-        Error *errp =3D NULL;
-        monitor_add_blk(blk, name, &errp);
-        g_assert_null(errp);
+        Error *err =3D NULL;
+        monitor_add_blk(blk, name, &err);
+        g_assert_null(err);
     }
=20
     return blk;
--=20
2.21.0



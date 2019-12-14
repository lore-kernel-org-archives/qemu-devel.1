Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218CBC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 09:48:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23F720724
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 09:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uf2fjZMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23F720724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ig42B-0006RJ-0u
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 04:48:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ig3zf-0004bU-MW
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:45:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ig3zd-0004ld-SI
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:45:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50887
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ig3zd-0004dv-BI
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576316743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=naCs+RRcG6LuS3J8BIz8inRWeFD5rZn+hdbe+odExp0=;
 b=Uf2fjZMd6jMKqnBCEaI4HSKJf7VG4dV/hAwknLhyaU7wzuldh7Oi/ZXI5lR+AJjsfzQCr+
 Aa+bDSC8T1ctcnMwR2q5wtsrORuDz3FNRpSWJxTmqRTv2xY7o6dzljpz5vrsizZl/X6TqV
 aGwfxzPKpK54MThQ9H9wxtdUJqiTJ84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-aNfg4UTaPZaDVAGCZFVn3w-1; Sat, 14 Dec 2019 04:45:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04AEA1800D63;
 Sat, 14 Dec 2019 09:45:40 +0000 (UTC)
Received: from localhost (ovpn-116-90.ams2.redhat.com [10.36.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9156776FB;
 Sat, 14 Dec 2019 09:45:36 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 02/16] hw: add compat machines for 5.0
Date: Sat, 14 Dec 2019 10:45:12 +0100
Message-Id: <20191214094526.8698-3-cohuck@redhat.com>
In-Reply-To: <20191214094526.8698-1-cohuck@redhat.com>
References: <20191214094526.8698-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: aNfg4UTaPZaDVAGCZFVn3w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add 5.0 machine types for arm/i440fx/q35/s390x/spapr.

For i440fx and q35, unversioned cpu models are still translated
to -v1; I'll leave changing this (if desired) to the respective
maintainers.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20191112104811.30323-1-cohuck@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/arm/virt.c              |  7 ++++++-
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 14 +++++++++++++-
 hw/i386/pc_q35.c           | 13 ++++++++++++-
 hw/ppc/spapr.c             | 13 ++++++++++++-
 hw/s390x/s390-virtio-ccw.c | 13 ++++++++++++-
 include/hw/i386/pc.h       |  3 +++
 7 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index bf4b1cbfb868..33dfc8ea62c3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2147,11 +2147,16 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
=20
+static void virt_machine_5_0_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(5, 0)
+
 static void virt_machine_4_2_options(MachineClass *mc)
 {
     compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(4, 2)
+DEFINE_VIRT_MACHINE(4, 2)
=20
 static void virt_machine_4_1_options(MachineClass *mc)
 {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ac08e6360437..58867f987d88 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -103,6 +103,9 @@
=20
 struct hpet_fw_config hpet_cfg =3D {.count =3D UINT8_MAX};
=20
+GlobalProperty pc_compat_4_2[] =3D {};
+const size_t pc_compat_4_2_len =3D G_N_ELEMENTS(pc_compat_4_2);
+
 GlobalProperty pc_compat_4_1[] =3D {};
 const size_t pc_compat_4_1_len =3D G_N_ELEMENTS(pc_compat_4_1);
=20
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 87aced0742ec..ffb30c32ce94 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -424,7 +424,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
 }
=20
-static void pc_i440fx_4_2_machine_options(MachineClass *m)
+static void pc_i440fx_5_0_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_i440fx_machine_options(m);
@@ -434,6 +434,18 @@ static void pc_i440fx_4_2_machine_options(MachineClass=
 *m)
     compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
=20
+DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
+                      pc_i440fx_5_0_machine_options);
+
+static void pc_i440fx_4_2_machine_options(MachineClass *m)
+{
+    pc_i440fx_5_0_machine_options(m);
+    m->alias =3D NULL;
+    m->is_default =3D 0;
+    compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
+    compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
+}
+
 DEFINE_I440FX_MACHINE(v4_2, "pc-i440fx-4.2", NULL,
                       pc_i440fx_4_2_machine_options);
=20
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 2608cd00623c..7398d7baa27d 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -348,7 +348,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus =3D 288;
 }
=20
-static void pc_q35_4_2_machine_options(MachineClass *m)
+static void pc_q35_5_0_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_q35_machine_options(m);
@@ -357,6 +357,17 @@ static void pc_q35_4_2_machine_options(MachineClass *m=
)
     compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
=20
+DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
+                   pc_q35_5_0_machine_options);
+
+static void pc_q35_4_2_machine_options(MachineClass *m)
+{
+    pc_q35_5_0_machine_options(m);
+    m->alias =3D NULL;
+    compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
+    compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
+}
+
 DEFINE_Q35_MACHINE(v4_2, "pc-q35-4.2", NULL,
                    pc_q35_4_2_machine_options);
=20
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2ca92f214819..3ae7db156303 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4491,15 +4491,26 @@ static const TypeInfo spapr_machine_info =3D {
     }                                                                \
     type_init(spapr_machine_register_##suffix)
=20
+/*
+ * pseries-5.0
+ */
+static void spapr_machine_5_0_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE(5_0, "5.0", true);
+
 /*
  * pseries-4.2
  */
 static void spapr_machine_4_2_class_options(MachineClass *mc)
 {
+    spapr_machine_5_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
=20
-DEFINE_SPAPR_MACHINE(4_2, "4.2", true);
+DEFINE_SPAPR_MACHINE(4_2, "4.2", false);
=20
 /*
  * pseries-4.1
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index cb5fe4c84d87..01e7e209a5da 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -639,15 +639,26 @@ bool css_migration_enabled(void)
     }                                                                     =
    \
     type_init(ccw_machine_register_##suffix)
=20
+static void ccw_machine_5_0_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_5_0_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE(5_0, "5.0", true);
+
 static void ccw_machine_4_2_instance_options(MachineState *machine)
 {
+    ccw_machine_5_0_instance_options(machine);
 }
=20
 static void ccw_machine_4_2_class_options(MachineClass *mc)
 {
+    ccw_machine_5_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
-DEFINE_CCW_MACHINE(4_2, "4.2", true);
+DEFINE_CCW_MACHINE(4_2, "4.2", false);
=20
 static void ccw_machine_4_1_instance_options(MachineState *machine)
 {
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 1f86eba3f998..61a998de4665 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -237,6 +237,9 @@ void pc_system_firmware_init(PCMachineState *pcms, Memo=
ryRegion *rom_memory);
 void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
                        const CPUArchIdList *apic_ids, GArray *entry);
=20
+extern GlobalProperty pc_compat_4_2[];
+extern const size_t pc_compat_4_2_len;
+
 extern GlobalProperty pc_compat_4_1[];
 extern const size_t pc_compat_4_1_len;
=20
--=20
2.21.0



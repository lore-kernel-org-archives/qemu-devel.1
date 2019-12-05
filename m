Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED741C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:10:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B75DB206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RymrDlXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75DB206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ictiS-0004mM-Qf
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 11:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ictey-0002To-85
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ictew-0007Jq-1X
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:07:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44981
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ictev-0007Hy-B1
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575562032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lllEY/p3qM1HPQXC8XGj58nJVJuSxHASxMSwbPKwDRQ=;
 b=RymrDlXVrMGpi/9/Ns9yjndb5kZPH/KtPm3gJzEwqmaRMDUhG4wQcSdazap4S+PsfoPQJP
 gd4ZREyTUHD45ETnb1D0itaFVvmN4X9jOh09mtDioGwy9dDsiMKtQBKXYPVkmz3dDQ63Ep
 QXFRlmOUqnhYkmoIaVlz+o/bXMyjnj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-vq54Ifv2N-ueRh8AZQi9nA-1; Thu, 05 Dec 2019 11:07:10 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 301EF8024DE;
 Thu,  5 Dec 2019 16:07:09 +0000 (UTC)
Received: from thuth.com (ovpn-116-87.ams2.redhat.com [10.36.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 418306B8D5;
 Thu,  5 Dec 2019 16:07:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/3] hw/i386: Remove the deprecated machines 0.12 up to 0.15
Date: Thu,  5 Dec 2019 17:06:50 +0100
Message-Id: <20191205160652.23493-2-thuth@redhat.com>
In-Reply-To: <20191205160652.23493-1-thuth@redhat.com>
References: <20191205160652.23493-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: vq54Ifv2N-ueRh8AZQi9nA-1
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
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

They can't be used reliable for live-migration anymore (see
https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04516.html
for details) and have been marked as deprecated since QEMU v4.0,
so time to remove them now.

And while we're at it, mark the remaining pc-1.x machine types
as deprecated now, too, so that we finally only have "pc-i440fx"
and "pc-q35" machine types left (apart from the non-versioned
"isapc" and "microvm") once we removed them in a couple of releases.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/pc_piix.c     | 82 -------------------------------------------
 qemu-deprecated.texi  |  2 +-
 tests/cpu-plug-test.c |  6 +---
 3 files changed, 2 insertions(+), 88 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 1bd70d1abb..59ac9d82c9 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -364,12 +364,6 @@ static void pc_compat_1_2(MachineState *machine)
     x86_cpu_change_kvm_default("kvm-pv-eoi", NULL);
 }
=20
-/* PC compat function for pc-0.12 and pc-0.13 */
-static void pc_compat_0_13(MachineState *machine)
-{
-    pc_compat_1_2(machine);
-}
-
 static void pc_init_isa(MachineState *machine)
 {
     pc_init1(machine, TYPE_I440FX_PCI_HOST_BRIDGE, TYPE_I440FX_PCI_DEVICE)=
;
@@ -800,82 +794,6 @@ DEFINE_I440FX_MACHINE(v1_0, "pc-1.0", pc_compat_1_2,
                       pc_i440fx_1_0_machine_options);
=20
=20
-static void pc_i440fx_0_15_machine_options(MachineClass *m)
-{
-    static GlobalProperty compat[] =3D {
-        PC_CPU_MODEL_IDS("0.15")
-    };
-
-    pc_i440fx_1_0_machine_options(m);
-    m->hw_version =3D "0.15";
-    m->deprecation_reason =3D "use a newer machine type instead";
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
-}
-
-DEFINE_I440FX_MACHINE(v0_15, "pc-0.15", pc_compat_1_2,
-                      pc_i440fx_0_15_machine_options);
-
-
-static void pc_i440fx_0_14_machine_options(MachineClass *m)
-{
-    static GlobalProperty compat[] =3D {
-        PC_CPU_MODEL_IDS("0.14")
-        { "virtio-blk-pci", "event_idx", "off" },
-        { "virtio-serial-pci", "event_idx", "off" },
-        { "virtio-net-pci", "event_idx", "off" },
-        { "virtio-balloon-pci", "event_idx", "off" },
-        { "qxl", "revision", "2" },
-        { "qxl-vga", "revision", "2" },
-    };
-
-    pc_i440fx_0_15_machine_options(m);
-    m->hw_version =3D "0.14";
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
-}
-
-DEFINE_I440FX_MACHINE(v0_14, "pc-0.14", pc_compat_1_2,
-                      pc_i440fx_0_14_machine_options);
-
-static void pc_i440fx_0_13_machine_options(MachineClass *m)
-{
-    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
-    static GlobalProperty compat[] =3D {
-        PC_CPU_MODEL_IDS("0.13")
-        { TYPE_PCI_DEVICE, "command_serr_enable", "off" },
-        { "AC97", "use_broken_id", "1" },
-        { "virtio-9p-pci", "vectors", "0" },
-        { "VGA", "rombar", "0" },
-        { "vmware-svga", "rombar", "0" },
-    };
-
-    pc_i440fx_0_14_machine_options(m);
-    m->hw_version =3D "0.13";
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
-    pcmc->kvmclock_enabled =3D false;
-}
-
-DEFINE_I440FX_MACHINE(v0_13, "pc-0.13", pc_compat_0_13,
-                      pc_i440fx_0_13_machine_options);
-
-static void pc_i440fx_0_12_machine_options(MachineClass *m)
-{
-    static GlobalProperty compat[] =3D {
-        PC_CPU_MODEL_IDS("0.12")
-        { "virtio-serial-pci", "max_ports", "1" },
-        { "virtio-serial-pci", "vectors", "0" },
-        { "usb-mouse", "serial", "1" },
-        { "usb-tablet", "serial", "1" },
-        { "usb-kbd", "serial", "1" },
-    };
-
-    pc_i440fx_0_13_machine_options(m);
-    m->hw_version =3D "0.12";
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
-}
-
-DEFINE_I440FX_MACHINE(v0_12, "pc-0.12", pc_compat_0_13,
-                      pc_i440fx_0_12_machine_options);
-
 typedef struct {
     uint16_t gpu_device_id;
     uint16_t pch_device_id;
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index e407cc085e..2850f9a520 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -261,7 +261,7 @@ The 'scsi-disk' device is deprecated. Users should use =
'scsi-hd' or
=20
 @section System emulator machines
=20
-@subsection pc-0.12, pc-0.13, pc-0.14 and pc-0.15 (since 4.0)
+@subsection pc-1.0, pc-1.1, pc-1.2 and pc-1.3 (since 5.0)
=20
 These machine types are very old and likely can not be used for live migra=
tion
 from old QEMU versions anymore. A newer machine type should be used instea=
d.
diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
index 30e514bbfb..e8ffbbce4b 100644
--- a/tests/cpu-plug-test.c
+++ b/tests/cpu-plug-test.c
@@ -148,11 +148,7 @@ static void add_pc_test_case(const char *mname)
         (strcmp(mname, "pc-1.3") =3D=3D 0) ||
         (strcmp(mname, "pc-1.2") =3D=3D 0) ||
         (strcmp(mname, "pc-1.1") =3D=3D 0) ||
-        (strcmp(mname, "pc-1.0") =3D=3D 0) ||
-        (strcmp(mname, "pc-0.15") =3D=3D 0) ||
-        (strcmp(mname, "pc-0.14") =3D=3D 0) ||
-        (strcmp(mname, "pc-0.13") =3D=3D 0) ||
-        (strcmp(mname, "pc-0.12") =3D=3D 0)) {
+        (strcmp(mname, "pc-1.0") =3D=3D 0)) {
         path =3D g_strdup_printf("cpu-plug/%s/init/%ux%ux%u&maxcpus=3D%u",
                                mname, data->sockets, data->cores,
                                data->threads, data->maxcpus);
--=20
2.18.1



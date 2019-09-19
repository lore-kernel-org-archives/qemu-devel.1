Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1848BC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D62F321920
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJbxOARo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62F321920
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4fm-0003HE-Sp
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iB49t-0001g1-Q7
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iB49i-0006GZ-3B
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:10 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41645)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iB49h-0006DL-Jf
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:01 -0400
Received: by mail-oi1-x241.google.com with SMTP id w17so13263oiw.8
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WgyVtq9w6PvClORTpivvOhmxn0kbUdDtW15cfLnsIag=;
 b=TJbxOARoZ0uYDI7F+ZBw/2P1mA/mfxoitGUNvTQztvEi5l4fK2PevTGq6I1CvhrS3G
 McPR/nsQDFNi1/XQULBQoJuQW2ZHm3YNPiwAATFWnG2MFyE0CMP1dPT6ZG7avY69lmR/
 T+ljxj3/TAo26K+Qje4UssGPm5IZdRd+VA3CYbNff8DVcL6u/RxseXdI+4Rzp3aD8J+a
 UITA96QA+EkVyehFMlfED69TPDkRL1o7zyIdPDF4UPmFbb1uuBHl8Y4I6WrxLYxni8nR
 6Xx1co7dbo9up/zxLPf3qvWQ4vOgFyiKlcxdqXvnICaDbUdq1WgefZicsX+dNUh24NfV
 ejEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=WgyVtq9w6PvClORTpivvOhmxn0kbUdDtW15cfLnsIag=;
 b=BcGfCwK5DV4aC/wCQF0rFV+ofzuGnaKowXP37xVNOWNwIAW1DweM4O4uPUubqRtUEu
 g7tfUkbT6w/b8Zh4K/Aiq2xKWhJRkCg2mumimA+4fiL6IA+xDrY8giFZQYq5m4BCL8Wr
 w0P8kwKz+idTFmZcSELNLoxSVjYJdbdX3Oq/HHP6U64JiUUAfMjnMbvN8O/FSqwJ4n/O
 kyYrAgDNjEGbAvNZvMnO9iMR9ljqV5tW2qFALdHWOJT2jKtXId517Lblr7xyuryGhgyb
 gWgoU5O44Y2PQX0o33vYDbyub9av1B2N9zDFcaO6BuYrByBdDEbdub1jSxr4RQvuAjSR
 KDiw==
X-Gm-Message-State: APjAAAUTqpZYd2ospWuGj+j1hBnnqHCr7Xp29vlmeWM2EUBGu0QZ3KXi
 QIysxRrGHSO4FWSs6MKwPA==
X-Google-Smtp-Source: APXvYqwq1G1VJ4q62ElrN/BsbVMNVBn1Cql/EANQH7UAnUEcCE8s2MU1qhALhDZgDrt9dnytuEjxJQ==
X-Received: by 2002:aca:50c2:: with SMTP id e185mr48033oib.152.1568929190461; 
 Thu, 19 Sep 2019 14:39:50 -0700 (PDT)
Received: from serve.minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id x140sm34370oix.42.2019.09.19.14.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:39:48 -0700 (PDT)
Received: from t560.minyard.net (unknown [192.168.27.180])
 by serve.minyard.net (Postfix) with ESMTPA id C596C1805B3;
 Thu, 19 Sep 2019 21:39:37 +0000 (UTC)
From: minyard@acm.org
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 15/15] pc: Add an SMB0 ACPI device to q35
Date: Thu, 19 Sep 2019 16:39:24 -0500
Message-Id: <20190919213924.31852-16-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919213924.31852-1-minyard@acm.org>
References: <20190919213924.31852-1-minyard@acm.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Corey Minyard <cminyard@mvista.com>, Fam Zheng <famz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Minyard <cminyard@mvista.com>

This is so I2C devices can be found in the ACPI namespace.  Currently
that's only IPMI, but devices can be easily added now.

Adding the devices required some PCI information, and the bus itself
to be added to the PCMachineState structure.

Note that this only works on Q35, the ACPI for PIIX4 is not capable
of handling an SMBus device.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i386/acpi-build.c             |  15 +++++++++++++++
 hw/i386/pc_piix.c                |  12 ++++++------
 hw/i386/pc_q35.c                 |   9 +++++----
 include/hw/i386/pc.h             |   2 ++
 tests/data/acpi/q35/DSDT         | Bin 7841 -> 7879 bytes
 tests/data/acpi/q35/DSDT.bridge  | Bin 7858 -> 7896 bytes
 tests/data/acpi/q35/DSDT.cphp    | Bin 8304 -> 8342 bytes
 tests/data/acpi/q35/DSDT.dimmpxm | Bin 9494 -> 9532 bytes
 tests/data/acpi/q35/DSDT.ipmibt  | Bin 7916 -> 7954 bytes
 tests/data/acpi/q35/DSDT.memhp   | Bin 9200 -> 9238 bytes
 tests/data/acpi/q35/DSDT.mmio64  | Bin 8971 -> 9009 bytes
 tests/data/acpi/q35/DSDT.numamem | Bin 7847 -> 7885 bytes
 12 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 8acf12df9a..4e0f9f425a 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1809,6 +1809,18 @@ static Aml *build_q35_osc_method(void)
     return method;
 }
 
+static void build_smb0(Aml *table, I2CBus *smbus, int devnr, int func)
+{
+    Aml *scope = aml_scope("_SB.PCI0");
+    Aml *dev = aml_device("SMB0");
+
+    aml_append(dev, aml_name_decl("_HID", aml_eisaid("APP0005")));
+    aml_append(dev, aml_name_decl("_ADR", aml_int(devnr << 16 | func)));
+    build_acpi_ipmi_devices(dev, BUS(smbus), "\\_SB.PCI0.SMB0");
+    aml_append(scope, dev);
+    aml_append(table, scope);
+}
+
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker,
            AcpiPmInfo *pm, AcpiMiscInfo *misc,
@@ -1862,6 +1874,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_q35_isa_bridge(dsdt);
         build_isa_devices_aml(dsdt);
         build_q35_pci0_int(dsdt);
+        if (pcms->smbus && !pcmc->do_not_add_smb_acpi) {
+            build_smb0(dsdt, pcms->smbus, ICH9_SMB_DEV, ICH9_SMB_FUNC);
+        }
     }
 
     if (pcmc->legacy_cpu_hotplug) {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 2362675149..6824b72124 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -283,15 +283,14 @@ else {
 
     if (pcmc->pci_enabled && acpi_enabled) {
         DeviceState *piix4_pm;
-        I2CBus *smbus;
 
         smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
         /* TODO: Populate SPD eeprom data.  */
-        smbus = piix4_pm_init(pci_bus, piix3_devfn + 3, 0xb100,
-                              pcms->gsi[9], smi_irq,
-                              pc_machine_is_smm_enabled(pcms),
-                              &piix4_pm);
-        smbus_eeprom_init(smbus, 8, NULL, 0);
+        pcms->smbus = piix4_pm_init(pci_bus, piix3_devfn + 3, 0xb100,
+                                    pcms->gsi[9], smi_irq,
+                                    pc_machine_is_smm_enabled(pcms),
+                                    &piix4_pm);
+        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
 
         object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                                  TYPE_HOTPLUG_HANDLER,
@@ -476,6 +475,7 @@ static void pc_i440fx_3_1_machine_options(MachineClass *m)
 
     pc_i440fx_4_0_machine_options(m);
     m->is_default = 0;
+    pcmc->do_not_add_smb_acpi = true;
     m->smbus_no_migration_support = true;
     m->alias = NULL;
     pcmc->pvh_enabled = false;
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d4e8a1cb9f..8fad20f314 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -316,10 +316,10 @@ static void pc_q35_init(MachineState *machine)
 
     if (pcms->smbus_enabled) {
         /* TODO: Populate SPD eeprom data.  */
-        smbus_eeprom_init(ich9_smb_init(host_bus,
-                                        PCI_DEVFN(ICH9_SMB_DEV, ICH9_SMB_FUNC),
-                                        0xb100),
-                          8, NULL, 0);
+        pcms->smbus = ich9_smb_init(host_bus,
+                                    PCI_DEVFN(ICH9_SMB_DEV, ICH9_SMB_FUNC),
+                                    0xb100);
+        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
     }
 
     pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
@@ -421,6 +421,7 @@ static void pc_q35_3_1_machine_options(MachineClass *m)
 
     pc_q35_4_0_machine_options(m);
     m->default_kernel_irqchip_split = false;
+    pcmc->do_not_add_smb_acpi = true;
     m->smbus_no_migration_support = true;
     m->alias = NULL;
     pcmc->pvh_enabled = false;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 062feeb69e..6df4f4b6fb 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -38,6 +38,7 @@ struct PCMachineState {
     HotplugHandler *acpi_dev;
     ISADevice *rtc;
     PCIBus *bus;
+    I2CBus *smbus;
     FWCfgState *fw_cfg;
     qemu_irq *gsi;
     PFlashCFI01 *flash[2];
@@ -117,6 +118,7 @@ typedef struct PCMachineClass {
     bool rsdp_in_ram;
     int legacy_acpi_table_size;
     unsigned acpi_data_size;
+    bool do_not_add_smb_acpi;
 
     /* SMBIOS compat: */
     bool smbios_defaults;
diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
index f9f36d1645c9b57aea38350d67dfaa143845697d..77ea60ffed421c566138fe6341421f579129a582 100644
GIT binary patch
delta 62
zcmZ2zd)$`GCD<k8xEuomWBo=hV@Xw2z4&0K_yA{5gXkv7U|%N#j(87G7aleN23C%E
RN0%TTW(IkN%{G#$tN;mh4yXVC

delta 24
fcmX?ZyU>=)CD<iop&SDPquoX>W690Qk}0eJT(JhZ

diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bridge
index 29176832ca9842c6654273ae1246321aa38b2821..fbc2d40000428b402586ea9302b5ccf36ef8de1e 100644
GIT binary patch
delta 62
zcmdmFd&8E?CD<k8h8zO}qx?oLV@Xw2z4&0K_yA{5gXkv7U|%N#j(87G7aleN23C%E
RN0%TTW(IkN%{G!{tN;Tx4vYW*

delta 24
fcmca%yUCWzCD<iolN<vB<Gqbs#*&+pB}-WWXCMci

diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
index 19bdb5d21050f24aaacbafb1f84d6e1d541876c6..6a896cb2142feadbcabc6276b59c138a7e93f540 100644
GIT binary patch
delta 62
zcmez1FwK$6CD<iongRm@<ByG8#*(V4dhx+d@d3`B2GLED!M;ug9Pu8WE<9`k46GdS
RjxIqw%nb4jn{6ab*a06=4(I>?

delta 24
fcmbQ{_`!k8CD<jTK!JgQar;ItW690QlE&-+VHF1X

diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.dimmpxm
index 727fe489b4c8cdd39476ff61e7d7664c816f5291..23fdf5e60a5069f60d6c680ac9c68c4a8a81318e 100644
GIT binary patch
delta 62
zcmbQ{wa1IgCD<jzMwNkq@!&=-V@Xw2z4&0K_yA{5gXkv7U|%N#j(87G7aleN23C%E
RN0%TTW(IkN%{G#^xB>h%4&?v<

delta 24
fcmdnvHO-65CD<iIOqGFwv0)>ZvE=4t$(!5&ShNQA

diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
index 9634930e6125de4375d87a56a353f636985599d4..c3fca0a71efa7b55c958a49f305389426fbe7922 100644
GIT binary patch
delta 62
zcmaE3JIRjACD<iINS=X#aq&j3I!RSkz4&0K_yA{5gXkv7U|%N#j(87G7aleN23C%E
RN0%TTW(IkN&Fzw@tN{Nt4#fZf

delta 24
fcmbPa_r{jXCD<k8jT{35WAa9>I?2uJBvV)cXHo~&

diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memhp
index dad5dc8db2f13bdb0de001da42c13b18286c3061..2abd0e36cd1344cbca3fa4ab59c5db2ea326d125 100644
GIT binary patch
delta 62
zcmez1KFx#6CD<iIOof4gv0x*Yv81Z1UVN}qe1Nm3L3ER3u&<K=N4$rp3lEzB11m?o
Rqe~DEGlM+CW*f;ZTmbN04s`$k

delta 24
fcmbQ{@xh(TCD<k8gE9jHqrpZlW690QlAE~zWv~Z^

diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
index 20f627ed08a0cae4e144f3e4dd7dd5f1d8d0318c..b32034a11c1f8a0a156df3765df44b14a88dbb4d 100644
GIT binary patch
delta 62
zcmeBn+vvvS66_LUsLa5?sI!sFSW;D0FFx2QKET=2Ai7C1*w@K`Bi_T)g@;Xmft4fP
R(Itq7nL(amvyJ3=P5{<m4j2Fc

delta 24
fcmdn!*6qgS66_Mft<1o{_<AFkvE=4t$#a|lSziY!

diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.numamem
index 7b96a972804e95e191d9d3bf9a965e90f6f7e555..d8b2b47f8b47067d375021a30086ca97d8aca43f 100644
GIT binary patch
delta 62
zcmZ2(d)AiACD<k8tQ-Raqvl2~V@Xw2z4&0K_yA{5gXkv7U|%N#j(87G7aleN23C%E
RN0%TTW(IkN%{G$RtN{IN4r%}Z

delta 24
fcmX?WyWEz`CD<ioxf}xn<BN@4#*&+pC9_xoWX}hC

-- 
2.17.1



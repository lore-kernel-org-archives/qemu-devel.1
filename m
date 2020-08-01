Return-Path: <SRS0=xT3E=BL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C84C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 13:25:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0992083E
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 13:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JsOnwzCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0992083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1rVu-0002ss-QY
	for qemu-devel@archiver.kernel.org; Sat, 01 Aug 2020 09:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k1rL7-0006J1-7a
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 09:14:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:48675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k1rL4-0003wN-KP
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 09:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596287640;
 bh=z/QXmt5sYC3nu5t+U0TkgIU+Re5QzTPu4ajnWt9P04Y=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JsOnwzCMLFubOcJCP/NrCpN3GAqjOCQ+SJV1D9vIlgGfRlRzlO3aWj6GZC92YOg9h
 fHZrbegE9+Xicng7qwIwXFhzK3Mk+gnnnK7ku8udeWazi45e6aNOT0yu4Why/bQ6lC
 oFI2JHi6CD96ty+FpPYTTd5F3R+n+IWcrMtLuGhs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.162.176]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQXH-1krM3e4B2z-00sNtn; Sat, 01
 Aug 2020 15:14:00 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 3/4] hw/hppa: Implement proper SeaBIOS version check
Date: Sat,  1 Aug 2020 15:13:56 +0200
Message-Id: <20200801131357.17379-4-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200801131357.17379-1-deller@gmx.de>
References: <20200801131357.17379-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6It3oYSTgvBrkeZ0GZ1B+fg3jkiUFwT4B3di5YYXEsEUmd3D8YF
 NJluS06+Et0dl5O6MZoXEb7nKy+kKr8qf8a5+MrmchHBYP5Suy/7GluwwpEly7YP0aCQrGr
 KUO/gmavbdzflyIfK+zxduaUlHIzaynCpDKntNkp7JjGxZ6AKJ1YTEFr/8BljKIfmGCn7F9
 bkacq8st0ej3mTJX2FZKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lK062rmJkm0=:O5iBlL1FvCaVE0HwwuQxul
 +H9aCtXDu8pvjzEQh/1B49KSQSkZXc+AAEVuvKfjVTu5yc+rvrsi7H+IzatpDk7Tb7TtakLkl
 /WwKQn9T4K6AMgOA7n9Ppv+4uy/zBKNmJtoCIZecwnzEETpW0z0KAwyREdtxftih/JaqLaFXP
 NKdMsnEr7zVxO2WiZAgHWhf5DpdpZmvnB/Z6XVR8NxwjLNGw7sLiydJp6MoYWDyKphgkEYS1b
 fT7SNw9EslZGwhfWeQcwxT5/Gs2UdCP4Er0P5a0wOBLb7+Acxj69TATqRnp4JmdH8M4yDFsut
 LZ1aVuS1EZo2056EjQuiVL8KHbdZclIru3QN9hnFLxOSleq0XvZel4MSzI94uBoW2sJ1LGIt2
 3ZwxG3WhQfZjXu+biYX1+zHPQV16tRBMQ8KLwqyw2NEGpfRq6VSUaZZI5TWtpbLj0jhqyv0Yk
 OJPYyvkOtXQP0MzeIna5+0HGx4qAYm6jSvcolGXgrtPZzyKK4DWmafPo7I4j3GqvwhNQ3vmgE
 o/d9uBi6WOEQKb0RDiBJfbkmPS1NOVj09FS1745oMyJgPhst2kv8P26WqGIsbHK+urcupqR4F
 Y5xpoM4DvlBg9ngX/mm6nPTKy1EVDWIs5/pWI7LfgvlaZEbMzd4jILFHUNrLRZXDSy6Doszgh
 8njxWhD6UugFUYWtxcaPKplbUqyqqZjD0qAmEJeWqTp0VMVboTTGwKc9zEq/m5iMJDb8AOCkA
 yXq9U4Msd7WZN9uparlrMk1z5PXVRlputfoMcbOBpEjiQpg8BL6LVvQUsuXuSQ6/ouFg7S7j1
 gsvw9NpTEuFqO9Rb/tKk0ZzbwAjIYPeju+3qKA4x2UiJrPF9R1znVts0OdExH7bZECE8RtrI1
 Mpx45IQkRRuvdBSyoHINvqvcNdsVDQok8GaO8MFKdSNmHYsu6MwN79VUYbE9zLU4yDkjB2m0+
 yrQC/Jx+LqBjuyDtDq5xbkMCe7e6OvEy5ximIRGqeckJdBDN0E9aNAutKnIExTV/9kzDdnK47
 fNGWVxughdTKU4SKZvtMrwCm2a6wD/PlwHfJIeBGDgUiyn+LcnaUJnuooQ0pWRdetqVlHmHLJ
 6ayghR+FV2S/FhPjQ8u0fADfShmbLP/Zw/OR9aGxuSvt6wE2J5LC3Q9pi89hMGiXc1Pu5mp5T
 U9x34GSMrf4A7PUF6isRYVs2uPOkHW3k2R0blDnpUFxwPLJxbT2uUs0Q7FypZd2v1sURK9MXR
 2Cbc4qDOyMugxW9z9
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/01 09:14:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's important that the SeaBIOS hppa firmware is at least at a minimal
level to ensure proper interaction between qemu and firmware.

Implement a proper firmware version check by telling SeaBIOS via the
fw_cfg interface which minimal SeaBIOS version is required by this
running qemu instance. If the firmware detects that it's too old, it
will stop.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/machine.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 49155537cd..90aeefe2a4 100644
=2D-- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -25,6 +25,8 @@

 #define MAX_IDE_BUS 2

+#define MIN_SEABIOS_HPPA_VERSION 1 /* require at least this fw version */
+
 static ISABus *hppa_isa_bus(void)
 {
     ISABus *isa_bus;
@@ -56,6 +58,23 @@ static uint64_t cpu_hppa_to_phys(void *opaque, uint64_t=
 addr)
 static HPPACPU *cpu[HPPA_MAX_CPUS];
 static uint64_t firmware_entry;

+static FWCfgState *create_fw_cfg(MachineState *ms)
+{
+    FWCfgState *fw_cfg;
+    uint64_t val;
+
+    fw_cfg =3D fw_cfg_init_mem(QEMU_FW_CFG_IO_BASE, QEMU_FW_CFG_IO_BASE +=
 4);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, ms->smp.cpus);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, HPPA_MAX_CPUS);
+    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, ram_size);
+
+    val =3D cpu_to_le64(MIN_SEABIOS_HPPA_VERSION);
+    fw_cfg_add_file(fw_cfg, "/etc/firmware-min-version",
+                    g_memdup(&val, sizeof(val)), sizeof(val));
+
+    return fw_cfg;
+}
+
 static void machine_hppa_init(MachineState *machine)
 {
     const char *kernel_filename =3D machine->kernel_filename;
@@ -118,6 +137,9 @@ static void machine_hppa_init(MachineState *machine)
                        115200, serial_hd(0), DEVICE_BIG_ENDIAN);
     }

+    /* fw_cfg configuration interface */
+    create_fw_cfg(machine);
+
     /* SCSI disk setup. */
     dev =3D DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
     lsi53c8xx_handle_legacy_cmdline(dev);
=2D-
2.21.3



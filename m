Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EAFC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33401205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33401205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58928 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL7sW-00054h-Em
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 11:07:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hKyrI-00055g-Jw
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hKyrG-0003Ye-N6
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:29:44 -0400
Received: from mail-oln040092255032.outbound.protection.outlook.com
	([40.92.255.32]:33703
	helo=APC01-HK2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistair@alistair23.me>)
	id 1hKyrF-0003WF-1K
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:29:42 -0400
Received: from SG2APC01FT020.eop-APC01.prod.protection.outlook.com
	(10.152.250.56) by SG2APC01HT181.eop-APC01.prod.protection.outlook.com
	(10.152.251.194) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1835.13;
	Mon, 29 Apr 2019 05:29:31 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM (10.152.250.59) by
	SG2APC01FT020.mail.protection.outlook.com (10.152.250.219) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.20.1835.13 via Frontend Transport; Mon, 29 Apr 2019 05:29:31 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
	([fe80::d5cf:d2af:3aea:e2a3]) by PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
	([fe80::d5cf:d2af:3aea:e2a3%3]) with mapi id 15.20.1835.018;
	Mon, 29 Apr 2019 05:29:30 +0000
From: Alistair Francis <alistair@alistair23.me>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v1 1/5] armv7m: Allow entry information to be returned
Thread-Index: AQHU/kyF1rnXY4JySUKixW4VXk8aZg==
Date: Mon, 29 Apr 2019 05:29:30 +0000
Message-ID:
 <PSXP216MB0277DF1EDB800674F0611482DD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
References: <cover.1556515687.git.alistair@alistair23.me>
In-Reply-To: <cover.1556515687.git.alistair@alistair23.me>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0090.namprd11.prod.outlook.com
	(2603:10b6:a03:f4::31) To PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
	(2603:1096:300:a::18)
x-incomingtopheadermarker: OriginalChecksum:56D9B9B2E0BA3A449027E937B7C764445B33B59F63AE801007351B0C289C39C4;
	UpperCasedChecksum:884B2AD11162C6EB5DFBF265CC251FD0CC9B69B524EE90D5EA4F2CCCE595ADA7;
	SizeAsReceived:7532; Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-tmn: [aycWjdaP8jTN8GXxmC1IXRSLkRuWg8dtyDIFgNpfSLuAoJxH+N9d2tKJF4wum6R7]
x-microsoft-original-message-id: <114729bb106dbc14480880ca4b91c3fbe8eb3783.1556515687.git.alistair@alistair23.me>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
	SRVR:SG2APC01HT181; 
x-ms-traffictypediagnostic: SG2APC01HT181:
x-microsoft-antispam-message-info: wV+9BNVt3n8x1BtgMEKIKfECMHoRQkP/F7lgCxA52ZYCAqNgt2YGaXud00B98EW6/WOF64GMjd53YdnXQ8zsJu3NTZ9WUKA0GrxmTZZA0obAZ6bWE743CoDn+5FRZX6lgZFAmuojE7pXjGiFzgyE0+n8Jt1uYL6Rlc1pvJxTmFrAgSSjL7+woOCvse8ixHnD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe6c694-6e89-454d-2a11-08d6cc63a777
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 05:29:30.8541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT181
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.92.255.32
X-Mailman-Approved-At: Mon, 29 Apr 2019 11:06:13 -0400
Subject: [Qemu-devel] [PATCH v1 1/5] armv7m: Allow entry information to be
 returned
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
Cc: "alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429052930.mQNYHukOewHJnqu98ucCVDlBQiIXKPk8rZEua3V9cG0@z>

Allow the kernel's entry point information to be returned when loading a
kernel.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 hw/arm/armv7m.c      | 6 +++---
 hw/arm/microbit.c    | 2 +-
 hw/arm/mps2-tz.c     | 3 ++-
 hw/arm/mps2.c        | 2 +-
 hw/arm/msf2-som.c    | 2 +-
 hw/arm/musca.c       | 3 ++-
 hw/arm/netduino2.c   | 2 +-
 hw/arm/stellaris.c   | 3 ++-
 include/hw/arm/arm.h | 4 +++-
 9 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index c4b2a9a1f5..a52328f188 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -286,10 +286,10 @@ static void armv7m_reset(void *opaque)
     cpu_reset(CPU(cpu));
 }
=20
-void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_=
size)
+void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_=
size,
+                        uint64_t *entry)
 {
     int image_size;
-    uint64_t entry;
     uint64_t lowaddr;
     int big_endian;
     AddressSpace *as;
@@ -311,7 +311,7 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel=
_filename, int mem_size)
=20
     if (kernel_filename) {
         image_size =3D load_elf_as(kernel_filename, NULL, NULL, NULL,
-                                 &entry, &lowaddr,
+                                 entry, &lowaddr,
                                  NULL, big_endian, EM_ARM, 1, 0, as);
         if (image_size < 0) {
             image_size =3D load_image_targphys_as(kernel_filename, 0,
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index da67bf6d9d..03147750f1 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -58,7 +58,7 @@ static void microbit_init(MachineState *machine)
                                         mr, -1);
=20
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
-                       NRF51_SOC(soc)->flash_size);
+                       NRF51_SOC(soc)->flash_size, NULL);
 }
=20
 static void microbit_machine_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index f79f090a4a..f6dc7dce2a 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -613,7 +613,8 @@ static void mps2tz_common_init(MachineState *machine)
=20
     create_unimplemented_device("FPGA NS PC", 0x48007000, 0x1000);
=20
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0x400=
000);
+    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0x400=
000,
+                       NULL);
 }
=20
 static void mps2_tz_idau_check(IDAUInterface *ii, uint32_t address,
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index e3d698ba6c..55d2273a54 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -328,7 +328,7 @@ static void mps2_common_init(MachineState *machine)
     system_clock_scale =3D NANOSECONDS_PER_SECOND / SYSCLK_FRQ;
=20
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
-                       0x400000);
+                       0x400000, NULL);
 }
=20
 static void mps2_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 2432b5e935..f81be74716 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -92,7 +92,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machine=
)
     sysbus_connect_irq(SYS_BUS_DEVICE(&soc->spi[0]), 1, cs_line);
=20
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
-                       soc->envm_size);
+                       soc->envm_size, NULL);
 }
=20
 static void emcraft_sf2_machine_init(MachineClass *mc)
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 23aff43f4b..59460ba090 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -589,7 +589,8 @@ static void musca_init(MachineState *machine)
                                                      "cfg_sec_resp", 0));
     }
=20
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0x200=
0000);
+    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0x200=
0000,
+                       NULL);
 }
=20
 static void musca_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index f936017d4a..38a6d8fdd1 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -38,7 +38,7 @@ static void netduino2_init(MachineState *machine)
     object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
=20
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
-                       FLASH_SIZE);
+                       FLASH_SIZE, NULL);
 }
=20
 static void netduino2_machine_init(MachineClass *mc)
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 05f86749f4..276b1acc46 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1459,7 +1459,8 @@ static void stellaris_init(MachineState *ms, stellari=
s_board_info *board)
     create_unimplemented_device("hibernation", 0x400fc000, 0x1000);
     create_unimplemented_device("flash-control", 0x400fd000, 0x1000);
=20
-    armv7m_load_kernel(ARM_CPU(first_cpu), ms->kernel_filename, flash_size=
);
+    armv7m_load_kernel(ARM_CPU(first_cpu), ms->kernel_filename, flash_size=
,
+                       NULL);
 }
=20
 /* FIXME: Figure out how to generate these from stellaris_boards.  */
diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index ffed39252d..10f7e10d95 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -28,12 +28,14 @@ typedef enum {
  * @cpu: CPU
  * @kernel_filename: file to load
  * @mem_size: mem_size: maximum image size to load
+ * @entry: location of the kernel's entry point
  *
  * Load the guest image for an ARMv7M system. This must be called by
  * any ARMv7M board. (This is necessary to ensure that the CPU resets
  * correctly on system reset, as well as for kernel loading.)
  */
-void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_=
size);
+void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_=
size,
+                        uint64_t *entry);
=20
 /* arm_boot.c */
 struct arm_boot_info {
--=20
2.21.0



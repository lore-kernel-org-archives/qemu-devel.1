Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2055C352A3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C5620715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C5620715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izszK-0003HI-I6
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 21:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsva-0005qj-HR
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvX-000194-E5
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:30 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53083 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1izsvW-00017v-U9
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:27 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id CB3C31A20AF;
 Fri,  7 Feb 2020 02:58:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 67B2A1A1FEE;
 Fri,  7 Feb 2020 02:58:22 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH rc5 08/32] target/avr: Add defintions of AVR core types
Date: Fri,  7 Feb 2020 02:57:36 +0100
Message-Id: <1581040680-308-9-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

AVR core types are:

  - avr1
  - avr2
  - avr25
  - avr3
  - avr31
  - avr35
  - avr4
  - avr5
  - avr51
  - avr6
  - avrtiny
  - xmega2
  - xmega3
  - xmega4
  - xmega5
  - xmega6
  - xmega7

Each core type covers multiple AVR MCUs, mentioned in the comments
before definition of particular AVR core type (part of this patch).

AVR core type defines shared features that are valid for all AVR
MCUs belonging in that type.

[AM: Split a larger AVR introduction patch into logical units]
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/avr/cpu.c | 560 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 560 insertions(+)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index f2632a3..aff9eec 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -215,3 +215,563 @@ static void avr_cpu_class_init(ObjectClass *oc, voi=
d *data)
     cc->gdb_num_core_regs =3D 35;
     cc->gdb_core_xml_file =3D "avr-cpu.xml";
 }
+
+/*
+ * Setting features of AVR core type avr1
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * at90s1200, attiny11, attiny12, attiny15, attiny28
+ */
+static void avr_avr1_initfn(Object *obj)
+{
+    AVRCPU *cpu =3D AVR_CPU(obj);
+    CPUAVRState *env =3D &cpu->env;
+
+    set_avr_feature(env, AVR_FEATURE_LPM);
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
+}
+
+/*
+ * Setting features of AVR core type avr2
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * at90s2313, at90s2323, at90s2333, at90s2343, attiny22, attiny26, at90s=
4414,
+ * at90s4433, at90s4434, at90s8515, at90c8534, at90s8535
+ */
+static void avr_avr2_initfn(Object *obj)
+{
+    AVRCPU *cpu =3D AVR_CPU(obj);
+    CPUAVRState *env =3D &cpu->env;
+
+    set_avr_feature(env, AVR_FEATURE_LPM);
+    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
+    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
+    set_avr_feature(env, AVR_FEATURE_SRAM);
+    set_avr_feature(env, AVR_FEATURE_BREAK);
+
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
+}
+
+/*
+ * Setting features of AVR core type avr25
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * ata5272, ata6616c, attiny13, attiny13a, attiny2313, attiny2313a, atti=
ny24,
+ * attiny24a, attiny4313, attiny44, attiny44a, attiny441, attiny84, atti=
ny84a,
+ * attiny25, attiny45, attiny85, attiny261, attiny261a, attiny461, attin=
y461a,
+ * attiny861, attiny861a, attiny43u, attiny87, attiny48, attiny88, attin=
y828,
+ * attiny841, at86rf401
+ */
+static void avr_avr25_initfn(Object *obj)
+{
+    AVRCPU *cpu =3D AVR_CPU(obj);
+    CPUAVRState *env =3D &cpu->env;
+
+    set_avr_feature(env, AVR_FEATURE_LPM);
+    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
+    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
+    set_avr_feature(env, AVR_FEATURE_SRAM);
+    set_avr_feature(env, AVR_FEATURE_BREAK);
+
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
+    set_avr_feature(env, AVR_FEATURE_LPMX);
+    set_avr_feature(env, AVR_FEATURE_MOVW);
+}
+
+/*
+ * Setting features of AVR core type avr3
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * at43usb355, at76c711
+ */
+static void avr_avr3_initfn(Object *obj)
+{
+    AVRCPU *cpu =3D AVR_CPU(obj);
+    CPUAVRState *env =3D &cpu->env;
+
+    set_avr_feature(env, AVR_FEATURE_LPM);
+    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
+    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
+    set_avr_feature(env, AVR_FEATURE_SRAM);
+    set_avr_feature(env, AVR_FEATURE_BREAK);
+
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
+    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
+}
+
+/*
+ * Setting features of AVR core type avr31
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * atmega103, at43usb320
+ */
+static void avr_avr31_initfn(Object *obj)
+{
+    AVRCPU *cpu =3D AVR_CPU(obj);
+    CPUAVRState *env =3D &cpu->env;
+
+    set_avr_feature(env, AVR_FEATURE_LPM);
+    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
+    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
+    set_avr_feature(env, AVR_FEATURE_SRAM);
+    set_avr_feature(env, AVR_FEATURE_BREAK);
+
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
+    set_avr_feature(env, AVR_FEATURE_RAMPZ);
+    set_avr_feature(env, AVR_FEATURE_ELPM);
+    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
+}
+
+/*
+ * Setting features of AVR core type avr35
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * ata5505, ata6617c, ata664251, at90usb82, at90usb162, atmega8u2, atmeg=
a16u2,
+ * atmega32u2, attiny167, attiny1634
+ */
+static void avr_avr35_initfn(Object *obj)
+{
+    AVRCPU *cpu =3D AVR_CPU(obj);
+    CPUAVRState *env =3D &cpu->env;
+
+    set_avr_feature(env, AVR_FEATURE_LPM);
+    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
+    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
+    set_avr_feature(env, AVR_FEATURE_SRAM);
+    set_avr_feature(env, AVR_FEATURE_BREAK);
+
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
+    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
+    set_avr_feature(env, AVR_FEATURE_LPMX);
+    set_avr_feature(env, AVR_FEATURE_MOVW);
+}
+
+/*
+ * Setting features of AVR core type avr4
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * ata6285, ata6286, ata6289, ata6612c, atmega8, atmega8a, atmega48, atm=
ega48a,
+ * atmega48p, atmega48pa, atmega48pb, atmega88, atmega88a, atmega88p,
+ * atmega88pa, atmega88pb, atmega8515, atmega8535, atmega8hva, at90pwm1,
+ * at90pwm2, at90pwm2b, at90pwm3, at90pwm3b, at90pwm81
+ */
+static void avr_avr4_initfn(Object *obj)
+{
+    AVRCPU *cpu =3D AVR_CPU(obj);
+    CPUAVRState *env =3D &cpu->env;
+
+    set_avr_feature(env, AVR_FEATURE_LPM);
+    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
+    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
+    set_avr_feature(env, AVR_FEATURE_SRAM);
+    set_avr_feature(env, AVR_FEATURE_BREAK);
+
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
+    set_avr_feature(env, AVR_FEATURE_LPMX);
+    set_avr_feature(env, AVR_FEATURE_MOVW);
+    set_avr_feature(env, AVR_FEATURE_MUL);
+}
+
+/*
+ * Setting features of AVR core type avr5
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * ata5702m322, ata5782, ata5790, ata5790n, ata5791, ata5795, ata5831, a=
ta6613c,
+ * ata6614q, ata8210, ata8510, atmega16, atmega16a, atmega161, atmega162=
,
+ * atmega163, atmega164a, atmega164p, atmega164pa, atmega165, atmega165a=
,
+ * atmega165p, atmega165pa, atmega168, atmega168a, atmega168p, atmega168=
pa,
+ * atmega168pb, atmega169, atmega169a, atmega169p, atmega169pa, atmega16=
hvb,
+ * atmega16hvbrevb, atmega16m1, atmega16u4, atmega32a, atmega32, atmega3=
23,
+ * atmega324a, atmega324p, atmega324pa, atmega325, atmega325a, atmega325=
p,
+ * atmega325pa, atmega3250, atmega3250a, atmega3250p, atmega3250pa, atme=
ga328,
+ * atmega328p, atmega328pb, atmega329, atmega329a, atmega329p, atmega329=
pa,
+ * atmega3290, atmega3290a, atmega3290p, atmega3290pa, atmega32c1, atmeg=
a32m1,
+ * atmega32u4, atmega32u6, atmega406, atmega64, atmega64a, atmega640, at=
mega644,
+ * atmega644a, atmega644p, atmega644pa, atmega645, atmega645a, atmega645=
p,
+ * atmega6450, atmega6450a, atmega6450p, atmega649, atmega649a, atmega64=
9p,
+ * atmega6490, atmega16hva, atmega16hva2, atmega32hvb, atmega6490a, atme=
ga6490p,
+ * atmega64c1, atmega64m1, atmega64hve, atmega64hve2, atmega64rfr2,
+ * atmega644rfr2, atmega32hvbrevb, at90can32, at90can64, at90pwm161, at9=
0pwm216,
+ * at90pwm316, at90scr100, at90usb646, at90usb647, at94k, m3000
+ */
+static void avr_avr5_initfn(Object *obj)
+{
+    AVRCPU *cpu =3D AVR_CPU(obj);
+    CPUAVRState *env =3D &cpu->env;
+
+    set_avr_feature(env, AVR_FEATURE_LPM);
+    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
+    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
+    set_avr_feature(env, AVR_FEATURE_SRAM);
+    set_avr_feature(env, AVR_FEATURE_BREAK);
+
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
+    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
+    set_avr_feature(env, AVR_FEATURE_LPMX);
+    set_avr_feature(env, AVR_FEATURE_MOVW);
+    set_avr_feature(env, AVR_FEATURE_MUL);
+}
+
+/*
+ * Setting features of AVR core type avr51
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * atmega128, atmega128a, atmega1280, atmega1281, atmega1284, atmega1284=
p,
+ * atmega128rfa1, atmega128rfr2, atmega1284rfr2, at90can128, at90usb1286=
,
+ * at90usb1287
+ */
+static void avr_avr51_initfn(Object *obj)
+{
+    AVRCPU *cpu =3D AVR_CPU(obj);
+    CPUAVRState *env =3D &cpu->env;
+
+    set_avr_feature(env, AVR_FEATURE_LPM);
+    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
+    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
+    set_avr_feature(env, AVR_FEATURE_SRAM);
+    set_avr_feature(env, AVR_FEATURE_BREAK);
+
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
+    set_avr_feature(env, AVR_FEATURE_RAMPZ);
+    set_avr_feature(env, AVR_FEATURE_ELPMX);
+    set_avr_feature(env, AVR_FEATURE_ELPM);
+    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
+    set_avr_feature(env, AVR_FEATURE_LPMX);
+    set_avr_feature(env, AVR_FEATURE_MOVW);
+    set_avr_feature(env, AVR_FEATURE_MUL);
+}
+
+/*
+ * Setting features of AVR core type avr6
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * atmega2560, atmega2561, atmega256rfr2, atmega2564rfr2
+ */
+static void avr_avr6_initfn(Object *obj)
+{
+    AVRCPU *cpu =3D AVR_CPU(obj);
+    CPUAVRState *env =3D &cpu->env;
+
+    set_avr_feature(env, AVR_FEATURE_LPM);
+    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
+    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
+    set_avr_feature(env, AVR_FEATURE_SRAM);
+    set_avr_feature(env, AVR_FEATURE_BREAK);
+
+    set_avr_feature(env, AVR_FEATURE_3_BYTE_PC);
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
+    set_avr_feature(env, AVR_FEATURE_RAMPZ);
+    set_avr_feature(env, AVR_FEATURE_EIJMP_EICALL);
+    set_avr_feature(env, AVR_FEATURE_ELPMX);
+    set_avr_feature(env, AVR_FEATURE_ELPM);
+    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
+    set_avr_feature(env, AVR_FEATURE_LPMX);
+    set_avr_feature(env, AVR_FEATURE_MOVW);
+    set_avr_feature(env, AVR_FEATURE_MUL);
+}
+
+/*
+ * Setting features of AVR core type avrtiny
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * attiny4, attiny5, attiny9, attiny10, attiny20, attiny40
+ */
+static void avr_avrtiny_initfn(Object *obj)
+{
+    AVRCPU *cpu =3D AVR_CPU(obj);
+    CPUAVRState *env =3D &cpu->env;
+
+    set_avr_feature(env, AVR_FEATURE_LPM);
+    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
+    set_avr_feature(env, AVR_FEATURE_BREAK);
+
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
+    set_avr_feature(env, AVR_FEATURE_1_BYTE_SP);
+}
+
+/*
+ * Setting features of AVR core type xmega2
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * atxmega8e5, atxmega16a4, atxmega16d4, atxmega16e5, atxmega32a4, atxme=
ga32c3,
+ * atxmega32d3, atxmega32d4, atxmega16a4u, atxmega16c4, atxmega32a4u,
+ * atxmega32c4, atxmega32e5
+ */
+static void avr_xmega2_initfn(Object *obj)
+{
+    AVRCPU *cpu =3D AVR_CPU(obj);
+    CPUAVRState *env =3D &cpu->env;
+
+    set_avr_feature(env, AVR_FEATURE_LPM);
+    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
+    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
+    set_avr_feature(env, AVR_FEATURE_SRAM);
+    set_avr_feature(env, AVR_FEATURE_BREAK);
+
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
+    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
+    set_avr_feature(env, AVR_FEATURE_LPMX);
+    set_avr_feature(env, AVR_FEATURE_MOVW);
+    set_avr_feature(env, AVR_FEATURE_MUL);
+    set_avr_feature(env, AVR_FEATURE_RMW);
+}
+
+/*
+ * Setting features of AVR core type xmega3
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * attiny212, attiny214, attiny412, attiny414, attiny416, attiny417, att=
iny814,
+ * attiny816, attiny817, attiny1614, attiny1616, attiny1617, attiny3214,
+ * attiny3216, attiny3217, atmega808, atmega809, atmega1608, atmega1609,
+ * atmega3208, atmega3209, atmega4808, atmega4809
+ */
+static void avr_xmega3_initfn(Object *obj)
+{
+    AVRCPU *cpu =3D AVR_CPU(obj);
+    CPUAVRState *env =3D &cpu->env;
+
+    set_avr_feature(env, AVR_FEATURE_LPM);
+    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
+    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
+    set_avr_feature(env, AVR_FEATURE_SRAM);
+    set_avr_feature(env, AVR_FEATURE_BREAK);
+
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
+    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
+    set_avr_feature(env, AVR_FEATURE_LPMX);
+    set_avr_feature(env, AVR_FEATURE_MOVW);
+    set_avr_feature(env, AVR_FEATURE_MUL);
+    set_avr_feature(env, AVR_FEATURE_RMW);
+}
+
+/*
+ * Setting features of AVR core type xmega4
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * atxmega64a3, atxmega64d3, atxmega64a3u, atxmega64a4u, atxmega64b1,
+ * atxmega64b3, atxmega64c3, atxmega64d4
+ */
+static void avr_xmega4_initfn(Object *obj)
+{
+    AVRCPU *cpu =3D AVR_CPU(obj);
+    CPUAVRState *env =3D &cpu->env;
+
+    set_avr_feature(env, AVR_FEATURE_LPM);
+    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
+    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
+    set_avr_feature(env, AVR_FEATURE_SRAM);
+    set_avr_feature(env, AVR_FEATURE_BREAK);
+
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
+    set_avr_feature(env, AVR_FEATURE_ELPMX);
+    set_avr_feature(env, AVR_FEATURE_ELPM);
+    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
+    set_avr_feature(env, AVR_FEATURE_LPMX);
+    set_avr_feature(env, AVR_FEATURE_MOVW);
+    set_avr_feature(env, AVR_FEATURE_MUL);
+    set_avr_feature(env, AVR_FEATURE_RMW);
+}
+
+/*
+ * Setting features of AVR core type xmega5
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * atxmega64a1, atxmega64a1u
+ */
+static void avr_xmega5_initfn(Object *obj)
+{
+    AVRCPU *cpu =3D AVR_CPU(obj);
+    CPUAVRState *env =3D &cpu->env;
+
+    set_avr_feature(env, AVR_FEATURE_LPM);
+    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
+    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
+    set_avr_feature(env, AVR_FEATURE_SRAM);
+    set_avr_feature(env, AVR_FEATURE_BREAK);
+
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
+    set_avr_feature(env, AVR_FEATURE_RAMPD);
+    set_avr_feature(env, AVR_FEATURE_RAMPX);
+    set_avr_feature(env, AVR_FEATURE_RAMPY);
+    set_avr_feature(env, AVR_FEATURE_RAMPZ);
+    set_avr_feature(env, AVR_FEATURE_ELPMX);
+    set_avr_feature(env, AVR_FEATURE_ELPM);
+    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
+    set_avr_feature(env, AVR_FEATURE_LPMX);
+    set_avr_feature(env, AVR_FEATURE_MOVW);
+    set_avr_feature(env, AVR_FEATURE_MUL);
+    set_avr_feature(env, AVR_FEATURE_RMW);
+}
+
+/*
+ * Setting features of AVR core type xmega6
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * atxmega128a3, atxmega128d3, atxmega192a3, atxmega192d3, atxmega256a3,
+ * atxmega256a3b, atxmega256a3bu, atxmega256d3, atxmega128a3u, atxmega12=
8b1,
+ * atxmega128b3, atxmega128c3, atxmega128d4, atxmega192a3u, atxmega192c3=
,
+ * atxmega256a3u, atxmega256c3, atxmega384c3, atxmega384d3
+ */
+static void avr_xmega6_initfn(Object *obj)
+{
+    AVRCPU *cpu =3D AVR_CPU(obj);
+    CPUAVRState *env =3D &cpu->env;
+
+    set_avr_feature(env, AVR_FEATURE_LPM);
+    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
+    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
+    set_avr_feature(env, AVR_FEATURE_SRAM);
+    set_avr_feature(env, AVR_FEATURE_BREAK);
+
+    set_avr_feature(env, AVR_FEATURE_3_BYTE_PC);
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
+    set_avr_feature(env, AVR_FEATURE_RAMPZ);
+    set_avr_feature(env, AVR_FEATURE_EIJMP_EICALL);
+    set_avr_feature(env, AVR_FEATURE_ELPMX);
+    set_avr_feature(env, AVR_FEATURE_ELPM);
+    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
+    set_avr_feature(env, AVR_FEATURE_LPMX);
+    set_avr_feature(env, AVR_FEATURE_MOVW);
+    set_avr_feature(env, AVR_FEATURE_MUL);
+    set_avr_feature(env, AVR_FEATURE_RMW);
+}
+
+/*
+ * Setting features of AVR core type xmega7
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * atxmega128a1, atxmega128a1u, atxmega128a4u
+ */
+static void avr_xmega7_initfn(Object *obj)
+{
+    AVRCPU *cpu =3D AVR_CPU(obj);
+    CPUAVRState *env =3D &cpu->env;
+
+    set_avr_feature(env, AVR_FEATURE_LPM);
+    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
+    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
+    set_avr_feature(env, AVR_FEATURE_SRAM);
+    set_avr_feature(env, AVR_FEATURE_BREAK);
+
+    set_avr_feature(env, AVR_FEATURE_3_BYTE_PC);
+    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
+    set_avr_feature(env, AVR_FEATURE_RAMPD);
+    set_avr_feature(env, AVR_FEATURE_RAMPX);
+    set_avr_feature(env, AVR_FEATURE_RAMPY);
+    set_avr_feature(env, AVR_FEATURE_RAMPZ);
+    set_avr_feature(env, AVR_FEATURE_EIJMP_EICALL);
+    set_avr_feature(env, AVR_FEATURE_ELPMX);
+    set_avr_feature(env, AVR_FEATURE_ELPM);
+    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
+    set_avr_feature(env, AVR_FEATURE_LPMX);
+    set_avr_feature(env, AVR_FEATURE_MOVW);
+    set_avr_feature(env, AVR_FEATURE_MUL);
+    set_avr_feature(env, AVR_FEATURE_RMW);
+}
+
+typedef struct AVRCPUInfo {
+    const char *name;
+    void (*initfn)(Object *obj);
+} AVRCPUInfo;
+
+
+static void avr_cpu_list_entry(gpointer data, gpointer user_data)
+{
+    const char *typename =3D object_class_get_name(OBJECT_CLASS(data));
+
+    qemu_printf("%s\n", typename);
+}
+
+void avr_cpu_list(void)
+{
+    GSList *list;
+    list =3D object_class_get_list_sorted(TYPE_AVR_CPU, false);
+    g_slist_foreach(list, avr_cpu_list_entry, NULL);
+    g_slist_free(list);
+}
+
+#define DEFINE_AVR_CPU_TYPE(model, initfn) \
+    { \
+        .parent =3D TYPE_AVR_CPU, \
+        .instance_init =3D initfn, \
+        .name =3D AVR_CPU_TYPE_NAME(model), \
+    }
+
+static const TypeInfo avr_cpu_type_info[] =3D {
+    {
+        .name =3D TYPE_AVR_CPU,
+        .parent =3D TYPE_CPU,
+        .instance_size =3D sizeof(AVRCPU),
+        .instance_init =3D avr_cpu_initfn,
+        .class_size =3D sizeof(AVRCPUClass),
+        .class_init =3D avr_cpu_class_init,
+        .abstract =3D true,
+    },
+    DEFINE_AVR_CPU_TYPE("avrtiny", avr_avrtiny_initfn),
+    DEFINE_AVR_CPU_TYPE("avr1", avr_avr1_initfn),
+    DEFINE_AVR_CPU_TYPE("avr2", avr_avr2_initfn),
+    DEFINE_AVR_CPU_TYPE("avr25", avr_avr25_initfn),
+    DEFINE_AVR_CPU_TYPE("avr3", avr_avr3_initfn),
+    DEFINE_AVR_CPU_TYPE("avr31", avr_avr31_initfn),
+    DEFINE_AVR_CPU_TYPE("avr35", avr_avr35_initfn),
+    DEFINE_AVR_CPU_TYPE("avr4", avr_avr4_initfn),
+    DEFINE_AVR_CPU_TYPE("avr5", avr_avr5_initfn),
+    DEFINE_AVR_CPU_TYPE("avr51", avr_avr51_initfn),
+    DEFINE_AVR_CPU_TYPE("avr6", avr_avr6_initfn),
+    DEFINE_AVR_CPU_TYPE("xmega2", avr_xmega2_initfn),
+    DEFINE_AVR_CPU_TYPE("xmega3", avr_xmega3_initfn),
+    DEFINE_AVR_CPU_TYPE("xmega4", avr_xmega4_initfn),
+    DEFINE_AVR_CPU_TYPE("xmega5", avr_xmega5_initfn),
+    DEFINE_AVR_CPU_TYPE("xmega6", avr_xmega6_initfn),
+    DEFINE_AVR_CPU_TYPE("xmega7", avr_xmega7_initfn),
+};
+
+
+DEFINE_TYPES(avr_cpu_type_info)
--=20
2.7.4



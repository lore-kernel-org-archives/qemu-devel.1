Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDF7C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38CE220724
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CE220724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js5Fz-0000ra-De
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 10:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5F4-0007Fn-Nm
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:38 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:39151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5F2-0008Ij-9K
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:38 -0400
Received: by mail-ej1-f65.google.com with SMTP id w6so39687969ejq.6
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 07:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5enkAooU5lwxNXXCx0RZhO9R/N9FPDFBQSmwf5FAFfo=;
 b=YX31MOgQp+sFCy86eC14Cl7v4dJOqowgIld2oSTcT3vz+Oc4Id0haH2jzcg0rqWtrp
 o+DsMK2S1u4MKkxHm+iq/SCwiLGzk0hHB/JtAAButo59dtJANjrKEE9Y5KnCmZAp7ogW
 QJGTX7u5ZUnNNPUD9C6jCAGsmSfF8Cq8vrMhQ2DF8DLgWzgyDAZKWM0zv7rrPbufM9nP
 aHAMd30GCletUQWSlj4VWUOz7padIee8SNNapEFp+peNG1bvGvwYQRN7uuc9/AqeGYOm
 WzpbRWUfvLC8qilysAYdtgQzlr9ap+iaw4rTfJVmqsZNfdpYGrkfd0Qsa38tNmqTVEAa
 aWpg==
X-Gm-Message-State: AOAM531LuwM0MAtmoX6X3JoZJC5uZl0FhEkSy0kN8iMAloObBaDTKIit
 KZ0pprE6VKummjpkm+pDjvrl2oJE
X-Google-Smtp-Source: ABdhPJwW+TDMdBp9wphUGHfFHgTeHMa2IMGjJkNyiMFLt4Cz/C8L+vFLL73PaHX8M0kTP+0AXbdkMg==
X-Received: by 2002:a17:906:90b:: with SMTP id
 i11mr39256172ejd.343.1593957814458; 
 Sun, 05 Jul 2020 07:03:34 -0700 (PDT)
Received: from thl530.multi.box (pd9e83654.dip0.t-ipconnect.de.
 [217.232.54.84])
 by smtp.gmail.com with ESMTPSA id bq8sm10941776ejb.103.2020.07.05.07.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 07:03:34 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Subject: [PATCH rc6 08/30] target/avr: Add defintions of AVR core types
Date: Sun,  5 Jul 2020 16:02:53 +0200
Message-Id: <20200705140315.260514-9-huth@tuxfamily.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200705140315.260514-1-huth@tuxfamily.org>
References: <20200705140315.260514-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.65; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 10:03:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>
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
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 target/avr/cpu.c | 560 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 560 insertions(+)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 4802453ff9..b7b2c21533 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -215,3 +215,563 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_num_core_regs = 35;
     cc->gdb_core_xml_file = "avr-cpu.xml";
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
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
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
+ * at90s2313, at90s2323, at90s2333, at90s2343, attiny22, attiny26, at90s4414,
+ * at90s4433, at90s4434, at90s8515, at90c8534, at90s8535
+ */
+static void avr_avr2_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
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
+ * ata5272, ata6616c, attiny13, attiny13a, attiny2313, attiny2313a, attiny24,
+ * attiny24a, attiny4313, attiny44, attiny44a, attiny441, attiny84, attiny84a,
+ * attiny25, attiny45, attiny85, attiny261, attiny261a, attiny461, attiny461a,
+ * attiny861, attiny861a, attiny43u, attiny87, attiny48, attiny88, attiny828,
+ * attiny841, at86rf401
+ */
+static void avr_avr25_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
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
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
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
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
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
+ * ata5505, ata6617c, ata664251, at90usb82, at90usb162, atmega8u2, atmega16u2,
+ * atmega32u2, attiny167, attiny1634
+ */
+static void avr_avr35_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
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
+ * ata6285, ata6286, ata6289, ata6612c, atmega8, atmega8a, atmega48, atmega48a,
+ * atmega48p, atmega48pa, atmega48pb, atmega88, atmega88a, atmega88p,
+ * atmega88pa, atmega88pb, atmega8515, atmega8535, atmega8hva, at90pwm1,
+ * at90pwm2, at90pwm2b, at90pwm3, at90pwm3b, at90pwm81
+ */
+static void avr_avr4_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
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
+ * ata5702m322, ata5782, ata5790, ata5790n, ata5791, ata5795, ata5831, ata6613c,
+ * ata6614q, ata8210, ata8510, atmega16, atmega16a, atmega161, atmega162,
+ * atmega163, atmega164a, atmega164p, atmega164pa, atmega165, atmega165a,
+ * atmega165p, atmega165pa, atmega168, atmega168a, atmega168p, atmega168pa,
+ * atmega168pb, atmega169, atmega169a, atmega169p, atmega169pa, atmega16hvb,
+ * atmega16hvbrevb, atmega16m1, atmega16u4, atmega32a, atmega32, atmega323,
+ * atmega324a, atmega324p, atmega324pa, atmega325, atmega325a, atmega325p,
+ * atmega325pa, atmega3250, atmega3250a, atmega3250p, atmega3250pa, atmega328,
+ * atmega328p, atmega328pb, atmega329, atmega329a, atmega329p, atmega329pa,
+ * atmega3290, atmega3290a, atmega3290p, atmega3290pa, atmega32c1, atmega32m1,
+ * atmega32u4, atmega32u6, atmega406, atmega64, atmega64a, atmega640, atmega644,
+ * atmega644a, atmega644p, atmega644pa, atmega645, atmega645a, atmega645p,
+ * atmega6450, atmega6450a, atmega6450p, atmega649, atmega649a, atmega649p,
+ * atmega6490, atmega16hva, atmega16hva2, atmega32hvb, atmega6490a, atmega6490p,
+ * atmega64c1, atmega64m1, atmega64hve, atmega64hve2, atmega64rfr2,
+ * atmega644rfr2, atmega32hvbrevb, at90can32, at90can64, at90pwm161, at90pwm216,
+ * at90pwm316, at90scr100, at90usb646, at90usb647, at94k, m3000
+ */
+static void avr_avr5_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
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
+ * atmega128, atmega128a, atmega1280, atmega1281, atmega1284, atmega1284p,
+ * atmega128rfa1, atmega128rfr2, atmega1284rfr2, at90can128, at90usb1286,
+ * at90usb1287
+ */
+static void avr_avr51_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
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
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
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
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
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
+ * atxmega8e5, atxmega16a4, atxmega16d4, atxmega16e5, atxmega32a4, atxmega32c3,
+ * atxmega32d3, atxmega32d4, atxmega16a4u, atxmega16c4, atxmega32a4u,
+ * atxmega32c4, atxmega32e5
+ */
+static void avr_xmega2_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
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
+ * attiny212, attiny214, attiny412, attiny414, attiny416, attiny417, attiny814,
+ * attiny816, attiny817, attiny1614, attiny1616, attiny1617, attiny3214,
+ * attiny3216, attiny3217, atmega808, atmega809, atmega1608, atmega1609,
+ * atmega3208, atmega3209, atmega4808, atmega4809
+ */
+static void avr_xmega3_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
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
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
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
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
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
+ * atxmega256a3b, atxmega256a3bu, atxmega256d3, atxmega128a3u, atxmega128b1,
+ * atxmega128b3, atxmega128c3, atxmega128d4, atxmega192a3u, atxmega192c3,
+ * atxmega256a3u, atxmega256c3, atxmega384c3, atxmega384d3
+ */
+static void avr_xmega6_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
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
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
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
+    const char *typename = object_class_get_name(OBJECT_CLASS(data));
+
+    qemu_printf("%s\n", typename);
+}
+
+void avr_cpu_list(void)
+{
+    GSList *list;
+    list = object_class_get_list_sorted(TYPE_AVR_CPU, false);
+    g_slist_foreach(list, avr_cpu_list_entry, NULL);
+    g_slist_free(list);
+}
+
+#define DEFINE_AVR_CPU_TYPE(model, initfn) \
+    { \
+        .parent = TYPE_AVR_CPU, \
+        .instance_init = initfn, \
+        .name = AVR_CPU_TYPE_NAME(model), \
+    }
+
+static const TypeInfo avr_cpu_type_info[] = {
+    {
+        .name = TYPE_AVR_CPU,
+        .parent = TYPE_CPU,
+        .instance_size = sizeof(AVRCPU),
+        .instance_init = avr_cpu_initfn,
+        .class_size = sizeof(AVRCPUClass),
+        .class_init = avr_cpu_class_init,
+        .abstract = true,
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
-- 
2.26.2



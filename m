Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94F6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B8520675
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNoCk2Yc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B8520675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssEq-0007KC-Kq
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jss9p-0007aZ-O5
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:29 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:50794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jss9n-0002sg-R3
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:29 -0400
Received: by mail-wm1-x32b.google.com with SMTP id l17so104027wmj.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=leFnQVZxp6n1rTBN3KN+k73hWpLZi4g9NsI2yg+Ji+A=;
 b=tNoCk2YcD7mfP9RnIx8s+leFpF6kWhWy61RYYIGcpnXi7eP0JjIenu4zcECgqqqGWC
 DdBKgCMoe0+SVy+CwBHdfLgKVhupTPkzst81/aHgBTbNay3NOfgnJEgs0913sOCFPoz0
 Sfdd7u4nmN1qUwKT71p8mTsPNeqqiDc0QSWBc69hHvoQq6fcUO2Y3SnYoJ+EerkYPVSB
 wJ3H6rSuIJVOS8r1IvFAlSxDcfd3uDMKwDBB2EOqefrMYuitgPe1rOFUyGzgNkj5zioT
 0g5qLTyA8R2byOFV9rbAqtyfGXPypUupqm7A0Fpz9vwVgbms7tZWMNu40t5uFUfMPs/5
 vLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=leFnQVZxp6n1rTBN3KN+k73hWpLZi4g9NsI2yg+Ji+A=;
 b=gtSXvagp/g/nf0yUupfUsTkRuhDH3iykTLdE6+KvQ6n9V8yoeeWppD80KgBUWFv3E/
 8pEbDQq8CmiUcVTf6rtrqw9xt5+j4x71RNHmMIbPiPBaq+2BmZKcgloA0UJ4cOWN9jod
 ZKjCMDe7F9UMHC4SrtDkrVWeM/m+eAW+eTRpFX5OsIgQUuWM5lFGnKht6EEs8De3ASfP
 CrVGQw/KhSVyNn6iwwN2VqG5XBra1iVA/TmwFAuwrTjStFg15DKF3ZG9x4j+GHhQe1uV
 r/sY19atY9XSYsxN0GYDddujXoejXsOcsyVCovcMWhwS/Ood7J9Laov+uXwDTCyNSD0I
 Jb5w==
X-Gm-Message-State: AOAM5311zvf/rk4qvAFmJlNnYR/BjbatUwd9MILMzPC2kgYVFNT8ZnLF
 wakPBvs2+H813r97v5zMVe/Yhfot
X-Google-Smtp-Source: ABdhPJyyo4ahuJE6xsLXMeVwk8dDHMsPqRF26qzQo/nJaN8cWkn+MU1jUUK32jTtIUgNPvjYN7lPpA==
X-Received: by 2002:a1c:4408:: with SMTP id r8mr5434311wma.100.1594145846213; 
 Tue, 07 Jul 2020 11:17:26 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 65sm2253337wma.48.2020.07.07.11.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 11:17:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/32] target/avr: Add definitions of AVR core types
Date: Tue,  7 Jul 2020 20:16:46 +0200
Message-Id: <20200707181710.30950-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707181710.30950-1-f4bug@amsat.org>
References: <20200707181710.30950-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

AVR core types are:

  - avr5
  - avr51
  - avr6

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
Message-Id: <20200705140315.260514-9-huth@tuxfamily.org>
[PMD: Only include reviewed cores: avr5/avr51/avr6]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/avr/cpu.c | 152 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index ac496b8f03..7178e86f69 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -215,3 +215,155 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_num_core_regs = 35;
     cc->gdb_core_xml_file = "avr-cpu.xml";
 }
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
+    DEFINE_AVR_CPU_TYPE("avr5", avr_avr5_initfn),
+    DEFINE_AVR_CPU_TYPE("avr51", avr_avr51_initfn),
+    DEFINE_AVR_CPU_TYPE("avr6", avr_avr6_initfn),
+};
+
+
+DEFINE_TYPES(avr_cpu_type_info)
-- 
2.21.3



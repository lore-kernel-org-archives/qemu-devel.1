Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE77C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6C920675
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErYYCwn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6C920675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssEy-0007dv-Cb
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jss9n-0007VY-T8
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:27 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:35586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jss9m-0002sV-8D
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:27 -0400
Received: by mail-wm1-x334.google.com with SMTP id l2so91745wmf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s/JhSdXpcoybmAAgefympk9swhlKDHAfPJ59qTtpwus=;
 b=ErYYCwn2/qbCHwAVy5rv7+DhnGPbfMFDO9iW6iZ4Vf8FzreJqhcR956w+C4UV/A4BS
 Vz4a+d95onuiHOC2DaOFiXL8+qaJrdSy2mLJFVl5zYxjuqot6MUz+dnyMMSAdJ+XXZZv
 ucoTsGJBcs82PfrMQPd5XgC9s+t2W9g3P8rnzCdkLSoq6OCDARpmKxLxcl5GJ4Ge+ZVI
 1AzhcysiRisx4oLj5GTou44gNzywIaFMPTFpArGpWF1yIqNq4NIIaKK7p1VaONYr+274
 DQChlmZfhRmmy8E6/oeiTTr9afsuuDwOri7JnQnljT0OiPS+KZwFI/Kuw/Nni2oPs/6J
 xESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=s/JhSdXpcoybmAAgefympk9swhlKDHAfPJ59qTtpwus=;
 b=R1F+rkJEYHBAe0cAQquAGocR7oyQgZRQ6mTsOdCOiv6FjVy2fjogDkww4LNmyk/33n
 ppl24SMVxeMu+g1jnl8r5Gz6qfNsRpAvAzHDzWgn1WBZcy4N0uK4+fhTCyQeBqMaxa64
 /w7UxZTt35s8SX1UYmrl762LWqy/738fqUrrERwpuYdyP8GpJbz2Ji80DlE79RqfjuOF
 B1N96njpm/kKyhYDx8XoMu+RIhVlM1IIbd96UAervrv+scJ2GR+m5YyTYHYD7a2ITcvn
 ii0HuuWuqQn//7nIjBk1oIa80S6BQgOIsuHoei6pyK0QtvjBonKjcRLxlgTJe2pvJaJY
 y4IQ==
X-Gm-Message-State: AOAM530gLNQ9/kXEn/KAIYgE7wOhIckO2SDYcBWnuyhAVNCfOlMFzroV
 v0gAKGbRWADjj6DIOWVQTiOl3gOp
X-Google-Smtp-Source: ABdhPJyqDIUafeSazF2qLOYMuiVOrRJuM12pldRGzulNYUtGmrZ3pJlqAq+TPqo0L7UNs6u2VMJqNw==
X-Received: by 2002:a05:600c:204d:: with SMTP id
 p13mr5407067wmg.88.1594145844694; 
 Tue, 07 Jul 2020 11:17:24 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 65sm2253337wma.48.2020.07.07.11.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 11:17:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/32] target/avr: Introduce enumeration AVRFeature
Date: Tue,  7 Jul 2020 20:16:45 +0200
Message-Id: <20200707181710.30950-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707181710.30950-1-f4bug@amsat.org>
References: <20200707181710.30950-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x334.google.com
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

This patch introduces enumeration "AVRFeature" that will be
used for defining various AVR core types.

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
Message-Id: <20200705140315.260514-8-huth@tuxfamily.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/avr/cpu.h | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 6f231d096c..f229ff78c0 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -72,6 +72,42 @@
  */
 #define OFFSET_IO_REGISTERS (OFFSET_DATA + NUMBER_OF_CPU_REGISTERS)
 
+typedef enum AVRFeature {
+    AVR_FEATURE_SRAM,
+
+    AVR_FEATURE_1_BYTE_PC,
+    AVR_FEATURE_2_BYTE_PC,
+    AVR_FEATURE_3_BYTE_PC,
+
+    AVR_FEATURE_1_BYTE_SP,
+    AVR_FEATURE_2_BYTE_SP,
+
+    AVR_FEATURE_BREAK,
+    AVR_FEATURE_DES,
+    AVR_FEATURE_RMW, /* Read Modify Write - XCH LAC LAS LAT */
+
+    AVR_FEATURE_EIJMP_EICALL,
+    AVR_FEATURE_IJMP_ICALL,
+    AVR_FEATURE_JMP_CALL,
+
+    AVR_FEATURE_ADIW_SBIW,
+
+    AVR_FEATURE_SPM,
+    AVR_FEATURE_SPMX,
+
+    AVR_FEATURE_ELPMX,
+    AVR_FEATURE_ELPM,
+    AVR_FEATURE_LPMX,
+    AVR_FEATURE_LPM,
+
+    AVR_FEATURE_MOVW,
+    AVR_FEATURE_MUL,
+    AVR_FEATURE_RAMPD,
+    AVR_FEATURE_RAMPX,
+    AVR_FEATURE_RAMPY,
+    AVR_FEATURE_RAMPZ,
+} AVRFeature;
+
 typedef struct CPUAVRState CPUAVRState;
 
 struct CPUAVRState {
@@ -126,6 +162,16 @@ hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int avr_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
+static inline int avr_feature(CPUAVRState *env, AVRFeature feature)
+{
+    return (env->features & (1U << feature)) != 0;
+}
+
+static inline void set_avr_feature(CPUAVRState *env, int feature)
+{
+    env->features |= (1U << feature);
+}
+
 #define cpu_list avr_cpu_list
 #define cpu_signal_handler cpu_avr_signal_handler
 #define cpu_mmu_index avr_cpu_mmu_index
-- 
2.21.3



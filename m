Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2976EC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B0D2064B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+JCPHlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B0D2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTn6e-0003Eq-OG
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmot-0002c9-9F
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:35831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmor-0003nF-Mu
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:26 -0400
Received: by mail-wm1-x330.google.com with SMTP id q5so8400114wmq.0
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BklhIgKFSOdOqleMIJMmYJg6l2FwjmXRFUfsBtmjdmE=;
 b=Q+JCPHlq/DYZLexc9+fHEYfpRGQNJw8PQC6wSfH5S6T84aziVpx/nfirns0LvCF/qk
 NnkhymGy8S06n4Yq2JPIqOuH/+o+qMpcvBjKKfxSZu7GRqfjSBJsBfAr6THdI19jpKED
 GeiQyJnvdiaJnJLi2kiBrZdIovPpLR3/IvrBEl40ig9u71M/3Zj5uoCOnrBgmHy7n+hu
 8/9iVR+y0hZII057IO3rJhGWTadq6ML9mlf3EQS2mn5UWsEjvVz5er93Ovkc3P4wjt0U
 tOclgZ5jlsVodXEZZHE1NGLzjolUPI9nxi3jD6nKr55SHBLmhvB16uebwtR3XvV99tUb
 A+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BklhIgKFSOdOqleMIJMmYJg6l2FwjmXRFUfsBtmjdmE=;
 b=gm8gtc8n1PyhvFIxbbsUSDmW/VRup/FVpKT8QS/OrGDvv+QO3G32YSsXMEoCUwglkQ
 LB3kON19Ua/L6hq+WsiKfDouD+vbUv0TSMBtSULTroM24p7ijty4pLRvBC4Dk2hnqDhN
 qbT424KvxH+Yqg4xYIat+M5S9Sh0f4Np0BCd2x3mTY8rrU5NO8VLwHU7Bz9wF8Sg2vCa
 13wuiuylk1/d/0XknYZke0woDEf2u5YU72XntJu5eoPlmmscbcW4PTmT4j6ZYpEJUmQp
 AgMIopK2C+yImTsT3zIui1piu2RxoDneNFkWWS3flhXC0xNUtTYFdcK87Z1kXheobgVR
 ZY4A==
X-Gm-Message-State: AOAM531lh+cXO++eRp9fID+ZEHG64fPw67jqsvahlZxAV1VLrD0akO9y
 /W/3Yh+6NilP3hJvlzpXNs5FIMzRSbs=
X-Google-Smtp-Source: ABdhPJzXyK1avxdHsbndLdHh941AUxk1D1c7y/P6+Iq/2yxN8Ku+TGv/VivFYJUXrevw74OlJ2j6+A==
X-Received: by 2002:a1c:d5:: with SMTP id 204mr8879191wma.56.1602943464152;
 Sat, 17 Oct 2020 07:04:24 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id 71sm9193904wrm.20.2020.10.17.07.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:04:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/44] target/mips/cpu: Introduce mips_cpu_create_with_clock()
 helper
Date: Sat, 17 Oct 2020 16:02:20 +0200
Message-Id: <20201017140243.1078718-22-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x330.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce an helper to create a MIPS CPU and connect it to
a reference clock. This helper is not MIPS specific, but so
far only MIPS CPUs need it.

Suggested-by: Huacai Chen <zltjiangshi@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201012095804.3335117-13-f4bug@amsat.org>
---
 target/mips/cpu.h | 12 ++++++++++++
 target/mips/cpu.c | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 062a4ba6225..d41579d44ae 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1307,4 +1307,16 @@ static inline void cpu_get_tb_cpu_state(CPUMIPSState *env, target_ulong *pc,
                             MIPS_HFLAG_HWRENA_ULR);
 }
 
+/**
+ * mips_cpu_create_with_clock:
+ * @typename: a MIPS CPU type.
+ * @cpu_refclk: this cpu input clock (an output clock of another device)
+ *
+ * Instantiates a MIPS CPU, set the input clock of the CPU to @cpu_refclk,
+ * then realizes the CPU.
+ *
+ * Returns: A #CPUState or %NULL if an error occurred.
+ */
+MIPSCPU *mips_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk);
+
 #endif /* MIPS_CPU_H */
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 2a6f4840e20..33a9ed5c24b 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -288,3 +288,15 @@ static void mips_cpu_register_types(void)
 }
 
 type_init(mips_cpu_register_types)
+
+/* Could be used by generic CPU object */
+MIPSCPU *mips_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk)
+{
+    DeviceState *cpu;
+
+    cpu = DEVICE(object_new(cpu_type));
+    qdev_connect_clock_in(cpu, "clk-in", cpu_refclk);
+    qdev_realize(cpu, NULL, &error_abort);
+
+    return MIPS_CPU(cpu);
+}
-- 
2.26.2



Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485AEC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78F02072C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8Pi0xkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78F02072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTmrW-0006a8-1C
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmnO-0001Sx-7O
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:02:54 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:33784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmnM-0003fr-50
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:02:53 -0400
Received: by mail-wm1-x32f.google.com with SMTP id z22so2986657wmi.0
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P79ova5bfhvdNtcXbRn3PCQfTzuWJLAcssq4u0+DQy4=;
 b=B8Pi0xkK9MBj6ODbJJQEPpHmuHk1S/EPn7I9X6Qq8eNHEFUX4XWnoebFPIg7P/ll3e
 NTQ/PqyffiBThWBQpU6gQtQ/m9Zgg+vow9D/jmXGZ1UUNpWVdT5g03IktcQ6iMsxvB1l
 U6f70hH1p6zW/O9AjKPpvPeiqxMtNZhN7qlnqXwgwRezWDuESysni4eZvd4NByZpHFWw
 qrE+tlV0ceXaReKGs03fu+f5yEWieY6QMxDGNOvXoBpTW+mAw8rCDl6hlxxU7l43w8r/
 UFSnQu8tBE56jRvzoY/ufbqnFAyQ/gg1mb0mv7dlIBQR6GbK5PG/DFuIz7ITctMbaOiz
 HTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=P79ova5bfhvdNtcXbRn3PCQfTzuWJLAcssq4u0+DQy4=;
 b=KoiJZ9eHb8pc+GSa8vbMVA6OI1sL+7Wq+5OYWelXKSr9k+YIHchNW21/4R14C8MN8a
 SNoHpMbwZtRGwpDrcyvNcc39loZp/2HaGU0XaAXACRAd8R5yZ5WU2O3zRM2153zedlSr
 RLBoBAomwMKqhQRoBq/Q695tbHiEfgoRIC4TMnXM7JifCE5Vb/5ISqg/TJz93Mw3FBpw
 QPFJnm+K/9pfwOzEPVy+cf3yKzx6Slp9IiLyvOXp1fcx7rKA4p5lHDaqkShe7haS+eck
 rci919A4regOmzQbER0oW3bhO4D+10qFSP+44GDPijgQktAyyCoqlcXxdsKjfUOa26TV
 UrEQ==
X-Gm-Message-State: AOAM5302gb/SKyBWTiQjiIrCvM839pbvW5rzq8AIpeCj5goWUGwfClpu
 4AI6hQp5VcQWtxfo6wLbi5petYAZ3t8=
X-Google-Smtp-Source: ABdhPJwnpX8AIGv5h69fLS+cPm2dDj6dz5oxgDfTlB/wrz3t/IOHD0mbQC6g4Veey8SDutD+yeJ7RQ==
X-Received: by 2002:a1c:9cd3:: with SMTP id f202mr8677113wme.148.1602943370403; 
 Sat, 17 Oct 2020 07:02:50 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id l11sm8472829wro.89.2020.10.17.07.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:02:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/44] util/cutils: Introduce freq_to_str() to display Hertz
 units
Date: Sat, 17 Oct 2020 16:02:00 +0200
Message-Id: <20201017140243.1078718-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32f.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Luc Michel <luc@lmichel.fr>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Alistair Francis <alistair.francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce freq_to_str() to convert frequency values in human
friendly units using the SI units for Hertz.

Suggested-by: Luc Michel <luc@lmichel.fr>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Luc Michel <luc@lmichel.fr>
Message-Id: <20201012095804.3335117-2-f4bug@amsat.org>
---
 include/qemu/cutils.h | 12 ++++++++++++
 util/cutils.c         | 14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 3a86ec0321e..4bbf4834ea5 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -158,6 +158,18 @@ int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *result);
 
 char *size_to_str(uint64_t val);
 
+/**
+ * freq_to_str:
+ * @freq_hz: frequency to stringify
+ *
+ * Return human readable string for frequency @freq_hz.
+ * Use SI units like KHz, MHz, and so forth.
+ *
+ * The caller is responsible for releasing the value returned
+ * with g_free() after use.
+ */
+char *freq_to_str(uint64_t freq_hz);
+
 /* used to print char* safely */
 #define STR_OR_NULL(str) ((str) ? (str) : "null")
 
diff --git a/util/cutils.c b/util/cutils.c
index 8da34e04b0b..be4e43a9eff 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -885,6 +885,20 @@ char *size_to_str(uint64_t val)
     return g_strdup_printf("%0.3g %sB", (double)val / div, suffixes[i]);
 }
 
+char *freq_to_str(uint64_t freq_hz)
+{
+    static const char *const suffixes[] = { "", "K", "M", "G", "T", "P", "E" };
+    double freq = freq_hz;
+    size_t idx = 0;
+
+    while (freq >= 1000.0 && idx < ARRAY_SIZE(suffixes)) {
+        freq /= 1000.0;
+        idx++;
+    }
+
+    return g_strdup_printf("%0.3g %sHz", freq, suffixes[idx]);
+}
+
 int qemu_pstrcmp0(const char **str1, const char **str2)
 {
     return g_strcmp0(*str1, *str2);
-- 
2.26.2



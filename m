Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04A2C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3826D207FB
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn3QruZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3826D207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRLoC-0006Qq-BJ
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 16:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiA-0000NB-Jf
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:26 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:40266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLi8-0007RD-U6
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:26 -0400
Received: by mail-wm1-x335.google.com with SMTP id k18so13263237wmj.5
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 13:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gETh5/Gck0bTQVP31ZR4AiV0ecmQtPxoBf6GwvczWOs=;
 b=dn3QruZ0BeBNyJD7SOaGy2t1UJ/cXhGnwfkMltxP/mVqV4wNuHAYc8lIPlK+euxoHD
 4BBfJ8IxFIk+f+7IKZyQccNDqb5U7NLfznVhWtZ8svJ8tXfYcK77cLa3ma9aK6HCCh72
 t0UU7hv016N8lEO1Ls9JKvX7D5oZLJW58wLiawd3aWufvLOe9/mp+0BhW+Hd3MqQmQmi
 hC4BHdNdkzVTtL3ynCuMjNuIjWDI/cH9nOKfHRoj2VWif8/P+I0PvdR8t8xc6lyGq5Ii
 vFvJ5VxvyWakt3pP/y+0TLPsAA+Ik7kzVgGtXulO7EbUIlO87ERa/4yOa6qfBW0+dwWa
 2yBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gETh5/Gck0bTQVP31ZR4AiV0ecmQtPxoBf6GwvczWOs=;
 b=e41NQwh4c5TkvS4mmLlNbIoe/9lsnMUqvpTACmgokhw96L7nf3LlUP4DEZ7sI1Ra+B
 bv9GD8Arhl4TPQVIIWmGw6SP34bfK2N29khlx6g8qTNBuD4qK45/TDYyIa0ZgIhgJKDr
 fX6dSV59N6IjsHU/1mdfAHQNLE0D1HdqP8MQRyWY8rQVEf8EI9btkJubhMJFC4WrzL34
 OlSeI+dH6+c4sGPb2iTBLaJD89Cgl5L3RYuocVkSN1+i60N/bHP/GmoQEGxCppi82G6g
 75okuP4e4OTL89jOfh6oKRrIr2Q5/mwSC3ZN8Gr3sPcv3MCstwvUQY0tPoOb8/sa0o4a
 dfPQ==
X-Gm-Message-State: AOAM530gWqVLeyHEgy6YNZeZBv4BC1Y00f11azE55ZFsr5Nqe3v375UG
 S4fyqz6isceoOykH5eGEsWLQjuuIqzo=
X-Google-Smtp-Source: ABdhPJwONZG/wcNaPy7XJYsbn0kuTCN4JQ/K/BQXQZ3Vj9543IOt8b8KF6DXV2VDfNXS1N5zdqQhZw==
X-Received: by 2002:a1c:b388:: with SMTP id c130mr3963908wmf.175.1602362603126; 
 Sat, 10 Oct 2020 13:43:23 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 205sm2705471wme.38.2020.10.10.13.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 13:43:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/20] util/cutils: Introduce freq_to_str() to display
 Hertz units
Date: Sat, 10 Oct 2020 22:43:00 +0200
Message-Id: <20201010204319.3119239-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010204319.3119239-1-f4bug@amsat.org>
References: <20201010204319.3119239-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce freq_to_str() to convert frequency values in human
friendly units using the SI units for Hertz.

Suggested-by: Luc Michel <luc@lmichel.fr>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Luc Michel <luc@lmichel.fr>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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



Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA93C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:02:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095FC20678
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnD9EkWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095FC20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRuev-0003v6-17
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRuau-0008Hl-8a
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:58:16 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:36963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRuas-0002ka-O9
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:58:15 -0400
Received: by mail-wr1-x42a.google.com with SMTP id h7so18470732wre.4
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 02:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gETh5/Gck0bTQVP31ZR4AiV0ecmQtPxoBf6GwvczWOs=;
 b=BnD9EkWuN4fVfGBKrKaKf/D3lY4cja0EcrNxlxJ0XTwXGhHCDfFbBx/N0A+00P4fGr
 GfqeMxSdOxKESoblvQiCcp4Kq5L02M1e8EHhmPcaTdpTJz6RQ3dSkkBQidY4IlcedmnO
 0vzlA3/wDZ14gqdX1CKo2gzg5dNQ1hTVEPYOklNnIUVbY01wv2xTYg7HvForn6jEJG17
 6L8UmcVyoxLA02aU4hG2VatJ/X1PVYhKTCrQ7d7GeaO3VQKhaQKKHwOOopJ4uuCgTTtm
 MjwY1zjSr9Ke4hplJ7a00qZVlmILk8jEVdqKkk5eQ+8KX1UI9g1dU/Nn9rXancsGmcJ+
 cKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gETh5/Gck0bTQVP31ZR4AiV0ecmQtPxoBf6GwvczWOs=;
 b=FRVerCv0zeUeBfn8SlRicMBe5dYkelMP6ROKuthtAzfF6bn/Ov7JKFq3dTSoizmEyT
 hzqBsO1HtqTn1hk528WzkmpVSB00sK/iE3uHyaTGoNjh07ZKbodyUSjX+i37yIntRzKQ
 TM6Z0wPIdyKO+Wg1ir6WNMI9U/anSiSW2ghT8YBjtfVwif0xblSoU42yzMspTgat8ibd
 lWrgI7S3dWVrIgKPf95zjaETdKae/gS6EC1sHg24jSWkOHsgl2OKAnaKxhyybc8DTWCG
 dXvdgPptDXE3gMLFZ2R4Abg2UkKeCyCzC2h4Vyv14iECYnSbN8ahiivYw7gSLfM6AfFB
 G6QA==
X-Gm-Message-State: AOAM531xEol27f4IYH3+2RjWw30pAVQYLJ/WFanL3Z57vozGHlcQBrAS
 +YVMfVD6Ltx4uEhjF0caSJC8hE6QP/w=
X-Google-Smtp-Source: ABdhPJyzp3Oz7lCryfa0fnJoTqdlUd1COKkw1hzCjLMsXWfyyPMCOg5Gb01EipYiH2nnffSxKJaDMw==
X-Received: by 2002:adf:bbcb:: with SMTP id z11mr28737435wrg.130.1602496692860; 
 Mon, 12 Oct 2020 02:58:12 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id i10sm5789911wrq.27.2020.10.12.02.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 02:58:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/21] util/cutils: Introduce freq_to_str() to display
 Hertz units
Date: Mon, 12 Oct 2020 11:57:44 +0200
Message-Id: <20201012095804.3335117-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012095804.3335117-1-f4bug@amsat.org>
References: <20201012095804.3335117-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
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



Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654FBC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DF7620872
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSpuy5mV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF7620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1v2-0008Fq-QI
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO1g2-00006n-CL
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:43:30 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:44392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO1g0-0006DS-Qf
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:43:30 -0400
Received: by mail-wr1-x42f.google.com with SMTP id s12so6576690wrw.11
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qkYlQ2hG55eOJBhaI2ddQgrPjAkAJgDAI2/vDJUHE4M=;
 b=aSpuy5mVKV3XTBolt0DA/n9lgeTekZfzkwi10SBQKfqkhawA96B46ElGQWHCHTGTuC
 UULcQkqNO/OmRhS2JVaiRo8mzq2mC8uJSnPU2H2uKZp6xASWBHFD+nKt1aMBEau+qAb0
 L8SpyN8jyzNShR/M0yfQnJz4OFx0eTJ6QdN28qekHROTo92dV650TRCDG03WeLD8H8a+
 tbfTCr5nVEcrXbybioLIJhGfcU52x58SshD2oJADJQDW+yYYslWHBchHG9TvKPBZoWwD
 GfW1fb5TSt+lueIS1Y+Oglv1YSKsKc9WlDAl2cZNwfJqliv9g1rcpLck2S0dzyr2wXpm
 kmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qkYlQ2hG55eOJBhaI2ddQgrPjAkAJgDAI2/vDJUHE4M=;
 b=ISttB+Cobf2M0I7IjApwmp/ftBvRCicouNF3duqbmt8X1YDH+5m/ofaEtbUuqc0zsF
 R1rtpzyRhgdY2D3pwqyx0lO5awLEOURDf8FbwBtAfFBjxkc2ix0o6zHbaA3vIMPNroKa
 4GsV87jqOVze6ztBNqx+5y3+Wx1rZ3Ee73nUngJXmc3bjCoAZwzsqDteeH43wVYB60Jo
 kJRl4XOy7odV+U/UxlBn0bVZmJ8RKZH6v+56vc8UDuX/acs3N3/lTwoPWmLcRSKz0obm
 85v2KSnuLOThkvHmp9siTHd8WEt1M/il++KtfEmxFxyqxv09p7yVu+S1b5eF2+SL5EQC
 ChyA==
X-Gm-Message-State: AOAM530e6SvpLP2yIcMfoKa4UdNUDEtV4EPTbnvRKN3UklSCv87K7DF2
 6mJla64pxCUzbeyoAv7asmRJOAslhFw=
X-Google-Smtp-Source: ABdhPJyHndWxHTjQLQJDVEY+v7Z4Kzx89vgIKk252SBVAYkpEHFSfoNjTZyu7ONwJ89gpluVKJ975w==
X-Received: by 2002:adf:f88d:: with SMTP id u13mr10687010wrp.213.1601570606902; 
 Thu, 01 Oct 2020 09:43:26 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id h3sm10733059wrq.0.2020.10.01.09.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 09:43:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] util/cutils: Introduce freq_to_str() to display Hertz
 units
Date: Thu,  1 Oct 2020 18:43:20 +0200
Message-Id: <20201001164322.1585392-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001164322.1585392-1-f4bug@amsat.org>
References: <20201001164322.1585392-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Tyrone Ting <kfting@nuvoton.com>, Damien Hedde <damien.hedde@greensocs.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce freq_to_str() to convert frequency values in human
friendly units using the SI units for Hertz.

Suggested-by: Luc Michel <luc@lmichel.fr>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu/cutils.h | 12 ++++++++++++
 util/cutils.c         | 14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 3a86ec0321..4bbf4834ea 100644
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
index 8da34e04b0..be4e43a9ef 100644
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



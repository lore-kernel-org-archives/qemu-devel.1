Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FFEC4727E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 09:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A9A023977
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 09:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5WvMunj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9A023977
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMSgO-0006Av-U6
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 05:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMSfT-0004Xx-BD
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 05:08:27 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:51089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMSfR-00029f-QY
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 05:08:27 -0400
Received: by mail-wm1-x333.google.com with SMTP id e17so3376052wme.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 02:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gSWJZnKhOrC53eEU7BCKaT5VT2GqivKC/fTv2rJCfmw=;
 b=X5WvMunjUsLtd2mptGhZleNmCFMuZ4w7XejQhfK2oyhGIpeC+BchQD4w8YwsF/wILH
 O1nqo6JcAGIOORTxzHo5WsaA0XONqTOTA77relREpEfXsje6Xh/qrtVEgbwLnDxkNkye
 begFE2y963So5IYztpwkv5z5D2bn2JKEM2M2eOcvr5E+lIzd+wx1maz/F1ftgan9uRv+
 ysv3cEECIW2LnX6eME5yeKwE+Pxf+ZPoFIc6mtuVgsj3lUq04a09uvFpT/K6nIEv7axG
 stzyQkPIfoxXe9NXt8IhgG6tytG+SYx61SL29sxSVmI0zi9lJ9WLdJdXfz6PMd7ibMuz
 3JRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gSWJZnKhOrC53eEU7BCKaT5VT2GqivKC/fTv2rJCfmw=;
 b=nqtU6Zo2p9Kpq2b68NWAghLhdiNkDwXBs9TUX9h//E/mj/kDN3QWq3I28FVqCtoQ/y
 cniEr4DsCjNnRVbu/1GaooFdzlr/kBia+VGXsU6MQYQNJNal8iS83D9GmSydvZi8Hh4D
 BJFRKh0gL6YBAy05wOOreZcbu2+IR+TizKYPaD2Zlp/vK/zOs4RbhQq1BPeFXiWgnMFs
 w7B2puciHttjDDzSwOCDrz72p1ARCpyc/8GxM6+X8Rv1sB+r0fPj/NG2wRO1eneaKjUC
 aYSX4OU9CuPL0GaJuIOICZKEqHlEA603CRwiqfQ00V9EFiq1N08+DNwLsQmxL0ZSZEU1
 pciA==
X-Gm-Message-State: AOAM532Foy2RzufcyGISrZvvsFZ/0yF7t8WKn6T5e9OrAYsz5ng2j6li
 wBkjaEyVLy4gTOZT/yFnNO9TQVQ1Li4=
X-Google-Smtp-Source: ABdhPJwGxE71rID2mFA3DEuK+vzDWzKrydocZuPZ2wGQitxZ8AgaDXRVy2kjMCPnlkwSvJiegrpvew==
X-Received: by 2002:a1c:7911:: with SMTP id l17mr6084925wme.179.1601197703999; 
 Sun, 27 Sep 2020 02:08:23 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id y6sm9007187wrn.41.2020.09.27.02.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2020 02:08:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] util/cutils: Introduce freq_to_str() to display Hertz
 units
Date: Sun, 27 Sep 2020 11:08:18 +0200
Message-Id: <20200927090820.61859-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200927090820.61859-1-f4bug@amsat.org>
References: <20200927090820.61859-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x333.google.com
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
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Tyrone Ting <kfting@nuvoton.com>, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce freq_to_str() to convert frequency values in human
friendly units using the SI units for Hertz.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu/cutils.h | 12 ++++++++++++
 util/cutils.c         | 10 ++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index eb59852dfdf..0186c846e9c 100644
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
+ * The caller is responsible for releasing the value returned with g_free()
+ * after use.
+ */
+char *freq_to_str(uint64_t freq_hz);
+
 /* used to print char* safely */
 #define STR_OR_NULL(str) ((str) ? (str) : "null")
 
diff --git a/util/cutils.c b/util/cutils.c
index 36ce712271f..dab837fd8b8 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -885,6 +885,16 @@ char *size_to_str(uint64_t val)
     return g_strdup_printf("%0.3g %sB", (double)val / div, suffixes[i]);
 }
 
+char *freq_to_str(uint64_t freq_hz)
+{
+    static const char *suffixes[] = { "", "K", "M", "G", "T", "P", "E" };
+    unsigned unit_index = log10(freq_hz) / 3;
+
+    return g_strdup_printf("%0.3g %sHz",
+                           freq_hz / pow(10.0, unit_index * 3.0),
+                           suffixes[unit_index]);
+}
+
 int qemu_pstrcmp0(const char **str1, const char **str2)
 {
     return g_strcmp0(*str1, *str2);
-- 
2.26.2



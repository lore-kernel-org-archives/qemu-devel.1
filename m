Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985C2C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD6F20BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWb5Pe1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD6F20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJwp-00083L-6Q
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJsc-0008Tt-P8; Thu, 10 Sep 2020 06:32:38 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:51709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJsb-0003BP-6J; Thu, 10 Sep 2020 06:32:38 -0400
Received: by mail-pj1-x1044.google.com with SMTP id a9so2815667pjg.1;
 Thu, 10 Sep 2020 03:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xhCi83owLgwjlb0w3wUGwCtyacoQCjPoxSEDHHZwCrw=;
 b=LWb5Pe1pJ+r0dUIxnWKIZhfwXFhqL44NKgwnanVqOynYH4jNWM24dr7t40PuAOo8LU
 u12pwmXLYyozrKwAEZiL/QO+sEjjpgRTNqtzQGgh44S4ZodQ0uBNQmhKBgqOnTVEhoFT
 4IPFDphhaivhtDTTl7AEDA2uHfXW2u0vO/jCt14Ld8PUEJ+xVe8Wd+Ixiza3x+5aUS2i
 VYdu/g/VXapaEOeaFyuTlpjf9WXunGv0omuQM+9cdryYNsWWDVifedBZcMtf/JL7N2ps
 E3YE3E5QKBG1JvigY/zisrf7yvKj5eHEFzJG+ou3EAksEgZySYY/HQqfCGJMn8ij8XGX
 D9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xhCi83owLgwjlb0w3wUGwCtyacoQCjPoxSEDHHZwCrw=;
 b=OmTCd4Hjz/EL1PkW9Hv1DmZxn2XxaHeLEoE8GCXuVVonqU+KXD+3eV3N57xSf1NCTn
 S1MsU/bEY6CtUhvxC9r+sV02M8cRZFUIyyBI35PbUMrmCghnw4YYRPqVtinzu0QoMvLM
 w9R9pM8aEs5kulORuJiSyaG/pfhpQoNN5qb0PAX232XU/7cwxa6bQ2AvJ9ypN2l5YDKu
 SS5ke607JyqjYr1k+rPbKGF7U7hcH3bTief5NquFHSJ+LUXEhHzZCClaaTTT4equ8fvl
 VuFMJuCpeGVVov5ltjfqNd2JA4AJrVK8K9/aDacwWSFhVsau9T2RxEWCo5kEHPE1T+aO
 o3aA==
X-Gm-Message-State: AOAM531ZXD64JZegsVjUUO/pNjafm4lzWFZQTIEZwUB96fGlGeYi3cvj
 s0RCDdV5AZFvdnsmMN0Bp+i0C5KxziulnQnHDZ0=
X-Google-Smtp-Source: ABdhPJwOT5vqvzc37BCOal3KGHZFnu8rhDrCvqoIP5xqIWE+gJy3e6jqos49qTiO/2mW/t97JyHJow==
X-Received: by 2002:a17:90a:d315:: with SMTP id
 p21mr4855106pju.88.1599733955030; 
 Thu, 10 Sep 2020 03:32:35 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id g21sm2000203pfh.30.2020.09.10.03.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 03:32:34 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 13/25] gcrypt: test_tls_psk_init should write binary file
 instead text file.
Date: Thu, 10 Sep 2020 18:30:47 +0800
Message-Id: <20200910103059.987-14-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200910103059.987-1-luoyonggang@gmail.com>
References: <20200910103059.987-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On windows, if open file with "w", it's will automatically convert
"\n" to "\r\n" when writing to file.

Convert unlink to use g_remove.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/crypto-tls-psk-helpers.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/crypto-tls-psk-helpers.c b/tests/crypto-tls-psk-helpers.c
index a8395477c3..58888d5537 100644
--- a/tests/crypto-tls-psk-helpers.c
+++ b/tests/crypto-tls-psk-helpers.c
@@ -26,13 +26,15 @@
 #include "crypto-tls-psk-helpers.h"
 #include "qemu/sockets.h"
 
+#include <glib/gstdio.h>
+
 #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
 
 void test_tls_psk_init(const char *pskfile)
 {
     FILE *fp;
 
-    fp = fopen(pskfile, "w");
+    fp = fopen(pskfile, "wb");
     if (fp == NULL) {
         g_critical("Failed to create pskfile %s", pskfile);
         abort();
@@ -44,7 +46,7 @@ void test_tls_psk_init(const char *pskfile)
 
 void test_tls_psk_cleanup(const char *pskfile)
 {
-    unlink(pskfile);
+    g_remove(pskfile);
 }
 
 #endif /* QCRYPTO_HAVE_TLS_TEST_SUPPORT */
-- 
2.28.0.windows.1



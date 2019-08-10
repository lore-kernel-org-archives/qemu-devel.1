Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDDFC32756
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0D82085A
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4YCuurm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0D82085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIq9-00017y-Aw
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34705)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIkp-0005RP-Ft
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIko-0004GV-GB
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:19 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34820)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIko-0004GF-Bs
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:18 -0400
Received: by mail-ot1-x344.google.com with SMTP id j19so63823631otq.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UnCpLXb0Tm7zqYonWzBKX7Cm2ohAULA3NbEvcZesBtY=;
 b=Y4YCuurmcsRd1lDniXb8fsVDwtM3OIO2st5C+qJdDllcoceRr4+PKh4a5jT1X1F7nV
 jvCh3iris+hldYmfd31xMNnTeo82+bH+uHqMyIBX+bkAln6D2c50CVxJN7UrAi/D0gzU
 HiSodpmf5ZdtM2lDALc1k+5w9PPaNZK4hsUy4h42DhUJy5ttAl5oVLmDmxEm62/aGj4+
 L/zkV694NLLtTTEKjJX5GECNY1K7MxeSb6A7bfcLm/owM3enJJujssFFo9JQRFu850St
 W4g0lp2tdTkO4s/F21ursy7ALzaYltYVCz29MkWmT01FNEu/EA/RAyRhrMskrn+EbiTb
 C7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UnCpLXb0Tm7zqYonWzBKX7Cm2ohAULA3NbEvcZesBtY=;
 b=pGaU4WV7aYAv3Cj4OnucDo9gki54++9/gfxs+vaK2xgZ0eup0F4x/62ugKooDx274j
 rdzB2PvMSTULFFYeS20ATut8GVQRE+jiGSu4HfqtZxs77dam8W1wsX5WCsuwPFJQ7RSM
 t05R03MoiAfYtgDBZ0lHPF8Lmt8gofAtv6wmg5U8mGVgJsrOg6GZcni58AvDMj5iOZtO
 Cu8NlDFZl5Z3bG74AblqRK8CzO0jXW3voU6e61/Q3cuiaV10286KB9luQpzh5GMM8enG
 bFYuOr3b8M8KQ+X8WV9W3Rp+1uGi1WrkCaIPEzKPeyixjms1NwlvFCGju+mn9nO6Cfqs
 DCog==
X-Gm-Message-State: APjAAAUyxo+/GT3IUuyiEz0HKokfKQ3PNeAvQGzG7Y6vVEgtcl/d8StE
 X96fDvU+W47giPFgC7MMCgPKhnQ8
X-Google-Smtp-Source: APXvYqwRT8CfMHKtC+/kor1tPsDPt7uP5cQI1/DLILmArdYMAakdY6Peh/3zXLI/Q+dE7z2z0CQDNw==
X-Received: by 2002:a54:4191:: with SMTP id 17mr4018392oiy.125.1565410397558; 
 Fri, 09 Aug 2019 21:13:17 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:17 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:26 -0400
Message-Id: <20190810041255.6820-11-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: [Qemu-devel] [RFC PATCH v2 10/39] target/i386: add vector register
 file alignment constraints
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

gvec operations require that all vectors be aligned on 16-byte
boundary; make sure the MM/XMM/YMM/ZMM register file is aligned as
neccessary.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8b3dc5533e..cb407b86ba 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1199,9 +1199,9 @@ typedef struct CPUX86State {
     float_status mmx_status; /* for 3DNow! float ops */
     float_status sse_status;
     uint32_t mxcsr;
-    ZMMReg xmm_regs[CPU_NB_REGS == 8 ? 8 : 32];
-    ZMMReg xmm_t0;
-    MMXReg mmx_t0;
+    ZMMReg xmm_regs[CPU_NB_REGS == 8 ? 8 : 32] QEMU_ALIGNED(16);
+    ZMMReg xmm_t0 QEMU_ALIGNED(16);
+    MMXReg mmx_t0 QEMU_ALIGNED(8);
 
     XMMReg ymmh_regs[CPU_NB_REGS];
 
-- 
2.20.1



Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116EDC432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 08:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF3E20732
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 08:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cl9SZMLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF3E20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iayQc-0005CT-U6
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 03:48:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iayOK-0002xu-UG
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iayOJ-0003FE-Tn
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:12 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36338)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iayOI-0003Dj-3F
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:11 -0500
Received: by mail-wr1-x442.google.com with SMTP id z3so37758912wru.3
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2019 00:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GFxLXW+tmEu7DaOmEL6R/bd6JpTrUvHv1FiUO4mVZHo=;
 b=Cl9SZMLEhs+IC66qs7r21ksekuIe4uAVIi8z6GNWzlS3BbOQsWULcetbw157a0g1Jy
 OsY0LH6of548e7Il9rHscYLf33b7rlKKCmMxhSEVQIPS555u5kdIXg+aM/NpyWqPx4cP
 Xv4DJxzmVaojfdzbEoKcDpgtFGgdnaLoarL0m7/hYshSXthWakGN2veSKT/hTq1NqOIl
 ZLIoxB5LYFei5ZKPvnm3PQS4RBBpIVyAvNkHknfChasl4hyk/E5np3y3opU9F1f921Kp
 oyiEkPEkKHLbyCUb9CJsH9eZQO72izVHebuBIJiK+EJqAGmGS38X7sbyPoLsEce2FPTT
 kthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GFxLXW+tmEu7DaOmEL6R/bd6JpTrUvHv1FiUO4mVZHo=;
 b=P/SdbPcHhcZ1Gx4DSncB3jk1yBm+amj00ZSjlOuLErf5r9e0kLGGY7EEww8k180b9Q
 CstI8t5T8eWf4Bh1nS9Ia3WPczfi6o0j/9Y9qUveUqn5T/kItqE6lIZ74RektoGo0VQq
 FZ9TuTm3rb+haZbFC4rpBrTDlYWL7dMvSjsZH4wAC9gZZzsvR1GCedUoNCSI3vi41M3B
 GC+LILfQeHZZw5jJsCbJnsRmmJnAOoPjOGQGFc/1ue/kyYsDt1PxY36ubc6xTize6cd7
 xKo7KC5iJjuOEQvjNBVAqQsIghJrybxClSY57vruvSDopcKJ7FcQA/J4U2uO4kJ2VBc1
 Mr7Q==
X-Gm-Message-State: APjAAAWaBa98kv3d/mx/zB2alLg7pSCIxhoBRYuW9GOpxl5XY95cv+bF
 EBSqvwcJLwukX1Z2a70O+Nn0bA==
X-Google-Smtp-Source: APXvYqx6o4NenfLt2Hj0OaWVVXhYWNNT9sI+wre+s66lKGCPbn9hPGjPGSI+LrE4SQbAkY9EAovy3g==
X-Received: by 2002:adf:f709:: with SMTP id r9mr57163868wrp.8.1575103569098;
 Sat, 30 Nov 2019 00:46:09 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c184sm5323829wma.20.2019.11.30.00.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2019 00:46:06 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B557A1FF92;
 Sat, 30 Nov 2019 08:46:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 05/14] gdbstub: add helper for 128 bit registers
Date: Sat, 30 Nov 2019 08:45:53 +0000
Message-Id: <20191130084602.10818-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191130084602.10818-1-alex.bennee@linaro.org>
References: <20191130084602.10818-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: damien.hedde@greensocs.com, luis.machado@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - take care of endianess of the whole 128 bit word
---
 include/exec/gdbstub.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 08363969c14..59e366ba3af 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -102,6 +102,19 @@ static inline int gdb_get_reg64(uint8_t *mem_buf, uint64_t val)
     return 8;
 }
 
+static inline int gdb_get_reg128(uint8_t *mem_buf, uint64_t val_hi,
+                                 uint64_t val_lo)
+{
+#ifdef TARGET_WORDS_BIGENDIAN
+    stq_p(mem_buf, val_hi);
+    stq_p(mem_buf + 8, val_lo);
+#else
+    stq_p(mem_buf, val_lo);
+    stq_p(mem_buf + 8, val_hi);
+#endif
+    return 16;
+}
+
 #if TARGET_LONG_BITS == 64
 #define gdb_get_regl(buf, val) gdb_get_reg64(buf, val)
 #define ldtul_p(addr) ldq_p(addr)
-- 
2.20.1



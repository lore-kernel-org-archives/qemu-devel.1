Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BFFC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:11:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FB3C2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WzdmFOU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB3C2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if5W1-0002lC-EJ
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 12:11:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1if5QX-0004v8-8Q
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1if5QW-00036K-5y
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:29 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39581)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1if5QV-00034T-Uq
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:28 -0500
Received: by mail-wr1-x443.google.com with SMTP id y11so24839805wrt.6
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 09:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KcowZQvidWsL6K9vNr5PA0mK1ZdxCgzSQNRXFm9TCF8=;
 b=WzdmFOU+RKvYTrBBKT4LIRw+l7zFuCjd99HBuVRHdH1mY9AAXPC1OrpDzUpDubH9FH
 zmlmZAYV3S//tP68iouHtVQAUZEFTezth5JAYMNy+Yk1X6dLsR8wCRcPg5nFo4GBdNEM
 2ABmFKb8uUhQwPaIr9jF1M9aJEnV/qGuxw9/8fykGadpV8eEPdLjSQXePs/0SQg+FzaV
 Sqk1+864nNzOSALeFX+1rWvSLCq+DuAUXMX9ttlwfhuumaxdBGVzkA1p+tE+zD4rfBxj
 FAd/UOCKvu4bMqWXYALbYfidsJeh7wZXi2awDkLwaOIaD98SrSSIqeqtNyl00JAx+Qyx
 deHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KcowZQvidWsL6K9vNr5PA0mK1ZdxCgzSQNRXFm9TCF8=;
 b=ZvJ889xT78Nu25qtWH8XlaOq9X4DxzlWMCuc4Rq+Iw7LN1KIhA2PeQdZGS//+Kjh9D
 DlMLDIAn8qXO9pv4ihAw6ou06oZK7KwT7k+JWnCaSFgL2H+NlnSuA0Kf8ztBDikitnq0
 mSh0uDlFTjpCP/UYIEY33a+WvAfuJ/6Khm+UL+tFBTJjf2qdtLmPv+AtLfqUVOpQhv0h
 0VK1pFt4FewEyCRB9X/geWWDBRhjNTZ17BBkMHB+76NeNx9S0Hpv6QylxOeGWcSB9cHv
 to1Fu3DkDuqWgPrme1HGaFcyc4Cu8ZSX0CXauFOe/kHns/HfpKEZDP41aYT2ojRG12Oa
 ngUQ==
X-Gm-Message-State: APjAAAXiq5Gj10ShUtclOiv/XOvHOcOxzfmTPDTDPPs/dorSxkIM9DdH
 HK/g8U0Pne7w3OdvcuIb6tacrA==
X-Google-Smtp-Source: APXvYqxoiiKY5pkiiC/f8HachCA9qH/ysb76GIYsZyl9zdnY4rz6XPmiqRAslt/++UCOOh606AivYQ==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr838579wrm.293.1576083926828;
 Wed, 11 Dec 2019 09:05:26 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d16sm3197299wrg.27.2019.12.11.09.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 09:05:24 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C40571FF92;
 Wed, 11 Dec 2019 17:05:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 05/20] gdbstub: add helper for 128 bit registers
Date: Wed, 11 Dec 2019 17:05:05 +0000
Message-Id: <20191211170520.7747-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211170520.7747-1-alex.bennee@linaro.org>
References: <20191211170520.7747-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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



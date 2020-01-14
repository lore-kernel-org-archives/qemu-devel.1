Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC955C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86059207E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kr2JJZ5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86059207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irNuy-0003xV-5c
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:15:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irNpY-00059B-L7
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irNpT-0007QS-JT
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:08 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irNpT-0007PJ-DZ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:03 -0500
Received: by mail-wm1-x343.google.com with SMTP id 20so14121583wmj.4
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 07:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rUFyb2y1MbKjceLsHfsc5550yIlmEuHV9I8+VOakZH4=;
 b=kr2JJZ5Qc/xyq/YPtiB+ZBtcQxsje3d4twQIAGLq5Rk8tGDIKL1FM63Udn9wyiOn8L
 Z1JeJI1RI3VvBnLqxEe1Q12x0ecy2I43g5CX+G1/HBHW44UdK24Vl3R0OfR0m5PWEOMn
 9THLulA3wKpM2rB7b4F5FBpNlK1v6LuY9Dzj9VZ52w/vqTM+TBDV+Hsn4WJBueNldBNh
 yAigllRSru74vr7drS4T+V9j7MgFP1nbrPCw4Z3nI26zLpmuQXFDUdwAlWfC6dbeixPa
 TeEv/H55uPLEpiWUBsMYBmsZM9RUZp0moXFhU86bQ5aSKQD6DZlI40eamUj2PQTDJRdd
 2c6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rUFyb2y1MbKjceLsHfsc5550yIlmEuHV9I8+VOakZH4=;
 b=jq2u5L63WVJXkiza652nAwwkaVcn7My0w7c80QcTNuPzUC0dJSNKUnjR+PGIjbPqZf
 Jvd3XJQHIq5l/L1XFY6DLPGw0ba2j+Ch/7O0EqHCmAM6pQRy4nAX8hTljAQEsKB+5BwL
 PMBaN9gIwA6pCyUVGeRwmTlZ7RpdCbScSd6QY9oHxJSZxjQTtvaOq+KcbudK8RE7+PfX
 cu25nLrPLjQJ2fBDJazFtM1Z9AyD+pDta0sUD8qYMYnEevHbR3GJywqxVrXVlxoUOe2Y
 yYQW3dN5SIaCb/dZvnUZi+HW1EGGzVK2h/FRuX01DCtmTDqCuJpwV0gydIz0GU0qCVcJ
 tavw==
X-Gm-Message-State: APjAAAUErNW8EBgFeEC6kec8lK9YafDKP7xhIyowHUT/VqgwUZ3hJKof
 /yW2KvF/NmUMminyshWPjw9/4g==
X-Google-Smtp-Source: APXvYqyPPfMAK9p2BejuSWjVCkJpSTki8a4BTvUOAtL6SX42UlCZfgSKQvtmJEMtmKmoCy7UNxkDxw==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr26314704wmh.99.1579014602497; 
 Tue, 14 Jan 2020 07:10:02 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n10sm19824230wrt.14.2020.01.14.07.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 07:09:58 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 640CB1FF92;
 Tue, 14 Jan 2020 15:09:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 05/22] gdbstub: add helper for 128 bit registers
Date: Tue, 14 Jan 2020 15:09:36 +0000
Message-Id: <20200114150953.27659-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114150953.27659-1-alex.bennee@linaro.org>
References: <20200114150953.27659-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
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
index 08363969c1..59e366ba3a 100644
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



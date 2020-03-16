Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C19C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACBD32051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O65mI6S1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBD32051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44775 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtpj-0003FT-Sh
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRM-0000dT-9K
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRJ-0008Hm-3f
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:12 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38045)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDtRI-0008Af-PD
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:08 -0400
Received: by mail-wr1-x442.google.com with SMTP id s1so537139wrv.5
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KcowZQvidWsL6K9vNr5PA0mK1ZdxCgzSQNRXFm9TCF8=;
 b=O65mI6S1wghhbDmZGb4kMT2DANfOqEHorC4qwoQPHMJCzjoMPAkjP4jqfPM/05mU/U
 spKNsYXasfvwGbMI0VTaWHGB8cVg+hDrHJSSoXHgBp+7Kj2uCKhGgxjIA6w2EkPlT+Qy
 ZqkDGgJspqo7mRjDTuFoDaNXkO6ORIxVABgd9iJVlUyKf+JuH+p+K0l9zRF5iwP+Gj+K
 MwQT2CittElXYO7F4qppuCGAMtpbp6A1ESzR8dkJ+M7nOviS94PS0DzJ77VY8UlgnQMj
 EE0CtM5aQieW01lY80gxxTzVH6N3om9IOUmlqqddFIRf10OSMkXbII9ZkS+zWeh3RaFe
 A1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KcowZQvidWsL6K9vNr5PA0mK1ZdxCgzSQNRXFm9TCF8=;
 b=uEJNCYsBp8gCxy/Cj6tY6NhZDD9U2Mf/1ruNcSJFKeBn1rTBRKwPh9k1+Ri6ZI9gmo
 IiQaZx9BYiMKrfbJRzDCzIDsO/Mqu5FZcUHyyeeY3lQzk69sU7GXwr6Jm07kwDC9rByk
 S/30/jMDoZ+Y2KAHOpxUTkRwTeetXTrwxeTXLTk3FLNEfVLQY0f1FQoqGccDqiA72ltf
 DFfUUhsGYrjLbnrb98TvfWFIqJPBURmtarNznCsnQ5gH8/DT3FuhfXBmzx8qkh5jTWZx
 W1PF87FliHYOZzFto/jnZZd3LSKvU8VDhsbDGXWolXakdkCD/aycJIdUlR40UX8x/p1l
 SKoA==
X-Gm-Message-State: ANhLgQ3esbOQbpt919/gQIg+ikOAadaxBz4BkwoaI1L3mdN1Zxlm6E9a
 msYrkDvlK6JpoMNT376/bhxOvQ==
X-Google-Smtp-Source: ADFU+vtqfxNnNe9C4oS0NYzhtcXzWASHHXW36WvL0X0M1eTUondQrZmNah97qVvcfm9lCI4LFc4RWQ==
X-Received: by 2002:adf:e50d:: with SMTP id j13mr431884wrm.34.1584379327687;
 Mon, 16 Mar 2020 10:22:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n6sm460988wmn.13.2020.03.16.10.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:22:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 11E4B1FF99;
 Mon, 16 Mar 2020 17:21:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 10/28] gdbstub: add helper for 128 bit registers
Date: Mon, 16 Mar 2020 17:21:37 +0000
Message-Id: <20200316172155.971-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316172155.971-1-alex.bennee@linaro.org>
References: <20200316172155.971-1-alex.bennee@linaro.org>
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



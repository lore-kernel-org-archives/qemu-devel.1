Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0477AC352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 00:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6AA3206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 00:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t7qUbzd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6AA3206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j22Iy-0003oY-1d
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 19:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j22I8-0002X7-Gc
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 19:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j22I7-0005Yh-Bd
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 19:23:40 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35941)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j22I7-0005Xe-5y
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 19:23:39 -0500
Received: by mail-pl1-x644.google.com with SMTP id a6so1594605plm.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 16:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c4AW/Bq5GW+BzA+6gDLmVxKMMXGf/BYTygbPUAb8Kco=;
 b=t7qUbzd9aT12EgxgQUJUcRZohEiyj18dQ/+wVd8dCAqBrGH6suOs5fZMUpCViqifoH
 wW0TNaRvbBFdBiMaArITAZRcCLbeJFtdkdMSIbfd4N3O+anTuChhfz5G6W5yKLGQeLeE
 8fmes6TkW8pRzMNLCg1/ZG36F0U/9QBfi278+M/etGDIgig4c5PC5gXT4/RSfH0RzJT/
 is1FvGjXkNooUTzWP+RTdQP4ivE6Ih+jPShaAlrZ50ap+qKPVS7x6dYXoY5ytv1MmctN
 uZViF5z8RwctCM1TmMyAgV9TBNUjrZSdpjMFsgqHl6WAox1BkJuRUyfOZJRZ3Skr0QuC
 ZLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c4AW/Bq5GW+BzA+6gDLmVxKMMXGf/BYTygbPUAb8Kco=;
 b=XyfxrUTFERT9YpgV0apsHMTHufNMpcRpyHoj5bFj0eTW5zM4r1Yl3Rvbb66KJ58U4l
 o4gvYs86rgPeZJtDNtYnT4bKIdhEYxQFm4od6XPHAWjKFpGjB4Pj/KcxiKrOBFuOc7sz
 MtreDqm/9uwi3zuC85T1DnGz3L5ID6w1oexbt1ZGLQnMc4QFtVryYd0fkl+H6JIQVJMr
 v1ZKervGLughk9mkUhLJxtifTJkb3aERzO83AbgWK911jKSSsT5CY2tD1LEc+QGkpwcu
 44CXuremu7MCZ6/5415N6uotdMK9VXMg9VZ0PF4bubYynCwrcmxSd+hp7zY5fA9cwYc/
 YBBA==
X-Gm-Message-State: APjAAAW4JmBdFD3fF0NG9mYr+P54YvUO3PbWKYyRN/9dFpsKq14lxVji
 pL1ZWQfAX7beS8GU8fdC0a2zyCTZf0g=
X-Google-Smtp-Source: APXvYqwrhdOTUxtnU/YboFEUeHlnHpB0o9DD9z8owCifwcGwGcYumdPdme9fj3RZlOfNkglj0Zv9Bw==
X-Received: by 2002:a17:90a:b009:: with SMTP id
 x9mr1951391pjq.124.1581553417777; 
 Wed, 12 Feb 2020 16:23:37 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id j4sm365277pfh.152.2020.02.12.16.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 16:23:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] tcg: Add tcg_gen_gvec_5_ptr
Date: Wed, 12 Feb 2020 16:23:32 -0800
Message-Id: <20200213002332.31821-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213002332.31821-1-richard.henderson@linaro.org>
References: <20200213002332.31821-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org, Taylor Simpson <tsimpson@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extend the vector generator infrastructure to handle
5 vector arguments.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-gvec.h |  7 +++++++
 tcg/tcg-op-gvec.c         | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
index 830d68f697..74534e2480 100644
--- a/include/tcg/tcg-op-gvec.h
+++ b/include/tcg/tcg-op-gvec.h
@@ -83,6 +83,13 @@ void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                         uint32_t maxsz, int32_t data,
                         gen_helper_gvec_4_ptr *fn);
 
+typedef void gen_helper_gvec_5_ptr(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
+                                   TCGv_ptr, TCGv_ptr, TCGv_i32);
+void tcg_gen_gvec_5_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t cofs, uint32_t eofs, TCGv_ptr ptr,
+                        uint32_t oprsz, uint32_t maxsz, int32_t data,
+                        gen_helper_gvec_5_ptr *fn);
+
 /* Expand a gvec operation.  Either inline or out-of-line depending on
    the actual vector size and the operations supported by the host.  */
 typedef struct {
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 41b4a3c661..327d9588e0 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -290,6 +290,38 @@ void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_temp_free_i32(desc);
 }
 
+/* Generate a call to a gvec-style helper with five vector operands
+   and an extra pointer operand.  */
+void tcg_gen_gvec_5_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t cofs, uint32_t eofs, TCGv_ptr ptr,
+                        uint32_t oprsz, uint32_t maxsz, int32_t data,
+                        gen_helper_gvec_5_ptr *fn)
+{
+    TCGv_ptr a0, a1, a2, a3, a4;
+    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+
+    a0 = tcg_temp_new_ptr();
+    a1 = tcg_temp_new_ptr();
+    a2 = tcg_temp_new_ptr();
+    a3 = tcg_temp_new_ptr();
+    a4 = tcg_temp_new_ptr();
+
+    tcg_gen_addi_ptr(a0, cpu_env, dofs);
+    tcg_gen_addi_ptr(a1, cpu_env, aofs);
+    tcg_gen_addi_ptr(a2, cpu_env, bofs);
+    tcg_gen_addi_ptr(a3, cpu_env, cofs);
+    tcg_gen_addi_ptr(a4, cpu_env, eofs);
+
+    fn(a0, a1, a2, a3, a4, ptr, desc);
+
+    tcg_temp_free_ptr(a0);
+    tcg_temp_free_ptr(a1);
+    tcg_temp_free_ptr(a2);
+    tcg_temp_free_ptr(a3);
+    tcg_temp_free_ptr(a4);
+    tcg_temp_free_i32(desc);
+}
+
 /* Return true if we want to implement something of OPRSZ bytes
    in units of LNSZ.  This limits the expansion of inline code.  */
 static inline bool check_size_impl(uint32_t oprsz, uint32_t lnsz)
-- 
2.20.1



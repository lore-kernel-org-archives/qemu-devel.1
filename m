Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351EAC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:29:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE922146E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RUD6SG1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE922146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49953 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK4ew-0003kg-74
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 13:29:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aN-0008Pw-1R
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aM-0006K6-0w
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:31 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:33395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aL-0006H6-QN
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:29 -0400
Received: by mail-pg1-x536.google.com with SMTP id k19so1949076pgh.0
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=KIh7KhTzHMM8NImyp8JEXp0cQ6SpWRDrI20KK0RXxhw=;
	b=RUD6SG1ZAQoiyJlACWpf6TIBHo4ZYQM5bO68uDlgzjPw0tIRxlfZo3cMdJ27zJTdkE
	iqF4NYY1HDFzR86HDPkr8ZJ+dgJL+gXPSHZpLLF4obU1EkwYXpbGWiYK0qktKU405NBf
	eUBv9g35G9dTj7jbB1KkGtpMhz9XztsedbpArL6IXdOA138N0KYK2dTAlGytU1XMBajY
	FMz+bH/cZWWEcc22IBnEjHF/Q5DybaeoFPC26eXiNO/Jnd210KH5ibmwh+l4JwVPhAPr
	/TvbXkVuw975PCcPW4gENxH0IXrzBBMW/dJ0ZZlbk6FaPVrJo9fHXw4oMTRfeNhdDTUD
	2UyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=KIh7KhTzHMM8NImyp8JEXp0cQ6SpWRDrI20KK0RXxhw=;
	b=CdWRtcdFBY8qKH3/+SKaFkAzSdJM2INE07gzaschLE8Ko/OZMw7bgixWtxyn9mvLcF
	j4MvXTPA3h8dWRTJ1jQK7j0yA2dOo7UNuam/YTEF+TjjsWNnv+CFchISEGZTGGjltrHN
	6AtOwapD2bZt8s1i1eflXpmrJ03fj21tzvMG8UnTV4aa+u6pNA4hpS0T1yVAisMO65Lb
	/rQlwdpwv4BRSuJPwN4zyvCRw4e2Blqnun5bSQCZPqKclZh05hX8pp8pNTPudoZMjcbE
	TnbIflRoU/tFawR4aqxRD6qQrsnzxjBBeYeHVDHgtqUbAUF01EmDhnYE0gVgDlWw1Rhq
	T3fg==
X-Gm-Message-State: APjAAAVwq5q9AqDhl2w8kDnfqL8TBBCH7yJHFDPtTjSrfM6bCyaT55tT
	hs9U3sZ4a0Ua6+A6iCJeGfHt78uZFs8=
X-Google-Smtp-Source: APXvYqzM23g+2kI9oY77pApHllq/sr5kMU3BjBdee1uK2LPbjXm7KJP4mrjA3zymXmJManbvdjH8tw==
X-Received: by 2002:a63:4a5f:: with SMTP id j31mr41802609pgl.369.1556299467178;
	Fri, 26 Apr 2019 10:24:27 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	j5sm7901762pfg.186.2019.04.26.10.24.25
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 10:24:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 10:24:09 -0700
Message-Id: <20190426172421.27133-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::536
Subject: [Qemu-devel] [PULL 03/15] tcg: Use deposit and extract2 in
 tcg_gen_shifti_i64
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426172409.Wzj5nZJmkLjPMmLyjyOr74jlBp6nmtdOIrONploGVS8@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index deacc63e3b..fbc70649dd 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1355,31 +1355,32 @@ static inline void tcg_gen_shifti_i64(TCGv_i64 ret, TCGv_i64 arg1,
             tcg_gen_shli_i32(TCGV_HIGH(ret), TCGV_LOW(arg1), c);
             tcg_gen_movi_i32(TCGV_LOW(ret), 0);
         }
-    } else {
-        TCGv_i32 t0, t1;
-
-        t0 = tcg_temp_new_i32();
-        t1 = tcg_temp_new_i32();
-        if (right) {
-            tcg_gen_shli_i32(t0, TCGV_HIGH(arg1), 32 - c);
-            if (arith) {
-                tcg_gen_sari_i32(t1, TCGV_HIGH(arg1), c);
-            } else {
-                tcg_gen_shri_i32(t1, TCGV_HIGH(arg1), c);
-            }
-            tcg_gen_shri_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
-            tcg_gen_or_i32(TCGV_LOW(ret), TCGV_LOW(ret), t0);
-            tcg_gen_mov_i32(TCGV_HIGH(ret), t1);
+    } else if (right) {
+        if (TCG_TARGET_HAS_extract2_i32) {
+            tcg_gen_extract2_i32(TCGV_LOW(ret),
+                                 TCGV_LOW(arg1), TCGV_HIGH(arg1), c);
         } else {
-            tcg_gen_shri_i32(t0, TCGV_LOW(arg1), 32 - c);
-            /* Note: ret can be the same as arg1, so we use t1 */
-            tcg_gen_shli_i32(t1, TCGV_LOW(arg1), c);
-            tcg_gen_shli_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
-            tcg_gen_or_i32(TCGV_HIGH(ret), TCGV_HIGH(ret), t0);
-            tcg_gen_mov_i32(TCGV_LOW(ret), t1);
+            tcg_gen_shri_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
+            tcg_gen_deposit_i32(TCGV_LOW(ret), TCGV_LOW(ret),
+                                TCGV_HIGH(arg1), 32 - c, c);
         }
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
+        if (arith) {
+            tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
+        } else {
+            tcg_gen_shri_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
+        }
+    } else {
+        if (TCG_TARGET_HAS_extract2_i32) {
+            tcg_gen_extract2_i32(TCGV_HIGH(ret),
+                                 TCGV_LOW(arg1), TCGV_HIGH(arg1), 32 - c);
+        } else {
+            TCGv_i32 t0 = tcg_temp_new_i32();
+            tcg_gen_shri_i32(t0, TCGV_LOW(arg1), 32 - c);
+            tcg_gen_deposit_i32(TCGV_HIGH(ret), t0,
+                                TCGV_HIGH(arg1), c, 32 - c);
+            tcg_temp_free_i32(t0);
+        }
+        tcg_gen_shli_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
     }
 }
 
-- 
2.17.1



Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ED7C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C4921842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qWfwn4vf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C4921842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4aV-0007xj-IL
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59750)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nx-0007Xo-0J
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nu-0001PT-4Z
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:03 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:45515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Nt-00018d-T0
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:02 -0400
Received: by mail-pf1-x42c.google.com with SMTP id r1so24850680pfq.12
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gABFvmxEEZWzDc6dniX7CF33hz80PTh6Y9giG8B8d38=;
 b=qWfwn4vfzazKS9Qyhqn1gfCLRpl+xcxrytxChp9uBWzRbPB5/opktJPXVxkR+DovQV
 +Rbmq5T3LVD8szGFnO2/bLdiim6hk2L6ZEYt9sujp+9dGixaS+12xmyCPzumlrlRz2dO
 8qNeiPUzn/1Ufuc/AEi4zeO5YFHcZwn0E6EBFSkmucRNvGr/NY45c8IYLMq+6/RkYiZu
 iASZPLDLsGBC+/odukewMUBxulL7ShkJ7Cm/aGvI41PeMO7Afhgmc0WlJYygAF+2uxZf
 /E/vxM8auJYL5LSXWJQ1yA4GP/Gmq45MbwUkMSbOyYcaBCemPgbtUt6gF5xuO/t2pTMT
 eBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gABFvmxEEZWzDc6dniX7CF33hz80PTh6Y9giG8B8d38=;
 b=SXgzISkKJXw5UvjT/EL22kbBqE/yCu7nlBPE7SnwG1ItptKd61yzxHFQdJqzYbh+K0
 IT4MI1NN1vAvZ9lC46hz2R9usiocsGt8sD5r7gcjMMH2G7+JGYPoqE9Hqi/i0gRJzspn
 hlo9PuVvj+kt1ZkYxLyhwBjGjs7hZ0KxJTZA4+skxKthBoJ1tlxeld+RZn1rA86T505S
 /PUtHQ5JSmGaS12WcZCfSHBEavIrK08UDzS2OMYoiI9yeXVQn4ehe0shUmUAF/bK/E9h
 3CuX9LbEDtOGpOJV2MgRlHaDnjnx2eCHxA7YEOAL+rQi2CL0xm6jGAOgeupqhGcvFx9m
 zurA==
X-Gm-Message-State: APjAAAVn7WyIl/jjk+RRzNu0g23sexN5ZOgyw7TZp9kppj+XdAhy7EsH
 splz8K6KBjXTeous55kULwqGchamNB4=
X-Google-Smtp-Source: APXvYqy59ngLkDCCAKE3jPs2qqnIZC7CjhGJmxPGhEjhbM6AxXraPsf0fWYBNSWOiczXgELd3IYFgA==
X-Received: by 2002:a17:90a:cb87:: with SMTP id
 a7mr102378917pju.130.1564163509596; 
 Fri, 26 Jul 2019 10:51:49 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:28 -0700
Message-Id: <20190726175032.6769-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42c
Subject: [Qemu-devel] [PATCH 63/67] target/arm: Convert T16,
 Unconditional branch
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 9 ++-------
 target/arm/t16.decode  | 6 ++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index f1cab437e0..480515a0a9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10639,7 +10639,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t val;
     int32_t offset;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
@@ -10683,12 +10682,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             gen_bx(s, tmp);
             break;
         }
-        /* unconditional branch */
-        val = s->pc_read;
-        offset = ((int32_t)insn << 21) >> 21;
-        val += offset << 1;
-        gen_jmp(s, val);
-        break;
+        /* unconditional branch, in decodetree */
+        goto illegal_op;
 
     case 15:
         /* thumb_insn_is_16bit() ensures we can't get here for
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index c18d146a84..457f2f4178 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -268,3 +268,9 @@ LDM             1011 110 ......... \
   SVC           1101 1111 imm:8                 &i
   B_cond_thumb  1101 cond:4 ........            &ci imm=%imm8_0x2
 }
+
+# Unconditional Branch
+
+%imm11_0x2      0:s11 !function=times_2
+
+B               11100 ...........               &i imm=%imm11_0x2
-- 
2.17.1



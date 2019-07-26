Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977AEC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:01:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65DD421842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mi5iMrWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65DD421842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Wi-0002zQ-0N
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58413)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NH-0004ZC-Kb
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NF-0000Ni-Ez
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:22 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:35672)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4NE-0000CC-Fw
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:20 -0400
Received: by mail-pf1-x434.google.com with SMTP id u14so24877954pfn.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BMsZb1YBUEkHFwRh2YB1z1GO0sYcNt67hSkjhh9u9CQ=;
 b=mi5iMrWGCckm2qAJEelgKpFU5RQeFtlvjRdAG3uF/g8cPqEcYsYMp6Ewb2jnN9DITj
 dplcSyTTrSSmw8PjN76+0yBAlDaB36wTCEU8vkdWu3Gh5C0QLEHkbg0Y0ThX9GhW72Vc
 zvVnrhS17n6ZhckRCeolIIacRX56xk0gSJ2H7iaQYz94ET+CBR3heLseAD1tfhvgCzDe
 vgI1IOm6GLwuKwKN+Kuab0Vt27U+/VhFzsb9SOInNoLGbLePpbRVduT1rfBterlpqTPT
 /js+TS3eM/OBIf/CVTXOggaIdlBNV5C5QCvUscDp57FEw5wCKpsDD3HDvbcEA3w/zX6d
 zFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BMsZb1YBUEkHFwRh2YB1z1GO0sYcNt67hSkjhh9u9CQ=;
 b=LL7lZgGF8+hzCLgvwCH1TXYlRx9WaRWdGCC1unkDBJ74hx5MrNuSrN14Pstt5Lps5h
 +7GuoIBfLn6ggJjuuiGbrrzcZ6DQmUqvEk8MOlvNI08rqTtiW3Kkf5TLjZCyp5GLI/hh
 Eil2yW9ayiyUCaW0CEjO1tQYI24e/F93K0V00yTHiZFhRMReVOe6O5rfG88j8XDoiSNF
 2wwcccy6Qhr/aZAw2HrdILw/2ce+0y8PBaKxr6/PI90yC6wbNzlHU0yuZijStvg+C9eD
 HBtnL9OF3JDfesHdSNzJrNxfF2SFsbmXN8um8FayojCLzkc1VwuApcMxoa/83fY+60M3
 RlbA==
X-Gm-Message-State: APjAAAVofr5Lsv8nsciRerwfGbgvj0duWULZ7f3yFYdfFIhuPQpM7Hik
 YByQcs0BQ5hzr1bFYsfX7hWLMok737c=
X-Google-Smtp-Source: APXvYqy65xnvcqSnRRDilNXXoLqDebJO1FqFcmJG1/2CyDX/jK46jswr7yxookjamoqjHgueyRsAIw==
X-Received: by 2002:a62:2f06:: with SMTP id v6mr23655611pfv.195.1564163471371; 
 Fri, 26 Jul 2019 10:51:11 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:56 -0700
Message-Id: <20190726175032.6769-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::434
Subject: [Qemu-devel] [PATCH 31/67] target/arm: Convert SVC
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
 target/arm/translate.c | 19 +++++++++++++------
 target/arm/a32.decode  |  4 ++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 3f14e5c7f3..7ea118a795 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9979,6 +9979,18 @@ static bool trans_BLX_i(DisasContext *s, arg_BLX_i *a)
     return true;
 }
 
+/*
+ * Supervisor call
+ */
+
+static bool trans_SVC(DisasContext *s, arg_SVC *a)
+{
+    gen_set_pc_im(s, s->pc);
+    s->svc_imm = a->imm;
+    s->base.is_jmp = DISAS_SWI;
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -10243,6 +10255,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         case 0x09:
         case 0xa:
         case 0xb:
+        case 0xf:
             /* All done in decodetree.  Reach here for illegal ops.  */
             goto illegal_op;
         case 0xc:
@@ -10258,12 +10271,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 goto illegal_op;
             }
             break;
-        case 0xf:
-            /* swi */
-            gen_set_pc_im(s, s->pc);
-            s->svc_imm = extract32(insn, 0, 24);
-            s->base.is_jmp = DISAS_SWI;
-            break;
         default:
         illegal_op:
             gen_illegal_op(s);
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index f0f0f50c4e..c2fb28f235 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -528,3 +528,7 @@ LDM              ---- 100 b:1 i:1 u:1 w:1 1 rn:4 list:16   &ldst_block
 
 B                .... 1010 ........................           @branch
 BL               .... 1011 ........................           @branch
+
+# Supervisor call
+
+SVC              ---- 1111 imm:24                             &i
-- 
2.17.1



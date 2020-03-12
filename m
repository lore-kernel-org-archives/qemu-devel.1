Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53B6C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:47:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7664320637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rb1015ft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7664320637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTne-0001yH-MX
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTix-0004rl-IH
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTiw-0001lT-FZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:31 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37767)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTiw-0001ko-9I
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:30 -0400
Received: by mail-pl1-x642.google.com with SMTP id f16so3074903plj.4
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h7AXraeqjBa9vhULwB29oPSWKU7V90nxWGB/AHNXvVI=;
 b=Rb1015ftymYuwi5nTcC4KlYDcTKVvlM5tuCW27x3uGhpkLiwc7K/EOQ5RAGy9ZN4tP
 E8qAkqyCaUFpLTRz31eS9m6OlLWP4jYsk75gz7xKdjnWDFj1k7B6G0T2Yp6IzyGg4uTm
 DHGShFuAeQwfQftD5Ui7k7fknncwhQX1LUQwTo3zUbcOIhtzAdLsEpXvJk7GS7aUI9KP
 P/cHam5CKveouVSU8dDb6hpAPkoUTzige9TSusj5sE2At8ZG1zK2lLnRFqzkt++LbRoP
 UW23tJCEZSnRdJxP6wBzI69zeikNO07+vHa8rjol1ptCBsLDrwBvB23W93uC9F5iDxfj
 PAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h7AXraeqjBa9vhULwB29oPSWKU7V90nxWGB/AHNXvVI=;
 b=hAfmGQkZwvAfFKv/57KWutpKvMORZy/MULt7dvmpbmUx++e94dnXYwNscebkZ5ksp9
 bkiIICWKR5smNkHcwqeErftSUrZ9Dwwkh8g+8RwrW7WXewA30sdHUF0O4mXmBaRrJOa8
 k+C+z4eIq7AylBgTTkpL8KwdUhMkVFPBDnNsklWg7UaScakk33xOQv/WL5bgG1iFo7H6
 p8LSWB9qbkWSs38ZuGhvZ9BHHwRhQIQo37GZPMIoPWLOmJGuH58FxzEQ8PrB9NRVcK1u
 pXLLJ9GbcS4C913L0Xx6XS2DliyLIIFtG9Li1EKrDhtwSs6gT0S5tIIMVRUFC0gy9Bcs
 ptKw==
X-Gm-Message-State: ANhLgQ2lvmtUwrpK28gL5lnB721ojLxw+TxJx3o7dPPZkyd50Hv0UyHj
 ue2S+TqbNP0O+zG5mAxzOdK1py4/Erk=
X-Google-Smtp-Source: ADFU+vuzHu1KWjyX0KR1P38uIdtDAbaOIe2mN51c1jg56JDfUH3qgkBI8TIiriAV0ntkArUA+zkmLg==
X-Received: by 2002:a17:90a:8d81:: with SMTP id
 d1mr5772884pjo.63.1584042148865; 
 Thu, 12 Mar 2020 12:42:28 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 06/42] target/arm: Add DISAS_UPDATE_NOCHAIN
Date: Thu, 12 Mar 2020 12:41:43 -0700
Message-Id: <20200312194219.24406-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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

Add an option that writes back the PC, like DISAS_UPDATE_EXIT,
but does not exit back to the main loop.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h     | 2 ++
 target/arm/translate-a64.c | 3 +++
 target/arm/translate.c     | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 41d6cc8db5..dbbb167174 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -173,6 +173,8 @@ static inline void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
  * return from cpu_tb_exec.
  */
 #define DISAS_EXIT      DISAS_TARGET_9
+/* CPU state was modified dynamically; no need to exit, but do not chain. */
+#define DISAS_UPDATE_NOCHAIN  DISAS_TARGET_10
 
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index a793ec9ee1..943d6034de 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14462,6 +14462,9 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_EXIT:
             tcg_gen_exit_tb(NULL, 0);
             break;
+        case DISAS_UPDATE_NOCHAIN:
+            gen_a64_set_pc_im(dc->base.pc_next);
+            /* fall through */
         case DISAS_JUMP:
             tcg_gen_lookup_and_goto_ptr();
             break;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5a21766cce..33a26287f7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11420,6 +11420,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_NEXT:
         case DISAS_TOO_MANY:
         case DISAS_UPDATE_EXIT:
+        case DISAS_UPDATE_NOCHAIN:
             gen_set_pc_im(dc, dc->base.pc_next);
             /* fall through */
         default:
@@ -11443,6 +11444,9 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_TOO_MANY:
             gen_goto_tb(dc, 1, dc->base.pc_next);
             break;
+        case DISAS_UPDATE_NOCHAIN:
+            gen_set_pc_im(dc, dc->base.pc_next);
+            /* fall through */
         case DISAS_JUMP:
             gen_goto_ptr();
             break;
-- 
2.20.1



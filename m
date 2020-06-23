Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1405C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:42:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D72120C09
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dD+6/qZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D72120C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnooe-00052v-MK
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 15:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojI-0003ME-Od
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:12 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojG-0005XX-F8
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:12 -0400
Received: by mail-pf1-x441.google.com with SMTP id s23so10556179pfh.7
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ztdDJx0ExFHe8U9Rsp15LQewSOcXI1YJBCF+u1ybiMg=;
 b=dD+6/qZHp/Je6fa++veUSdrBukySRuCBizJAX1jUzbZ7UUw/VehNs2LIniG+Mjk1fO
 fBZonBaCjTI0osePmb1DbhP1LFsGgestwr1uGZBwy/kB2EOh+otUsDcGqYgPQFI4/N7y
 r6HihAUI/GHcxqHGpkw7qJcUSrTHui1jw45nZJEGrnroH4nN5Ja71ZNmQvMGhLIDCl+e
 qmUoUCTuHMhgv6/CK38rmV3s/Vapfw8UX2LiceJgsPqzzpEwysiP8gKZYEKWVCgdzTOo
 v9FXMavXdn7gFUL8Iwo9DA4otJx622kTCpNB4k+CaOQhjN4ySujiowILgRFC9zfGjm+E
 xMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ztdDJx0ExFHe8U9Rsp15LQewSOcXI1YJBCF+u1ybiMg=;
 b=qtmgcFbbtk0vVgHIlKm7wZ02ij01F+AMt7TjdsmrSC6WeisNnTV3HoY8A+a9a6py4r
 yZWBTNC8tsBUKCFCvfr+a3xF+E9dmQa3a/9JcHYrRa1FGnbzez/SBL0L42jZpuEuJoE8
 BJ6acKtXHTi1kpxlB7UwAXK6yqnfzS1lxxNBnYuD1QOLhNVUkBnOpsBlnnXO3iQIMcpq
 Uaq6kdHKZeRDU+lDiJS/yOGryP9DuDJZbdzE40996x6mnaYanb2i4ueI3YO6XowM5o/l
 yDpbYm3hriWT1jBS/IGHWAdP3P2jzvyVULvVYBpdNStMJ3kyjeJez7vWy1qFmT+zixXS
 JXQA==
X-Gm-Message-State: AOAM530GPoSYcaRVCV3hglEOuX9SGnhl2cquN4jysj05gLpizOatRw/h
 4YTd6g00QNqGlV7F+fl55I7XvIhObgk=
X-Google-Smtp-Source: ABdhPJwIxy7cSFVY1M9w856Ky6tH7xztd58UUilROHBKr4wu9MFuQWgn0d1NUT53hvszz0s4PQlZzQ==
X-Received: by 2002:a63:5d04:: with SMTP id r4mr18789452pgb.15.1592941028697; 
 Tue, 23 Jun 2020 12:37:08 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 06/45] target/arm: Add DISAS_UPDATE_NOCHAIN
Date: Tue, 23 Jun 2020 12:36:19 -0700
Message-Id: <20200623193658.623279-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an option that writes back the PC, like DISAS_UPDATE_EXIT,
but does not exit back to the main loop.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h     | 2 ++
 target/arm/translate-a64.c | 3 +++
 target/arm/translate.c     | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 6c01f47983..c6f9376000 100644
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
index 63029bbc59..b4bf4cce18 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14310,6 +14310,9 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
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
index 45ea788370..00f94371a4 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9926,6 +9926,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_NEXT:
         case DISAS_TOO_MANY:
         case DISAS_UPDATE_EXIT:
+        case DISAS_UPDATE_NOCHAIN:
             gen_set_pc_im(dc, dc->base.pc_next);
             /* fall through */
         default:
@@ -9949,6 +9950,9 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
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
2.25.1



Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5176C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:16:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F7E206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7yUf7QQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F7E206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgI1S-000104-Lp
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyC-0003UP-PH
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:28 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyC-0003X4-1W
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:28 -0400
Received: by mail-pl1-x643.google.com with SMTP id y18so201724plr.4
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2dMQqpeyi0XKIpauyWT1oQVejUj1nmYGROEX25a4OR4=;
 b=P7yUf7QQBE5+/vpm46q5Q4PrJEeyCCeg0Ufbn7DdA+si9Qoxr68iS2PL0j0ei/ftZC
 iY/l9i84a4oJOxaSHwQIaQjot8cFBR2Z/zZXRKtbJ6+D8bNKKoaD91JYfzisB74MNwAR
 2ZAvKiYG4SF0H2WaMVyg0MC3EsgN8eR395IsckgidIoPo4jke2cWeDTDtbnQyYwMCRSp
 IPv4dbhVsORCd8x1SovWN7d5IHLQSHzOMTCQQh59Z8Mm1T6UkIECXhPFlNh+BI9/X1zi
 y6V1+t6id2EfsWXZ86bArKfdfVctHF9p3zFJT/GxzxQ99KQKIy1iJX4t2f1eHgKJD0EP
 L+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2dMQqpeyi0XKIpauyWT1oQVejUj1nmYGROEX25a4OR4=;
 b=CqAVvHnVbykRX00kQV/fsHGVXj9X0C+2Qv1OBUu62dGoKxc9Agef0bdn1ar8kn5p+z
 70PWcUB3K7hNYUStDFGnhPE10aC+29DaocBwGnplUsxjq9LKwhpImWao2L3t+DLYbfRw
 RYEqunemEHvbC5ghehLaYleDpzONemhv3PgIsiMZDROqvLQGuo5xgjkLnbYJoxliGOmO
 5Y7SsW4r6CJ3H5To/uHbjha3zHu1khd8o92WDPxC/MSF4MV2/E7RdFgO2RCf0Vb6eiOu
 jsEhA3Qb2C3Tl8GZKJJGrxmO8jg9C0hIvmB/Z4dVV5i2HpgBZpm39rCVcVP7T5bFMBSi
 yOKA==
X-Gm-Message-State: AOAM532npcO6BjR5nA5Nu9YavYpNtqgJxlelYSnVbJJUatPyu7bmDvrR
 AsnODjElQHWe2fWlAlKh+YPGjnPM54s=
X-Google-Smtp-Source: ABdhPJxH72F6TNjk5l8H88vQUdmMy9GKV8r98aIwQyED0zJTIuERXHq9fYKsGbyV66ib9HCL7bFqPA==
X-Received: by 2002:a17:902:9f90:: with SMTP id
 g16mr20197123plq.146.1591146806315; 
 Tue, 02 Jun 2020 18:13:26 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:13:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 06/42] target/arm: Add DISAS_UPDATE_NOCHAIN
Date: Tue,  2 Jun 2020 18:12:41 -0700
Message-Id: <20200603011317.473934-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
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
index 68a55251c3..81e47677c7 100644
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
index 430f1867ab..d4d2f69d87 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14340,6 +14340,9 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
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
index 00a6fe6752..460be11f31 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11085,6 +11085,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_NEXT:
         case DISAS_TOO_MANY:
         case DISAS_UPDATE_EXIT:
+        case DISAS_UPDATE_NOCHAIN:
             gen_set_pc_im(dc, dc->base.pc_next);
             /* fall through */
         default:
@@ -11108,6 +11109,9 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
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



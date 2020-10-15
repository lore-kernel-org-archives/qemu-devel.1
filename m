Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F47C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4622225D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ln+lu2dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4622225D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT57f-0002WE-Jv
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 11:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kT54k-0007O2-JN; Thu, 15 Oct 2020 11:21:54 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:35028)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kT54i-00060Z-FP; Thu, 15 Oct 2020 11:21:54 -0400
Received: by mail-ej1-x642.google.com with SMTP id p5so4220314ejj.2;
 Thu, 15 Oct 2020 08:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+5eiH3n+bCt0Dpm1Jhk3VQr3ezZvJ5rxkkrpSjvz9lY=;
 b=Ln+lu2dx+lU+NvEyswVbTDCr4V5va6XwwXiGmFqMWPIdIHK3ONNdYpXcq1QDwNk04k
 KSrVbBltKo3VCtHBTkdzHGaqq/MpcKryLInhTJBlHIMQWZoRS3Zjl4r0n4fw2/xEDFpi
 ATqUxBTTpYp5fTsFek182sEVdfEw9u1bWU/9c3rXTV7F5pm3JUtc7iKRRyT8JCfTY+az
 cUyFtQd6HozPh4wnbRKM0tieap/I/mbAnyJ0LQ4FMVZyN1mnAOZt8x4sxNsQcOv/uAjw
 lqp724JRhxSKEVZvA2jAxfjNNVQnGBjf8UjWupLAczO7KMjna2wzkzfgBo0IjS38Q5l6
 ikcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+5eiH3n+bCt0Dpm1Jhk3VQr3ezZvJ5rxkkrpSjvz9lY=;
 b=P+A7lB7i7Cls8YTO6uF84yHT6iF+XoKU8N38IhGXKpCRA6tY5WBNyc2BQ/i2D5xmrF
 xQdRKwcRLSUVz5TGMfmJoz3bBwfX1mWyKHWFrsHFQYlE9u9LtfNKclratQwKZJwNPJqo
 GLRc93MZ4Ko0Qa4Dhij88DDPlwU/yUA3EozHVI80DFksOEcAU+3iuHdZ9wiWQvoGohRN
 07laacFM2FDcPh5OR1B6hK+yKim8gyM2mtg2WG/kGfWxKXPRyhoHKR9CHdUHTMyaSQ6c
 MMmMezNS0tLYq/ghs9EM2cCqU4W4v03qUAgm42V76CdEhykUiZf2XPzqN3Vk2zPV7gjj
 pilg==
X-Gm-Message-State: AOAM530Y977XCkH5Pgf8EY5DUaKtFcKPifmyxxJjpCjqlnSe+nhm/uqI
 c1L22UBSVMrnmFvu3Ju2jjI=
X-Google-Smtp-Source: ABdhPJyFgLuvwbAAAxGGCLfbCpIpt/C9QOGd8OMEBNbrWLJBttspBXNrOIHYaYhXuXGzftDjqxAh2w==
X-Received: by 2002:a17:906:f29a:: with SMTP id
 gu26mr4731629ejb.363.1602775310793; 
 Thu, 15 Oct 2020 08:21:50 -0700 (PDT)
Received: from neptune.lab ([46.39.229.194])
 by smtp.googlemail.com with ESMTPSA id i5sm1819539ejv.54.2020.10.15.08.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 08:21:50 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <space.monkey.delivers@gmail.com>
To: 
Subject: [PATCH v2 3/5] [RISCV_PM] Print new PM CSRs in QEMU logs
Date: Thu, 15 Oct 2020 18:21:37 +0300
Message-Id: <20201015152139.28903-3-space.monkey.delivers@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201015152139.28903-1-space.monkey.delivers@gmail.com>
References: <20201015152139.28903-1-space.monkey.delivers@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: baturo.alexey@gmail.com, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, space.monkey.delivers@gmail.com,
 Alistair.Francis@wdc.com, kupokupokupopo@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexey Baturo <space.monkey.delivers@gmail.com>
---
 target/riscv/cpu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d63031eb08..6ba3e98508 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -255,6 +255,25 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "htval ", env->htval);
         qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mtval2 ", env->mtval2);
     }
+    if (riscv_has_ext(env, RVJ)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mmte    ", env->mmte);
+        switch (env->priv) {
+        case PRV_U:
+            qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "upmbase ", env->upmbase);
+            qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "upmmask ", env->upmmask);
+            break;
+        case PRV_S:
+            qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "spmbase ", env->spmbase);
+            qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "spmmask ", env->spmmask);
+            break;
+        case PRV_M:
+            qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mpmbase ", env->mpmbase);
+            qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mpmmask ", env->mpmmask);
+            break;
+        default:
+            assert(0 && "Unreachable");
+        }
+    }
 #endif
 
     for (i = 0; i < 32; i++) {
-- 
2.20.1



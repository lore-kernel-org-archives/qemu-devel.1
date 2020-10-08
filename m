Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4896FC4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 871312083B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ru8Vj5ot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871312083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVcW-0004BT-9K
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 09:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVTx-0003l9-OL
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:17 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:37746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVTw-0001z1-7g
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:17 -0400
Received: by mail-oi1-x22f.google.com with SMTP id t77so6184513oie.4
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 05:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gnZVZh1VIOx2Bn7nb5JDBu+SrUOXUk1VIW8AryTGMI0=;
 b=ru8Vj5otdLG3SQmnBAPtF4jbZcc4YjSLViq82IGnqsbnwg9HJmmyqZzRCLBhpBgxRL
 ecakmSCSiMpl8h0QBaGw+jb69toESr4GWNFlxWIANssC6QiBuUV/yo/LOKv7mJgKV8mD
 P5bjoVO6yAEIpr9qdK+nqZSl6c2rttgN/kJBd3ijw8diYz1y0IIuCROYVw/0ddp34D/f
 H7ejZqZGT+7ZUX1wYEVgiYqffFGDq77PsvD8BuBQTDWifGfP/JZIqXi0jVP2gFSFOcBX
 tVx+vEUe1qshaOx35J94NAt5esIhOa8JkIOdhsAtERpxYwp9+cZARKz72oRmPLMqNAlX
 WKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gnZVZh1VIOx2Bn7nb5JDBu+SrUOXUk1VIW8AryTGMI0=;
 b=fZmkRgvTwURGovlsJXvvyreHGEONLMUkAt5jw8I+ivWBLc70/xr1Bf5ho5XmLRrIyn
 Fev1q6gV6Kdms5FTEQMLLiCGyYGapokEH13GxtLq7Y126gLDY41nURbja6KwhRlIDDe2
 GunFyNhR6d5JcEQpeAr2ALJxcK2umRwy9XFzYJcb763Z+xAVZcc+qjs3b5CHleM+UYa6
 twqP26Z/oagrcQCdMp4k05tJeVUe+pHEjEeI5E5qp9Ucwu8+qKSRzSj9Sm8zxZ5rnpir
 ETe8zJNxvS7WyZdBiI4gmgXNFQlw/b/VCHm+pgvyZzyRbiVLAiwpEt3YvYzIA5yBE5wZ
 y4/g==
X-Gm-Message-State: AOAM533w+Y9wHpKq6wVmRoi7ezOtKSi8IzO/xxvsbO4iVNFm/A86l35a
 4xZ9vcepvypCaCuTk6UPlyBCQjYtM3YZPegt
X-Google-Smtp-Source: ABdhPJxZ8J48d3lzNMKzVe7imxMS6hBZtO2MM+YBF7sXAeHMvRc5eor4dGh0ck2mXILV4YzdYS/HKg==
X-Received: by 2002:aca:5143:: with SMTP id f64mr4653748oib.161.1602161834780; 
 Thu, 08 Oct 2020 05:57:14 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id w64sm4701933oig.31.2020.10.08.05.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 05:57:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/11] tcg/i386: Fix dupi for avx2 32-bit hosts
Date: Thu,  8 Oct 2020 07:56:55 -0500
Message-Id: <20201008125659.49857-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008125659.49857-1-richard.henderson@linaro.org>
References: <20201008125659.49857-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous change wrongly stated that 32-bit avx2 should have
used VPBROADCASTW.  But that's a 16-bit broadcast and we want a
32-bit broadcast.

Fixes: 7b60ef3264e
Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 2f696074ab..d8797ed398 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -958,7 +958,7 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
         new_pool_label(s, arg, R_386_PC32, s->code_ptr - 4, -4);
     } else {
         if (have_avx2) {
-            tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTW + vex_l, ret);
+            tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTD + vex_l, ret);
         } else {
             tcg_out_vex_modrm_pool(s, OPC_VBROADCASTSS, ret);
         }
-- 
2.25.1



Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CB5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6260A20657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuPLHifG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6260A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jalnU-0006ue-CT
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 15:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaleg-00030X-NH
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:42:31 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:42544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaleg-0004co-4b
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:42:30 -0400
Received: by mail-lf1-x141.google.com with SMTP id x27so9020683lfg.9
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 12:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VfSR/iJCl425OOqSbF8PVZDqL9Chz8pkOfIuaFDrxZg=;
 b=MuPLHifGazW/gJF66Iqq9VeFkBArcEx2x9ftHgij8KRr/rXOhiN3BlKMAUhhd016kV
 Jkq7waTksMeYWcKsRQCKYbNAFkS3a37nejZLHDQrcuIo0/g8ABGD+xXwOlsUG10QKBGL
 bZ99VtdeFvhimb42PXKGj3aCswIMWk5kwW7xKCiPF7ftWidqng7yX8CUDqZ1yOz36CrN
 Jz4Z4U19N8R9h1qNz8p8p1CzcwejaHJ6e8hsFzetCrwiLq0evKIb8yXxJmCj4kys8v4z
 wo9zIEwbmGjgX1NezNs3c9j3f5N93XxJrudJy6/i6tDbMI1Q6nA3U/2fhnhWBQhyfe0B
 yVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VfSR/iJCl425OOqSbF8PVZDqL9Chz8pkOfIuaFDrxZg=;
 b=FDq5eEjifWPOjF2qYNLW4xYK+YWTLUReYWpP2KQMELRA6J1kbjjiUwpdnFP7blfvov
 iEwHHt0hF7U9dVb9elBH+SFP0BNaVplL3xaxIUlzvzvk6GQSat9LLYOUPcCHaQ0N4dAb
 sL9IrkD4iXOe1mA6tHTZ0MZ6uU3C/0LOsu3AZ7LWlos0YCFoY+StVlGwaW3OApMvzhkA
 88c9RBLGy3Xty1AFZ9/JvjLguucFx7qjMBBjopARYVj09dP4E2YvGaDzE2c9267IAGNT
 DHoK9KkTVs3kYsSy39pjBPgTTH9RM6SkZmQN9aiqY5RoluWxcPhwrlfd6+6ExiZzXKFz
 s9Aw==
X-Gm-Message-State: AOAM530RBCE2DI0ok6NjdR5iWqG+SX2lxNCK2CIW4dqithMKKUpX/XWm
 RXwqIKvu0SzJs40fort88QIN8q+HK9o=
X-Google-Smtp-Source: ABdhPJwofSqsBZvIOhsvskMG3PJ8Jxe9gxZwelbQ9fZ3QbwYBPYhUSK2eU8sKSP+OAKZYESlPf3BQQ==
X-Received: by 2002:a19:c64c:: with SMTP id w73mr12431310lff.67.1589830948556; 
 Mon, 18 May 2020 12:42:28 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id r15sm7593128lfp.34.2020.05.18.12.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 12:42:28 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 15/22] target/mips: fpu: Remove now unused FLOAT_RINT macro
Date: Mon, 18 May 2020 21:41:42 +0200
Message-Id: <20200518194149.16281-16-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518194149.16281-1-aleksandar.qemu.devel@gmail.com>
References: <20200518194149.16281-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_PASS=-0.001,
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After demacroing RINT.<D|S>, this macro is not needed anymore.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index dae1331f23..56ba49104e 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1102,19 +1102,6 @@ uint64_t helper_float_rsqrt1_ps(CPUMIPSState *env, uint64_t fdt0)
     return ((uint64_t)fsth2 << 32) | fst2;
 }
 
-#define FLOAT_RINT(name, bits)                                              \
-uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,                 \
-                                         uint ## bits ## _t fs)             \
-{                                                                           \
-    uint ## bits ## _t fdret;                                               \
-                                                                            \
-    fdret = float ## bits ## _round_to_int(fs, &env->active_fpu.fp_status); \
-    update_fcr31(env, GETPC());                                             \
-    return fdret;                                                           \
-}
-
-#undef FLOAT_RINT
-
 uint64_t helper_float_rint_d(CPUMIPSState *env, uint64_t fs)
 {
     uint64_t fdret;
-- 
2.20.1



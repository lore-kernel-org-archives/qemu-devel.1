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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F5BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:46:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB119207F5
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFfvYWDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB119207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaliM-0007v7-Ro
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 15:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaleV-0002bt-Or
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:42:19 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:41107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaleU-0004WE-TX
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:42:19 -0400
Received: by mail-lj1-x242.google.com with SMTP id v16so7124364ljc.8
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 12:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JGfw2GTf7AKSuMq7zTbg0UDU4aheCMwNjjypN/fhxrQ=;
 b=UFfvYWDT1ZXBNFjcfFQ7Qy0FVtDmVSnTPKcSJ+1w6+gBnyYfHAVrcn85vYrfAIy3ET
 jDEjOOndvoVX/24fnVYtylWE7j5RNETIcHW1knjNDOB4cuACG2bKgc0KyYbnz4fl/fC4
 OQC/8dLjFaEXcM/xUyuUGHlWe/rFi4uOmJDPcqoeRdbhBNdLM54C9YtPjts1BZENi4kX
 yw6TtzzFtm5KAsOKL84ElOReXDmGtMZeGAA8PctwfXZ7suNPPtSr1eai72N5OSfdpNz8
 X6hEvgNbGHrjNXdChOYN91bCXSooWtpTTyXeJXN934dFYPZhSfArWh3vABj5onFME0mT
 kn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JGfw2GTf7AKSuMq7zTbg0UDU4aheCMwNjjypN/fhxrQ=;
 b=Risz9Qfm5xnirt9+0CxN+1N46ouJeY7ZGuLN5V71XThyMThbou+WXezJON28c1Bs3i
 CgtV2rjAIPq+uBr/OuekJpTlRdcFYRJwhiktLpJXK9S2QLZdK63UabtlPXuTiQd6B2MV
 5rOzpmwp6xCYRo4uZT0hbW6RzkyirHcD/btMMHWSdyBj5B7eX/u94ISX5KuQLfiOchxC
 cU2jb8gvk3mTDgux5Vwztw5YuZUO2UF/R/mT+hE3rBzwSXVr6D8bMiAPpT5ncPGyKLfe
 CEiDwlLZUAhCQCNlZ9R1rzpd882m24Xz0qD+Gcjo58Sul5zxkauquPU9CRKhc39Ut9if
 i9SQ==
X-Gm-Message-State: AOAM533lXfpv1lwHcQdcwGjdne61+2K3sPwAMUokeEWONLUccM4JEHrc
 QesC3HnxkL2/Q/dETSGonUzkuZ957HU=
X-Google-Smtp-Source: ABdhPJzNjxXXJ5BSQbuOEBnxHv5OWsszCr3BARfObWkR8YeMjIdhH1RZsVSQiSAIirl/7nDvmJLAFQ==
X-Received: by 2002:a2e:870d:: with SMTP id m13mr11215076lji.64.1589830937072; 
 Mon, 18 May 2020 12:42:17 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id r15sm7593128lfp.34.2020.05.18.12.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 12:42:16 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/22] target/mips: fpu: Demacro MADD.<D|S|PS>
Date: Mon, 18 May 2020 21:41:34 +0200
Message-Id: <20200518194149.16281-8-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518194149.16281-1-aleksandar.qemu.devel@gmail.com>
References: <20200518194149.16281-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x242.google.com
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

This is just a cosmetic change to enable tools like gcov, gdb,
callgrind, etc. to better display involved source code.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 41 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index a3a39681f8..c070081cbc 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1495,12 +1495,51 @@ uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,             \
     update_fcr31(env, GETPC());                                      \
     return ((uint64_t)fsth0 << 32) | fst0;                           \
 }
-FLOAT_FMA(madd, 0)
 FLOAT_FMA(msub, float_muladd_negate_c)
 FLOAT_FMA(nmadd, float_muladd_negate_result)
 FLOAT_FMA(nmsub, float_muladd_negate_result | float_muladd_negate_c)
 #undef FLOAT_FMA
 
+uint64_t helper_float_madd_d(CPUMIPSState *env, uint64_t fst0,
+                             uint64_t fst1, uint64_t fst2)
+{
+    fst0 = float64_mul(fst0, fst1, &env->active_fpu.fp_status);
+    fst0 = float64_add(fst0, fst2, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fst0;
+}
+
+uint32_t helper_float_madd_s(CPUMIPSState *env, uint32_t fst0,
+                             uint32_t fst1, uint32_t fst2)
+{
+    fst0 = float32_mul(fst0, fst1, &env->active_fpu.fp_status);
+    fst0 = float32_add(fst0, fst2, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fst0;
+}
+
+uint64_t helper_float_madd_ps(CPUMIPSState *env, uint64_t fdt0,
+                              uint64_t fdt1, uint64_t fdt2)
+{
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fsth0 = fdt0 >> 32;
+    uint32_t fstl1 = fdt1 & 0XFFFFFFFF;
+    uint32_t fsth1 = fdt1 >> 32;
+    uint32_t fstl2 = fdt2 & 0XFFFFFFFF;
+    uint32_t fsth2 = fdt2 >> 32;
+
+    fstl0 = float32_mul(fstl0, fstl1, &env->active_fpu.fp_status);
+    fstl0 = float32_add(fstl0, fstl2, &env->active_fpu.fp_status);
+    fsth0 = float32_mul(fsth0, fsth1, &env->active_fpu.fp_status);
+    fsth0 = float32_add(fsth0, fsth2, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return ((uint64_t)fsth0 << 32) | fstl0;
+}
+
+
 #define FLOAT_FMADDSUB(name, bits, muladd_arg)                          \
 uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,             \
                                          uint ## bits ## _t fs,         \
-- 
2.20.1



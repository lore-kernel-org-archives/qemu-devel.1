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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B281DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:15:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF2D20674
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXDzMvrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF2D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jamB0-0006Jv-58
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 16:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jam5x-0006gD-1o
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:10:41 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:37082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jam5w-0002MG-9w
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:10:40 -0400
Received: by mail-lj1-x241.google.com with SMTP id o14so11276183ljp.4
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 13:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VfSR/iJCl425OOqSbF8PVZDqL9Chz8pkOfIuaFDrxZg=;
 b=GXDzMvrvjmSsyYUIeFLOvzzy61GL2M631wiJcofaXwLrtii4gZZQiJOZgCAAzwv5Fz
 DQAQlCLnLMPI/r8nGq26pnrsrHZoLbZ27f51baIzePLQ3Ca/Wss+524JE6OdsME/E9eS
 h3LOYdMkSZZykgb02i2qjK7RpdK8hZrbA0TaTjEe2iwzgEQ0pF0n11nk1szKd5EwzDhk
 8or7kmwpVM8sPt8KJglFe6GslfVHBCe7ki93VT+DtBFF/AtroomuZEbLjhiKzFbfHgtM
 DFxqiI4xPdRM855QDp68/ZtvvqI5gGpDERse4G7SuqetC1CdBBPMFWG17ogs4V/tIipB
 9aiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VfSR/iJCl425OOqSbF8PVZDqL9Chz8pkOfIuaFDrxZg=;
 b=h/wO26cVuITDD2MoUPfskEUwD1exquYuQ4vBqyKB1xKutIaCSX9kZFKPqMvn1gHXke
 0L8I9pY8MvxzNd/QMjbaB/RNy60irURIhixYqnMq98VNRYNKmWfAFfh/6DR+KCAxLR1N
 TB59+QM4xHn/MjkZCFqX5MFr9MxJAqV/4jrBJG1YUEB1NAGzGU8c1zYJqdE2K9RzdxFU
 WEOrviOc3+V5NXmG+7yL8GblWJrFDN4Tz0x6PMCo97pkXCcSDFQgqOBgMGXSqaOAyLUB
 ohVHd32oNYUggJBdoa8udmOg5NBITqUnAZiUG4UF+1l0FHslciBHiftDu/GAaxaQH5mN
 bgwQ==
X-Gm-Message-State: AOAM533kes2gMBRhtc9uWrTVQV7X+g80V5ITgu4ac9yaqpYWhtr6Ign7
 4HKWL4hq3tjSjhafZXyZ6Qfq0J4puAU=
X-Google-Smtp-Source: ABdhPJzXL9JbEXkb1ERb8bXod3ObJtw/9km/UvN6Tnnav+o33gdJu9DW2loB+Lr981TrwVadej5siw==
X-Received: by 2002:a2e:870b:: with SMTP id m11mr4088291lji.45.1589832638587; 
 Mon, 18 May 2020 13:10:38 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id c78sm8700591lfd.63.2020.05.18.13.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 13:10:38 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 14/21] target/mips: fpu: Remove now unused FLOAT_RINT macro
Date: Mon, 18 May 2020 22:09:13 +0200
Message-Id: <20200518200920.17344-15-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
References: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x241.google.com
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



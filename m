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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CE8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:15:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B163F20674
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy+qIf66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B163F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jamAp-00062x-UY
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 16:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jam5m-00069t-4x
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:10:30 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:40776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jam5l-0002Fk-Eh
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:10:29 -0400
Received: by mail-lf1-x143.google.com with SMTP id h188so9225764lfd.7
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 13:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mYxLSKIyVoYLGhdjGpHn4CJKDqZ2VBMgsndd+FGkZyM=;
 b=Oy+qIf663ApaXErJ9OBjRv7/hOPVdkbkbls2B+RGiXyMG6gIp2XJtgzsaFcGlJyztT
 icaHa5SwF5Yw2XA/iO6zCff6ZtIiTE8DQBXZ0Z2c0j4JBf946LRo04nYTiQWl0BoHrpN
 ea1IguM+60VVzEcjXp0A7dPVMqMtbaSCEGmAz+qvVIMtleagAUQ5LLzJpYIqi4lT+lLD
 uWGov/Ax2Y5aqK+4t8q8jpPzLy9aLun1nvA4fhlOHLPv08SA0wbBi2MYErWdDFWPZpxG
 1CHRIDb+NVhKKJh5T3v/mKhuIS+UL9R4xcGVp5xe95HfegsGT4tSgt0ad92QpDRO/xjC
 XXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mYxLSKIyVoYLGhdjGpHn4CJKDqZ2VBMgsndd+FGkZyM=;
 b=gDAqnpjAnmGcODUijs4SqcscgSpHNonjAnAprRDa0USoksSIiBS9NaSen5Q7SzVPp1
 3N3g/SmNIYNyi/9xXbptUzG+IE/bSlJJ0y33YWExa00lOznno++pLPCV6TzlJJcdvArl
 M9ULlM2jigwQLLMau5u7fHqq7ahEoXAIGaKf+0h6zq4e4/LhPZVZoPyHRjKYExdY6e26
 kBGjg92gSk3rmHDWHId1F9fDiVCAd+5k3pFpFw50/cMEKXgln9hL0MrUoZFaMLcu3Grp
 Z/qlI4FBzAARkB9TqqhLZkRRx8JpKjJByd7nENbOfneG+vG0bS1zfijcvbgT8z/wDaFS
 VaHA==
X-Gm-Message-State: AOAM53161y/Wj7nWI8fZP2WZTXS5NGlecpa8zN5VnoR+r0jF3gqG+P0V
 ZGYPRSFlUgx4ixp2Qa56danvY+0uAtg=
X-Google-Smtp-Source: ABdhPJyssr7rfTQqfxHumocsuweNwR9n1q7spqgMcn4+ziXs+MssoTqt9cKNNqsof/sPpkIBhSup6w==
X-Received: by 2002:a19:ae10:: with SMTP id f16mr11938626lfc.74.1589832627692; 
 Mon, 18 May 2020 13:10:27 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id c78sm8700591lfd.63.2020.05.18.13.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 13:10:27 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 04/21] target/mips: fpu: Demacro DIV.<D|S|PS>
Date: Mon, 18 May 2020 22:09:03 +0200
Message-Id: <20200518200920.17344-5-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
References: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lf1-x143.google.com
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
 target/mips/fpu_helper.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 449e945166..2759c9989d 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1208,7 +1208,6 @@ uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,           \
     return ((uint64_t)wth2 << 32) | wt2;                           \
 }
 
-FLOAT_BINOP(div)
 #undef FLOAT_BINOP
 
 uint64_t helper_float_add_d(CPUMIPSState *env,
@@ -1319,6 +1318,42 @@ uint64_t helper_float_mul_ps(CPUMIPSState *env,
     return ((uint64_t)wth2 << 32) | wtl2;
 }
 
+uint64_t helper_float_div_d(CPUMIPSState *env,
+                            uint64_t fdt0, uint64_t fdt1)
+{
+    uint64_t dt2;
+
+    dt2 = float64_div(fdt0, fdt1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint32_t helper_float_div_s(CPUMIPSState *env,
+                            uint32_t fst0, uint32_t fst1)
+{
+    uint32_t wt2;
+
+    wt2 = float32_div(fst0, fst1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint64_t helper_float_div_ps(CPUMIPSState *env,
+                             uint64_t fdt0, uint64_t fdt1)
+{
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fsth0 = fdt0 >> 32;
+    uint32_t fstl1 = fdt1 & 0XFFFFFFFF;
+    uint32_t fsth1 = fdt1 >> 32;
+    uint32_t wtl2;
+    uint32_t wth2;
+
+    wtl2 = float32_div(fstl0, fstl1, &env->active_fpu.fp_status);
+    wth2 = float32_div(fsth0, fsth1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return ((uint64_t)wth2 << 32) | wtl2;
+}
+
 
 /* MIPS specific binary operations */
 uint64_t helper_float_recip2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
-- 
2.20.1



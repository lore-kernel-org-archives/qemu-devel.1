Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0071DC433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4FD2067B
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3oruxSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4FD2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji1I2-0005hk-UZ
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 15:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1FX-0003pT-QL
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:31 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:39101)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1FW-0004kq-62
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:31 -0400
Received: by mail-wr1-x436.google.com with SMTP id t18so15164222wru.6
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 12:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GR4eimU9t63Pw1mCFxbwUNXUU4YvTN5YihjHWjA0XDI=;
 b=P3oruxSxyZp9KdYNDiwu+6cw6x/Wb7gc1UgYelJUWgDxdciMlwmaM2/OfTywZku/am
 MBU9/qm0zzN5se7wLYoI3z41j0DjPeYPAEFCSyNGRlhH85PhVdyhbFyonW1FT8MVE0SC
 lq37xRHz0Ysao9/mW/RZuGiYan7iv09IROFu8Wv/oq4xqthPPY1+Oul2oaOsofA1qJ96
 IxnR39HGs1f1YoqYtJnPXRAXgg75eirroV54xxTNM/DYSM/h66VDm1qaKWCdxZH+pPmM
 SP64lo7opD+ShdnTv9jzblukJMBCLU8dyklw+sjirQKRQRe3gsA1KRyW1Nx6RxmnINK5
 D/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GR4eimU9t63Pw1mCFxbwUNXUU4YvTN5YihjHWjA0XDI=;
 b=ipqRDF4MSPkNh0p0gc5x8Tc4RQh8Nx7WIyuZMy3Fhy3LWheAI8scDtRtIj7o4r99ad
 JJZe7kDINgKV4k8arF/U8SX3CTwsxrXnONAgPxrHGJSaEIeRAy0hhAZwXR+GSwlQzgk6
 n5CjrOUqOTVAwVavEpprLN/qVc3GUlzrbC8nrkSLRnPoH1QJFM0OOo3xf/GMM/OCIdHN
 BwO8LP2AI1i9MTH/+MeVQg9hitsLtTSqln4cQQZFtTVKmSahDpB5KW80L/vKEZ6C96Pt
 infw3zW8Mg3Ogu7aaNJOFCYuQvUJG/NcrRY1B0MjpwMi9zt4C0FjATqCpGiDm0HLYFfd
 OBAA==
X-Gm-Message-State: AOAM533z1EET7+OS7GHR2gK/LZya1f8+7jos9n5K/Pa4t7nwYZjU4gR4
 YrSw8eplJVIFtSpd7zI6myc7pK4k
X-Google-Smtp-Source: ABdhPJxzlRDsepqMVublejJlY7a8iW8/8sR/qn1HfxvabumaA6GIG+UJLdfEFbZmvjLx0Oe9X0q56A==
X-Received: by 2002:a5d:654c:: with SMTP id z12mr19648203wrv.315.1591559188784; 
 Sun, 07 Jun 2020 12:46:28 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id u130sm21091339wmg.32.2020.06.07.12.46.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Jun 2020 12:46:28 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 03/21] target/mips: fpu: Demacro ADD.<D|S|PS>
Date: Sun,  7 Jun 2020 21:46:07 +0200
Message-Id: <1591559185-31287-4-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is just a cosmetic change to enable tools like gcov, gdb,
callgrind, etc. to better display involved source code.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200518200920.17344-2-aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 5287c86..984f3f4 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1208,12 +1208,48 @@ uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,           \
     return ((uint64_t)wth2 << 32) | wt2;                           \
 }
 
-FLOAT_BINOP(add)
 FLOAT_BINOP(sub)
 FLOAT_BINOP(mul)
 FLOAT_BINOP(div)
 #undef FLOAT_BINOP
 
+uint64_t helper_float_add_d(CPUMIPSState *env,
+                            uint64_t fdt0, uint64_t fdt1)
+{
+    uint64_t dt2;
+
+    dt2 = float64_add(fdt0, fdt1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint32_t helper_float_add_s(CPUMIPSState *env,
+                            uint32_t fst0, uint32_t fst1)
+{
+    uint32_t wt2;
+
+    wt2 = float32_sub(fst0, fst1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint64_t helper_float_add_ps(CPUMIPSState *env,
+                             uint64_t fdt0, uint64_t fdt1)
+{
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fsth0 = fdt0 >> 32;
+    uint32_t fstl1 = fdt1 & 0XFFFFFFFF;
+    uint32_t fsth1 = fdt1 >> 32;
+    uint32_t wtl2;
+    uint32_t wth2;
+
+    wtl2 = float32_add(fstl0, fstl1, &env->active_fpu.fp_status);
+    wth2 = float32_add(fsth0, fsth1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return ((uint64_t)wth2 << 32) | wtl2;
+}
+
+
 /* MIPS specific binary operations */
 uint64_t helper_float_recip2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
 {
-- 
2.7.4



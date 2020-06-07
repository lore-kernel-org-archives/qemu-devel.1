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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484D7C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B97220663
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN1qXI6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B97220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji1KC-0000jO-A3
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 15:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1FY-0003qV-VH
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:33 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:35364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1FY-0004l1-5p
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:32 -0400
Received: by mail-wr1-x42c.google.com with SMTP id x14so15169214wrp.2
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 12:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Zv8J6uiqikEoKXTVeDakEnxTIZuunJgq0fWRKMjc/JU=;
 b=HN1qXI6YKmS2JN8pyiAptOYLET0RysHy5OQQZaA8Vm0kVc8ZqhH8HgjDzS/Bxhhx9B
 Az6GA5BHa1uTGIpFED2GUxKtj6hyL3vK8bizr53vzSqsK6fZEQdtDfLnrduJjM9/tVoQ
 qsN8TUb45Zh22Mw/GQg+1vXFM5MCrnBomUOIS4IFEgZ32oFE6jUX4SlzOo8F/TxFPFB3
 icQJ6Vh/1H7LTFJN4R/Lpg+NOLBWjDLEYkCaO5dvB25u856XmUCfyws3gUhzBREbdbKc
 42XfSRW3RFMbIpraKFNy4aJQJEOisYKAZ1c01sdjklfjT6Tzdkc1T4tiRvJVFop+noQ6
 tACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Zv8J6uiqikEoKXTVeDakEnxTIZuunJgq0fWRKMjc/JU=;
 b=I92KfAoK9z3NMYPkFAySoxS7cL92PJBrYtNX5PummofBr5n3hL7hsHMCkv24v03Qfl
 iYJc3eJH10g40/qnLjlsINGtq6jFwfGNNxIuJ6ZlrsNBScsMZdm7xgrdfAOHs+gN3aj5
 0PmQQUJbVNVFmSIOZLXo/s3+EewDz9N3RYGI94FbtylvAHweOjGY6yhzaZVFip+lsz6S
 2olMobLP74ntwqE0UjZOqliIBQZA91Vo4MUjMgLR5aSOd05iVygIlApDfOQfnJgbysoE
 ls3za3zKDcJLwIG4Hn1o+c+Maq6/2arP5aUKbvAuLcw2ktN31Y/XMnfuez3pP2JOhu7Z
 E/3A==
X-Gm-Message-State: AOAM531euF3n+39/9hzna3OxVZ6PxGR627Yf/+Jv3XP9UC19VBNBSflB
 tYlGYjsjwOeyhr+HKydnIEk8mGG0
X-Google-Smtp-Source: ABdhPJzrWBBz+VTDlIidJGkN9KJFpWlE8zRR8/ik3auDDA/x3lDj9qPr562gdQuawwuAs6ZGHp1KWw==
X-Received: by 2002:a5d:4bc5:: with SMTP id l5mr20340368wrt.104.1591559190299; 
 Sun, 07 Jun 2020 12:46:30 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id u130sm21091339wmg.32.2020.06.07.12.46.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Jun 2020 12:46:29 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 05/21] target/mips: fpu: Demacro MUL.<D|S|PS>
Date: Sun,  7 Jun 2020 21:46:09 +0200
Message-Id: <1591559185-31287-6-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42c.google.com
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
Message-Id: <20200518200920.17344-4-aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 715a872..449e945 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1208,7 +1208,6 @@ uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,           \
     return ((uint64_t)wth2 << 32) | wt2;                           \
 }
 
-FLOAT_BINOP(mul)
 FLOAT_BINOP(div)
 #undef FLOAT_BINOP
 
@@ -1284,6 +1283,42 @@ uint64_t helper_float_sub_ps(CPUMIPSState *env,
     return ((uint64_t)wth2 << 32) | wtl2;
 }
 
+uint64_t helper_float_mul_d(CPUMIPSState *env,
+                            uint64_t fdt0, uint64_t fdt1)
+{
+    uint64_t dt2;
+
+    dt2 = float64_mul(fdt0, fdt1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint32_t helper_float_mul_s(CPUMIPSState *env,
+                            uint32_t fst0, uint32_t fst1)
+{
+    uint32_t wt2;
+
+    wt2 = float32_mul(fst0, fst1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint64_t helper_float_mul_ps(CPUMIPSState *env,
+                             uint64_t fdt0, uint64_t fdt1)
+{
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fsth0 = fdt0 >> 32;
+    uint32_t fstl1 = fdt1 & 0XFFFFFFFF;
+    uint32_t fsth1 = fdt1 >> 32;
+    uint32_t wtl2;
+    uint32_t wth2;
+
+    wtl2 = float32_mul(fstl0, fstl1, &env->active_fpu.fp_status);
+    wth2 = float32_mul(fsth0, fsth1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return ((uint64_t)wth2 << 32) | wtl2;
+}
+
 
 /* MIPS specific binary operations */
 uint64_t helper_float_recip2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
-- 
2.7.4



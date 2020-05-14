Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D407C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:29:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C2F20643
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uo2hvrcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C2F20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZJXf-0002eZ-Jo
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 15:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJQA-0007QU-L3
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:33 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:46235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJQ6-0007O8-SF
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:30 -0400
Received: by mail-lf1-x141.google.com with SMTP id v5so3577338lfp.13
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 12:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y+crpwaRbz+NuIRuZ2Ykd3V1TrXmhpx6yRUQr18fFhI=;
 b=uo2hvrcM3/9HoFG9rT1VSHSOLiya3Fdk6iLEB7WqTGFempSyz6y/DpP24T64xc/4jY
 ljCT/YENGyD22uoPVOIJrofF3164IdaQJRk4gacTlm3TaONwUOKFTtJbf+vz76jd3J4m
 +J1Lq8noBQ6Zf8N8z2LO79e0PEKkfEDZ1JWh6R8CLpZELrZ2s6QxoS6R6g969FlEVVEc
 V5OKbFw5kKixkHlZtNUympRJHWPB5NvOW/u8ICM1uzMvlBsZ9KZjzgeUS3DkNH4U5Ulu
 LbIN6ToEodCaKsOmXbd+33KEneehE3k5WL+aaY4VGFOn9Lnwq/W1Hw3SMzRB5gSrZi5N
 3FUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y+crpwaRbz+NuIRuZ2Ykd3V1TrXmhpx6yRUQr18fFhI=;
 b=otHjm0FFO3YChoRj+neehMIcxfErc+PLZFZ2vgcl3EqhgV5ZsXNapqIk7npIYGbasx
 q/oQ49SOSSGFC590KCReUF3CuEM8dVXR69yJG8VLOtVQquWyLnvarCt92KGn+LritPoo
 Qrqj8NHmpyamhVefUj3zqwp176+ChrFPxDKvCo8BIT3lgCjdmUHKIALeQ3UwTEfFnnA3
 JFjt16JtWVMF1RJo98Stds5aun96r4dw6rpWsTQv8H49sh4J4IzVKvVNsGaUQg5EDklo
 XHzoUWGW0UEkSEQwQYQz3ozu7XLi0dt3egPuJoL/sw6ls5UmWI/WWfPNiiNhg1m6B3/0
 cCBQ==
X-Gm-Message-State: AOAM533KFVVHL0n0UKevv1nckD1mw1uScFoK6rW3FNlWfMYLgVqgXOOR
 zp0o90Lfg5hi6TRYhkwgE7wXWrxlAC8=
X-Google-Smtp-Source: ABdhPJwABdm/IhtfQWcUONAjk6wwp+JXHTrH4uHwztxxyC0DZEkvExtu/fmA9uBJvCXRlVno9RebFw==
X-Received: by 2002:ac2:414c:: with SMTP id c12mr4215022lfi.47.1589484085282; 
 Thu, 14 May 2020 12:21:25 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id h3sm2427257lfk.3.2020.05.14.12.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 12:21:24 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/17] target/mips: fpu: Demacro RINT.<D|S>
Date: Thu, 14 May 2020 21:20:43 +0200
Message-Id: <20200514192047.5297-14-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
References: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@rt-rk.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is just a cosmetic change to enable tools like gcov, gdb,
callgrind, etc. to better display involved source code.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index e227e53f70..dae1331f23 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1113,10 +1113,26 @@ uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,                 \
     return fdret;                                                           \
 }
 
-FLOAT_RINT(rint_s, 32)
-FLOAT_RINT(rint_d, 64)
 #undef FLOAT_RINT
 
+uint64_t helper_float_rint_d(CPUMIPSState *env, uint64_t fs)
+{
+    uint64_t fdret;
+
+    fdret = float64_round_to_int(fs, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint32_t helper_float_rint_s(CPUMIPSState *env, uint32_t fs)
+{
+    uint32_t fdret;
+
+    fdret = float32_round_to_int(fs, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
 #define FLOAT_CLASS_SIGNALING_NAN      0x001
 #define FLOAT_CLASS_QUIET_NAN          0x002
 #define FLOAT_CLASS_NEGATIVE_INFINITY  0x004
-- 
2.20.1



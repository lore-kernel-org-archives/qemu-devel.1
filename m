Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26C4C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 22:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 436E320758
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 22:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I09d9MZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436E320758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaRRl-0003ip-Tu
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 18:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jaRIn-0001wt-9n
 for qemu-devel@nongnu.org; Sun, 17 May 2020 17:58:33 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jaRIj-0005iJ-FR
 for qemu-devel@nongnu.org; Sun, 17 May 2020 17:58:29 -0400
Received: by mail-pl1-x641.google.com with SMTP id f15so3396275plr.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 14:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GuKQ1OZpzNXkTUoxhwG03FMhbt3mmT8xFQUFvn4BBPI=;
 b=I09d9MZ9lto32k2IMHynP085zNmSWLdiO2KzA0dTqvngSalq9WWsZVDxmhYReiree5
 Z4cTgzMi0A7VfHSqiTC8kpV7o0gIY5tTeODHCzYOeB7S7cAreQpgvHHlsqJYINdqhZQT
 aF2wGkVYaFE4MpVX9l/Nt/kKug0T3lwPqvKSlKmzLeYRhm+v67lKVqqa5gRIDOO45v3H
 U1DWG1rPitFEHkKqnJS+IgJJeIJL9Yh9jUfAdXx9N4CtDhStElKrAaM2tha+ACrsTofx
 Lfzmo2fNuMQ8cJoS9UTxRKipAYgEV8E4+neByrKJif+n37qHxM6CJbQavfv+WlrQfIRe
 YUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GuKQ1OZpzNXkTUoxhwG03FMhbt3mmT8xFQUFvn4BBPI=;
 b=OgTS31t5Of+rgfVri03SKftrUEweSfOD3yJPpqRQ+ERVRsIK0uSA0PPQ8+47p3328Z
 12qt1IUa6G/ePm95PDZaaZ1RFEumEq03bO1rFOFxCNa9kQzzlUQbDD3OBg4EgiMVYC6Q
 lL7YJzKIpbX/3TSpUPO5OviyUlaAF2qxaLVcMqCwTsadRneVJ0Jp8vwdQ/zta3nsI79/
 wa5Isl4aY34jQ1etWa6jyMrPS3yWWj3CHny+ejn3W/JNf6eTHAXCs3VpS5/MxfGg6aWm
 nrJh3rGrFRRZvD+Zu5owcFz2fZeZgOupLvjQ7axoXX7r/Lq0YwQb+3lhIvQHGa9jCa2d
 vq2Q==
X-Gm-Message-State: AOAM531oHPZ4cWs7yIkzceTiOUA1ASZr84Mm7FXsSlK/xLSabmwao7qf
 uTsaJDOUI1m0UCX6DirVTiIsA2Mk
X-Google-Smtp-Source: ABdhPJz4uzJgQPiwVRUL8S5r4MfgE2RV9kmjjRvsOaSZfDw2lqqBAP0DNSi0ie6oi/RjZ315YzLNXg==
X-Received: by 2002:a17:90a:248a:: with SMTP id
 i10mr16839706pje.174.1589752707411; 
 Sun, 17 May 2020 14:58:27 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:400:e00:ed54:ef93:7dc5:e673])
 by smtp.gmail.com with ESMTPSA id h14sm6670139pjc.46.2020.05.17.14.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 14:58:26 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/xtensa: fix simcall for newer hardware
Date: Sun, 17 May 2020 14:58:14 -0700
Message-Id: <20200517215814.19623-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200517215814.19623-1-jcmvbkbc@gmail.com>
References: <20200517215814.19623-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After Xtensa release RE.2 simcall opcode has become nop for the
hardware instead of illegal instruction.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 546d2fa2facf..4bc15252c8a5 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -2367,9 +2367,10 @@ static bool test_ill_simcall(DisasContext *dc, const OpcodeArg arg[],
 #ifdef CONFIG_USER_ONLY
     bool ill = true;
 #else
-    bool ill = !semihosting_enabled();
+    /* Between RE.2 and RE.3 simcall opcode's become nop for the hardware. */
+    bool ill = dc->config->hw_version <= 250002 && !semihosting_enabled();
 #endif
-    if (ill) {
+    if (ill || !semihosting_enabled()) {
         qemu_log_mask(LOG_GUEST_ERROR, "SIMCALL but semihosting is disabled\n");
     }
     return ill;
@@ -2379,7 +2380,9 @@ static void translate_simcall(DisasContext *dc, const OpcodeArg arg[],
                               const uint32_t par[])
 {
 #ifndef CONFIG_USER_ONLY
-    gen_helper_simcall(cpu_env);
+    if (semihosting_enabled()) {
+        gen_helper_simcall(cpu_env);
+    }
 #endif
 }
 
-- 
2.20.1



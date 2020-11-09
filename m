Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B7EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E6C20789
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XDlih/Yv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E6C20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc8ZI-0006Mi-QZ
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:54:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kc8Y2-0005Iq-FW
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:53:34 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kc8Y0-0000PQ-29
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:53:34 -0500
Received: by mail-wm1-x344.google.com with SMTP id s13so8191669wmh.4
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 06:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NJhGAXP2h9Fo3Qoy3VCI1hDmptB3uQvjfcrEm2GQu4o=;
 b=XDlih/YvQ9EueJITn32CczHFH4OAP45WdvFAB4JnWAjPpMnt8gRhRPwuSIIxmqE8Nw
 R8yktxVg8dRs7Vc12DtWr9kIJjmRM6esQzlqzlPxw/S2v64QgVkk7UEF4hDmXRWqbkaf
 LQj4PAt/EHpu92SzoPYO60TR1h2ZI0n90Np8sU/BfSadCq0ucGcxqNXb8hfNYo4tvUNU
 Azp4heglPGJy1wBKfrruUAIqUzFec5DYdMF4nK/BokvvTZQ5nZPuDZISWdi5CFaJO22H
 GzvyWaw6dCY/v6BeVhHpiK+TpkJmxB6witCRTjyS/QbChsdPH9Gy+W/4sTE0gxTMoNUm
 dRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NJhGAXP2h9Fo3Qoy3VCI1hDmptB3uQvjfcrEm2GQu4o=;
 b=a0O5U3g0FVFHy8KnsUij5f3jUrwhsvesz8EWKFY+YZ+wmL2qxVOHon406p/91hlDIQ
 optZkN0j8QQ2TX77WL0z/iZ04DCJB1p1GlE0UqrIsog8EIMnfEenJALT8j6j46KrgMaP
 EuOMnSbt8Ev4gxvRKR+S+iaC1Xth3KzyOfQhfjoBFJsXRyjelEdfAc6qU01nqBQvR1jp
 ltE/kIluhwc/Na2rXxygTFkVpUlM2dYBHcrityxB5hugdb0e/6vom/s9ghnQF7RD0ceU
 X/wBDRHSdewzvUCualU/ZIV+dsBCg4Kg6LAkRuDkMhZh6KrIxBoAJZ1J58ap57i535kP
 gDew==
X-Gm-Message-State: AOAM533/3yoh8cSH+vf0ry5rHZ4Js2tOgNZIufs3qpV0Qrxbn6QkP40V
 GpSXVyuZJ9hMPFRDEg9mA8Fjyw==
X-Google-Smtp-Source: ABdhPJxMK/n06p9xkIonJ5j4VU410Sszjl76eofGpRoD3ajCGpiRTgrW3h4GD4SiA3h6gehtHKRVUA==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr14501218wmc.24.1604933606840; 
 Mon, 09 Nov 2020 06:53:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id i5sm6827444wrw.45.2020.11.09.06.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 06:53:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm/translate-neon.c: Handle VTBL UNDEF case before
 VFP access check
Date: Mon,  9 Nov 2020 14:53:24 +0000
Message-Id: <20201109145324.2859-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Checks for UNDEF cases should go before the "is VFP enabled?" access
check, except in special cases. Move a stray UNDEF check in the VTBL
trans function up above the access check.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Based-on: 20201105171126.88014-1-richard.henderson@linaro.org
("target/arm: Fix neon VTBL/VTBX for len > 1")
---
 target/arm/translate-neon.c.inc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 0ae95cb8df8..2403825d15f 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -2874,10 +2874,6 @@ static bool trans_VTBL(DisasContext *s, arg_VTBL *a)
         return false;
     }
 
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
     if ((a->vn + a->len + 1) > 32) {
         /*
          * This is UNPREDICTABLE; we choose to UNDEF to avoid the
@@ -2886,6 +2882,10 @@ static bool trans_VTBL(DisasContext *s, arg_VTBL *a)
         return false;
     }
 
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
     desc = tcg_const_i32((a->vn << 2) | a->len);
     def = tcg_temp_new_i64();
     if (a->op) {
-- 
2.20.1



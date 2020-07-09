Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE87C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:20:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 264FA2074B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yacbWQTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264FA2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtXPp-00021n-Js
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 10:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXIz-0000P3-Le
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:13:41 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXIx-0001LB-TD
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:13:41 -0400
Received: by mail-wr1-x444.google.com with SMTP id s10so2512679wrw.12
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 07:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ewDyFwxeAsoL4ZL7KCxcKldr+wl06CrcFcMcQWcDgRc=;
 b=yacbWQTrJ5yoHcIO/VeStISRu8ejApcnBRCZagkZ0baIPabIU1kH1EjMtSbkcMCt8S
 MuvlZdltYGbhvquKn8O0lQhuUPV8YWFkjgNfmzJi3HhLpslL+1cK6ZZ5q/aHCGEZgjie
 wbVnCNpLH23joinKGTzDc2B+zcjD4cgghVXorXm/wFUdy05t4yfrL2GSve2+k+lmxwNg
 A3ub1FT2cfiAnCF8tFTmAr/g+naXpsOU4pJFHwv0A4TedxqbG2gFQmKdYLnBraESidwz
 pGlUPzMiTpou2yAZjeff3utZ4VGNmF89UfweORoxHlh1MTaQEqRZ2Ywvfgcwfnn8LVJc
 IMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ewDyFwxeAsoL4ZL7KCxcKldr+wl06CrcFcMcQWcDgRc=;
 b=cdymFyWOJ4SXwLl/cNdNPHSrdXUAGZ36QNEZgBYsY1CUBEaexyoO51d3+7WmMboNl7
 UN2ud7FbEJjWGmEB3Ii4ZSlgWvhTQ1Mps/Vhy42xtLk/Jw2r2RX+pAOGzFuVBoLzQDhJ
 3Y3zpLN31JBzgzN7gXlqH0IC0tZoCbRoeDwtfEIkNGgSqaZJDR7j5Gby7VU++2A+GsfT
 dvxu7+N7t+ckVdDk0GOhsu+h4LuelAzIfSwmsLpGeJppgE4c8O8mZ5Pa8i4TRtp0AC5T
 wll1JzOw9Aa3gvcVPDUg4OPUlPCsldX9E0oqLmgVBRi9kcY2hMPWNIGOfttgoWpdVPWJ
 8ePQ==
X-Gm-Message-State: AOAM530UAKlvA61iUvJGP0INdX3SQZF34gys3I7dVGU5cn3IiCSfHjuo
 H2dCK0qh+zl8FuOKiPBIpVqC7g==
X-Google-Smtp-Source: ABdhPJycb1HRMwtAQ9SsCOT5hQWOwkjX7x0nt3wg9nifSXs78fHSRsQuZ/NVnnWNC8Ls4LLY3yVXNg==
X-Received: by 2002:a5d:658a:: with SMTP id q10mr62322515wru.220.1594304018455; 
 Thu, 09 Jul 2020 07:13:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g144sm16699999wme.2.2020.07.09.07.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 07:13:34 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 40C9C1FF98;
 Thu,  9 Jul 2020 15:13:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 09/13] target/sh4: revert to using cpu_lduw_code to decode
 gusa
Date: Thu,  9 Jul 2020 15:13:23 +0100
Message-Id: <20200709141327.14631-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200709141327.14631-1-alex.bennee@linaro.org>
References: <20200709141327.14631-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Claudio Fontana <cfontana@suse.de>, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The translator_ld* functions very much expect us to be decoding one
instruction at a time. Otherwise we will see weirdness such as:

  qemu-sh4: warning: plugin_disas: 6 bytes left over

when we use the disas functions. For what SH4 is doing here (scanning
ahead in the instruction stream) this is the right function to use.

Reported-by: Claudio Fontana <cfontana@suse.de>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/sh4/translate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 6192d83e8c66..919da72a0c98 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1915,9 +1915,13 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         goto fail;
     }
 
-    /* Read all of the insns for the region.  */
+    /*
+     * Read all of the insns for the region. We do this directly with
+     * cpu_lduw_code to avoid confusing the plugins by decoding
+     * multiple instructions.
+     */
     for (i = 0; i < max_insns; ++i) {
-        insns[i] = translator_lduw(env, pc + i * 2);
+        insns[i] = cpu_lduw_code(env, pc + i * 2);
     }
 
     ld_adr = ld_dst = ld_mop = -1;
-- 
2.20.1



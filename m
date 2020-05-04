Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE393C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:40:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87ADF206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xry39U1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87ADF206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaOB-0003ou-CM
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHj-0008Kt-Ah
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:23 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHh-0000o8-JZ
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:23 -0400
Received: by mail-wm1-x344.google.com with SMTP id x4so8236947wmj.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LQncQVuc9PNxrpkqh3ABgysYVzrhk3KqSd8QlCpLW+s=;
 b=xry39U1UhQbES9/4j7X8IeN2FFv+CeANO85nnQGpgeYzIQ2TOoWnLQTLzhetXlsGdR
 qqQqDC/1XlDNJx7kCQRI0NuETIFh+einE4KccUN4o651KM3C7PWyYdbtCT7M9D+rFSR7
 9e/80kcTMp8AQ5DjpwjN3lpHPFAbsVvYaiqdgbbFfLKOtu4ksXDhDfWYFn/jnY4MAmNx
 8YkAt0kYv1krL9Ik24FwOql7XUFAB3OXiRaLr6JXKMrQl3DrC3LbtqpKCD9/oPqjbqNH
 gdg4mbvKbVAm8339KUYZUBYibUZx5rlGHE+8gL+u0g1WsseqUP9YtTh7bS32gE7hsQDQ
 +QQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LQncQVuc9PNxrpkqh3ABgysYVzrhk3KqSd8QlCpLW+s=;
 b=heBr76aFMFIj8xVvWj+4lexjD2d1DDZnGjpOcM4dPEp1Wbjk3KD9hN/M4OCt0pY2YC
 4shoDhoxoYSwz7ctnR1r0iC2lzIpl0+y5INJ+NUc4c37SkGiMwAuCFGl2Tv2kelUyh4w
 8Yn/YRpS6yOTz5nQg5ZlVjKtD6vZ6jORJozGLjJcpajlf7BgWvERUAuRQUm/K/tNuPP/
 0191xc8VzwNOrU1PRNCZzTX6F94K+eh6bLx34C+Idd7dF7dTpFKJM12ZWITtAbKLxmJF
 +mholR3SwmJSG9ys4q0mb1j7F3llijBbSStT3hD1UL/nnS1nk5ENEzIi2LAFxbDozFDy
 K+vw==
X-Gm-Message-State: AGi0PuaADaEJN+OSNctL2qzAV4/YferxwMWdfj6SuHPuozw+3IGV01cR
 qiuUPnzkESV8CWD9cpI9vBKoBXVTbqzrpg==
X-Google-Smtp-Source: APiQypKo71ywZOHFC0zdbI+T8n2MPN3dhD1bu6ZuzsRCIAzUE3btZV8Uk6Vc845w5Z5Go1oyz3PDVw==
X-Received: by 2002:a1c:bc09:: with SMTP id m9mr13895725wmf.145.1588595599764; 
 Mon, 04 May 2020 05:33:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/39] target/arm: Use correct variable for setting 'max' cpu's
 ID_AA64DFR0
Date: Mon,  4 May 2020 13:32:37 +0100
Message-Id: <20200504123309.3808-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In aarch64_max_initfn() we update both 32-bit and 64-bit ID
registers.  The intended pattern is that for 64-bit ID registers we
use FIELD_DP64 and the uint64_t 't' register, while 32-bit ID
registers use FIELD_DP32 and the uint32_t 'u' register.  For
ID_AA64DFR0 we accidentally used 'u', meaning that the top 32 bits of
this 64-bit ID register would end up always zero.  Luckily at the
moment that's what they should be anyway, so this bug has no visible
effects.

Use the right-sized variable.

Fixes: 3bec78447a958d481991
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200423110915.10527-1-peter.maydell@linaro.org
---
 target/arm/cpu64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index e232c0ea12c..9bdf75b1abb 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -710,9 +710,9 @@ static void aarch64_max_initfn(Object *obj)
         u = FIELD_DP32(u, ID_MMFR4, XNX, 1); /* TTS2UXN */
         cpu->isar.id_mmfr4 = u;
 
-        u = cpu->isar.id_aa64dfr0;
-        u = FIELD_DP64(u, ID_AA64DFR0, PMUVER, 5); /* v8.4-PMU */
-        cpu->isar.id_aa64dfr0 = u;
+        t = cpu->isar.id_aa64dfr0;
+        t = FIELD_DP64(t, ID_AA64DFR0, PMUVER, 5); /* v8.4-PMU */
+        cpu->isar.id_aa64dfr0 = t;
 
         u = cpu->isar.id_dfr0;
         u = FIELD_DP32(u, ID_DFR0, PERFMON, 5); /* v8.4-PMU */
-- 
2.20.1



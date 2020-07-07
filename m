Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F30C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:03:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18BF3206E9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4Zp4Jqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BF3206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshdT-0001GS-DO
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jshaf-00063m-Qz
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:00:29 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:33671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jshae-0002e8-69
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:00:29 -0400
Received: by mail-wr1-x434.google.com with SMTP id f18so35882601wrs.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OAALL/cw7n/+7fM0VWJqcBq9KNUXzDegINtW6gZFwpE=;
 b=g4Zp4JqxMQPW8NXDh2LJhXZHDLOUQ189LrGld5JfP8h5zhM6Xd+QkQdlrN9P222zjR
 BSIZwCgn1DHaFmIDL9K4dzgLPt94oDTQ/d3iCQ/qpTNX1JweFpw3F5utysmWLb0dP7te
 GIhWpTvc181uBX0ULfohDy9jSU+sZcD9+HLUoauVHKkXZhTZTOi/eHk+tXRXzLaKKbXN
 xGo9ZIYD8/GwsMX+a9x71slDgsrQqdlHH9elRSEkmhT85xsg4zApN4QlqP6fYxXD/0wf
 zdkdrs1ieITWFTnI8pTclq+akEJ4xNTv6gWfFUpLDdcReNNMlai0ih5KmNIHTrXDjOBW
 +FVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=OAALL/cw7n/+7fM0VWJqcBq9KNUXzDegINtW6gZFwpE=;
 b=jcaeK/nDXbmFYSF86RkrOEnNm/NqFEVd5+wJvz7QqbMqFqOGuj7cvYiy5uc7Skb+qM
 8YZBZ8BPrLgbh8XArvGVs8VeGKVCsURQWWUupG3Vooc255+c1ibpIXdW2KtCg0eaGA2S
 141xbzllHC6zx6YPPJIsHIn6MwN0UKcPd6PVGsxo+Wt7Wu0zOlWLEqE1ncsrpeMeltfw
 z5ps5A9lI8Gcf/un+c7q6kIihvZnKwIUN+tqlDq13K8qz1b/L8/lES66tHNPkciC9Z4X
 8X7bmXp/B5+duynSTOuFvXd7WddrNieQwBCYWXptwH1Hj8VZ+7444VB0sUVnGSJbHuNi
 +wYA==
X-Gm-Message-State: AOAM531/1xsCpiA359xz1qZuPk36mEBDbBskRxBdqfrO0PCgbrmc1kQI
 5QYT1GAQjqB7WfkBejhJZU+q575o
X-Google-Smtp-Source: ABdhPJxc//4/PZI0CVaSPHvX5M1mgcsLxzF7/0tKrF5PLqkXGGvI1Bt1TUT9KPVYpktsN3pUtnST7A==
X-Received: by 2002:adf:e80d:: with SMTP id o13mr20788802wrm.112.1594105226591; 
 Tue, 07 Jul 2020 00:00:26 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id r3sm30763634wrg.70.2020.07.07.00.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:00:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] target/avr/cpu: Fix $PC displayed address
Date: Tue,  7 Jul 2020 09:00:19 +0200
Message-Id: <20200707070021.10031-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707070021.10031-1-f4bug@amsat.org>
References: <20200707070021.10031-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Thomas Huth <huth@tuxfamily.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

$PC is 16-bit wide. Other registers display addresses on a byte
granularity.
To have a coherent ouput, display $PC using byte granularity too.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/avr/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 50fb1c378b..9be464991f 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -151,7 +151,7 @@ static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     int i;
 
     qemu_fprintf(f, "\n");
-    qemu_fprintf(f, "PC:    %06x\n", env->pc_w);
+    qemu_fprintf(f, "PC:    %06x\n", env->pc_w * 2);
     qemu_fprintf(f, "SP:      %04x\n", env->sp);
     qemu_fprintf(f, "rampD:     %02x\n", env->rampD >> 16);
     qemu_fprintf(f, "rampX:     %02x\n", env->rampX >> 16);
-- 
2.21.3



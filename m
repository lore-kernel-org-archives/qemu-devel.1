Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594D1C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:48:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279962072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDdqEbk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279962072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboMo-0003OU-Ax
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIE-0002JW-1B
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:38 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:37865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboID-0006Wu-4V
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:37 -0400
Received: by mail-qv1-xf43.google.com with SMTP id z5so3373977qvw.4
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5p5QVMZ54qL4PKza/xfxsC7DswUaUr8tRQACxDFIq5U=;
 b=TDdqEbk6IX9z4XjZHxvf8HwqY56a2NNvE/lbRvy54fv88C4LqyMEVOTbLkkaL+NQw4
 t62o5xVjf0LYZu5vCJ+/1y7FLD9tXneVyGyGaaippzhChniq9ZCc3/E9IsIQEsltvL2L
 fgvY/kbobS927GncxGuEhQsPSjDrrK7TEtUA0KEEdegBgcafpnf2i23zZmPF17BMHyt6
 xhAXQy5w6ydVDYzKE+Pphw25qIXE/s9xKy4A2WzpxwPWHeZpf3EyJpodnuFkzgxwgudB
 T++Ze6xew05f0IvnVwW0FHo873oI5iD7r72thC1g0/OCR7s1Ree0+PGL+nIQKFnD+CrP
 4lkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5p5QVMZ54qL4PKza/xfxsC7DswUaUr8tRQACxDFIq5U=;
 b=CHfEkyEMV88N4Hx3fCXxJTNDYOClkb/xGchyNH0MDBeS5xKxKsImB3pb9Buqrj6148
 6YsuJ5fL8DfTuvbcxWyM6w1BLnhB4nntOWycV79smwQ1l54TgiugDXEowkJzvov9CUTc
 XR8M7yZOog53TnHTUVSeIIRoTIB4RjZ+U7NqYzAgWv0WEQt7s9U6VMrGma1AYEqhdBaL
 LJYlnDLnzTaVC0yPW1M6JnZkauIf3DpvCBGR59WlKfs5zskGMM9R3vkG2d7xAvRW0vVf
 6fgqyNSjVe4v75+11qkFabgq8jC6oPNkzqsR24qpPZdx0Fy7jWA//n3x1uE05C8aLY9s
 u2dQ==
X-Gm-Message-State: AOAM5303Lz0fdDdHtL+QWaJmkUf0NF5H6fIvg0Ln4KHIj8U7rsxCe/UR
 4YuQTVT4Ceu8ytlMf7FqveJoMv79DqaOAA==
X-Google-Smtp-Source: ABdhPJyCV5SE2WUnx34e5z2KktJO6u3Sblxv7Y+Ht53ezVG+H7MvsnigQDZ+mXkTtrbsW9fH57j6Wg==
X-Received: by 2002:ad4:4141:: with SMTP id z1mr10624562qvp.227.1590079416020; 
 Thu, 21 May 2020 09:43:36 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:35 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 16/74] tcg-runtime: convert to cpu_halted_set
Date: Thu, 21 May 2020 12:39:13 -0400
Message-Id: <20200521164011.638-17-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f43;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf43.google.com
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
Cc: richard.henderson@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 accel/tcg/tcg-runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 32ec18fe40..ca0774d3bf 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -173,5 +173,5 @@ void HELPER(cpu_halted_set)(CPUArchState *env, uint32_t val)
 {
     CPUState *cpu = env_cpu(env);
 
-    cpu->halted = val;
+    cpu_halted_set(cpu, val);
 }
-- 
2.17.1



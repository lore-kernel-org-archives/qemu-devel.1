Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C48C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE435221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HTsbhsNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE435221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dXj-0004mH-9P
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dQj-0000aa-QU
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:47:25 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dQh-0007fy-CV
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:47:25 -0400
Received: by mail-pl1-x642.google.com with SMTP id w17so27293138ply.11
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=drhHEFRj8g8xHCSfNMMcorRHdIOXXyDjguE7cUlbARg=;
 b=HTsbhsNiWdRH7+GXR2q2E4suNGcQodAoazQTqbM30FKCskNYfBgF9ACq6siXvBsa0K
 0r91KxcOombT4AdvC9PbGdSYIYooNOaeSyJ0T5zKq5G9CP7UAfu0b4gm1WTSuiUFBuEY
 vazvdJpJ27XoPfViCpyFpNrjzhQCzMuZrGTYxF56RLOrSXDGVcnUVWVz7/pOOwVjhvgL
 PE3/JPcp+H0Pb1MLQa67LuL23p5qX/jlFSQMD0rXzKzHo6C9SaauemEqH7VRqDtOFDQa
 sASqdxmo2pE0aUHpDdSjVCzod4XgaHRzuwsldifKv8W8JUd+mGN9oIE1IdLImYlGLm4E
 hvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=drhHEFRj8g8xHCSfNMMcorRHdIOXXyDjguE7cUlbARg=;
 b=PyuLv22b8UcrxGZwjG55JnOTduX9FaRuGy/xfmKMOqzg1wOp0QJb2g7a23FSkmbXAu
 LmJ4xfGbzEVgWO5PDHPKMiMNkyz1kBTqDWwU3wbReeiexBi11DKHYH/P/tTv4we+1tPi
 e8GIUEKoESAU9PNKoQjbA9QbDQz6H/bN9ZVqtETfVok3IgdbnUMytXQBsnc7I/ZlbNdc
 APOcO/Ly7/JMkyVOXU4lWgjKmos3YxD5dV5rKlSzI6Cf/+MFphpwXp3hfiFeP/0mSCGG
 FjkWG3YPsKToaEnxtfXVOvON8QOUZ/QgzCrFELjIXRhoKZ5iNJlp8dQeiINDaZ44E7De
 vukg==
X-Gm-Message-State: AOAM530MKGWozQqEa4K+NKnMN0UVdgaFJQZMhL0YHoAx0Ym7HVTZbLlj
 Xxxa3qqwRIuFr4TZAv0sQPbup42rTd4=
X-Google-Smtp-Source: ABdhPJxMRJClA+Ba/98FqwTLmdOvZLuSoTg+TwzTooHznYT7iL6nOt2yRr5TlNVSbNnC/82pBF2fzw==
X-Received: by 2002:a17:90a:6285:: with SMTP id
 d5mr7885742pjj.85.1596710841785; 
 Thu, 06 Aug 2020 03:47:21 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:47:21 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 02/71] target/riscv: Use FIELD_EX32() to extract wd field
Date: Thu,  6 Aug 2020 18:45:59 +0800
Message-Id: <20200806104709.13235-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/vector_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 793af990673..43ba272c09b 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -98,7 +98,7 @@ static inline uint32_t vext_lmul(uint32_t desc)
 
 static uint32_t vext_wd(uint32_t desc)
 {
-    return (simd_data(desc) >> 11) & 0x1;
+    return FIELD_EX32(simd_data(desc), VDATA, WD);
 }
 
 /*
-- 
2.17.1



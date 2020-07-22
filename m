Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635C0C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:19:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D96A20729
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AsemGna+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D96A20729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyAtw-00084x-EO
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAt0-0006H9-Pl
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:18:02 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAsy-0005Gb-6W
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:18:02 -0400
Received: by mail-pf1-x441.google.com with SMTP id 207so872017pfu.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=X1LjG6RnJFzOwqupbNN0fmDaBqQS4kt6NiMvgH0v9Do=;
 b=AsemGna+W0Blh3cqN058BH2n1LSs+uk/6prjWLWNB6knKdgwWv5/iVL0utXJMUZBa5
 9Q7DYpptA9tnQMTzjtKqBrv3t6f44nozJzC871JOaHhmlrIfeGYlw1Xg9JHUlcdRmxXS
 UjmqTuX9N2uGGZf1xgeQJVRDc8+wnJCK9L5EDbp6ktqh4o0IsYAez9grhHlbkR4vC4A6
 TztujTiqOVmC2OHfxRXPcuxSRHSjmybVBh7oXyAhWtylzWSEu5ux0dJSQdy4R1b50nxd
 INedkWUH9MiOPfNZipDBVGZploPCYTQd8YS23SwfQUMmxjc58JC46lLfm+QgVL8G2T1L
 7NcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=X1LjG6RnJFzOwqupbNN0fmDaBqQS4kt6NiMvgH0v9Do=;
 b=iZEKNb50jx9Va5G/r3HZ0G7UpXTmOWl71k6KeRiJnzBqvrzOFFynAQH8zHsIgq7rk1
 IgcB/rQBlA/OgGiiKgu5Wo4UmYy81q26cGNjdYMFQt3PDYY45hjQc87J+7TMSZIchA55
 gtIUNWn+c53/9vdgIwTrEjaAJNVyVXPgg9MabopCfT6Di7N7JBLjPfN8mUj/C22PI/Ur
 tu4Z65zBJNgm7ff+wgdJwd4tgOTTtBVF1j6jSCO45iQanOrvP/X2PMYCcNPWU3S21QbL
 vsc303Hp/z78Gd9dXmcA7L40QGwHsB/uhhJE4P+qMJ1kzWftQo9S3z67vzmD0h0r5Ypq
 D9YQ==
X-Gm-Message-State: AOAM531Ba9yUIXqd0xVrjPm0kGF2hbf8XHZpIGsbn8zwu+jl5hjgKDZK
 xxs89q8ueN9PwcDtNnevbjjjH4uFUkU=
X-Google-Smtp-Source: ABdhPJyq3lYX4I+k9jL/m85IDJag6nyaAaEwIpP+yBJ7j90p2xPOgu8VXKehVN1lTRv/PKdpZqYJTA==
X-Received: by 2002:a62:3587:: with SMTP id
 c129mr28124312pfa.212.1595409478746; 
 Wed, 22 Jul 2020 02:17:58 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:17:58 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 07/76] target/riscv: Use FIELD_EX32() to extract wd field
Date: Wed, 22 Jul 2020 17:15:30 +0800
Message-Id: <20200722091641.8834-8-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x441.google.com
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
---
 target/riscv/vector_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 39f44d1029..4c0a6198e7 100644
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



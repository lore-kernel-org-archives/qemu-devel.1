Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA105C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C4622063A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bluGCR8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4622063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7b92-0002CL-LK
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7arS-0008K5-R2
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:51:22 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:35581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7arQ-00053n-Rz
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:51:22 -0400
Received: by mail-pf1-x42b.google.com with SMTP id d188so7898481pfd.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fR4JpsXJUuT5lJNobC6iQBq0EFUGSIwBclP3cnYK+Jo=;
 b=bluGCR8I7oJDlVxHvXBbJF5x6SX0H/gpKKmSNeVIuak9l/cZUkOKEWbv2th3i7iIgq
 /FaBwaMHT29rXdSA6eKoSuRni0uwaMWnOmR0npo5hqwOgRLFyLuGqPsyeqbOKbsRtGOK
 MNea7CJxX3xy6KroFz9N+VGFXE/EgFql0M7xonZvrTeMDLYmnn+E9DOLfwHrKqOuIhsx
 4CPfcaf6P481t6Zxj1tdunRMOWEd5Mh4kY4vAFlEG19eUwyxNY/Lkvq2u/aoHn21CuJ2
 BKG1MvckCyY9wrvkKdx+3VTSpYS8+W/49UCaLiA5tofhfx8+xMxLtv8OX7DPYZvsPDL5
 C+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fR4JpsXJUuT5lJNobC6iQBq0EFUGSIwBclP3cnYK+Jo=;
 b=H+GN1zshIqAq9qTDLJ9Vbc1/cyQ61lGt0XeE6jugKWCX9XmwigJ3PkmgfJEFAeR8Fk
 xdQ0rvi6VzCKd017js7/pn5Hq5O7owhrPqSdSmIAKhKjKtbAaFQuokwzYLENNLI3MOO3
 pxowpvgZtPRdHHnhMFO0y6JdR96Ti5LIx8dZ4xfvFrX5V+GhKYi+fYHP+vqufzj43mbA
 PO4DtUS7nGoCjabOEC+Vli+MaZ/elBqk2PgKGx5TP7Vwj12AjI0ZpITUqKnFYA6Ff1xJ
 jG8jpCxPigglnVWzPL75/YmfNnnCGE2190dzkiX5gj39nUTskp3L9yVrJ8zdhkw1kq4D
 wPAw==
X-Gm-Message-State: AOAM533VyOAiMpIF1ZjphwlXBYePSPZhhnFSsFBKw0WDL43zMngGlx9m
 l2y5AMrkHFNA404ksu0IgpDRGlDYOoRBmg==
X-Google-Smtp-Source: ABdhPJzNQRVvCrMOGALQIBFmKfL1aAddZ+1fV3WdLUEhhSzKDSEkor0hrgk3iXMWsTYvfCwfjd2zGQ==
X-Received: by 2002:a63:3157:: with SMTP id x84mr9121757pgx.256.1597654279485; 
 Mon, 17 Aug 2020 01:51:19 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:51:19 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 26/70] target/riscv: rvv-1.0: floating-point square-root
 instruction
Date: Mon, 17 Aug 2020 16:49:11 +0800
Message-Id: <20200817084955.28793-27-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42b.google.com
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
 target/riscv/insn32.decode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index c99575d1360..f142aa5d073 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -527,7 +527,7 @@ vfwmsac_vv      111110 . ..... ..... 001 ..... 1010111 @r_vm
 vfwmsac_vf      111110 . ..... ..... 101 ..... 1010111 @r_vm
 vfwnmsac_vv     111111 . ..... ..... 001 ..... 1010111 @r_vm
 vfwnmsac_vf     111111 . ..... ..... 101 ..... 1010111 @r_vm
-vfsqrt_v        100011 . ..... 00000 001 ..... 1010111 @r2_vm
+vfsqrt_v        010011 . ..... 00000 001 ..... 1010111 @r2_vm
 vfmin_vv        000100 . ..... ..... 001 ..... 1010111 @r_vm
 vfmin_vf        000100 . ..... ..... 101 ..... 1010111 @r_vm
 vfmax_vv        000110 . ..... ..... 001 ..... 1010111 @r_vm
-- 
2.17.1



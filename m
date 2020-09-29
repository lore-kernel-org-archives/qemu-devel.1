Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36FDC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0859F20774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bUqxKjWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0859F20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLSN-0006yT-SP
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKy1-0005fS-Qm
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:07:15 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:45912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKxz-0002Bx-OT
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:07:13 -0400
Received: by mail-pg1-x52b.google.com with SMTP id y14so4608189pgf.12
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=SIH69F4lD/ulL3L/bQ9It0P1aDp77VjtDK919f4m0g4=;
 b=bUqxKjWmFdCuQz7jucNb/Nz75eWWOvNdQOImAYMe82vYdHhV6/fdzX4IZOEompWVbt
 IdFJou1XesM7sOy8t5kl+J1SjkCbtceRcLOAbGRSuO3MiuV/p91NXWRtfv4+M2TGJxYy
 sJ66f8WjenrkykZppx9BA3TgviE51ge5+35+hbUiZBZiwO07++lpMIHtG8E0akMPY+VM
 SMdMGkNTxWD8sFE1oHh0JSxLqYrSwopsRzU0MEZ66tYlPjYFFXX4cvpXN2CEkdONBk9X
 f2fhVhceYmbTsBoW0TbjsDwsCDP9L0NOzRZlOjgn9g1D56a1D6Qy8lzMd6/5luk5Lud2
 XDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=SIH69F4lD/ulL3L/bQ9It0P1aDp77VjtDK919f4m0g4=;
 b=i+D0Sk58tt/uRg0WhT9Cc++gw9GloA7SBw4e6/+JNDw7LeTC6qpNSr72R5ZfxoOXBj
 HEaIZQUk8q88tnwmIdrhVj/WdOcE9qAUksbrCqLj42cY00KdD1NFFKIIfk2w1n6daLn6
 QLip+jwHA1XoOifP1qNrwDVYqkF/LlT+gphh2K2V2sSus+W17eEt48MUdksayfFmYNUe
 +wynx6OTTwAUZWgjjxqpbv0EeKmhRrYucAU7LOueQaZuT2vlsQyPafZxJOJZ7rLQL6DN
 sE+Z3XiU214pQlMSVpe4q69jUFoF6LVgkoDECFdk6zXX7rLzNdcUk/GvvGOMqOFRUYrd
 VJvw==
X-Gm-Message-State: AOAM533x5bFRhFGzDMLbaGEz6jQ6CRtEz3VcfOwTWFgFuV96SjExJpLT
 ULhwoA/3846YS3FGkyoaxHZVnsBtdFqjiQ==
X-Google-Smtp-Source: ABdhPJxBqvZE6d00xfsqdZfR2HmanS+ILB0dl/2V+5zGHBUSaClsrytrED+pJhELolYkEzPmkaKz6A==
X-Received: by 2002:a05:6a00:844:b029:13f:dd99:d1a4 with SMTP id
 q4-20020a056a000844b029013fdd99d1a4mr5606810pfk.31.1601406430081; 
 Tue, 29 Sep 2020 12:07:10 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:07:09 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 32/68] target/riscv: rvv-1.0: element index instruction
Date: Wed, 30 Sep 2020 03:04:07 +0800
Message-Id: <20200929190448.31116-33-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x52b.google.com
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
index 33b4612a69..c3b42b051c 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -608,7 +608,7 @@ vmsbf_m         010100 . ..... 00001 010 ..... 1010111 @r2_vm
 vmsif_m         010100 . ..... 00011 010 ..... 1010111 @r2_vm
 vmsof_m         010100 . ..... 00010 010 ..... 1010111 @r2_vm
 viota_m         010100 . ..... 10000 010 ..... 1010111 @r2_vm
-vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
+vid_v           010100 . 00000 10001 010 ..... 1010111 @r1_vm
 vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
 vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
 vfmv_f_s        001100 1 ..... 00000 001 ..... 1010111 @r2rd
-- 
2.17.1



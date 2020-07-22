Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233C0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF5C220787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="C1uNwpcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5C220787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyB9a-0007eY-3j
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAur-00021B-3m
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:57 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:36265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAuo-0005dS-7I
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:56 -0400
Received: by mail-pl1-x62a.google.com with SMTP id t6so658784plo.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4piOJT33/Ks8zF+9lTjhNZDrDdEfFTDr1vcWWDQC6yw=;
 b=C1uNwpcn6DVXbFosicjBeiHqTCuaxM5YkcRemZVJjGjBew1JJzG8e++v3GiVL0w/aA
 ahtMlU/hlI2QoVjuxBfgkhXJdLK37WqRICOwVCpDswK0FpkXfkwHyWzPZH6vfOPoXEIV
 rG0EcH1icZgQ58y/tiIVuPizuk98bXY4VIPqNZWTtGpOf4THJBTfCGnZOYV5+H1a050j
 /vaL3IAcnd62WdSf5ffM8shoQJB8U/w5EbjOh/Crk898A0Fu+XQOW5f8MJ/cmq+cHdju
 btzYuGBUGXdWfeTzWVMEEeAdHlq/3j7gxkPvETF2GxKemR3Rftk6sA3QT4R+FwPbpn9d
 xWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4piOJT33/Ks8zF+9lTjhNZDrDdEfFTDr1vcWWDQC6yw=;
 b=id8gRxflJCZK4vm3ZV+A84FJZcT9SVOshZl4v6zgifKOJ8pEspZtqMw6vDk4isfk+O
 wCoYxZGjYiX4LjH5gsySuIXE+L5MRL3TA+LW21wFYBzWF7yDRC02RSFoQkqRPjfvN/X+
 E+vucfUdm+bpfCXGazG1a6gdgmQsUdIvLSt4Qdd8eY1RGJ6pOlSJq5ZqMMsEU95DQUpj
 /NQosshawqjylamrudCeMbyWBLADUBFJTPaRg5aMOuM5YBlFLpIW2KW9G8jN+HjCvA8C
 Th/jpY5tk57GVn43rT1bd1nrHXn0QfLGdiGf/eVn+2gzZvoxhazKK8q4K2jVLUvRr5CX
 40RA==
X-Gm-Message-State: AOAM5331F778+Lcgv2O0rrQwlC5UVlvd2bRt+gIoUgW2c7eP5Ffvn3/4
 zPYIsNrT0uJ3YPN147Hv/1TPicd3RSw=
X-Google-Smtp-Source: ABdhPJyayt+RE2BbcPL5Qbk+24xYDL0+o4vI1yRNlbnIekYyi/8DMIRymJkUzgSrUkugz/kmdNgxDA==
X-Received: by 2002:a17:902:7292:: with SMTP id
 d18mr9103648pll.137.1595409592826; 
 Wed, 22 Jul 2020 02:19:52 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:19:52 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 31/76] target/riscv: rvv-0.9: floating-point classify
 instructions
Date: Wed, 22 Jul 2020 17:15:54 +0800
Message-Id: <20200722091641.8834-32-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62a.google.com
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
 target/riscv/insn32.decode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 1d34fa647b..7ad936e605 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -532,7 +532,7 @@ vmfgt_vf        011101 . ..... ..... 101 ..... 1010111 @r_vm
 vmfge_vf        011111 . ..... ..... 101 ..... 1010111 @r_vm
 vmford_vv       011010 . ..... ..... 001 ..... 1010111 @r_vm
 vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
-vfclass_v       100011 . ..... 10000 001 ..... 1010111 @r2_vm
+vfclass_v       010011 . ..... 10000 001 ..... 1010111 @r2_vm
 vfmerge_vfm     010111 0 ..... ..... 101 ..... 1010111 @r_vm_0
 vfmv_v_f        010111 1 00000 ..... 101 ..... 1010111 @r2
 vfcvt_xu_f_v    100010 . ..... 00000 001 ..... 1010111 @r2_vm
-- 
2.17.1



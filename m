Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BFCC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F95206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ksTjYxWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F95206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtssB-0001up-Sj
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqdV-0005OM-9l
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:52:09 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:40362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqdT-0006es-Qs
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:52:09 -0400
Received: by mail-pf1-x436.google.com with SMTP id u5so2381475pfn.7
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4piOJT33/Ks8zF+9lTjhNZDrDdEfFTDr1vcWWDQC6yw=;
 b=ksTjYxWdPj1ksMb3WDrIljRPevALRn6DhxvTjc0nHKyRJGMgAkyH+YnCi3vucNCUqr
 nc6iFjvuxpA2AiGa8ni4RI/VIfleJRcorCi60D4aCul08jjaY4anY/76FdY0Gz/++TkW
 uH5oI90akm4hfk2jymSe7YqgIwZhx7hErc3DXFL7ZjraTr59SYLflWxC5qRzEkuH6C0b
 BCi5x4m2AlUt8zSBfcXnoPhcUU4RUXI+p5HvlxdfUmHfYRCFrEOimZoGXgEuq5PjRYUc
 dA6WKcR+sMBMHtt2ylTWcwyDXKoVGgXa5wSIRYm9CNu6iRNRTHIaK9t9xqLwChl63YOP
 F16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4piOJT33/Ks8zF+9lTjhNZDrDdEfFTDr1vcWWDQC6yw=;
 b=fJwuUTkpGpgayeJiJ1gRq/RYrl64DQOgQ+/GNwTjRqnkagJ1uHX3EgMIxfaoP3hc77
 7mhCElZQHnlLn2F7qo80P57ne3S3Io9WHGfn/v3VkGvU36AUf3f34H3sqxOMnlkEt6M5
 v34JXCjgpPQGyNgOEEZ2/+JcITccXlsZ0t3Jc7X2hCquvrL3/w3GY+Hk6+HBveSWV4IK
 VMlfymO9jCKhn+q2cI2sL+bkHuSr/IO/omFI0ZHr6SW+XJKnhyxUV5MdF5/7ao4ABTp9
 NM+ETTjDNbm3/7/KIflldFSPVJH2PytaG/T/uDEgiWhgW55uHvnZLOQrUkwsrQ3Gh3wE
 /LsA==
X-Gm-Message-State: AOAM531F4uNp52bSZIkU5mz1Au+fXURZjgXG9BsDkUYk47CLB8sl9way
 225QK61ibIs8tbv3TUwjxXmuRPCKdf9fWw==
X-Google-Smtp-Source: ABdhPJxUg86F8XFbRrre2d2UX3el93oN91C9dHdbPiUxviEMiCwL3gYCHAsRmtX97j9Q40e2rEkIaA==
X-Received: by 2002:a63:e60b:: with SMTP id g11mr59807259pgh.188.1594378326469; 
 Fri, 10 Jul 2020 03:52:06 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:52:06 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 23/65] target/riscv: rvv-0.9: floating-point classify
 instructions
Date: Fri, 10 Jul 2020 18:48:37 +0800
Message-Id: <20200710104920.13550-24-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:17 -0400
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



Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CE7C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 07:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 106872253D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 07:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6fo/ZFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106872253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuAQL-00077c-6r
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 02:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iuAPX-0006hD-Sg
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 02:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iuAPW-0001Yy-TX
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 02:26:47 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:54959)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ianjiang.ict@gmail.com>)
 id 1iuAPW-0001Ya-Nw
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 02:26:46 -0500
Received: by mail-pj1-x1044.google.com with SMTP id kx11so2721964pjb.4
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 23:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=jP9h02ZX8/5mHKV76tlpPH+xgzQS+hAJgjbV+xIc/n8=;
 b=f6fo/ZFD7/JnZgvR1IosY/u5rpTmzd9k8SwYLBcV5jBXmry/hY3tCUYO4Uh2Vh7XjK
 ClsDqbxGR+RE2tmLqGKIm610i/wW3+Hom2vlO0qWhW64oBSOz/BC+t27T/qxR/R+bliB
 zWUaFopBTAPBZSgkQky2p7mr9DXkFmcHxRzRA8JSsYsbT9LNENKDvmOhcuaA/vTqxT9Q
 t2UV7e6ity3paqEEaJOesCtZvBwmCkmq4yx3V1tFevyY6xefZ0zMu702cXcg0DOTR3pD
 o5zQc7di4YiE3YxBwbx5UmEECMP8GnLu5eFX4MHReq2P1gxikRg6xB1R9DbuxKfYLO7G
 Ac0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=jP9h02ZX8/5mHKV76tlpPH+xgzQS+hAJgjbV+xIc/n8=;
 b=XG3Ui34b24wFSvqRsI1MnVks+LJhCoFI0u0bF5D4qJ6v6pKCec6CgdEEE6ljlP4TpF
 bofnjgS6qDndmAjndHjzabAU7YC3gW7C7VzEssHtPyYaO/Xo16rxRdQoSAam5LIFcwW/
 3WZhPEQCfMiGao63ySQWgnFmD1ZuSeLL0Vl02k8pGeWcSE6iPtGM6wXwbelzFOrmTMNR
 FSST5bDYhzCDT76Svdqs1W+UGWmdNou1pbH2P5m3SGzW8rwmH94XSpeOL2EaXe0FY3CT
 p9bTMf6UjOd3ubz5dRDkgKMIKbKfsRUCwS8vFNeEItX0cWDUNhwtoGqCluLj6qCzFRy+
 hYng==
X-Gm-Message-State: APjAAAVBR2kPdYPrjmc+v1A6xgVwZ/Jl1V6BzjJ9wo3CJC1FC7CwMsVU
 tDaFBORnKOS7WU401u75jHNq8KrEo8wwyw==
X-Google-Smtp-Source: APXvYqw8BK6I/lFYXHnHIdTWVS2TcK7Eu0ZRXKJ4UKESi6lM+aqkIF0CG4w9LEQePxXO3i49PjPGDg==
X-Received: by 2002:a17:90a:a88d:: with SMTP id
 h13mr1528333pjq.48.1579678005546; 
 Tue, 21 Jan 2020 23:26:45 -0800 (PST)
Received: from localhost.localdomain ([111.196.189.80])
 by smtp.googlemail.com with ESMTPSA id
 x21sm45374895pfn.164.2020.01.21.23.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 23:26:45 -0800 (PST)
From: Ian Jiang <ianjiang.ict@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] riscv: Format Rd of FMV.W.X with NoN-boxing
Date: Wed, 22 Jan 2020 15:24:48 +0800
Message-Id: <20200122072448.18510-1-ianjiang.ict@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: Alistair.Francis@wdc.com, palmer@dabbelt.com,
 Ian Jiang <ianjiang.ict@gmail.com>, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For FMV.W.X that moves the lower 32 bits of an integer register to a
floating-point register, Rd should encoded with NoN-boxing scheme.
Note: This applies to RV64 only.

Signed-off-by: Ian Jiang <ianjiang.ict@gmail.com>
---
 target/riscv/insn_trans/trans_rvf.inc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index 172dbfa919..62b7a36567 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -368,6 +368,7 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a)
 
 #if defined(TARGET_RISCV64)
     tcg_gen_mov_i64(cpu_fpr[a->rd], t0);
+    tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd], 0xffffffff00000000ULL);
 #else
     tcg_gen_extu_i32_i64(cpu_fpr[a->rd], t0);
 #endif
-- 
2.17.1



Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA288C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:50:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F07A20674
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YP2LQNXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F07A20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBOL-0004on-Nn
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAx1-0006nq-OP
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:22:11 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:38097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAww-00069K-Ir
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:22:11 -0400
Received: by mail-pl1-x62a.google.com with SMTP id m16so655703pls.5
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Yqh7XLC8qZitr5dXFkR4oqQGB5Ty6ak6uA+SOmZyzxk=;
 b=YP2LQNXwRgt0sOCvcjMzXtBDgHa14zZEu/JJRVNoQ8/+FD9VdyQqexnh2DdgQk6s/s
 bBMvcEZPOuuJg6Z/WwbA4HmRruZZBDOZCX8L+PrwkSyZ+pPi25cBWujADLt/WqZmsnqz
 Irb7B4Bn4WqLeoKn0P6DjaNMs2w5NPGexWAv1QyYwtZINnKpqVaYQXuxr2JqUzB32xRo
 wHcvWE0QRPiV15gvesp8snok/jL4h8GT7VS5ooMbWhG3YdXbmddFD6Y0H7ZdgAt3pW6M
 QMANv0lCAWtgENBU46/5aMnv4iWsq9Y+6Tt5YzfW0FOALSsATe9M0JmIYPglD2yP1Vqg
 iE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Yqh7XLC8qZitr5dXFkR4oqQGB5Ty6ak6uA+SOmZyzxk=;
 b=WThJDZi1/f59ZNEEcFkpQZKSp/KsQ0J1Bfi4FpvwSS6YEQZWDRSGq77U9FyhSfjuiW
 1zm9j3LydklNxB9pS9Et1gO9zfgUjawDCYE3+17dqzEoPFc7Oy/DEAL441uKfI+zlnqv
 TK5axsagO6/CgJYJKtQ5XQz3L1EONAhVqxn0U4/c4aqNTqdbAVcQD7b0k/RLsf1UyEPN
 XuBGkogC/cmR203+N9xyRPuodhMp5zSB6Y3Z2P5l9pJ6AzXoJVZ4k8MF22kB5D9P7q1m
 VxIWDHDHHhQqR4+vc1B1824gM7Ur+6w/qqJyyvYZPFCc06z/c1qLINpdLgYvrCeQY8K5
 ay6A==
X-Gm-Message-State: AOAM533FJv0nkXQyxkhwGgwSXGDNMjzUrvigTz6yD0FdXKY4jy9oTxWG
 Md7UdSA2SSTFlzvFfDQmKGVGUoG9EXM=
X-Google-Smtp-Source: ABdhPJxRvvKUmKlK8o7ObgdpXl+M5pVj9bwF4+FkYF50C3UDR0MlTbF9gONG4qQaChzK3dbFxAI2ag==
X-Received: by 2002:a17:90a:dd44:: with SMTP id
 u4mr8419692pjv.203.1595409725092; 
 Wed, 22 Jul 2020 02:22:05 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:22:04 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 64/76] target/riscv: rvv-0.9: single-width scaling shift
 instructions
Date: Wed, 22 Jul 2020 17:16:27 +0800
Message-Id: <20200722091641.8834-65-frank.chang@sifive.com>
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Zero-extend vssra.vi immediate value.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 10d8b8b00d..fb8478a456 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2406,7 +2406,7 @@ GEN_OPIVV_TRANS(vssra_vv, opivv_check)
 GEN_OPIVX_TRANS(vssrl_vx,  opivx_check)
 GEN_OPIVX_TRANS(vssra_vx,  opivx_check)
 GEN_OPIVI_TRANS(vssrl_vi, IMM_ZX, vssrl_vx, opivx_check)
-GEN_OPIVI_TRANS(vssra_vi, IMM_SX, vssra_vx, opivx_check)
+GEN_OPIVI_TRANS(vssra_vi, IMM_ZX, vssra_vx, opivx_check)
 
 /* Vector Narrowing Fixed-Point Clip Instructions */
 GEN_OPIWV_NARROW_TRANS(vnclipu_wv)
-- 
2.17.1



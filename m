Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13604C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7CC522D0B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="R6du+1Dc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CC522D0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dbo-0003n7-78
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dRs-0002jr-IK
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:36 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:37214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dRr-0007sF-1z
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:36 -0400
Received: by mail-pf1-x429.google.com with SMTP id s26so24714720pfm.4
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fGmZi4G6G8HBm6kSF0AhkPZa7UesVkFkZsuvcd4O+2c=;
 b=R6du+1DcDEU9q9Jf4F1QYzrnwFdudp1yW+7VoColi7zvPA59WzLSmiK75KQpExyWq3
 6RZqhL49s9j7qsT7OM/dkLgPsz0cO/WfWs+0zWfoKmnq16A0k76wdFTL7pUWBApxuQxY
 krcVRaFlNnzszC4DbTYP84tH6jkh2IK+M5WDsn+xjto/RWUrVk6lvhxcrAKNjGiNXNlI
 GKIj8062kQfbNQx9jplX/RXzFOTGEEyP1MFENteo++uof1NExHk/hxTC8XeeY30I8g0t
 Afkq4ao04vvoy3YjhM+9QLDtKl+I8P/44q3E1O3/V/Ka7djoXLJ9U8+orhlSepYTeO70
 uJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fGmZi4G6G8HBm6kSF0AhkPZa7UesVkFkZsuvcd4O+2c=;
 b=g1AzlFcnoVbCcZTiCL9b1sbm9ukLm3yx/kIcnOeWKutFYeHf6jHUfVjp+zT8EKxr8E
 fmEWM+nqpMrNsmrLh3G6jkCA4A7nVVGEEAvEHuloHTH8bxqRFjAZBIbK0MsJNicmVitB
 86BB0F1K0USDxQrums6f+8vHQad3Msr1Iq5BfM+qXVQtVAKaLo8rz2EbwDUvdJuMel/A
 LXyuQT9VCX1xd1b1aAz4O1kytiSoHnn8ZWkc4qq4tANeAP2Q2HCVHgmS4DecyYi+B7dU
 fwf7CSsg8QiisWYLld6i7nSLqfJD8DGNRwNhyOs2VDQZ8TMp5Bkk7OGajMJsppjep68L
 VLlw==
X-Gm-Message-State: AOAM531ISGNSfbb+zdGoWcxOmhDf3+SONbtkyJZWPgjbidTip/oa9E9y
 yRVPAk5/YbEbyhdT6mejsSxE9nWu5i0=
X-Google-Smtp-Source: ABdhPJyHub4FH4VlmHxGOsZRReb6OeUHPTUSIJgyxSf1cgG91ZvKqUHD0KCU8+22OizWLqKGF9h0PQ==
X-Received: by 2002:a65:43c9:: with SMTP id n9mr6578329pgp.452.1596710913213; 
 Thu, 06 Aug 2020 03:48:33 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:48:32 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 29/71] target/riscv: rvv-1.0: floating-point classify
 instructions
Date: Thu,  6 Aug 2020 18:46:26 +0800
Message-Id: <20200806104709.13235-30-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x429.google.com
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
index f142aa5d073..a800c989050 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -550,7 +550,7 @@ vmfgt_vf        011101 . ..... ..... 101 ..... 1010111 @r_vm
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



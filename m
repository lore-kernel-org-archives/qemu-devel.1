Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1150C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B01920829
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AUasqCyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B01920829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7b7j-0007NL-H7
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7asG-0001UZ-7d
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:12 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:43178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7asE-0005Ca-7w
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:11 -0400
Received: by mail-pl1-x62d.google.com with SMTP id t10so7157155plz.10
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/QB6MM6my3+zghgo3JxQFAhPc1E5NUjOg7eIVy9GGiM=;
 b=AUasqCyMHH/quxy2GkiAZpoXVLxNbf0Ciw+/mSYgHnuqB9+vzI8vR0c0KEwl0MjKE6
 +6EDc8xhEoACAsKhiZQjnuaDLyaS3fQ/8fdAwt3XkUoPOGvRslkkDj6frjdshBF7NXTJ
 IskfGsVTtM+QFUQHmECrn/YfiDU/NIRhahUz9+BqIACgZb9uGOIBjWx2q6eFU6Pue0/W
 rIQuA1mwaAwkrBLtBHdGUxR1cKtpSfC7J90Z7mgkig6pdIE4DH7Yp1SK8OP02b9NAb+z
 4iaJxwbIga/HRoTP+WD1XMiXVBWwppRISy+V6xGAxpEbqdqhS48cfvUZDSRm9d2TzXuL
 49Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/QB6MM6my3+zghgo3JxQFAhPc1E5NUjOg7eIVy9GGiM=;
 b=l/PDcbhboWBDw9D8GeiR8LTlwK3RhSVkC91gKqZhH6gJXj0AZAbvd5OCiYGoKeLoco
 JYH0fGQWuhGzmxzKkyfeZypvw3k+M7n1u4+NiFKHKE2t0MTy8iBM5xLB1Fv8fzLBlDms
 tlrE/kcuYoBMZD1CxW7wGGFU3cikGhaWR0BjqojZsOktGKu6YdckVZIPGWi9IEWxiVAR
 1BOwyqHeRK2RkGvNG9vXACw8b3MmPeZOrA/20VQW/8HSe2TjeskPdzf2HKCrUDDKezCm
 kpLTxO1otN95AjDpjpDVx7yCJ4jhc3dwKtTMjVRs6k9vv73YNIBhdNFFv4eP9qRyfU3I
 7arA==
X-Gm-Message-State: AOAM530vvJMHR5s9sjjLBOkLVGY8WPo8szykoyrcFSw02Fo+Q80LS192
 roRHiSfYNaWXJi4097Xm/PCDhRp50SG54A==
X-Google-Smtp-Source: ABdhPJyl4SSmCNGtZQ14VRWLhDGfJ3EW2FiZTQKQPA9K5cvLhs0oCYth8CjuCtpUQw+MOkDI8b4Y2w==
X-Received: by 2002:a17:902:ac87:: with SMTP id
 h7mr10721972plr.238.1597654328847; 
 Mon, 17 Aug 2020 01:52:08 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:52:08 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 44/70] target/riscv: rvv-1.0: widening integer multiply-add
 instructions
Date: Mon, 17 Aug 2020 16:49:29 +0800
Message-Id: <20200817084955.28793-45-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62d.google.com
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
 target/riscv/insn32.decode | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index c4fe9767585..2e305d492d8 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -438,9 +438,9 @@ vwmaccu_vv      111100 . ..... ..... 010 ..... 1010111 @r_vm
 vwmaccu_vx      111100 . ..... ..... 110 ..... 1010111 @r_vm
 vwmacc_vv       111101 . ..... ..... 010 ..... 1010111 @r_vm
 vwmacc_vx       111101 . ..... ..... 110 ..... 1010111 @r_vm
-vwmaccsu_vv     111110 . ..... ..... 010 ..... 1010111 @r_vm
-vwmaccsu_vx     111110 . ..... ..... 110 ..... 1010111 @r_vm
-vwmaccus_vx     111111 . ..... ..... 110 ..... 1010111 @r_vm
+vwmaccsu_vv     111111 . ..... ..... 010 ..... 1010111 @r_vm
+vwmaccsu_vx     111111 . ..... ..... 110 ..... 1010111 @r_vm
+vwmaccus_vx     111110 . ..... ..... 110 ..... 1010111 @r_vm
 vmv_v_v         010111 1 00000 ..... 000 ..... 1010111 @r2
 vmv_v_x         010111 1 00000 ..... 100 ..... 1010111 @r2
 vmv_v_i         010111 1 00000 ..... 011 ..... 1010111 @r2
-- 
2.17.1



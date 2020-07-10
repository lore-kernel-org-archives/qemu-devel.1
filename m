Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDCFC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D4A20772
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZN3n2MiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D4A20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsfS-0002b4-4h
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqeO-0005i6-IW
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:53:04 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:33041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqeL-0006o9-LQ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:53:04 -0400
Received: by mail-pg1-x536.google.com with SMTP id o13so2388775pgf.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=V77vPoxF5wHJpkr1vzvCn6SW3F0N4bm+U02KvfCaIVI=;
 b=ZN3n2MiIsrq2WKB/kZQwU6uZ48ML4UPuftw4uG+h7nxnkBmiACIQ8m6kCMJNhW44hK
 KRxTzK1rMLvVsnRCR7nmVqluXt2k26dvvmnZ83aq87+QYWyCSzLsEtKzuSQfzBWYls7x
 UueDoUh4t72U+sKTHZyNDTM8t1TK9jkEOqcxRXusclZjq0cOeRUYEYAkK6BQ9dWETdPB
 xYQVcwHQlaTjsvfKUM4glJ3zYOmq/2Ou2fXzvnYrXbeRLcCkZUK6sWJtm8x56B8mW9mC
 Zml7eBu00q9J9ymiyI6ejLt1eXMtLvNGil6siFlRIoaQGo0mxjx+u8kwKV07GQEcmSe+
 PY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=V77vPoxF5wHJpkr1vzvCn6SW3F0N4bm+U02KvfCaIVI=;
 b=OpUPCASlfQA5AkhItW65ibJi5JnYU1E2z3BcXdaFfXYEHWD8o9VLtben8EwAe+XQ8d
 y9FYXN0yD44OT5urO8bODtD+cDw2Er35HWfIVzNqOg7soST4eph9yW6kxq39FR13dGnK
 +IHS3PFUVxtxoIPrC9aWsCpCUaut+CnzA6cy4MOOjanbOxVlYREqk6xQ5AvolfK0Rg0v
 VstpmsuhU/BJzzB6DJr+3qhcyZkd26zm7Ze3Rrb1kzWhZ8Ohf1nr0UpcFzI+nHOsdKLf
 oFjrTXw/OOXdSJy0YanDkiydNozOoIddtqFIJns9BqYLVJ4JK/rtYk8RwoLpNAm/iso3
 VMvQ==
X-Gm-Message-State: AOAM531YTx68g8jdTRT7lIEpi9Ldhwt682qlL4UkK3GLfAkSV+wWzmKv
 SHFpy6iayDZxaNCtyOkcTnlnucIHWwT2NQ==
X-Google-Smtp-Source: ABdhPJwVW9LsPG2L47xzLT3c1ypXUUo85tqOwTPZgjv7BYHb+jSpwgBtAwa0nh+qb7R304qhSsNbEQ==
X-Received: by 2002:a62:3814:: with SMTP id f20mr62652011pfa.278.1594378378755; 
 Fri, 10 Jul 2020 03:52:58 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:52:58 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 36/65] target/riscv: rvv-0.9: widening integer multiply-add
 instructions
Date: Fri, 10 Jul 2020 18:48:50 +0800
Message-Id: <20200710104920.13550-37-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x536.google.com
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
 target/riscv/insn32.decode | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index bc6c788edf..c6a7145aa5 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -420,9 +420,9 @@ vwmaccu_vv      111100 . ..... ..... 010 ..... 1010111 @r_vm
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



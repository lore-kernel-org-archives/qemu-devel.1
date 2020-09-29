Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAA8C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D87B42083B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="G/uPhAfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87B42083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLW8-0003tH-U4
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKyn-0006jw-MV
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:08:01 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:42880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKyl-0002L7-JA
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:08:01 -0400
Received: by mail-pf1-x42c.google.com with SMTP id d6so5520528pfn.9
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dKXFHFiIXP9JYtyVSpnpgKdh+GGJff1eG/Jdv4eJQdA=;
 b=G/uPhAfrEjiQeaFt8vphLIpubrGPlS3A4DdD5YHgYNtpSen2bEmEZfBepL65M4ImBJ
 7L6cLBLXgl2/PbGvkY17ERJseqRUAg0ZTvSP8qIadK6+enFjWqhOcAYgPyF3wiujuoNp
 Go0bdg77LQMRS8Ss6Z+JNZ644DuT+nBYiWb+ds+BcxS98FeJ2Vs38s2kZ6A/Lk+uw/2j
 NkwKoz6u8LZElj3ID5fbJNwYsdsgQ8wbzanWToUCslI/22J4UUbIWrR+YKWFEoN9QEzG
 sKmCtCQwxe0qBrH1CjhYSB0s8UcTHAOQuJMxJnWcoo3MDArP/keT7UJW31Vi1ZBZ3YNs
 GcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dKXFHFiIXP9JYtyVSpnpgKdh+GGJff1eG/Jdv4eJQdA=;
 b=ORj/mTqCU+cknW1ACNww+siWBg13Pk52KhRkafQ+LsEArCH7DxvswVOwOHxv0xllJ2
 3ZmtbF4gSVxcAoB5/ZUu74TwfskmEFn/338OPDJ26Aol86dwolIzwRYIJPtnwlRCSr9C
 WKUsvd/r1SH7JZ5agZlvcrpwOVgPf1Ppb3pAW3fNY8dpTPoGBAOlsGvocTeB9isH1z72
 s4bQB+hvw3TnhCMjODas/khBNyrLqkA+Oj4BokC0Gvo1a1QYJlpxyx3Vwx3BNTwl0qpY
 C1fPD7Khlde6/3DKnd4Y+XRO5k1czstNtM1DXayqrLWbt7orwhlh1TGOjeP6lr5wqv20
 8Dig==
X-Gm-Message-State: AOAM530/L4LZvpgR+/4rd59JNckk4mll0C16CTUolDlkZAKLS4J5S2Jb
 6Yg1Ag+WNH4py0UZAoMXEryDMTUhvkYryQ==
X-Google-Smtp-Source: ABdhPJw3xaPyYcZqyFLOhPzrQGkTFiQZCIHD93fsd/i+B4aQHPXGiLbHVY6HzYwATgZAoe3z95p1aA==
X-Received: by 2002:aa7:8a46:0:b029:142:2501:398a with SMTP id
 n6-20020aa78a460000b02901422501398amr5252752pfa.79.1601406478028; 
 Tue, 29 Sep 2020 12:07:58 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:07:57 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 45/68] target/riscv: rvv-1.0: single-width saturating add and
 subtract instructions
Date: Wed, 30 Sep 2020 03:04:20 +0800
Message-Id: <20200929190448.31116-46-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42c.google.com
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

Sign-extend vsaddu.vi immediate value.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 746db60337..16f051a8d7 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2249,7 +2249,7 @@ GEN_OPIVX_TRANS(vsaddu_vx,  opivx_check)
 GEN_OPIVX_TRANS(vsadd_vx,  opivx_check)
 GEN_OPIVX_TRANS(vssubu_vx,  opivx_check)
 GEN_OPIVX_TRANS(vssub_vx,  opivx_check)
-GEN_OPIVI_TRANS(vsaddu_vi, IMM_ZX, vsaddu_vx, opivx_check)
+GEN_OPIVI_TRANS(vsaddu_vi, IMM_SX, vsaddu_vx, opivx_check)
 GEN_OPIVI_TRANS(vsadd_vi, IMM_SX, vsadd_vx, opivx_check)
 
 /* Vector Single-Width Averaging Add and Subtract */
-- 
2.17.1



Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1D7C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:07:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E21F222D0B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hIqzOksJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21F222D0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dZv-0000NG-JP
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dRp-0002gN-Gu
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:33 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030]:50784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dRo-0007rx-3B
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:33 -0400
Received: by mail-pj1-x1030.google.com with SMTP id e4so6461709pjd.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fR4JpsXJUuT5lJNobC6iQBq0EFUGSIwBclP3cnYK+Jo=;
 b=hIqzOksJkAKffpftrP2k1yMu0k5UaCvMrho+0eVcPut+IRsGq4xWUV+W2/6u3AAXsd
 pwnuvO1XugCLOMhr3n8r2+A8We4fK2Xe56pPaJA1FnlMuLvJ/7B0+7k/VvCTHQxNqKPR
 3ijBATdcdFfANrGPEaPhn/8ddv6bIXppgOF8t3rLdTFr8CCKH7FEEwt5RMkm7Xyi9ca2
 x+rf000F5oHVpkuz6NDUFFkiuP5dcjoRGvH5QDasXCE6IN9KfaZnwEHwdScpUiTFJGEG
 JJogtZdFQfhwDjVh1M1RdCZ/+tejr8byDdw/4LrJh7wGUZfTSEyO6KwSz1Wr1W0w/TpW
 Kw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fR4JpsXJUuT5lJNobC6iQBq0EFUGSIwBclP3cnYK+Jo=;
 b=UW6lT4zypeauvFld18SoBRCzoonoNJKArW2bG3fPVQKt/M/r9SGV3jGKPZjiCfVruI
 wvxX722NTzu4/8dNQIJFS+aKpfHu25svGLuySzLFkpDHsEJV/EZJOAjVssAzRGYat8Ip
 OH0Lkq3tmKx5zJ4SO0zdwguxeJZpb4fc/+N8BQQtd0LOax77bRlt6AK9/QZzv4Aq8nP0
 ZbkEfWvS0bOCf/RDgA+EcsNTcQRlELooTYLPYci8ykC8fjFTaNpKn30JvcGEgbhyw8rT
 D7Qc9ArCikxr19BUR9hw5shGLXB1DJOl4iVISU5DO1RQAnxek0smgWnUWTkbxSCU3Was
 4uiA==
X-Gm-Message-State: AOAM5315muq6b65J69CSCnRTD5u4Inq+U49MQ6Blz1yqzTv1OmEx2fce
 /TNSIgnG/Ez62Q4zGBa3ERrgM2JvS8E=
X-Google-Smtp-Source: ABdhPJy4lCpitlQqAlmK+zbQCX+WjIuXjMSS6enJ0MuGJ7A59MAotsk9kDlIqvf+eMeriwKb6upOMw==
X-Received: by 2002:a17:902:8c8a:: with SMTP id
 t10mr7178377plo.112.1596710910735; 
 Thu, 06 Aug 2020 03:48:30 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:48:30 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 28/71] target/riscv: rvv-1.0: floating-point square-root
 instruction
Date: Thu,  6 Aug 2020 18:46:25 +0800
Message-Id: <20200806104709.13235-29-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1030.google.com
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



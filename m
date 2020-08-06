Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC08BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B801622CF7
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="buYQOliX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B801622CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dvB-00005O-3Y
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSX-0003bQ-0u
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:17 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:33278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSV-0007yZ-IN
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:16 -0400
Received: by mail-pf1-x42a.google.com with SMTP id u20so2765295pfn.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/QB6MM6my3+zghgo3JxQFAhPc1E5NUjOg7eIVy9GGiM=;
 b=buYQOliX+mE+WL5ac2AeYndKjWKSCZ9sMPxk7f9R0GHBaTo/PUx+TxNKsw1Uh0IZmi
 34thI0fv7VqwV01mx9VIMpBhwYGx5ehO2W8DT8i/WL4jNVvfEaFdHaILUmkFjfUE6WlV
 tSYt6kRgS9e79HlEJ4i6MkCK+/G8fmEjH75w1biyzQ75CqJixdJ5uO1JjJ40eBbNmm/9
 WUAE2tprlJrR3e5JyXGgbeZBKHjP9UkPxyHv5+Z09V67Efem0Naqbj6HqsOwAOKEFTUl
 Zz1KVccdolOhcAjHADGCFLlTIYegVSxWrMa31vZicHxNdOUHigna93oRAa7l8wMEkEuk
 +OeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/QB6MM6my3+zghgo3JxQFAhPc1E5NUjOg7eIVy9GGiM=;
 b=VRa7HegFA2JjU/cwpxncXo89POcM4Wvp4b16cAE7VjhL283++XQqCcx+p4i0VSjwyk
 hQchFgSR9ntcELbciti3ZqAK9mu6EPt0XwvUVTbq1zEuEKdoUMsxQ+LHdhPJBElVjUNa
 wW+kIxRYhrYE4oOx9dDf1zJGpfPBJ+iqUlNLnwbBPYp/iqthVHb5+o4q9XhSndk6I3Ob
 yFII0+Nq5zHjHmZm1KQh7tZ2OXZdMT7Aqqdi+GVZZpinDkkjtH9ihNRk2HOjlfR58C7g
 w/8wezZfuEEKFFqKn7o3mNTvBK5h5NCrcoZDS7wCxC7KS3AZ+bBEQS1T4lKcePxdlYUc
 MsQg==
X-Gm-Message-State: AOAM533qzAbjgti4FDj9IWcwwUhwAqE6DNMpz+MWyl+BPpoUDwEHJDIl
 4xZn+VBbisb/GCr7RPnpcYqR639uYgI=
X-Google-Smtp-Source: ABdhPJzYjXAy+6IuWMEODwoxK+naZW3j85ipztrpPH+/lQkK71rNhRE0ZqweZylkLWezS7c3NAKUTg==
X-Received: by 2002:aa7:9a5b:: with SMTP id x27mr7453062pfj.15.1596710954111; 
 Thu, 06 Aug 2020 03:49:14 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:49:13 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 46/71] target/riscv: rvv-1.0: widening integer multiply-add
 instructions
Date: Thu,  6 Aug 2020 18:46:43 +0800
Message-Id: <20200806104709.13235-47-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42a.google.com
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



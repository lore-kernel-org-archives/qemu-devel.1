Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223F9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E95B1221E5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QOucNCXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95B1221E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dg8-0002XQ-7I
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dS5-00035U-CM
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:49 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:33242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dS2-0007uU-GS
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:49 -0400
Received: by mail-pg1-x535.google.com with SMTP id o13so26507220pgf.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5gJQpQuBdx5+IRqoLCBuH1Sdjx31gU5U1EvDuXvWhTM=;
 b=QOucNCXwwKUzLCXKpxaitn4EBvdRjp2gLHEooPPMC7hg8Zuo3bp5JpHHxpweFfLMXt
 9S1kmGltJFpF2+WtC384QkbptRAoAdEbQPK0+FNXZK1GA5puK4gFZRy3v0U9/NskpIfC
 NPI26C7EWLM/1FxeOPtUIfyoZeyjyw5XABT9HfhDrdwirwo76VYoBXdqeA8nnCCRsNfi
 KJ4xwKRirAnzviI9jIwAHLoBJQDwNbRA6Wu7x6toVB3zTBk2r2Rk8kqAYH1z0r9iiJDd
 r/LIlMBD525BiV/oKEsi+bKz1oQWSzsQsslSwMq4tUeIX5R32Uxg7rpzIbt68GQhCvwQ
 ENGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5gJQpQuBdx5+IRqoLCBuH1Sdjx31gU5U1EvDuXvWhTM=;
 b=Lx57+YZNmUGO6kBEQYtf5W5YlnLbkGtevcrh6oC8yDJ6HD0bbY0zlzVDS3UZN/1TjR
 a/Sm6rVjyNy4zo5QOQxxXoBb/bvRqq5Vaug73I/0C5T7VjL4TahjluaB1NUFNTNrMo5T
 UaeiYzVDW4MYauDqtuJADXWQTeqN/hKtvLU1ZHLp+1TLa31OWx6DytraoNKbTSsJdNMI
 iEHRTOROMMlpUtGK146ZnjWlOmR+kQbCtOZ5fGXtAqVYde9oy8zJfumPAioW73UBr2BK
 tnWDBt63XSA+WW368ztRtTQHLVyeX8lOlkSHsTdOEeN30+PkbywtTVsN1ps8mL8Om+YJ
 8/HQ==
X-Gm-Message-State: AOAM532Vu0buEN2IYcW/ryVpile/182pwmACZ/axBYyeERgxVOf8CRvL
 TFKNM/9WUeql6W/4GZa9i/rNR9AkhX0=
X-Google-Smtp-Source: ABdhPJyCo91lh0lVCmuZ/W0oq7q30sll9g0wg8XduOEGKVsHj4xGDVtu5cLMlledjM/rJsQGLwunHg==
X-Received: by 2002:aa7:80d6:: with SMTP id a22mr4094761pfn.275.1596710925062; 
 Thu, 06 Aug 2020 03:48:45 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:48:44 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 34/71] target/riscv: rvv-1.0: element index instruction
Date: Thu,  6 Aug 2020 18:46:31 +0800
Message-Id: <20200806104709.13235-35-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x535.google.com
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
index 7a10fc27c5f..15afc469cb0 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -597,7 +597,7 @@ vmsbf_m         010100 . ..... 00001 010 ..... 1010111 @r2_vm
 vmsif_m         010100 . ..... 00011 010 ..... 1010111 @r2_vm
 vmsof_m         010100 . ..... 00010 010 ..... 1010111 @r2_vm
 viota_m         010100 . ..... 10000 010 ..... 1010111 @r2_vm
-vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
+vid_v           010100 . 00000 10001 010 ..... 1010111 @r1_vm
 vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
 vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
 vfmv_f_s        001100 1 ..... 00000 001 ..... 1010111 @r2rd
-- 
2.17.1



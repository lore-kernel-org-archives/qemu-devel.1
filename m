Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592EFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3AA22D05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CgHmZ4C7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3AA22D05
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dpe-0005mh-I3
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dS2-0002yB-G0
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:46 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:39378)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dS0-0007u1-2j
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:46 -0400
Received: by mail-pf1-x42e.google.com with SMTP id z188so16875001pfc.6
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=99inUY6TcXre93Q9sK2twtbOOBRR6deMTZ0PhPm0qww=;
 b=CgHmZ4C7YjHiUolO2acSRX64EUMGTuX33DoYRLIOHpmC9DZxHLRGGFBeNPj6jJwG5+
 BzqPWyTWopsyKFDU4Shocpbx9HUvBO8E4zhpaJoVB5i2w7iTcmtTdF/9QQWWP1G3gwc9
 DquaIoC1NC0PgC+3PHByUlYnz2pqzc4UhDY6hobRu2xpdv0iKJzWgsxBMOQbViM0221b
 n4KzSV257uRhdCPxaIRT15iSXC9tjPWtQjK3Wel8r2IeByTkPeUBWlSBoOQx+pAa/ABO
 fWB5q4SCZTHNHl4bO3Ic7GK7WBXAaJXre+RW2gCATitwvcrwij3drDJsjBU8JAkpLU5N
 vdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=99inUY6TcXre93Q9sK2twtbOOBRR6deMTZ0PhPm0qww=;
 b=tcAmch2P60Eqmo6LejRosSezVji6l6RqkELznsnvO9R5GmJDuMP3KBGXdQr0Sa8pb/
 I3KR2GRVL3w23WvZZZYFHQWMhiicYK8JNxEcPvK4qyeQzuWl7qbmBwJuKavXBldQor7i
 +drRJyPNlahuPvkB1ciWh0E/rUbf09AGAwhDgsheAwCEboujucmP1/unMuvZX2ahNR4u
 Jo5GIKaz3yDbHRsr9444lmQSQ9R3HNFnHhk8TVOeDLHe3d6nVhf2zJx76qQwr6WhtOjm
 plA59gPETAjzTsVEGwnaqs+3o5RV3sikfUDg47fgbZZrVDbqYCgsXuF9z7Q+yzkfcCUN
 N8ig==
X-Gm-Message-State: AOAM533QcVCHSuZOqbeKb1RQesS33cut7Zi7KCfyRd9RWJZxwDb+o0Si
 FK5p7iv7ZQwq59WYsbD0vm3Aip7rlM8=
X-Google-Smtp-Source: ABdhPJz+Jjzj93HVfugF2wi5Kxnuk6zCjLnxm00J2LMNF22aJeyTIW6FSLAuC/WWCJUV3W7iLOS9bQ==
X-Received: by 2002:a62:1b4a:: with SMTP id b71mr3203100pfb.106.1596710922625; 
 Thu, 06 Aug 2020 03:48:42 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:48:42 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 33/71] target/riscv: rvv-1.0: iota instruction
Date: Thu,  6 Aug 2020 18:46:30 +0800
Message-Id: <20200806104709.13235-34-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42e.google.com
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
index 0992d6ac86d..7a10fc27c5f 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -596,7 +596,7 @@ vfirst_m        010000 . ..... 10001 010 ..... 1010111 @r2_vm
 vmsbf_m         010100 . ..... 00001 010 ..... 1010111 @r2_vm
 vmsif_m         010100 . ..... 00011 010 ..... 1010111 @r2_vm
 vmsof_m         010100 . ..... 00010 010 ..... 1010111 @r2_vm
-viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
+viota_m         010100 . ..... 10000 010 ..... 1010111 @r2_vm
 vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
 vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
 vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
-- 
2.17.1



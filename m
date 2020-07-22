Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3846BC433F7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF712077D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="G2rnH8m0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF712077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBDH-0007ZA-7S
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAum-0001wh-MV
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:52 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:41161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAuk-0005cw-FD
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:52 -0400
Received: by mail-pf1-x42d.google.com with SMTP id w126so698958pfw.8
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mGnKSMkKMtsxEVb7JFS0nY27EekRK3d4wsP51kVAl90=;
 b=G2rnH8m0AcSmUyCzxoci1Tb8SPSeg7DaQt1+GjXsxVSWHC6VQpliA7g9BUJx/G4DAF
 Zuu0RHRHJSjwaaLIrZMePpb+Xm7eacRRkmSgBTGOAW9mliw+JGs7GfyUdw5JDWy0BIXz
 1W1qzDYJYrKpxgLpIvNPTz/sCxzOn0R0hYU/EkMlOkdDGhLeC0Qc7a3NWyXLvkMVpY4z
 WhxRcc3XKmjaC4ddFm6Mbqg1RTym8n5nuSjRvTriT8pfQO4olCmQgYkEuh9XImx5yjbG
 TkR+czYEMVWc3MFwbrz9bv26tWnAPRzNuN7nerDdvbsiNVrWR5kHCurNl6YRSWweHl2n
 hCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mGnKSMkKMtsxEVb7JFS0nY27EekRK3d4wsP51kVAl90=;
 b=oeAcmmdqNFSOzNcOG3WZtYQ9orHz4j+LfDOtn142V+2RR7gK51OdIyhZ+AGZXECHEY
 uGYSLkBA1T+mXJrkc8zTElyNHdXSfmdo2AXAB8sbxh26n+nYl1NRw6l0nifzxroCTXNp
 fEybFZrsaIU9TacNbup0oOJZkONMFqYYqAGRWlhGtmQAQuKNKhrUrnXY437CXQIWisPX
 62J3GRdGRcAmPZatalw/x/SeLaNvqRTs3G45+ptKW069fI64QeW2m0m0QFFwtYBrLecI
 HAac1WLAwsGFECsoKMTI7ublOrxbxZe8BJ0pw4cmkxV/pzvY5RvCyl04P/y+XFKHizKR
 5pag==
X-Gm-Message-State: AOAM5322Tc7t7/sfEIJmJkg5YG5svkATYX9Iopow2Go8ol1sYUDG8v/b
 c9caZzcYp2crXhR2bP6dpJNqTnQvmrY=
X-Google-Smtp-Source: ABdhPJwz2PRLy0ePfNpOkFksGcSj8T/7V+MLLru1WyUGDnZI77BQz4NmqlTPe/V6jJdT7dyWfHvPhg==
X-Received: by 2002:a62:fc53:: with SMTP id e80mr26746292pfh.129.1595409589088; 
 Wed, 22 Jul 2020 02:19:49 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:19:48 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 30/76] target/riscv: rvv-0.9: floating-point square-root
 instruction
Date: Wed, 22 Jul 2020 17:15:53 +0800
Message-Id: <20200722091641.8834-31-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42d.google.com
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
---
 target/riscv/insn32.decode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index e3f0fba912..1d34fa647b 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -509,7 +509,7 @@ vfwmsac_vv      111110 . ..... ..... 001 ..... 1010111 @r_vm
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



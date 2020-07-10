Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FEEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DC2C206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Zuf+vGmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC2C206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsqa-00070j-Fc
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqdS-0005NU-Ie
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:52:06 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:33673)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqdQ-0006eI-IE
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:52:06 -0400
Received: by mail-pl1-x62e.google.com with SMTP id 72so2112944ple.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mGnKSMkKMtsxEVb7JFS0nY27EekRK3d4wsP51kVAl90=;
 b=Zuf+vGmqjzcAJJn8IEs0hWUiO+M0vI+4INjHzDDG5u69S//0fx/ZqKsTOVsXWd/yPi
 ii+95JFuylF0GzdKwNom5gSf19r9b9sWofO7tZWBuOIWlG1/TEGK3zbIH5SyesySgAaE
 jkWABx3hXsHHSbU+ZozSqoVf2tmReRggfwyVGs5q8bu845I1na4geA0FyQGwNuW1y72w
 Smus/PKprmdsD/01NgfzJo+hgKzgf1GyxWQCiBAkT1EOvdtSYlqxYNSEhYAfR4rLATYJ
 Utt3aEus4oIBAfGK9pZEaVO1rBKfIYBRlfYHRy4KQXL8YBHhIKVs7d2sSSSi2+V6C54X
 C6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mGnKSMkKMtsxEVb7JFS0nY27EekRK3d4wsP51kVAl90=;
 b=Y5zIJb1nb4PTpZaCCRRpX6T5miiJFc02i5CSR9Rpfkx8P1qrAx1TgOyJ2t96JtmQvj
 rh9EBQFO4e8DGGyhuY7QykMNY13pleD0Qgni75G/WUqOKFTrUlx1R4c223r+iI5MV1Qz
 4C3QKsHRKPq8Lim4rjZ07VarOX+7Du1H+5ZAKbDys6pPghGCSJzZmPGeh9GZz/aUruUc
 dKMVjzlej+MIlBucQVwiJjlrzIOhqQu0Ct0cquO/BxziUnUeuCh34UfjX1/KZ4S1a47G
 mosax39dUJ/W9LUuQPQxQoYRnwI0k1TAa5NaD+d+IYCa2C8RIxZVjQoex1Kezssfa6Ga
 iMSA==
X-Gm-Message-State: AOAM531UxKHSeKrqA3rUGCw6oXgXl/Y9bmqD3LUdczzN0xFdmrgS33YG
 jYPlGqjnamMMpfAgTzXgTiFscAKSwtRDZQ==
X-Google-Smtp-Source: ABdhPJyzbPxUZXhnlpeVNHG6c5CN+lyeYYtkgZ2qM4meUS8EtasSa4AvT/hJgq0kVLQW2oSi6p1dtg==
X-Received: by 2002:a17:902:8204:: with SMTP id
 x4mr53877958pln.16.1594378323192; 
 Fri, 10 Jul 2020 03:52:03 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:52:02 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 22/65] target/riscv: rvv-0.9: floating-point square-root
 instruction
Date: Fri, 10 Jul 2020 18:48:36 +0800
Message-Id: <20200710104920.13550-23-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62e.google.com
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



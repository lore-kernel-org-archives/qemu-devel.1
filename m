Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7183EC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E67CA20774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Yz5Wb0JQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67CA20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLRw-0006aN-Tz
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKxd-0004py-UW
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:06:49 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:36590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKxc-000289-AQ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:06:49 -0400
Received: by mail-pg1-x529.google.com with SMTP id x16so4648653pgj.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Scdzj96FfL7pUjXSYLA4a+TTflohdoYCZ5nFPT7xIBg=;
 b=Yz5Wb0JQ8u2PJldthxenMFbKpfzj/+8Lt7ZhRYJAJjPf+o9tKihB1as+HhmXjz4Ttj
 vC6x/iw4k2Lv0+UrW2+9q5tdOft69yl5k2jsrTTBWnNnEOq74gCdPgGPQzgpwzJlCInF
 1niDUUEoGKs9un0lYx+28ZIrYAGZLI4MHn/WsvKuH/fvNjOfFiJq182cRzJ+1ZDa0ia5
 7NdmvV3g4hJ0bBZCkmUpKGuKnRywwioQ5N/bksNwAbG1MTe82ww3kyqLq/2hA2H7YJdt
 ywxJ2w+RSUcQ80R5LkAvkKlsHtqG50cfXnjwQqU8PebLdh2rkJS4rC9fTDcr2Pf7f2fp
 gaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Scdzj96FfL7pUjXSYLA4a+TTflohdoYCZ5nFPT7xIBg=;
 b=R4Pz154xQQ/giuqURTWI0xJoD+OApv3khsnT14pVa2zzSpguEW1Y8lN8M4dL0C2YB4
 /0U7+1d7dTq8Fn4HZzU6x4Qxo4jkdO3uk84qX5VS95dBcpHbQqoQxadx9g85qEzB/UcL
 XPXA78IWBGFJFVHLGuyCJnrFTSe91jXooF5JpbgHO41CVN84V0PDeSqId057T3Gxi5Ns
 IoR2CjZAQL2k4PaLAmvtmdh5Po9cHhGXox0IwciNOiJbMqN3PmLxglwG5QgrCMxhO1Le
 VdBmPlSGAhErnuIYwm2cL5YEehpQZwO51kD6eMhjmrT/4giEy7IrOqRpbU4r/946EfL2
 7Ivg==
X-Gm-Message-State: AOAM531rGWkvnRsnYLDviB2G5vVIsenN1ZL0IcWTuPlyP2wO+Dx5DR23
 p+KZICFU1d1wwANsuIzIdEdYW6vfM5AngA==
X-Google-Smtp-Source: ABdhPJzqIP5yhs9mef/3BoMjz782TpvYrlM+ZdsEVdVY4/Op3FOme6eKfZc/DwaCCEKvUANJv3ZfmA==
X-Received: by 2002:a05:6a00:1356:b029:13e:5203:fba3 with SMTP id
 k22-20020a056a001356b029013e5203fba3mr5295969pfu.3.1601406406361; 
 Tue, 29 Sep 2020 12:06:46 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:06:45 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 26/68] target/riscv: rvv-1.0: floating-point square-root
 instruction
Date: Wed, 30 Sep 2020 03:04:01 +0800
Message-Id: <20200929190448.31116-27-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x529.google.com
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
index 44d35c0271..6c95a3460a 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -538,7 +538,7 @@ vfwmsac_vv      111110 . ..... ..... 001 ..... 1010111 @r_vm
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



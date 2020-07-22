Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99566C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 618A0206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="d5G2jdhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618A0206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyAvn-0003Sn-Fh
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAt9-0006g5-R5
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:18:11 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:35537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAt8-0005Hr-5d
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:18:11 -0400
Received: by mail-pf1-x42b.google.com with SMTP id a14so873408pfi.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/qLsSnqF0o8+PHvgbRszILIBQb0kzGW6bHTY2HlnYvg=;
 b=d5G2jdhGpDa+NY4oQckWYwFgKMFetFGKUNH5G4rUkIzK7YmCxG6oPZGneVnvXzksqm
 Nuq+coCsQ98clUnv2aKZZ9KH4gi2lVkQjmDdtV1jNpxc3/4gjXjNppWRKLzJTBJeDMMs
 acPgqugkMyXs7xFGpM+pSL4LoG63Q04iPm28HfMp+QfCFuTp6I0alN1xvVexq2WJcGBK
 4s+G3fVdZw7QBx2qi01EhU+bS5eQNvsZwy0FSgowUN96rfiQA8hbSSBnuuAKRFQb4DPh
 QRgt76sgVi8x5ULAwRS12+dYHw3hfgUfYSrOONsY2vguIVCRBZARIElYMq+uSUkeaEer
 WWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/qLsSnqF0o8+PHvgbRszILIBQb0kzGW6bHTY2HlnYvg=;
 b=CYAwoRXH0/zZ/PduC8PPwNKOvx+6Tbm3sJ0pTucNeYKAieGWnIaSPAPFWsa+rxVvp/
 OWpf9ZZO9fpcbyhAnu+qpGSRaJ41ALouoe0bUSOlsLEmBzv21AHIzkC2jwazJCiJT8lo
 LRQqerKtFJUEzHU255WevxPfTA8Vi/D446NOgqRuWvKE4LUGv2Vv/8MSvdSplXANPsE2
 Xy0b4lzQHYLtTMDbJyCK0pCSfZHnD3Di2JSr5YmnWXiAc/iRmLnvsuUJB3kYEvXXWFV1
 f7WboyPv7oV4lt4ut/A8GY5oqlUqKCoOK+2fIKYW+ipL/ECtMqdk7RYpzwrImMNMW8KD
 UODw==
X-Gm-Message-State: AOAM5310EUp6zMlkcAfRp7GMO8jsWSzy5e04tSfsuQe8i7FHw3WrluR7
 Jl7xYD3gGwAUG8kUuMG16mfu/vlDkH0=
X-Google-Smtp-Source: ABdhPJyEqsLvjtzYbIkaq3k7A8v3ZY1vWRMtGOye0PYe9hE8v0kvI9gou/mQor5lNz1bNcE/lz0bpg==
X-Received: by 2002:a62:8045:: with SMTP id j66mr27305745pfd.162.1595409488726; 
 Wed, 22 Jul 2020 02:18:08 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:18:08 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 09/76] target/riscv: rvv-0.9: add sstatus VS field
Date: Wed, 22 Jul 2020 17:15:32 +0800
Message-Id: <20200722091641.8834-10-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu_bits.h | 1 +
 target/riscv/csr.c      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index a8b3120883..5b0be0bb88 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -422,6 +422,7 @@
 #define SSTATUS_UPIE        0x00000010
 #define SSTATUS_SPIE        0x00000020
 #define SSTATUS_SPP         0x00000100
+#define SSTATUS_VS          0x00000600
 #define SSTATUS_FS          0x00006000
 #define SSTATUS_XS          0x00018000
 #define SSTATUS_PUM         0x00040000 /* until: priv-1.9.1 */
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index fb21c87488..ab4a4fc132 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -365,7 +365,7 @@ static const target_ulong delegable_excps =
     (1ULL << (RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT));
 static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
     SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
-    SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD;
+    SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD | SSTATUS_VS;
 static const target_ulong sip_writable_mask = SIP_SSIP | MIP_USIP | MIP_UEIP;
 static const target_ulong hip_writable_mask = MIP_VSSIP | MIP_VSTIP | MIP_VSEIP;
 static const target_ulong vsip_writable_mask = MIP_VSSIP;
-- 
2.17.1



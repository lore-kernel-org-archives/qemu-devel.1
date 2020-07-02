Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F323AC433E3
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C43EB20760
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h78vT4Cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43EB20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2AX-0005OS-0P
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29Z-0003XD-3o
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:37 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29W-00009X-MH
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707614; x=1625243614;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F60hhPMGOm/aK/Xcvf9Qif0y1msMkdIb5SO4KW8GxzU=;
 b=h78vT4CzMdwSRmuB2RJq/XzAy3pl1jLMslwjxUQzpwggnK001utBeqGC
 JWS4PN9W/p+rGgH278RqfjC7f1rjbFShrQ5h0CofNdSOGc2NJITCqnsXi
 bFCGOpKsHcewkKqTuWcSEcApF25H+XG3xkf+Ktb1kv3cmPBPD4484nVby
 dq5wLgX8spw3uV7ry+gI0PadKimssx07Dzlmx45doOXeIhpcBiCM8Z/TG
 YmaAK6aKphChF5xBZ2kKXia1HS/ItrspKQZpOqd+IqZJ45XmeQ3uTJryB
 WK8RqyREDEBKPrM1Nize61ntE4aFoKjQYKR10JGoTmN8W6LQxYDtTfnKo Q==;
IronPort-SDR: /nzMGJkM6GOuF5asg1r6qrVxQODxik1+2++0PAskelKb6PpKsrZLtN8iuHid6ILwQDzChQe9O/
 bIoF0Jct4+5iT3ysz5d2SiwjfUvukga5na0txLt4m31kzjtjSVY2PllAtHvy3kpCDxbkL/Xkk7
 FYXpiOJmmgrdOMRPoK4IXe7u3kJc8kpl7cpSJ7SmXpthQt1eUKEAw+VzuEWtuPdMVAhXN2T87a
 7nspFwiyZbUX86fRcnb31M8ZptMvIVbNBHhnk8h0YIe0xIQJ3eHL6yiGW7gaXAnx+XpdNLkJT2
 /aM=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498462"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:19 +0800
IronPort-SDR: c9BJ18hW9vCR3ldbMRhBbPUHyMLfX/KXmylph027/0ceVGByv1fUWUuf6lZfkvO0JDuOdUVlEq
 YatS0bWFRShxQDnVii9WmAsx5L/oNBxe4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:34 -0700
IronPort-SDR: n65UDyVrGj5kHY49EPUfhtl3q2LTUvq88Gn/ko1UllAAhezXtuGH7luyD38jFcT38hrU0f+vcd
 ytaEQ/Kt9OEw==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:19 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 02/64] riscv: plic: Add a couple of mising
 sifive_plic_update calls
Date: Thu,  2 Jul 2020 09:22:52 -0700
Message-Id: <20200702162354.928528-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702162354.928528-1-alistair.francis@wdc.com>
References: <20200702162354.928528-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=4451fe355=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 12:33:30
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Jessica Clarke <jrtc27@jrtc27.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jessica Clarke <jrtc27@jrtc27.com>

Claiming an interrupt and changing the source priority both potentially
affect whether an interrupt is pending, thus we must re-compute xEIP.
Note that we don't put the sifive_plic_update inside sifive_plic_claim
so that the logging of a claim (and the resulting IRQ) happens before
the state update, making the causal effect clear, and that we drop the
explicit call to sifive_plic_print_state when claiming since
sifive_plic_update already does that automatically at the end for us.

This can result in both spurious interrupt storms if you fail to
complete an IRQ before enabling interrupts (and no other actions occur
that result in a call to sifive_plic_update), but also more importantly
lost interrupts if a disabled interrupt is pending and then becomes
enabled.

Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200618210649.22451-1-jrtc27@jrtc27.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_plic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index d91e82b8ab..c20c192034 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -255,8 +255,8 @@ static uint64_t sifive_plic_read(void *opaque, hwaddr addr, unsigned size)
                     plic->addr_config[addrid].hartid,
                     mode_to_char(plic->addr_config[addrid].mode),
                     value);
-                sifive_plic_print_state(plic);
             }
+            sifive_plic_update(plic);
             return value;
         }
     }
@@ -287,6 +287,7 @@ static void sifive_plic_write(void *opaque, hwaddr addr, uint64_t value,
             qemu_log("plic: write priority: irq=%d priority=%d\n",
                 irq, plic->source_priority[irq]);
         }
+        sifive_plic_update(plic);
         return;
     } else if (addr >= plic->pending_base && /* 1 bit per source */
                addr < plic->pending_base + (plic->num_sources >> 3))
-- 
2.27.0



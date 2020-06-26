Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40EDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA812089D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G9oi7hIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA812089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowLM-000886-UG
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 17:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowI5-0002pm-2L
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:45 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowI1-0002yi-MS
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208422; x=1624744422;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qpKzwblaRf2F0jUNdWykbNTHSQmsZK/6FTkF0U3QfCc=;
 b=G9oi7hIyjvmVRGqNoh3L5vT5fezwuLQJwUCrEmuL6tDS49EFYoKiaTcn
 hDzXgzRzwRyzxyN0QKSEHv/Lwp9m/z/BWidrrTxnIHKMZQBswkkTGf9aS
 g6SxClZw/6a2v9Xh4gsBAuGqJDdaQLwFdkiB14b/wxe7qg5Gz3zQN7HYN
 JPdNNO8CKJ+QNuYJr5gDlZ+t7HKWQ4mdZQe8pe1t84orImEfCp8k0YsB+
 3TFxpUQTFpaN8wQyneG2PQL2bvQWDu7JqEe+uzB08sSl1QEqHG8r2SNxQ
 wednxhFRJkpg0U6u2HFbRykMHs1ZbKNUp50V7V6kdlnnhu2kSn6nGqHzt A==;
IronPort-SDR: JIQS3yqY0aqCtF0d6xvO0qh3hc//ilwlA0ZIeuOMaSTipRMWAQyILQaTPmajmn/n6YybkHoZS0
 3gO6B2oNE4zFhSPSe4NkfoHRg1U2xIwxcBnFL0TEm5GKYm7N2pQYYsiiFtKv5Nrxv1OyNngvvp
 +zl219h4NbVXkR4ZA0UJrAdxjLtwAAZYVyqywxje61zJhp2/Ec8tm8mpesAFd08FxK7cOvMIX4
 xesUfUe5KOklNILoppbcHTGfMyB97cZtMy6IU1nENtGByQL9DJ8zgPfvy6JCO3dpMhGFydyRS7
 SA4=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="145360016"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:35 +0800
IronPort-SDR: CpgQb4GBUlh0b8PN6fj8lCCTHpQ5FTRlI5GsIjVAl7LXC5jM6BlHFKnP+YNlOZwwPyLRtB+HN2
 +LQdskaceYEq+wi10hEIsx9Wopv9v7aGo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:33 -0700
IronPort-SDR: aOAlNHI6HhVx2L4O6K6ZQ85fBAQU1zqhV3EyBPUPFvQ2Lg8GIInwVSG7+By+VAOD0oByj3wazA
 jg4iglOu7dvA==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:35 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 02/63] riscv: plic: Add a couple of mising sifive_plic_update
 calls
Date: Fri, 26 Jun 2020 14:43:09 -0700
Message-Id: <20200626214410.3613258-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626214410.3613258-1-alistair.francis@wdc.com>
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=439617756=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:53:34
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
Message-id: 20200618210649.22451-1-jrtc27@jrtc27.com
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



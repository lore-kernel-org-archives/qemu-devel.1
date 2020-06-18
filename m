Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B3EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 21:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E8D208B8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 21:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="Preb8aGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E8D208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm1lB-00046M-Pi
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 17:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrtc27@jrtc27.com>) id 1jm1kP-0003Jd-1b
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 17:06:57 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jrtc27@jrtc27.com>) id 1jm1kN-0002Mu-Ei
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 17:06:56 -0400
Received: by mail-wr1-x441.google.com with SMTP id b6so7557722wrs.11
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 14:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jrtc27.com; s=gmail.jrtc27.user;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xmHWxebtPKupZcaNBdpPwXqTediISejz0zucPT84HsM=;
 b=Preb8aGP3Y9TvJgXjcxe0QA7HId1Sufa1futOsZv4GJhWt8sFoeJdEkx9/5RV14TLS
 WV19KxDPS0NRxzgO70mf6wa+HnI2rvf4hKVMZrenVnztzgJkLZefgQo5XNQNSCyqQEfq
 5+6RUi6HkzoEaCxgKC7ixFuioO09C768d+MwwuC8fDZmCQYTdptMK//DhcFfspiIxN0X
 UNleIpraOb8Lygh815qpp2cbiT1BViV4W1gLQD3d5QDeysdYITYnJmRzyWZfIKoYCm51
 g2CJe+ldZgDileXBfQzZEkCra1+h3gWXVdvqJBvSxRCtO1tD74/9Q/lsEgH4epos2NCY
 /uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xmHWxebtPKupZcaNBdpPwXqTediISejz0zucPT84HsM=;
 b=SYRWVNaSrneyzN7VMTwAc9hY3AovDSjXictGceI60um3wRVQH7MralEFcnqqnvyMEx
 Hlt0LcxXcYHcaOthUXVTgPUClJa6VT7YyvIMNqzsJ1LneoZbSXbW+sjt5GjE9g/b2E3V
 AWJyuKoC99ysStoDOPbhXZoFT2oK7v/T8exj37iNmEk8J3w0z1X5EjKF3tncUbwKIoMR
 SRkZJ/utDUk+XNMdJxYui+UElD9rkqMqWUyLM2GQcbTH5pNCp28uwkT3J8uMoTm7EARj
 WELhufGV4v9jxpecchPUzksHJLQhp8eXtVgcsntkoO0Ic9wEB1Y73v1P3nNjiJNSUhrX
 av/Q==
X-Gm-Message-State: AOAM531+ZWXPdtX9DgBgkoghOnJJS3ncYY9z3Y71UPs16xJJPiw+Uy+w
 NEznbm1Dk/fSutnjqStLmfakoQ==
X-Google-Smtp-Source: ABdhPJz6pq+khpYv/LmFnJkEwHYiTMq/pazc6YIYTSwJFj5lQY+P4nxiH3LXSX8v3ZOPyLUvcx7M2A==
X-Received: by 2002:adf:9163:: with SMTP id j90mr385972wrj.65.1592514413895;
 Thu, 18 Jun 2020 14:06:53 -0700 (PDT)
Received: from Jessicas-MacBook.local (trinity-students-nat.trin.cam.ac.uk.
 [131.111.193.104])
 by smtp.gmail.com with ESMTPSA id l8sm4725526wrq.15.2020.06.18.14.06.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 18 Jun 2020 14:06:53 -0700 (PDT)
Received: by Jessicas-MacBook.local (Postfix, from userid 501)
 id B8907207587E59; Thu, 18 Jun 2020 22:06:52 +0100 (BST)
From: Jessica Clarke <jrtc27@jrtc27.com>
To: qemu-riscv@nongnu.org
Subject: [PATCH] riscv: plic: Add a couple of mising sifive_plic_update calls
Date: Thu, 18 Jun 2020 22:06:49 +0100
Message-Id: <20200618210649.22451-1-jrtc27@jrtc27.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=jrtc27@jrtc27.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Jessica Clarke <jrtc27@jrtc27.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
2.20.1



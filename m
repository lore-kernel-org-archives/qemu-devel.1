Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75903C433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 09:45:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4517C2073E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 09:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BOfUxphE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4517C2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsNh8-0007sw-7d
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 05:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amergnat@baylibre.com>)
 id 1jsMld-0005w4-3q
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:46:25 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:32810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amergnat@baylibre.com>)
 id 1jsMla-0000tb-Ld
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:46:24 -0400
Received: by mail-wr1-x442.google.com with SMTP id f18so31824156wrs.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 01:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=Djt1gr0/S2tGtCGU7xh8b2ka2pC16hBw7TSjsoH+kGI=;
 b=BOfUxphEMAp3HLd4ceoMc9DVRiHLqfMuWbvT0IBmN1kjNH6aTXOlvIbw0Upi1wWtNT
 H05LbpTi+rji6h824ZuCj4oPtBYdO7WGJbEtYzAG6lcPp13L5psm/OBrBBFN7YWsjrjp
 KM10yImtoTlXaT2l5op5I0Z8plc0aMJnemIblPKa6V6XZYiK2sT9+HZrSDbHeHv2XMBX
 BHI/HhNvXfnfAGl+T08bamUaRxC2ogBeYmyKcuyNjmXAHno4xTh+lja+LkEkT8ICLuty
 cbE4cqqiQ5Ysr5OIsNHW8nyAFQekQjI283wUzCFWLNjwg+JOdEc9qxsT7so81t6+Jn5S
 MRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Djt1gr0/S2tGtCGU7xh8b2ka2pC16hBw7TSjsoH+kGI=;
 b=ZLo2NHyJoCdE4jZ7Aa9NCQ1QXBnz+jJyiCFhhNe4bOpuwNQJDneRYEG2LpCgT2CX0X
 i99h9vMHm9XBiNdr98ChzKPxjDcsrnvAzZPKu5D20VWzWRsVrCGcutYyXJtpZo/Ex5sF
 jGxKNkQxZANzJUkbS0DKOd8hUgmw22c2MnubEEwfhGZGhO8yhals9CLI7SJ2rvNSsM6C
 6FZu/XVK44qEIo6RKpy0WK8Bu+jIHl5pK9Gw2ljueLIgGEOs2bQt58z2ddrL7SA6R4Ja
 4rlI4wSz35kw2S4MiYskj6KHzuoeGL/uh9WwzyHWfAAGXEUIm1yS791iHmFIXjBJLVZF
 3ZJQ==
X-Gm-Message-State: AOAM531DHFRpBgHVpTljXnClg8uv3/r6XtrgofEj3/IaUavo89kf+Rb4
 DCst2ROZOPHQVzzA5ZYciqvQ5g+1zdw=
X-Google-Smtp-Source: ABdhPJxUX+HA7GAigFKfS+MUke35EFH3CmMi6xbwzGrcwVAyCLoMRsqyjqC0VgbgDvUFlRCgv19oeQ==
X-Received: by 2002:adf:e948:: with SMTP id m8mr48775025wrn.398.1594025179341; 
 Mon, 06 Jul 2020 01:46:19 -0700 (PDT)
Received: from pop-os.baylibre.local (158.73.152.77.rev.sfr.net.
 [77.152.73.158])
 by smtp.googlemail.com with ESMTPSA id h13sm22786439wml.42.2020.07.06.01.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 01:46:18 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
To: palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de
Subject: [PATCH v1] target/riscv: fix pmp implementation
Date: Mon,  6 Jul 2020 10:45:50 +0200
Message-Id: <20200706084550.24117-1-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=amergnat@baylibre.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 06 Jul 2020 05:43:09 -0400
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
Cc: baylibre-upstreaming@groups.io, nroyer@baylibre.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Alexandre Mergnat <amergnat@baylibre.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The end address calculation for NA4 mode is wrong because the address
used isn't shifted.

That imply all NA4 setup are not applied by the PMP.

The solution is to use the shifted address calculated for start address
variable.

Modifications are tested on Zephyr OS userspace test suite which works
for other RISC-V boards (E31 and E34 core).

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 target/riscv/pmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 9418660f1b..2a2b9f5363 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -171,7 +171,7 @@ static void pmp_update_rule(CPURISCVState *env, uint32_t pmp_index)
 
     case PMP_AMATCH_NA4:
         sa = this_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
-        ea = (this_addr + 4u) - 1u;
+        ea = (sa + 4u) - 1u;
         break;
 
     case PMP_AMATCH_NAPOT:
-- 
2.17.1



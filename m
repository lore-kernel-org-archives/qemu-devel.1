Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABE3C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F79207BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lExAHq0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F79207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyAwG-0004hx-UW
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAsv-00065z-Qh
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:17:57 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:45225)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAst-0005G5-7f
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:17:57 -0400
Received: by mail-pg1-x533.google.com with SMTP id l63so857202pge.12
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ty5URjUyAzHgdvndBCovXPI97TuuSa9GCoER6PMKuQs=;
 b=lExAHq0aTH0YZZuiGS2ib8iSpBxaQN4xik9afcTn7nz+J4qYclGYPdSCo3f3nLEM6G
 O6KiUua8cx9qKShUnM3lanh1gqGd7j/Z7uHqkX2RaFl5sSLSJXmmuELDdwctVEbfLvjO
 uPB2wH2zkfyIpkbpPS2vjdXoePNgiUJk/zOiunVhiqx/6SWwsAWkrTa63nMdeQBgsVkw
 hqJg+NoJH7vf31jMu1rimpBi/7OWkgjC6Z5zZvnt+BAPcNBJo7gLmgphh+AlG1k2+YKW
 TVWflS0Ifp6igU6QGtWOIsWATeKOzd/UG3dr7lHSrpDHgoHDqtZeQtMLldh7fj842i2N
 uKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ty5URjUyAzHgdvndBCovXPI97TuuSa9GCoER6PMKuQs=;
 b=oatren5oYLMXfq+WRG0HbDB9LrhNvhfq4FhdzyoTfJKZLqAO/QBbjAGBfQdJdLZmiM
 NpdtoMAd8/fRIlO3ed0r6Dz2ONr7Zy72iE0PvVuAeskJgntim4Qf7C+hCzf6DQ09nCGn
 wf0rfmbQp/HvDJE5rtDMRQLxyDHbmdi+tLGMARdC1zwBB3OrMFfrd2T6GdNaCvZYhYG3
 knPRWQEtHRqUUFrocOCE9a70AHBPkAkpVnJjajLBFriK3foe1HPjGy6fnRyU1tE5WqkL
 5+seapjT2MtgchbidOqzgrOBR0PwCnvPthm9oRqsV8pAdKQ8UzMSfHbg9v2GgOGMc1FP
 kxaA==
X-Gm-Message-State: AOAM53189IcWMH3m5p7WmJvMM6HutdPPL0KrRtwf4NVn9gSfQ7DYWzvX
 1bZkEn2jboMGydsYOYwqbEeHYdxMp9Y=
X-Google-Smtp-Source: ABdhPJwcNVgrl5aP2pbP2KG/FbS8es//wK6NMKXmTuLjXzsfGrdG699Ako1q5bsoYYMZKZsME65+yQ==
X-Received: by 2002:a63:7c56:: with SMTP id l22mr25289808pgn.127.1595409473878; 
 Wed, 22 Jul 2020 02:17:53 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:17:53 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 06/76] target/riscv: fix vill bit index in vtype register
Date: Wed, 22 Jul 2020 17:15:29 +0800
Message-Id: <20200722091641.8834-7-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x533.google.com
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

vill bit is at vtype[XLEN-1].

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 378f6e82bf..27ce075e50 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -98,7 +98,7 @@ FIELD(VTYPE, VLMUL, 0, 2)
 FIELD(VTYPE, VSEW, 2, 3)
 FIELD(VTYPE, VEDIV, 5, 2)
 FIELD(VTYPE, RESERVED, 7, sizeof(target_ulong) * 8 - 9)
-FIELD(VTYPE, VILL, sizeof(target_ulong) * 8 - 2, 1)
+FIELD(VTYPE, VILL, sizeof(target_ulong) * 8 - 1, 1)
 
 struct CPURISCVState {
     target_ulong gpr[32];
-- 
2.17.1



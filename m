Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F15CC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 09:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A78C2074B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 09:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oky857f/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A78C2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwjI4-0006Zk-LK
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 05:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwjHM-0006AS-6b; Sat, 18 Jul 2020 05:37:12 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwjHK-0000fD-PT; Sat, 18 Jul 2020 05:37:11 -0400
Received: by mail-wr1-x442.google.com with SMTP id b6so13423268wrs.11;
 Sat, 18 Jul 2020 02:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wbNW1G0WmInth/Nk79nljnnF9ybYz9nbp6jZzmf3edQ=;
 b=Oky857f/64Ot4+B/TFebNvDZxXsHKQdiSpMnkcBAk76atgIJI5Wqbpfhj7bX2DDBuK
 hxiFtgYb2vKBxAo879t6FEtn2hvmVbxbKrDx0le75bWIlxKPgVOU9QuS0MxjCsStPpyt
 UyBOoZf5LNtGhyDdaU4+vHDetPAnCWsQu9RyrYluuUhfRKBg62BFs526bmhOQxt0ugpR
 +UWpIlzLBEw/dn7YM0uDhBFIiGcqkNiSCs5PtbnjTzikiYdfxb/1TVe4fr44KyGPj8ZZ
 TtI7rTX5klnOVX3cxPq8JJk/hlVXKqPCrvodkb7OKy/yTjRDV5rkzJLlANW8z+Vzhai/
 gpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=wbNW1G0WmInth/Nk79nljnnF9ybYz9nbp6jZzmf3edQ=;
 b=Kh4BvQnUWEAZkICPx7XWdec+tLyZK6TXt7MESlArBXiadYA51sZFnVzCeHfeZddxUJ
 madCfPtFGThUb2pAXtwXUWfC+2dKqWw2zuGFyLYCGMa1xbhdUYbvqqB0g2j7tTLwNtzW
 MuCtCbhQSUUHWDHqX6BQLfqw/krvpP4ZqUw3VM7brzfI9e21GV0HkTE5KyBHhnPTdor2
 0mnh+rSpWQyhzmu2rHmB6Zi74EyhnrQgVHIqMV4aVtQ0QCjZ7wnVmfANNqBfhvHSkRlC
 f0cjTWVdWMr2Nuv7joRvFwY/eYE3vN8nUo+UmuCJr+LmSHTxFb0DLhA7OREUXW4Rlv+a
 PdnQ==
X-Gm-Message-State: AOAM533EG/o2IXW0w2+BBW7F9EUQ78c/uFSKdCAE504oXPNEcFew2Adu
 EOZfh7gqBxNoeHMcdrLWTkJhwxADWFg=
X-Google-Smtp-Source: ABdhPJzBsRHAEQ6CICFlX8M+L5vh8brCSLE5h97mrqH0ahI2Tz43Gbva/Wy7CaE83Qew7hMKSv4jFg==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr14401078wrq.189.1595065027505; 
 Sat, 18 Jul 2020 02:37:07 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 190sm19881823wmb.15.2020.07.18.02.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2020 02:37:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1] hw/misc/milkymist-pfpu: Fix pFPU region size
Date: Sat, 18 Jul 2020 11:37:05 +0200
Message-Id: <20200718093705.7271-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Michael Walle <michael@walle.cc>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The last microcode word (address 0x6000.6ffc) is not reachable.
Correct the programmable FPU I/O size (which is 4 KiB) to be
able to use all the microcode area.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/milkymist-pfpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/milkymist-pfpu.c b/hw/misc/milkymist-pfpu.c
index 516825e83d..4fbe3e8971 100644
--- a/hw/misc/milkymist-pfpu.c
+++ b/hw/misc/milkymist-pfpu.c
@@ -507,7 +507,7 @@ static void milkymist_pfpu_realize(DeviceState *dev, Error **errp)
     sysbus_init_irq(sbd, &s->irq);
 
     memory_region_init_io(&s->regs_region, OBJECT(dev), &pfpu_mmio_ops, s,
-            "milkymist-pfpu", MICROCODE_END * 4);
+                          "milkymist-pfpu", 0x1000);
     sysbus_init_mmio(sbd, &s->regs_region);
 }
 
-- 
2.21.3



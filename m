Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B76C433E1
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 20:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DADC2073E
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 20:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uGqxQPLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DADC2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsBYG-0006Db-S9
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 16:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsBX4-0004PM-DG; Sun, 05 Jul 2020 16:46:38 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsBX2-0000p1-UD; Sun, 05 Jul 2020 16:46:38 -0400
Received: by mail-wm1-x344.google.com with SMTP id g75so37066778wme.5;
 Sun, 05 Jul 2020 13:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=97pUZmX/67wbHP9Fb1MFklUqwh59qQdvzxeqL5/W8D4=;
 b=uGqxQPLPNagqvAJlLJufXSkR4jInpyfz+KVDjHLZRwMN7Kk+EOLJ8d7pUkBc5uYkRU
 KhM3bHfMakJN5r/Gd89cq6gN+4Dj55IObDyjHHGQ7caqcXncD36kZ6MUHTSxqgeT8wh8
 FELegVmolU+gYrBr/FgqTSU7Q2WQA17iTTxlNbjgHn2bczrB++MF+m101hfKA3bdxUKy
 39jAyhv/7D34Yslqnv1NwGF5m37xMJNnQc70xGdCVxqQPdYP4GxiH/Ter2y9/roh2rCO
 503gsou0Mk2FrlOYzZ3x43LZRLGCKo9+Fkxj0MIm9rSwl1KTBUEx6fO0O9maHK/PulDW
 z1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=97pUZmX/67wbHP9Fb1MFklUqwh59qQdvzxeqL5/W8D4=;
 b=a/leI7WlTyFUxdyaIKuNgx255ajjIPyPFxnnw3trSuJ1HLjryDxL1I+/zTPkEj/1qD
 oXSEElzbh03lM6GKpnJOAYHJxGTuPpbz9r8LAiAHHTaR5AOpki2/+ibXBHM5eGQ/NTsk
 NrOWhuVRlMXhFwLEKUyW/QMR3DeZRk8kOwrleeywYXrcO7pA8TDlUez0ekwLvV5UxkP3
 9akmOFx5upN1F1oXza+z6WAI3+O8V769NTpyyYShoKzWipoyMEGPUG0NyJUhLBP+FkVm
 kr9uW7aqJ1oo7moi9c4yvOq2LvIY+2zkuzDAbeoIMsdGaB9r0yK161ls9WwQFgaTGqeB
 Jb5g==
X-Gm-Message-State: AOAM533UA4J2ik46MKDtoyliDPXzA2hsISiNLykvy9LFRqAelP245IrB
 oHsqgGUBZv4gfgouP6EarCclO9N50Kw=
X-Google-Smtp-Source: ABdhPJzcIwUuzT6OUxbkOEB/leCLT/f8hgT9lGfq7iqtLEvoduxDdN9SnE9Oyaoqul5hEqsQsxckdg==
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr47170302wmy.79.1593981995180; 
 Sun, 05 Jul 2020 13:46:35 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id g144sm51397817wme.2.2020.07.05.13.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 13:46:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/10] hw/sd/pl181: Rename pl181_send_command() as
 pl181_do_command()
Date: Sun,  5 Jul 2020 22:46:22 +0200
Message-Id: <20200705204630.4133-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200705204630.4133-1-f4bug@amsat.org>
References: <20200705204630.4133-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

pl181_send_command() do a bus transaction (send or receive),
rename it as pl181_do_command().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/pl181.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 649386ec3d..3fc2cdd71a 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -173,7 +173,7 @@ static uint32_t pl181_fifo_pop(PL181State *s)
     return value;
 }
 
-static void pl181_send_command(PL181State *s)
+static void pl181_do_command(PL181State *s)
 {
     SDRequest request;
     uint8_t response[16];
@@ -402,7 +402,7 @@ static void pl181_write(void *opaque, hwaddr offset,
                 qemu_log_mask(LOG_UNIMP,
                               "pl181: Pending commands not implemented\n");
             } else {
-                pl181_send_command(s);
+                pl181_do_command(s);
                 pl181_fifo_run(s);
             }
             /* The command has completed one way or the other.  */
-- 
2.21.3



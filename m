Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A15C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8146820651
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+QG7KhU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8146820651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufWS-0005Fa-QF
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58443)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPe-0000To-T1
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPd-0002v0-SF
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:42 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43800)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hufPd-0002uX-MR; Mon, 05 Aug 2019 12:00:41 -0400
Received: by mail-pf1-x443.google.com with SMTP id i189so39874716pfg.10;
 Mon, 05 Aug 2019 09:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=8KdynR/OjUZU1xuClc8qRK6ENODt1avb+04qYHb5Ais=;
 b=r+QG7KhU9pUTlFRQUDkVP+nzR/m4yzx8Tfmh9Kvg8MJTb8stSBpsGGLHhc9fAd7yiF
 TuNupfpcdN7XscrV0UL/eCTyX/lAjyiuV08SETsI0rRpblleab1ilY3tlOV2NTDirv2y
 jBefWKJSDeWMMFU8PODfNL6Z1t76CZ/kjNLayApBKaNVmo+F26H4No1V23Ez2grFgJYN
 MNcLcWcP/cljYyRiu7Lv6F4lMYIz0FvsicLjrZOidVRDXdY200ARIlNeWPElvaUL2868
 VQPAlFm6OYZovXWCxuBlKWrDf/ncNWK3pBpoYJL6QLjXuJQ9UuaMxR1pl3NEpO3zlPcV
 OUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=8KdynR/OjUZU1xuClc8qRK6ENODt1avb+04qYHb5Ais=;
 b=TW3OSFb8XL0SNgqC5imhhpk85tfULK/5A9quKb6oJLnlqfsQQ55AmjHlwsBHo0Nc3F
 ZGvMnIVkUDGlRS8om5StYsw6cyz6+s2nCgiJoTBcl6PGFcK2kMGUufv2q0ucTm5sFfT6
 dvv1TNOeSkKDqI51Xsiu74LiaDuDvCW9MR70cZXCsY75pP1boNgHHN3CXwyv4XBeyIF/
 f7+D6SSrzE3WbCh7FiZ5AiD+HQr4MgDbeJ8TiS1PjE2hUNclO6t+pN//rcIDmz8DfI8B
 mnKZ4aA0Jn3tXTujVl0Qej6s4ulMqEfMXyEFgoeaP4zDzhjYPPi0NiR9PnJIHqHMOZyg
 oYlg==
X-Gm-Message-State: APjAAAV6dsjwWkeS6asE8OBBU9Y/r/VIIBJHs+wH0Rw8V+WlaLQEC9Ll
 bkzCyMbN1Az09b7QNaTE7Lw=
X-Google-Smtp-Source: APXvYqxviVTKIE4ikfxTz2ujZ++l8mcu2A1BRqTlQeIvxq8U8AOKutPEzb/d7G+PD9e54TQYAWiN/g==
X-Received: by 2002:aa7:8218:: with SMTP id k24mr71035655pfi.221.1565020840983; 
 Mon, 05 Aug 2019 09:00:40 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id d18sm47728793pgi.40.2019.08.05.09.00.39
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 05 Aug 2019 09:00:40 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Mon,  5 Aug 2019 09:00:07 -0700
Message-Id: <1565020823-24223-13-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 12/28] riscv: sifive_e: prci: Fix a typo of
 hfxosccfg register programming
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It should use SIFIVE_PRCI_HFXOSCCFG_RDY and SIFIVE_PRCI_HFXOSCCFG_EN
for hfxosccfg register programming.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/sifive_e_prci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_e_prci.c b/hw/riscv/sifive_e_prci.c
index acb914d..c906f11 100644
--- a/hw/riscv/sifive_e_prci.c
+++ b/hw/riscv/sifive_e_prci.c
@@ -89,7 +89,7 @@ static void sifive_prci_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 
     s->hfrosccfg = (SIFIVE_PRCI_HFROSCCFG_RDY | SIFIVE_PRCI_HFROSCCFG_EN);
-    s->hfxosccfg = (SIFIVE_PRCI_HFROSCCFG_RDY | SIFIVE_PRCI_HFROSCCFG_EN);
+    s->hfxosccfg = (SIFIVE_PRCI_HFXOSCCFG_RDY | SIFIVE_PRCI_HFXOSCCFG_EN);
     s->pllcfg = (SIFIVE_PRCI_PLLCFG_REFSEL | SIFIVE_PRCI_PLLCFG_BYPASS |
                 SIFIVE_PRCI_PLLCFG_LOCK);
     s->plloutdiv = SIFIVE_PRCI_PLLOUTDIV_DIV1;
-- 
2.7.4



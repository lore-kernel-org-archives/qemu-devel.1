Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B084C433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D7A208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPNwMQtw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D7A208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwiz9-00055s-FF
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 04:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60454)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwit3-0006aI-Kt
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwit2-00045o-PY
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:33 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36299)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hwit2-00045Y-KD; Sun, 11 Aug 2019 04:07:32 -0400
Received: by mail-pf1-x442.google.com with SMTP id r7so48245543pfl.3;
 Sun, 11 Aug 2019 01:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=EvhVZdHb2hebBUuM2+1LwSpIfoOPqSDNrj4o6ITuFwg=;
 b=nPNwMQtwSnxqESDNDJi64+FVKMNwQ534K71jEShF6vqNetAOGYh84xboTYjuRh5tAX
 VH4fWPYqBr/Ah/f730XH9fF0ks8TEmgkn1nAZp+TES+tolb7w+vlGfsEbJx33T2nREO7
 nV6Kf/4OLf2cc/3/3P0hScSwj5Gmf0+1ZhD9gPA0ihaCkg4JnqEO+Nq8uFB8yrBMRcuS
 MHHOXSmaB7f9497Ns7XpRNmQiHzMOKQyGmWU1oiHSqqX+laG3T3G52Btcp5tI5krh7P9
 fRgjzznyMkd21JHLLUJF68il/sdz5LMgOMWVroZjXW0ZLN4N2/pik5GE9G6ps5ZOGcbs
 YpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=EvhVZdHb2hebBUuM2+1LwSpIfoOPqSDNrj4o6ITuFwg=;
 b=a5nqv6o8udgd5/3pWNVNVw9gy2xMB6d2l2vpP5IGAOYvltNFeZTJ/LzoweAdRJUkiv
 /9sGS1iD2z2zsckK35rbrCDIA3yWbgWfYxCk24HEu8N8vaMN7cPWOrhcCN5i2by88eBq
 fRlSIyKnlMqUcvkszA7GadMIcCMnTx+VNeKWnZvE0eq/eRnGTJg1279ZF54gjBAHb6MQ
 qihPF0+uaSffnM3Llm30XkP8LF0cLV+8U91+bXf4/TzgbSArEmUi0IlAzsIVpqjn+hqk
 4Sy2k0ybdPSKkjE+UkK/O7IT76TPaxYxZxntt7ZCTefnHJX8wNsSfkdNSgV8/dCO8beD
 mZKQ==
X-Gm-Message-State: APjAAAUxreiu/DH8+BlCuy5s/jgWZpjPIa9QmVYsXFBoPU3kD2boKFsV
 sQ+soBYCiEUz6nWubg4jAEo4FP61
X-Google-Smtp-Source: APXvYqxSvQWUMfk2gVubQ3yWkWGe8pVd1zZzU9waxR9j4DqSkLTIkWhaEFDxhPDCJwFoYMjK0bvJtg==
X-Received: by 2002:a63:62c6:: with SMTP id
 w189mr25059280pgb.312.1565510851794; 
 Sun, 11 Aug 2019 01:07:31 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v8sm87339107pgs.82.2019.08.11.01.07.30
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 11 Aug 2019 01:07:31 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 11 Aug 2019 01:06:55 -0700
Message-Id: <1565510821-3927-23-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v3 22/28] riscv: sifive_u: Generate an aliases
 node in the device tree
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

The Linux kernel SiFive UART driver expects an aliases node to be
present in the device tree, from which the driver extracts the port
number from "serial#" in the aliases node.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 7eb2b7e..0c1a89f 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -284,6 +284,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     if (cmdline) {
         qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
     }
+    qemu_fdt_add_subnode(fdt, "/aliases");
+    qemu_fdt_setprop_string(fdt, "/aliases", "serial0", nodename);
     g_free(nodename);
 }
 
-- 
2.7.4



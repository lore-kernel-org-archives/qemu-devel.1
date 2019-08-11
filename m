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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF17C0650F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E7E208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OM0zBYrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E7E208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwixI-0000p0-5T
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 04:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60141)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwiso-0005gt-7K
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwism-0003tn-SI
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:17 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36299)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hwism-0003tO-Mm; Sun, 11 Aug 2019 04:07:16 -0400
Received: by mail-pf1-x443.google.com with SMTP id r7so48245372pfl.3;
 Sun, 11 Aug 2019 01:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=wYGsUwsYyo+kXYWSIY6vMGuCQJtL6iV3rGu0dyhNCPA=;
 b=OM0zBYrJjaAdBTfz6dMY3oId8/jymerj0RruyiNHCFghfqISchC7eC0AqVPznDKPf2
 TB1ukmVB2krDJT8UJ00FDGfkMLudHXHVf4+jNUqjuVMPM6DJY7H2EjMfBe91e26PtqAE
 VMeg3uVPu8wqcUfiBNw1MlVSTyejY/lyugKqnQsWlQGKEB/9fUdDlhxF54A0CRMW+qMe
 77iAzF9h0dnj5Lq1GOhNKkgDurhBc+JXzBsV8KCTgLVwsn/9Y9pegAQwUScVBTP5YKme
 h3S20YNvFCswR78RypamAG/DIFxV+F82S6mjr3wAKki98d14eIn66Aa3f+jsIL9T8l09
 QyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=wYGsUwsYyo+kXYWSIY6vMGuCQJtL6iV3rGu0dyhNCPA=;
 b=Y7ZB+bqLMBvn0zHUsbOMzMDJHfBLrpF00RhNPt+JEYyW/ngOTADIW98NKSbrZQzjdu
 FYkbV6B4zrUTcivB0mOGv4wVjE04uRhZ4PWTMTjcnVEbgOAu3yiI6SAZYsAXHcSFoHyQ
 ks+uetcC+lB84E+m3MHmStanOZy/ZiiD3s7h7MjVuWMQJKh0anH9jpeHanu2LwNelktu
 p58AGjT0QlAUrTbxFvpAd+l164Oy0warS60ZI6/E7Ts8m+GBqqYGOz6xwensM0uXs5n+
 aYtaHRUD0bEvVTYMYMIOZBLBxH/ZfzVOGn+xHnzepaeBVYsxVXN8h9JzX1jPxbMpy2Pu
 p47g==
X-Gm-Message-State: APjAAAUZbaGKHlDTWonV4fkMg/sib3Ti3MRbybEyy1lRT8PU7TPJhcmI
 UvvYVK6r/vz79+KJP7zmySA=
X-Google-Smtp-Source: APXvYqxo3DNVqx0avQTdl1UcCyO+BmTt7tM2IdM0ch2XFk6E5eLmyX7InjSRyB1PvXpWzSrKZ4PwvQ==
X-Received: by 2002:a17:90a:c386:: with SMTP id
 h6mr3635204pjt.122.1565510835987; 
 Sun, 11 Aug 2019 01:07:15 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v8sm87339107pgs.82.2019.08.11.01.07.15
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 11 Aug 2019 01:07:15 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 11 Aug 2019 01:06:41 -0700
Message-Id: <1565510821-3927-9-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v3 08/28] riscv: sifive_u: Update PLIC hart
 topology configuration string
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

With heterogeneous harts config, the PLIC hart topology configuration
string are "M,MS,.." because of the monitor hart #0.

Suggested-by: Fabien Chouteau <chouteau@adacore.com>
Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index f8ffc0b..16ab95c 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -373,10 +373,11 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     plic_hart_config = g_malloc0(plic_hart_config_len);
     for (i = 0; i < ms->smp.cpus; i++) {
         if (i != 0) {
-            strncat(plic_hart_config, ",", plic_hart_config_len);
+            strncat(plic_hart_config, "," SIFIVE_U_PLIC_HART_CONFIG,
+                    plic_hart_config_len);
+        } else {
+            strncat(plic_hart_config, "M", plic_hart_config_len);
         }
-        strncat(plic_hart_config, SIFIVE_U_PLIC_HART_CONFIG,
-                plic_hart_config_len);
         plic_hart_config_len -= (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1);
     }
 
-- 
2.7.4



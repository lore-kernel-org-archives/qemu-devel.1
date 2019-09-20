Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C3EC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813B3208C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCXLmIG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813B3208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBFCG-0002df-Di
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 05:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iBF8K-0005j1-T7
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:23:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iBF4H-0002oM-Fb
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:19:10 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43152)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iBF4H-0002o1-Ax; Fri, 20 Sep 2019 05:19:09 -0400
Received: by mail-pg1-x543.google.com with SMTP id d4so384463pgd.10;
 Fri, 20 Sep 2019 02:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=u/XXhvAolCieP6V1RN94aOGfpzypnA1RhoVy7PHOsac=;
 b=fCXLmIG49+wsif6g44N7pNcQD6/9BmxjmVA5KQTrRgjFD2tsRIZX+1PyccTorw7Iib
 dgS9gyUJbhQZeXc0SM2zgwf/Wd7vNxUmUNABsWp3gINu1cKdb9i88/K5Vv8Gwsfu7yno
 aG9HRXbFp/S2ighvtle2f3bqBcPkRb6skyj0TjMHhm1hIaZaI8fjZ24SdnyK5YLDDThX
 boOVG4iXDWqeIRTuXYvVRWoH+exh2cVL29zvUzOPZaw6jX3BvA/zHEY/dE6M/Jx5474D
 x64zAu7qSCUPMk/gmeA+iM+vcJTUAilDGSf2UoBWcZhttyFTsTZJdrEZv2WIOFYQdCZM
 sTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=u/XXhvAolCieP6V1RN94aOGfpzypnA1RhoVy7PHOsac=;
 b=cu2IHxxLQ/I1PR4XEVrRt+0SgtTBeRJ88ifob9Tcs7ultaaiiJ5zEsdtOOsOMIXp1X
 p99K3yg9yg/DB/fceT4b8OJXThPX3vhFzToi+9fQv9bLhvYkRBHe3x2rIZK9cPjmmO4n
 axTr+mQvkZI98qxziuFsNvJS4U9SlKOPgydNDrrJy3JUdrTSxy7Ihxbf4ucqX/HQnYSu
 vw38ChiK4oaDvYvW5sxbCHxZlkKUM3o5ogeyLERufSaQ6/84+Ty6dP8OEQo6iZZW9bIl
 XPXEH1ZCTvPrBhilVB8znfo6JEcsCzd1Y3o41/mYuf0juUUoyuE+JFNRuWAE5yNwzzfr
 /8mg==
X-Gm-Message-State: APjAAAWwKqT65Uf75NFxuaFKTXM0phmd6OYEsho3XA0xbA6yh/bqk9ur
 bLA5XoAVfp2IKcHuI3Dzhm4=
X-Google-Smtp-Source: APXvYqyNkevPjfniTbLQjpKGLV/cndKHIk/8BrfTVG4+L/jfaW16pBBCaSuavhqNn9USlEeQdgcSQQ==
X-Received: by 2002:a17:90a:1903:: with SMTP id 3mr3513369pjg.80.1568971148373; 
 Fri, 20 Sep 2019 02:19:08 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id m9sm1500731pjf.11.2019.09.20.02.19.07
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 20 Sep 2019 02:19:07 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 2/2] riscv: sifive_u: Add ethernet0 to the aliases node
Date: Fri, 20 Sep 2019 02:19:02 -0700
Message-Id: <1568971142-27979-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1568971142-27979-1-git-send-email-bmeng.cn@gmail.com>
References: <1568971142-27979-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

U-Boot expects this alias to be in place in order to fix up the mac
address of the ethernet node.

This is to keep in sync with Linux kernel commit below:
https://patchwork.kernel.org/patch/11133033/

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/sifive_u.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 02dd761..1ac51e3 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -270,6 +270,10 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         s->soc.gem.conf.macaddr.a, ETH_ALEN);
     qemu_fdt_setprop_cell(fdt, nodename, "#address-cells", 1);
     qemu_fdt_setprop_cell(fdt, nodename, "#size-cells", 0);
+
+    qemu_fdt_add_subnode(fdt, "/aliases");
+    qemu_fdt_setprop_string(fdt, "/aliases", "ethernet0", nodename);
+
     g_free(nodename);
 
     nodename = g_strdup_printf("/soc/ethernet@%lx/ethernet-phy@0",
@@ -297,7 +301,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
     }
 
-    qemu_fdt_add_subnode(fdt, "/aliases");
     qemu_fdt_setprop_string(fdt, "/aliases", "serial0", nodename);
 
     g_free(nodename);
-- 
2.7.4



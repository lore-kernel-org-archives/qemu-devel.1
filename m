Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B57C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 21:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C37B217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 21:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/PgcLMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C37B217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu12i-0005a7-Gs
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 16:26:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <d.c.ddcc@gmail.com>) id 1iu0rW-0000rn-Cy
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 16:15:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <d.c.ddcc@gmail.com>) id 1iu0rV-00060Y-96
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 16:15:02 -0500
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:45223)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <d.c.ddcc@gmail.com>) id 1iu0rV-00060L-3P
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 16:15:01 -0500
Received: by mail-qv1-xf42.google.com with SMTP id l14so2194701qvu.12
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 13:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Dk0J5dyN1r81HDyEPcIptSVZY2GMAmDlVKyeJm3oy2k=;
 b=b/PgcLMvd3k19JdL7ITELhngGr2EbPp1b7FbUX9PHWP87242GKgupWRnTDK8O2wL4U
 xgMkQ5WIdu3AIl39JjnfE/9Y10wUOrHfkIQgfmISvPLaHD7loMGsJxwnnNEgbk5T/r9a
 FODmRKiFrDgDslxmSFz7A6xjgoEy2Xpl6rZFYrfFnIIMgm4mkmallxkWzQgPMRZW+0HY
 spazc2FU0ZzlgUbMajPRYczKjG9h6QmD5KviJ6TOlozAzBqEv4kGINzpX4YPSD+lyP9c
 1igtjxtV4Oyzg4HutnesIUHimpW6BO8T7McVgssItdOOkvxSUcaqV9wgFBWNaaMLHkix
 J8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Dk0J5dyN1r81HDyEPcIptSVZY2GMAmDlVKyeJm3oy2k=;
 b=dgF33oiaBmT3gwRklE4QHjCIUa6tU0FaEmXEfPzyj92dVOYdYo7yFKa7BdgH0EdET2
 s3+CB2yMrcUXIMCRH9ssWR6aeCwqaylrifmTL4b3TSZqhzWkRGWAQjmvbOcmF+HJnexr
 sVAjFlOESOJEBDSejQ9ZPz5NNkt0FoNGgh75M8Xh+ra4Vp4aAZ0obAdeQ5ZAnjdIFPAJ
 NXlUoWysbr610zmgPIYC5V10vBzwpwxImVkVe2gWBztN78lh7HBNq2/JKBPqGERvIaGR
 qDBpvBihET/EbITzlFSDSHZYySL0KJhBncNTQnE0XwjvvFIjpZgHd84lMvStw82VeLuo
 1A5g==
X-Gm-Message-State: APjAAAXjasHYq8EcG+AR5Nopi9vQzaWkaxTmgDj0pI/zvGmeHWxQvPzU
 sYiiMrcOlZ5kSmux93r7KBo=
X-Google-Smtp-Source: APXvYqxUvzv9mRJd7bE0rhKZ9IPPN0/+uf/DUybWSEr30e0GDQtDHjMfR/rBr0WyxmFxUWraU0PsJA==
X-Received: by 2002:a05:6214:287:: with SMTP id
 l7mr7142521qvv.142.1579641300177; 
 Tue, 21 Jan 2020 13:15:00 -0800 (PST)
Received: from localhost.localdomain
 (pool-71-182-232-12.pitbpa.fios.verizon.net. [71.182.232.12])
 by smtp.gmail.com with ESMTPSA id 184sm17586893qke.73.2020.01.21.13.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 13:14:59 -0800 (PST)
From: Dominic Chen <d.c.ddcc@gmail.com>
To: jasowang@redhat.com
Subject: [PATCH] e1000: emulate additional dummy M88 registers
Date: Tue, 21 Jan 2020 16:14:58 -0500
Message-Id: <20200121211458.62838-1-d.c.ddcc@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f42
X-Mailman-Approved-At: Tue, 21 Jan 2020 16:24:56 -0500
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
Cc: qemu-devel@nongnu.org, Dominic Chen <d.c.ddcc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Certain drivers will write to the M88E1000_PHY_PAGE_SELECT and M88E1000_PHY_GEN_CONTROL
registers on the M88 PHY, so perform dummy reads/writes instead of returning errors.

Signed-off-by: Dominic Chen <d.c.ddcc@gmail.com>
---
 hw/net/e1000.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index a73f8d404e..52c5d80042 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -206,13 +206,14 @@ enum { NPHYWRITEOPS = ARRAY_SIZE(phyreg_writeops) };
 
 enum { PHY_R = 1, PHY_W = 2, PHY_RW = PHY_R | PHY_W };
 static const char phy_regcap[0x20] = {
-    [PHY_STATUS]      = PHY_R,     [M88E1000_EXT_PHY_SPEC_CTRL] = PHY_RW,
-    [PHY_ID1]         = PHY_R,     [M88E1000_PHY_SPEC_CTRL]     = PHY_RW,
-    [PHY_CTRL]        = PHY_RW,    [PHY_1000T_CTRL]             = PHY_RW,
-    [PHY_LP_ABILITY]  = PHY_R,     [PHY_1000T_STATUS]           = PHY_R,
-    [PHY_AUTONEG_ADV] = PHY_RW,    [M88E1000_RX_ERR_CNTR]       = PHY_R,
-    [PHY_ID2]         = PHY_R,     [M88E1000_PHY_SPEC_STATUS]   = PHY_R,
-    [PHY_AUTONEG_EXP] = PHY_R,
+    [PHY_CTRL]                 = PHY_RW, [PHY_1000T_CTRL]             = PHY_RW,
+    [PHY_STATUS]               = PHY_R,  [PHY_ID1]                    = PHY_R,
+    [PHY_ID2]                  = PHY_R,  [PHY_AUTONEG_ADV]            = PHY_RW,
+    [PHY_LP_ABILITY]           = PHY_R,  [PHY_AUTONEG_EXP]            = PHY_R,
+    [PHY_1000T_STATUS]         = PHY_R,  [M88E1000_PHY_SPEC_CTRL]     = PHY_RW,
+    [M88E1000_PHY_SPEC_STATUS] = PHY_R,  [M88E1000_EXT_PHY_SPEC_CTRL] = PHY_RW,
+    [M88E1000_RX_ERR_CNTR]     = PHY_R,  [M88E1000_PHY_PAGE_SELECT]   = PHY_RW,
+    [M88E1000_PHY_GEN_CONTROL] = PHY_RW,
 };
 
 /* PHY_ID2 documented in 8254x_GBe_SDM.pdf, pp. 250 */
-- 
2.17.1



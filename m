Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C21C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267D4206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEm4PStX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267D4206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiDug-0001lb-FS
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 05:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiDsA-00084f-Ev; Mon, 08 Jun 2020 05:15:14 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiDs9-0006YU-K9; Mon, 08 Jun 2020 05:15:14 -0400
Received: by mail-wr1-x442.google.com with SMTP id x14so16551093wrp.2;
 Mon, 08 Jun 2020 02:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GAilW8yie/Do5KptkIQuqkh+fcg/rpMOQw77I65dDB8=;
 b=oEm4PStXndMdrJqKwb6eb7K8+NRMM1HCO1tnV4LI3kl/h7uo4y5SzLzZcjI4Vpbxma
 0NvtC5ZQYjSs50pIODcz866DqBEJz2+BVrvVDm+rs5A+vveYvJO6E6EjpuZ5iZTO9AAp
 kPZRm+pL+QBDEHrqub4NW29VRvsq6R05YR8SaRRpfncL3TG/qlykfa4lFAD/+LS3C7to
 soazm+XNSUpdYmoHTiECSGQB1vG5+2rstGxqF9y+lddSl+6oaZhNwf5xRjLNUmQt13Eq
 yJvM3lWGqQ3Ja8yyK6tHqvPUMsTcGmElajHh+oDB5dusS94XKnDdOwHb0z2Oqup6UcFt
 FQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=GAilW8yie/Do5KptkIQuqkh+fcg/rpMOQw77I65dDB8=;
 b=UqgkITBRpSrUSx7AWBKQFaPgdjNV1mqpHLT4ziDJKPQsg8NgGdLDj76KTwWFTjmK9W
 aCpNKy6bhSAqcWVrB12lojUeuEsliWNrRLujjWd1wDLkD9vGdDSo0TzcWwjJL6aAibBJ
 ttmlxmSEuaRV38dYvcerKuuDTlGOCHsD23RkPUCf327LRWgCoylYTzkLYi0oI6YoJDZ3
 JfXgjxVxKMZCrqdVf6W75XmrXgTtjMZtFl/TERSToXkqC+r5pmOEf9HYl0NqnOkYSPYj
 UH9PhaaKtIdFMeUXDeKi21+sFKSS/F+P2PxD3EnQy8/00/2zbdaspHfQZf0R65pKwdKZ
 IsEw==
X-Gm-Message-State: AOAM532e1C/dP6rkKJmY5rbl9Lga8eyIVfeSeMUlwCyUDxb1vgs3MT5Z
 3oPqR/jMQZT3U4DFtIBSJAcGM94m
X-Google-Smtp-Source: ABdhPJzKsjQBjZgx7bAQeXpii+MNkT9H3BOM1qbbHolNVqLu8p3j9rybbjIpKcEQH8xSti2BdBwJrQ==
X-Received: by 2002:a5d:6601:: with SMTP id n1mr21605212wru.23.1591607711465; 
 Mon, 08 Jun 2020 02:15:11 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id c5sm18258653wma.20.2020.06.08.02.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 02:15:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/net/opencores_eth: Use definitions instead of magic
 values
Date: Mon,  8 Jun 2020 11:15:07 +0200
Message-Id: <20200608091508.19838-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608091508.19838-1-f4bug@amsat.org>
References: <20200608091508.19838-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use definitions from "hw/net/mii.h".
This also helps when using git-grep.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/opencores_eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index 2ba0dc8c2f..90d3846bb7 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -86,8 +86,8 @@ static void mii_reset(Mii *s)
     s->regs[MII_BMSR] = MII_BMSR_100TX_FD | MII_BMSR_100TX_HD |
         MII_BMSR_10T_FD | MII_BMSR_10T_HD | MII_BMSR_MFPS |
         MII_BMSR_AN_COMP | MII_BMSR_AUTONEG;
-    s->regs[MII_PHYID1] = 0x2000;
-    s->regs[MII_PHYID2] = 0x5c90;
+    s->regs[MII_PHYID1] = DP83848_PHYID1;
+    s->regs[MII_PHYID2] = DP83848_PHYID2;
     s->regs[MII_ANAR] = MII_ANAR_TXFD | MII_ANAR_TX |
         MII_ANAR_10FD | MII_ANAR_10 | MII_ANAR_CSMACD;
     mii_set_link(s, s->link_ok);
-- 
2.21.3



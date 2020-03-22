Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511CFC1975A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 20:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15AB22072D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 20:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6V2qEsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15AB22072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG7dC-0002lK-63
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 16:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jG7cO-0001VA-5B
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 16:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jG7cN-00018N-5u
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 16:54:48 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36838)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jG7cN-00017m-06; Sun, 22 Mar 2020 16:54:47 -0400
Received: by mail-wr1-x444.google.com with SMTP id 31so8420576wrs.3;
 Sun, 22 Mar 2020 13:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Zzy2hYvjYn3wSBM6sGEj1OgFy+nH1+JEHvHfIqt2Yq0=;
 b=l6V2qEsIMwaUc71z0WJb5Sp19aP4RK37tnYt4DmjWM3YxVyiNKD4lwzj/Q+10lBzeI
 YB3we+rfS/rRmn8Jn8s74oWClQsKlwZBiSknwo1J+O4jStt5/u/bIfU+oRUbfN310ZlK
 e5Gko56c1BFryFUyTNnqrppqbh+66DUmGdjrAzFyKzOSv8K/FhTWB/z3wqqk3SD7vJkD
 oRTsCfxzJV2yX02AeIs1ypuRg3soGISYeF5QYcAdvb/FLJdRTxCN4ilpZlxDkMRuhTCd
 Fsh+17W9kO7NBI5OSyklppmCAauCE3nYlljt+sE6SM8IHcDh3B15zytD85Xd6GLIVIsd
 KmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Zzy2hYvjYn3wSBM6sGEj1OgFy+nH1+JEHvHfIqt2Yq0=;
 b=mgEzH/xs5e1XzeoniK96mDhjB8H+NEj5pVtMpBey9iHerEPKDM9jpC5MSYs4lDes+6
 BpzxwD6Wcmkv0PTHtBgdzEHOuBZa1/iJH3chFDGIbemgYq8lVAhp9C8wEmtQQ3C8xBDX
 gwO4edEupG3EJFSdbiwWWmxelFyxMASGLzmVrL8wnQB4DoW50HUDHyZCicLW7gnn7fuS
 3brQvDVFQXHSf+1+2iVTyq8ylT9BjFZ5LP9bkD1gfgcBWrM3DfCA9OaWsszaWkPvYjru
 RTjT0hARQ9/85DxwpN/cuscouCwvRahjxExs71LrbCP3DpGVTEejMGyNC0eAdo8sQAk/
 Z4Vg==
X-Gm-Message-State: ANhLgQ2cYMpKROlHn5edON97L1bq+BboWF6j03mRPx+7j8wfwTprRi9/
 zjIIUz7np/7NWlj2P+nkFykH/Kn6
X-Google-Smtp-Source: ADFU+vvE920e1KPDRAa4ZwBYPZTJmg3+1k0Rg4pMnvW9VnwmUDTwT4Pziif/F8lVUOx2VW9ugyOFBQ==
X-Received: by 2002:adf:f6c7:: with SMTP id y7mr26054380wrp.269.1584910485802; 
 Sun, 22 Mar 2020 13:54:45 -0700 (PDT)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id w7sm21083875wrr.60.2020.03.22.13.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2020 13:54:45 -0700 (PDT)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/misc/allwinner-h3-dramc: enforce 64-bit multiply when
 calculating row mirror address
Date: Sun, 22 Mar 2020 21:54:39 +0100
Message-Id: <20200322205439.15231-2-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200322205439.15231-1-nieklinnenbank@gmail.com>
References: <20200322205439.15231-1-nieklinnenbank@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: peter.maydell@linaro.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The allwinner_h3_dramc_map_rows function simulates row addressing behavior
when bootloader software attempts to detect the amount of available SDRAM.

Currently the line that calculates the 64-bit address of the mirrored row
uses a signed 32-bit multiply operation that in theory could result in the
upper 32-bit be all 1s. This commit ensures that the row mirror address
is calculated using only 64-bit operations.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 hw/misc/allwinner-h3-dramc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/allwinner-h3-dramc.c b/hw/misc/allwinner-h3-dramc.c
index 2b5260260e..f9f05b5384 100644
--- a/hw/misc/allwinner-h3-dramc.c
+++ b/hw/misc/allwinner-h3-dramc.c
@@ -85,8 +85,8 @@ static void allwinner_h3_dramc_map_rows(AwH3DramCtlState *s, uint8_t row_bits,
 
     } else if (row_bits_actual) {
         /* Row bits not matching ram_size, install the rows mirror */
-        hwaddr row_mirror = s->ram_addr + ((1 << (row_bits_actual +
-                                                  bank_bits)) * page_size);
+        hwaddr row_mirror = s->ram_addr + ((1UL << (row_bits_actual +
+                                                    bank_bits)) * page_size);
 
         memory_region_set_enabled(&s->row_mirror_alias, true);
         memory_region_set_address(&s->row_mirror_alias, row_mirror);
-- 
2.17.1



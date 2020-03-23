Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A244C4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:30:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4595C2051A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIkl9Yjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4595C2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGSmg-0001jI-9O
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 15:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jGSlq-00018V-0L
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jGSlo-0004t5-Ew
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:29:57 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40706)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jGSlo-0004sS-9E; Mon, 23 Mar 2020 15:29:56 -0400
Received: by mail-wm1-x344.google.com with SMTP id a81so762478wmf.5;
 Mon, 23 Mar 2020 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=aFZT4+DtltuOgjmsXEVbjJcqCfMa/s86Y31iza4rRjo=;
 b=sIkl9Yjj27jEs30EH2dKNvFFiFedWHffVOg9iqD+7BfQvIrHWDLGplk+DlXjDImCuH
 GoDdleHXHB6JiTU3A+BMRECUEcXODMjclI5Yt0vQ+4ebcj6ByVXSsl6YEKA/rN44ZihC
 X1hsZRzov7SE++VeWh6SKkKKwyK88Ihx6kzZw2knNOxJsM7cSYNc04YY+2h58R2s2/i5
 owWeEenzw+pp49W0D11VdOIyZPwPj+aOme8P/DFfGSZL2F6y2KF1EAYVhHQwSt3txhh7
 WW8SVo0NrMysLmQhVfNkAR1gOPdTRZ1MJShKjUw4AdB/fOaFwcLfEtQKhRWOOAdW0RaE
 Oo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=aFZT4+DtltuOgjmsXEVbjJcqCfMa/s86Y31iza4rRjo=;
 b=r+AE9+OCXv8xup7T4tzVRehtdOSvEDXTQywWbq4pd4bD1jHDVwnFm1eTgqj1cUSMaF
 jdH4yN3H4qFP/pWN6XVpArmInjbfvy0fT2DmuIfHpJZsxlzKfA/XyhY2dc17SCNyaw+E
 z7Ki7e5O1Ii9/Qa6ez0qCZ8HB+BfM/bP9YCslPOaALn+oBi3YJeSVGq83Yyf9TbBBijy
 x/aLNR2G402Sq2+0qmD5jaaJ698duREdAyzDBvd509gqa2VWwnBgRJctBuEM7EBfTnz6
 tU+lHX6EByJGmuW2Z6JRptUCk689bCTjyT9PvqPMfjpQDGmfASCvSmQcgxky8rJ6PW5w
 +V0g==
X-Gm-Message-State: ANhLgQ3aJZN3ug1Iqrn7o0qhYWVqaDa+ams7z3SxcbOKD5Hgb+iAiogf
 gXxAzMYDT++W811UB2hOqszlR3cs
X-Google-Smtp-Source: ADFU+vsPx2pq67X07DqV/CX52IAuYyA9iqJp4vckie2QK6NjUdOGWrFi4Itbe2jzX/gLFKv7qRw4eg==
X-Received: by 2002:a1c:ba06:: with SMTP id k6mr977978wmf.136.1584991793474;
 Mon, 23 Mar 2020 12:29:53 -0700 (PDT)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id t124sm769364wmg.13.2020.03.23.12.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 12:29:52 -0700 (PDT)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/misc/allwinner-h3-dramc: enforce 64-bit multiply when
 calculating row mirror address
Date: Mon, 23 Mar 2020 20:29:44 +0100
Message-Id: <20200323192944.5967-1-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
index 2b5260260e..1d37cf422c 100644
--- a/hw/misc/allwinner-h3-dramc.c
+++ b/hw/misc/allwinner-h3-dramc.c
@@ -85,8 +85,8 @@ static void allwinner_h3_dramc_map_rows(AwH3DramCtlState *s, uint8_t row_bits,
 
     } else if (row_bits_actual) {
         /* Row bits not matching ram_size, install the rows mirror */
-        hwaddr row_mirror = s->ram_addr + ((1 << (row_bits_actual +
-                                                  bank_bits)) * page_size);
+        hwaddr row_mirror = s->ram_addr + ((1ULL << (row_bits_actual +
+                                                     bank_bits)) * page_size);
 
         memory_region_set_enabled(&s->row_mirror_alias, true);
         memory_region_set_address(&s->row_mirror_alias, row_mirror);
-- 
2.17.1



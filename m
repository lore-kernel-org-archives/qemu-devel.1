Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5665CC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2237620873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gYS+CSws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2237620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2G6V-0004HO-8m
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:08:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhO-0004n0-8G
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhM-0002OS-V1
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:38 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:38068)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2FhM-0002IH-OV
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:36 -0500
Received: by mail-wr1-x434.google.com with SMTP id y17so6985213wrh.5
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Q9e7uYuHp7WmXaVUmzVEpdJqH/noVIYn8omsNxWs6hg=;
 b=gYS+CSwsM9/WEBEUpJ4UyzuDvoxX/lqMQ+MYrMk9HFM+m3PYr3gtQyQlMHHc84TKpg
 IUGX84wAW0A9mSEF0sMenylP1g+gvl6DYr3QFqDVWUF76p7XF9K0D2pqjxJXeh1HFv/V
 2cwDsi3d5/CM74pQ9QYVGIjHgoor5mSLCF+dID3a8KGwTiR9Le+XibGC1oHp9ZlPzXmA
 VmjXT6iUojukYuTxoGWd+fi3SsK8wUa/DdBM2KUOZEHuvdj4vltMVTigJpYw/1OPd4AU
 uQjiHy2PJ0s5WdNnCd6ZAgEhypeVP76xqJnvuc4PAUKKlrK5+ttC53JtDnUm01DxUfJI
 BWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q9e7uYuHp7WmXaVUmzVEpdJqH/noVIYn8omsNxWs6hg=;
 b=LBEr03lnmFouYwwae5ENyssZa+UfUSeu6wm5cTBpoW6ThWM9w2afQFAv3F8LauOXFV
 EZc9mGrGAaM80Tvb1Y/K43eEO72aLXbTAZzAURRa+hEC++HROApa6wyN9dyK0XW3Wtlo
 7RzB6YrxksKyj6mXPqtQforEDYdbag0TPB4JPPCkHBTHW0Rr4q6Xcya3C3rWQsJZwbPy
 XTi0kHwP+ADyxwp4XRnWmx9L19TMv3CyE5lU8dA0o0uQrvPWYcTw2JK5RKAJLOl2Q5AT
 p006e5Aco5zpuNEAA/eOPDuEBNj7VGPK4fE3krAZBbt7yPxl0U4FTnT1fTVS42yeOWMl
 ndDg==
X-Gm-Message-State: APjAAAV4XV2H0bCot0EFGqpZMbCtYTahZkrOtwOllEwovV9bGrC+Wulv
 J5H7mbxUGr7E48WlO5geoByvL3m6n+0=
X-Google-Smtp-Source: APXvYqwFbXNGaFjVv8At5zv+/CXSXoFuHeS7u6Xm1kCBHEOONwb7zQ4OqsTz5CIdrVsQwvlFnaQKUA==
X-Received: by 2002:adf:f802:: with SMTP id s2mr23549703wrp.201.1581604946456; 
 Thu, 13 Feb 2020 06:42:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/46] hw/arm/raspi: Correct the board descriptions
Date: Thu, 13 Feb 2020 14:41:33 +0000
Message-Id: <20200213144145.818-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We hardcode the board revision as 0xa21041 for the raspi2, and
0xa02082 for the raspi3:

  166 static void raspi_init(MachineState *machine, int version)
  167 {
  ...
  194     int board_rev = version == 3 ? 0xa02082 : 0xa21041;

These revision codes are for the 2B and 3B models, see:
https://www.raspberrypi.org/documentation/hardware/raspberrypi/revision-codes/README.md

Correct the board description.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200208165645.15657-3-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index f2ccabc6628..818146fdbb2 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -221,7 +221,7 @@ static void raspi2_init(MachineState *machine)
 
 static void raspi2_machine_init(MachineClass *mc)
 {
-    mc->desc = "Raspberry Pi 2";
+    mc->desc = "Raspberry Pi 2B";
     mc->init = raspi2_init;
     mc->block_default_type = IF_SD;
     mc->no_parallel = 1;
@@ -243,7 +243,7 @@ static void raspi3_init(MachineState *machine)
 
 static void raspi3_machine_init(MachineClass *mc)
 {
-    mc->desc = "Raspberry Pi 3";
+    mc->desc = "Raspberry Pi 3B";
     mc->init = raspi3_init;
     mc->block_default_type = IF_SD;
     mc->no_parallel = 1;
-- 
2.20.1



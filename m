Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB3EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF8520885
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cM0cBZBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF8520885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiLU2-0004cd-Dy
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 13:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiLT5-0003lI-BB
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:21:51 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiLT4-0005rx-N1
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:21:51 -0400
Received: by mail-wm1-x341.google.com with SMTP id d128so327396wmc.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l3OsN3VBIWH0n5zIcjstWrd5n5XCWgTvFGwOC1jVbxI=;
 b=cM0cBZBjzBaa73hwBeCtp7gFI4WxRVUI0ZKU/z8cDwsJRQDqZuU4FqUp6pXsUFpIZi
 hLuFIiPKWBMmT0sLZAxIVQm+GfX/+TdvMsNNdTASl2U8BwrpBbqmJH1kJzmU3oU5KBiz
 QB5DOoxwx5ziKZuHq1hqBwEIwZE9AGnb24QNEfmjhBYLyNgGBpaJ41tILSQfTRKQT5nb
 FH8ikkBXlcry+QXWdWqE8oJmhgrd2Z7B5zg2aMcxre/9AruZxahtRowKex3t5s96/wbv
 PE3zOg4xv8N1Q7WRJm71bkQ/MF2Ici+XSpp4pzZDR61fGR3iPCmXdaewJgjb1jXj0hIu
 wssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=l3OsN3VBIWH0n5zIcjstWrd5n5XCWgTvFGwOC1jVbxI=;
 b=jffyhJH6Fg413ne7QlwQKxTH9i2pBZxWBuxUo3k+PvpGfs33vIkhIALeN67ko+uqRS
 rKhK+XyD229w3NdZ48S13IfyvuA5Zzhr9zzf7q7H0ByrxlpzDBhHktliktelybbmmOQT
 1dDEtGnlh3+2XhUI5D6Eh72kHsYB/dOA2HyXJzWMM7kDaoSua449xgNRuBtMJTQ6uoyU
 UlRWDGD3nMiZrx7cX0PLiqR2GXmZGW6+eCxTYhJ7lvu1xm2NQ5wn0vlNvztmMiUoRTYS
 rcicC1oLZAR/37gANal4yBCuifZbu9UGxNecrcxxqTbi4Dw+VOfXPvFSdSKC2vTlTywA
 VtDw==
X-Gm-Message-State: AOAM531wQ9GXOhB/p47rrpVimmlYTF+gaWKFyK13CnT3SyuOvDhen8Gr
 nZX04qeiLSABVDBPDSJ6FLHPur3Y
X-Google-Smtp-Source: ABdhPJz1NLE8O+1HvA3RNz5C/WFFasAzKCC2DwHb0Tf8wFweN0EA6nA+SELXg25Y+gCpgDGrQO4ECA==
X-Received: by 2002:a1c:dd44:: with SMTP id u65mr383461wmg.180.1591636909084; 
 Mon, 08 Jun 2020 10:21:49 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id n23sm223618wmc.0.2020.06.08.10.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 10:21:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] hw/sparc64/niagara: Map the UART device unconditionally
Date: Mon,  8 Jun 2020 19:21:44 +0200
Message-Id: <20200608172144.20461-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608172144.20461-1-f4bug@amsat.org>
References: <20200608172144.20461-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The UART is present on the machine regardless there is a
character device connected to it. Map it unconditionally.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sparc64/niagara.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 201fb05d50..a87d55f6bb 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -151,10 +151,8 @@ static void niagara_init(MachineState *machine)
             exit(1);
         }
     }
-    if (serial_hd(0)) {
-        serial_mm_init(sysmem, NIAGARA_UART_BASE, 0, NULL, 115200,
-                       serial_hd(0), DEVICE_BIG_ENDIAN);
-    }
+    serial_mm_init(sysmem, NIAGARA_UART_BASE, 0, NULL,
+                   115200, serial_hd(0), DEVICE_BIG_ENDIAN);
     create_unimplemented_device("sun4v-iob", NIAGARA_IOBBASE, NIAGARA_IOBSIZE);
     sun4v_rtc_init(NIAGARA_RTC_BASE);
 }
-- 
2.21.3



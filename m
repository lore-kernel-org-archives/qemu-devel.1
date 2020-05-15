Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2316DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E12902054F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6N85Fzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12902054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZVvt-000055-51
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 04:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZVv9-00085h-5X
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:42:19 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZVv3-0002au-Sv
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:42:18 -0400
Received: by mail-wr1-x441.google.com with SMTP id l11so2586202wru.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 01:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UGHia7OPwnpjBQqXAnZTtbhaJ1+gtteX4DXlcTT506w=;
 b=l6N85FzbX0JAzkQhYC9GfJBhyHTb1psuc4YixAiOEwXw+TFS1AtoKr3vUKpmD2Ve3j
 88TQLGhaZuHCuX1OUKvSAQwAGATq6HKj0KMru7JANIsvzdaXPUv2tKCSjcklKgkPRVzO
 3afjfF2HT1KxvevOJ1ktPlaWtX+NNYUngZemCrdAL5HHU7ybqy0JCM/SegpU9A19nXVG
 1LxmBMcZOGAeIvi6BGvW9/RYAU15MSd+PLmQl5S40GbMPbfLGlfO+ySvSbTlsewubJue
 n7IdqvsCHr73vifAiiQGSf5VEKYDIKxItjmdPcLlfsNkALM3ufB3g4+0vFVXHdEUY30q
 Y9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=UGHia7OPwnpjBQqXAnZTtbhaJ1+gtteX4DXlcTT506w=;
 b=CIasSlmXPRogF4KNpF/Dwv8mbaQ2KWlqhUjyEtTpoG/CNCSGMuhRCdCGFUWGY/fgRB
 ln9+Md2J2megmFVOvGRl5U1eh9FwM7pSQwcyFRrnHxckHjkhea9dyfIFqkieWm9KjYGh
 6ccXOHaMHKGGsbxxgWb7hTYMJ/y+XLykiSEzwyH2DuPdx15lt2wCuB0mb6pBlW9hwdP3
 L6M9R8dp+OiI56WZruWflVZLy5r+QXIenCBiGzklF+YleOLeuZQDoV8zzNuFwdQEYlfD
 5r2E5l4pxjOVXbhs8wL8L+UAixNeD1pTQ9la+Iv2399QSEOLKZ9biSd0F+DLxa0aW/ZC
 PC6A==
X-Gm-Message-State: AOAM530TMY5q1F+fUf7sRMj5KPZmX+X/kh0zC21JnWHpcO7mza+inbRu
 E6DaIMmWBubLfF2NlD0aF8P1eiq1tU8=
X-Google-Smtp-Source: ABdhPJy9jukBFrBWX6VitDxwDVsaLLTGfjVhCjNsfWT1RwPvLjgR8BymwontobLnRoDA9LBcA1jsig==
X-Received: by 2002:a5d:668d:: with SMTP id l13mr2965226wru.214.1589532132191; 
 Fri, 15 May 2020 01:42:12 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id b19sm2691869wmd.26.2020.05.15.01.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 01:42:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/mips/mips_fulong2e: Remove unused 'audio/audio.h' include
Date: Fri, 15 May 2020 10:42:09 +0200
Message-Id: <20200515084209.9419-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Fuloong machine never had to use "audio/audio.h", remove it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/mips_fulong2e.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index ef02d54b33..05b9efa516 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -33,7 +33,6 @@
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
 #include "hw/pci/pci.h"
-#include "audio/audio.h"
 #include "qemu/log.h"
 #include "hw/loader.h"
 #include "hw/ide/pci.h"
-- 
2.21.3



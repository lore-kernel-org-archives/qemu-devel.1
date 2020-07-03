Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A26FC433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:10:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF055204EA
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NTyIN0ns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF055204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPCc-0005jV-3G
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxe-0005sj-BG
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:50 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxY-0005oj-GB
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:49 -0400
Received: by mail-wr1-x441.google.com with SMTP id s10so33384355wrw.12
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=VKvp3GygN6NnSayidALafcM4t4tV8T/cgZll1mJohvM=;
 b=NTyIN0ns1+eSMr4oOtscO/0nnHqmiA0KUWOeizBulFcWpsQt5nYQqVzqo9Uew0KkTR
 5zdNGPKcvfod5SVYumuQ+mXtJTkIw7u6wqMw+yDbFhQq9aBpQsEpWeXb+2hj5aVJO2Di
 iikeml2zfcSflRtTZMs87NOSmDLwfzddKok0lFsLp3xKmdCM8NygtJvLbjXSeD6kHtc7
 PP+1OvnER8vn0EX2eEmf6DhF2fr72mtrR2T8stgTT7w0yf+MnQrP5Oaip1YNuvL19ugE
 D3OR3PXrFeswP60q5wCLXAAj98FbyXqprDaWN5cW69/8enBCHEVLBmIAD7Nc33ojGKjm
 16gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VKvp3GygN6NnSayidALafcM4t4tV8T/cgZll1mJohvM=;
 b=tyUrsYfLxDyWt8p4uTnA8PbzSKb2jMgJeg4m4cnDZDYeEsLxgjweX1Omvs+0faOqkp
 exPGIQevzdo9f3nRhaq2hE27/wirD1RzbPYGywaCXoq0owXLmQjFOTz1+F8lLVAsrsWc
 +CBgwFUrXe8iefF+jwVx4SuEmClsG5SDccDFYy3ZTU4lyoRBlLduTLtDEtCM2e+WjqY8
 9qq6Cy70wGnjpFz9UJ7dOMeX5fCeUPe6lDt7W40vFSC+n3L1iM5xi1avsWTRW+adxY47
 dpsAoE5qkEnFEtPy2lx2qUP1uyPXXIpiNdeaVdoVBGt2u3xe/8pbIA032oHuoRToHj2f
 eQMQ==
X-Gm-Message-State: AOAM531/EQeRoiaVg4ud760/yXRNnTJRr3KAfZcBOyCVOFP27iLVJsAl
 v99Gvv6qDCH4c0eGRfmQ79ARjBXH6Zqc3A==
X-Google-Smtp-Source: ABdhPJzUJEN/pj5+7JN7/vRmMYXVVZ+ANSmGGqiZMogjQcw3xu/jIc8wiYX60ym1nIF2Y/gc7LeYuQ==
X-Received: by 2002:a5d:68c7:: with SMTP id p7mr39704358wrw.16.1593795282877; 
 Fri, 03 Jul 2020 09:54:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/34] hw/arm/pxa2xx_pic: Use LOG_GUEST_ERROR for bad guest
 register accesses
Date: Fri,  3 Jul 2020 17:54:02 +0100
Message-Id: <20200703165405.17672-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of using printf() for logging guest accesses to invalid
register offsets in the pxa2xx PIC device, use the usual
qemu_log_mask(LOG_GUEST_ERROR,...).

This was the only user of the REG_FMT macro in pxa.h, so we can
remove that.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200628142429.17111-16-peter.maydell@linaro.org
---
 include/hw/arm/pxa.h | 1 -
 hw/arm/pxa2xx_pic.c  | 9 +++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
index f6dfb5c0cf0..8843e5f9107 100644
--- a/include/hw/arm/pxa.h
+++ b/include/hw/arm/pxa.h
@@ -184,7 +184,6 @@ struct PXA2xxI2SState {
 };
 
 # define PA_FMT			"0x%08lx"
-# define REG_FMT		"0x" TARGET_FMT_plx
 
 PXA2xxState *pxa270_init(MemoryRegion *address_space, unsigned int sdram_size,
                          const char *revision);
diff --git a/hw/arm/pxa2xx_pic.c b/hw/arm/pxa2xx_pic.c
index 105c5e63f2f..ceee6aa48db 100644
--- a/hw/arm/pxa2xx_pic.c
+++ b/hw/arm/pxa2xx_pic.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "hw/arm/pxa.h"
 #include "hw/sysbus.h"
@@ -166,7 +167,9 @@ static uint64_t pxa2xx_pic_mem_read(void *opaque, hwaddr offset,
     case ICHP:	/* Highest Priority register */
         return pxa2xx_pic_highest(s);
     default:
-        printf("%s: Bad register offset " REG_FMT "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "pxa2xx_pic_mem_read: bad register offset 0x%" HWADDR_PRIx
+                      "\n", offset);
         return 0;
     }
 }
@@ -199,7 +202,9 @@ static void pxa2xx_pic_mem_write(void *opaque, hwaddr offset,
         s->priority[32 + ((offset - IPR32) >> 2)] = value & 0x8000003f;
         break;
     default:
-        printf("%s: Bad register offset " REG_FMT "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "pxa2xx_pic_mem_write: bad register offset 0x%"
+                      HWADDR_PRIx "\n", offset);
         return;
     }
     pxa2xx_pic_update(opaque);
-- 
2.20.1



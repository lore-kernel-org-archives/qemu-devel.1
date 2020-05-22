Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CC6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 11:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F906206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 11:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxBVMRpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F906206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc6ET-0005pH-9B
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 07:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <e.mikitas@gmail.com>)
 id 1jc6Cg-0003JP-9Q; Fri, 22 May 2020 07:51:06 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <e.mikitas@gmail.com>)
 id 1jc6Cf-0004cP-Bl; Fri, 22 May 2020 07:51:05 -0400
Received: by mail-wm1-x342.google.com with SMTP id f13so8374141wmc.5;
 Fri, 22 May 2020 04:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ATw2AQdt0tMLUBC524HixfrRhPl572ZT8HtNHYF2xvw=;
 b=dxBVMRpg+o021KVHz5A8ks0zutiZTujaLqO42y2jmH0xWCjP6saCePCEciz/aotlv2
 auN9x41lY5UXjVFoi2hQdFPA5caXoKjxjqXL0gpC1cCvwCQVeCCQ+VHbAnxfAMkWsnv5
 8BLDHzi6xsH3htbgiKiI8rnRYEwFVb8nekUuvXBDovBDHCdBA2sBbDUXdbzRrJSCIo4i
 AiaQox3x70+aaDcnuJ+BboGY8Kpp3zLmjwcpS0cKpQGzv71EIwK+P33+cq4UrWMF8pPQ
 yoHOVZrcfsjj8MmASQuZnmCLoh+Rsa0ZBTnsZAxdsOeDNlJWZXRsCP7rBOQ2/0clZ/yC
 bggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ATw2AQdt0tMLUBC524HixfrRhPl572ZT8HtNHYF2xvw=;
 b=re4ndstB6uSFYJRxJbGZTuPIqqxlJKGRQSPS3yc80tk6ohj9LsS3Ss1dTU/aCc75qt
 SxejqNCYZamwuh0GEFILqPhPsIOVrdz4692TZJ1Q+GO0e6O3HR9bI42N1EDpjLFHC+gU
 me9ZsdzP/nRPweWsXJEPryS4UPK+tE7IC2rEAHMNOkye4VBqP4+UaE8iZ6TCeuHwV93+
 VECfnNXu0nq03DyNTNEOSIgIAa53kIlqWtna39+KDST0NGu/JP4FLXU4s9UbVVD0UMib
 gtctvv3r7uxs6i9jLUkd/EMJS4YHxSuCbW+fJ9xt4RDNHR8r3FxxBBR7hd8PyVC4/XZ7
 erEQ==
X-Gm-Message-State: AOAM530j8f0u7c4iX4F4gcfX8G9FWzJV4S1EFrYXy1evgjGvaWKbEotw
 xwWLM97tNBFSpgUoHh+yvM0=
X-Google-Smtp-Source: ABdhPJx4pJZpBmySqwHifSC2uYjzqgo1cF1Z9J0UvHeHi7upWFmPmdioA+AqPcCwgKmjeIsw3Ye1TA==
X-Received: by 2002:a1c:dc05:: with SMTP id t5mr13600278wmg.112.1590148262694; 
 Fri, 22 May 2020 04:51:02 -0700 (PDT)
Received: from eden-linux.lan (bzq-109-66-59-205.red.bezeqint.net.
 [109.66.59.205])
 by smtp.gmail.com with ESMTPSA id m3sm9237640wrn.96.2020.05.22.04.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 04:51:01 -0700 (PDT)
From: Eden Mikitas <e.mikitas@gmail.com>
To: peter.maydell@linaro.org
Subject: [PATCH 2/2] hw/ssi/imx_spi: Removed unnecessary cast of rx data
 received from slave
Date: Fri, 22 May 2020 14:50:36 +0300
Message-Id: <20200522115036.31516-3-e.mikitas@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522115036.31516-1-e.mikitas@gmail.com>
References: <CAFEAcA8FFc_Vf-UQO9f_3qoXiCJf9N1uWh7qB-WXrEWTzKBu8Q@mail.gmail.com>
 <20200522115036.31516-1-e.mikitas@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=e.mikitas@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, alistair@alistair23.me, qemu-devel@nongnu.org,
 jcd@tribudubois.net, qemu-arm@nongnu.org, peter.chubb@nicta.com.au,
 e.mikitas@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When inserting the value retrieved (rx) from the spi slave, rx is pushed to
rx_fifo after being cast to uint8_t. rx_fifo is a fifo32, and the rx
register the driver uses is also 32 bit. This zeroes the 24 most
significant bits of rx. This proved problematic with devices that expect to
use the whole 32 bits of the rx register.

Signed-off-by: Eden Mikitas <e.mikitas@gmail.com>
---
 hw/ssi/imx_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index 6fef5c7958..43b2f14dd2 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -206,7 +206,7 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
         if (fifo32_is_full(&s->rx_fifo)) {
             s->regs[ECSPI_STATREG] |= ECSPI_STATREG_RO;
         } else {
-            fifo32_push(&s->rx_fifo, (uint8_t)rx);
+            fifo32_push(&s->rx_fifo, rx);
         }
 
         if (s->burst_length <= 0) {
-- 
2.17.1



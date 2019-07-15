Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3310BC76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E342067C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nWnlgsY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E342067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1GU-0004Zu-VJ
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51759)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1FF-0007oG-Vq
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1FE-0006AR-UC
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:21 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:50263)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hn1FC-00068b-Uf
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id v15so15252419wml.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 06:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=L2IhKlit3pXJDd+/6R6m/mSK1+w4V2YJU+DGORWiSMg=;
 b=nWnlgsY+0S6B38l9dOW2G9sA2y5vmMYi8C5f1Mn21xdJ3GmSLtshqwFuSJlDEtSD6L
 HjMw4pQMQxS/0ZapAe0eDgJktaLFshXFItfDSD6/dJ/JK9ZxbFsi0qNg2ma4vNOhe+eJ
 bGELrVyTia6YjniCBg8+Yy8bB85XupSXTFXk6iefQQJI5pEsg/9elkVUrjkPT4P7ve3M
 42bQY9rWIFIjrRy4DjtR0hPkHalcwLftaLON3RbdPd5oRT8Yy0Aq/3vGFiyZ3zyCM/l7
 xfaUEuimMfNpX8V1r0X2tldGmSCo/CgZnj3mZGoFkOMisMs838LvP7smRSwyXb/O0g7a
 h+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L2IhKlit3pXJDd+/6R6m/mSK1+w4V2YJU+DGORWiSMg=;
 b=HZEXzakCkmstQ0trWSVxVBusiDbcKKETetYlehI1JVGZLpReKAXcO1tEbXbHr5WXX4
 Twe8F6dwO1ahOxOQO+8iro6rzgcAQ45/AGnRcaneFQ8TEGx3u5iDyNv/ajGYquDfmARh
 DBEsubA+cTQwgJ+lb9peEa9SJRbPGtcTM2tzI2esI5OMlmNnO/hZqh590FUxejbjsuj+
 67xXowEPyR8yRDSbML6QKO2CuaRLtA2CVCpyoGmNxW28DUQ0rSaHSikseFSFbUgF2Qrg
 1TZ7BgGAdrPuB8+47llCMd6YCo/Ma/YojGaHlPC0Enufuh+0r1sSrDMkjrLfZ0X1I13f
 9QSg==
X-Gm-Message-State: APjAAAVRC5bjmX0rEq1FcCy3UhgDEdJGXp1+dAGFCP4z+zLfDIvtKrvx
 DKkTvYGiaHI5bp3jGt07G/Tt9wvkasUa8A==
X-Google-Smtp-Source: APXvYqz2Yyib+vGkjvNfRv7bBaFsoFzOXVVMHViD+LWxyi9w8cnlWnI0lcs4evdBIHfx8mR52jrJuQ==
X-Received: by 2002:a7b:ce01:: with SMTP id m1mr24706428wmc.1.1563198137172;
 Mon, 15 Jul 2019 06:42:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c7sm14221808wro.70.2019.07.15.06.42.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 06:42:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 14:42:05 +0100
Message-Id: <20190715134211.23063-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134211.23063-1-peter.maydell@linaro.org>
References: <20190715134211.23063-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: [Qemu-devel] [PULL 04/10] hw/ssi/xilinx_spips: Avoid out-of-bound
 access to lqspi_buf[]
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Both lqspi_read() and lqspi_load_cache() expect a 32-bit
aligned address.

>From UG1085 datasheet [*] chapter on 'Quad-SPI Controller':

  Transfer Size Limitations

    Because of the 32-bit wide TX, RX, and generic FIFO, all
    APB/AXI transfers must be an integer multiple of 4-bytes.
    Shorter transfers are not possible.

Set MemoryRegionOps.impl values to force 32-bit accesses,
this way we are sure we do not access the lqspi_buf[] array
out of bound.

[*] https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultrascale-trm.pdf

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Tested-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/xilinx_spips.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 3c4e8365ee1..b29e0a4a89e 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -1239,6 +1239,10 @@ static const MemoryRegionOps lqspi_ops = {
     .read_with_attrs = lqspi_read,
     .write_with_attrs = lqspi_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4
-- 
2.20.1



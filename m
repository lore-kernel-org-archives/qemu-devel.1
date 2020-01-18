Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B112C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 16:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6734F2469A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 16:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPz//ZtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6734F2469A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isrD6-0006Mi-3V
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 11:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1isrBL-00046W-OL
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 11:42:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1isrBK-0002CU-LQ
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 11:42:43 -0500
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:40115)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1isrBI-0002Ao-HV; Sat, 18 Jan 2020 11:42:40 -0500
Received: by mail-yb1-xb41.google.com with SMTP id l197so6015446ybf.7;
 Sat, 18 Jan 2020 08:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vU+VqIHGN1BijkfK3vPdPlxjr39cqTq4olg29px/6oo=;
 b=uPz//ZtFoeXIRURh/9ksxf+hkfCDupjqzy4v7RMYejungSB8UGniLRo0oUwKrbhS1o
 yVZL+p2z32a/UtiggylKrVWXE4Z01CVCFPvi5ww4nailqxfRUH5enIzXWvkLyIkwsja3
 69zS4IdOpzygUEuLtiQGGvmHvON8ovi6SplW0/ZY9tO02oji32TBBkXXL7qc/RiauLdP
 /QKKwTBoW8+Ln+ohvsbfoBYCz3EsZaQf5q2PzEei4WOReaPcGMVl2v9kMBKRs9v7Hl2Y
 xX9mqGJVaZIbyJt/7OG0MnpZohvfYaCKBtRKIkjDTVpFJNwOwR61p1p9dSeQCJ86+2wX
 5xpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=vU+VqIHGN1BijkfK3vPdPlxjr39cqTq4olg29px/6oo=;
 b=XlcYGjs+351/PhjLztbrBYNd3gonKLMd/dNRkjtqafLAYDW4IygVXUM4eEL2WDCD88
 xeRt1ryItsR4NDXvB8531hm+J0XRnnqLeFwByvYRn4WH2KrAlRPVcN8qniGv/IEoVDon
 e1IqS1ycS8smSdNBSIE+GUFaskE2+TRB/wy8/8uPlF4duln52UN4ql4bvOuG1tArhMPw
 hBPgPQncg0TeC3cx8oTD1du8xXmVIRKiju8OLxX+/qpOP4mVU8HClIALsHOGRqVN7FZK
 NlZKTCIUrQ52uxcP9Y4jEgUF+yxXvSqVTG6t9EsJekMcbhLaYugtLbNJoWAgLjSahcNZ
 pWjw==
X-Gm-Message-State: APjAAAXBupivMl9WV/vn3NYPHeSpOHKeb5Lc0I7GY9bkli208G39CTaT
 NtGx7CpOdjMUo4GXk+ZKjlE=
X-Google-Smtp-Source: APXvYqxuI8jlZ/9JfRavArGuLtrk2ZcU5phOrvHEE3ldyyRLCqEPGjYFlmx86VZnUZcF/ptz2kkURg==
X-Received: by 2002:a25:5944:: with SMTP id n65mr5248639ybb.291.1579365760077; 
 Sat, 18 Jan 2020 08:42:40 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id a128sm13431651ywh.60.2020.01.18.08.42.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 18 Jan 2020 08:42:39 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 4/7] hw/char/exynos4210_uart: Implement post_load function
Date: Sat, 18 Jan 2020 08:42:26 -0800
Message-Id: <20200118164229.22539-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200118164229.22539-1-linux@roeck-us.net>
References: <20200118164229.22539-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After restoring a VM, serial parameters need to be updated to reflect
restored register values. Implement a post_load function to handle this
situation.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v4: Additional patch to implement post-load functionality
    in exynos uart driver. Required for next patch in series.

 hw/char/exynos4210_uart.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index fb7a3ebd09..5d48701b6d 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -522,10 +522,20 @@ static void exynos4210_uart_reset(DeviceState *dev)
     trace_exynos_uart_rxsize(s->channel, s->rx.size);
 }
 
+static int exynos4210_uart_post_load(void *opaque, int version_id)
+{
+    Exynos4210UartState *s = (Exynos4210UartState *)opaque;
+
+    exynos4210_uart_update_parameters(s);
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_exynos4210_uart_fifo = {
     .name = "exynos4210.uart.fifo",
     .version_id = 1,
     .minimum_version_id = 1,
+    .post_load = exynos4210_uart_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(sp, Exynos4210UartFIFO),
         VMSTATE_UINT32(rp, Exynos4210UartFIFO),
-- 
2.17.1



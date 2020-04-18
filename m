Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FDEC2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 08:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09CFA21D7E
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 08:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpbE5lcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CFA21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPjE9-00083T-3k
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 04:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rfried.dev@gmail.com>) id 1jPjD4-0007Ry-E1
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 04:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rfried.dev@gmail.com>) id 1jPjD3-0003Hk-CL
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 04:52:22 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43774)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rfried.dev@gmail.com>)
 id 1jPjCy-0002ni-VS; Sat, 18 Apr 2020 04:52:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id i10so5639368wrv.10;
 Sat, 18 Apr 2020 01:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DVmUkRypS4yJb7fuz5VWblU8qv2S4JA+/u3qEKCQZHM=;
 b=WpbE5lcp2LmiFfZUub8cHiARORuIc1AmK5OwVi6DQbT+dgfKaVYeivVOSn00TqyHwa
 eXLrdE8FCxU+0bGHTjg7ew7xy1Q3BRTbf3dPBd3BmPw85EoeOU2fnB/UgP8R5vJ/FWuR
 o3kv7GDIx77lpaj9cw9oa5MgrLPJUH4KTmVuF6/g2issZ1o0dt2aL7f3UUVHHnT1AYk5
 wGTCif/9tC7inlWAIXyp4x+nivyRz4g7fnqtF1DF4W81CyzVaNamz/EXsuR0YuFX8HLJ
 L2q5wg5E3ufJz9Ha40McPICSbEI2e6bVP38S1et+LK8QAxQdsp69kBC4MauYbqBnN9mm
 g8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DVmUkRypS4yJb7fuz5VWblU8qv2S4JA+/u3qEKCQZHM=;
 b=nEC0AvmHUtlWSzgL4qxE/a/HupkOAQS6gBxjR3pobWuCmPyKXy77nT+JBw2bAW3Axz
 uCz1o4gRhZHwmqVRCqozvlCvtY3AxLrfHEFQ3m6RWgX0TdQcF5shN/omRDRzu9eLz4fR
 HVC2+2jkJIErADSg0YEafzF6wZTJwWf+EZiA1PSGUPLeXjFqRHzDPt/His4AxXVXCEaa
 G89Pqz7ZZnWevC0o9Q1IS3AvzdcdAHtS7gOZC6feG1dLaHzF5qDXYUz6gWx1wFMyaSGa
 5QvI7rf72lZHGEwW/HXVP5ojFQVYAfam+0YTRz2r3cPjIPh5hZzrVPwlY/KuPYKB+wmK
 RWcw==
X-Gm-Message-State: AGi0Pua+5SKNqVIYiIaAxZ4oTguD4dAhF49HwaG6dCO8GW0gIgvZdbH9
 yatT43/zqYkr6rStXIwL8sQ=
X-Google-Smtp-Source: APiQypJ+ONAKAulryAmi3EUwPeEnoJxp5UoUL+St5Fk0Df6f3oFcK532dI17auEeSo4f39XxzxXM/Q==
X-Received: by 2002:a05:6000:12c7:: with SMTP id
 l7mr8368414wrx.239.1587199933676; 
 Sat, 18 Apr 2020 01:52:13 -0700 (PDT)
Received: from localhost.localdomain ([37.142.6.51])
 by smtp.gmail.com with ESMTPSA id q8sm10790461wmg.22.2020.04.18.01.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 01:52:13 -0700 (PDT)
From: Ramon Fried <rfried.dev@gmail.com>
To: edgar.iglesias@gmail.com, alistair@alistair23.me, peter.maydell@linaro.org,
 jasowang@redhat.com, qemu-arm@nongnu.org
Subject: [PATCH resend v2] net: cadence_gem: clear RX control descriptor
Date: Sat, 18 Apr 2020 11:51:45 +0300
Message-Id: <20200418085145.489726-1-rfried.dev@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Ramon Fried <rfried.dev@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The RX ring descriptors control field is used for setting
SOF and EOF (start of frame and end of frame).
The SOF and EOF weren't cleared from the previous descriptors,
causing inconsistencies in ring buffer.
Fix that by clearing the control field of every descriptors we're
processing.

Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

---
v2:
  * change function name to rx_desc_clear_control as proposed by
      Jason Wang
  * Move the function call above the comment, as proposed by
    Philippe Mathieu-Daudé

 hw/net/cadence_gem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index b7b7985bf2..22a0b1b1f9 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -411,6 +411,11 @@ static inline void rx_desc_set_sof(uint32_t *desc)
     desc[1] |= DESC_1_RX_SOF;
 }
 
+static inline void rx_desc_clear_control(uint32_t *desc)
+{
+    desc[1]  = 0;
+}
+
 static inline void rx_desc_set_eof(uint32_t *desc)
 {
     desc[1] |= DESC_1_RX_EOF;
@@ -999,6 +1004,8 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
         rxbuf_ptr += MIN(bytes_to_copy, rxbufsize);
         bytes_to_copy -= MIN(bytes_to_copy, rxbufsize);
 
+        rx_desc_clear_control(s->rx_desc[q]);
+
         /* Update the descriptor.  */
         if (first_desc) {
             rx_desc_set_sof(s->rx_desc[q]);
-- 
2.26.0



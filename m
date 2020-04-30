Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14AFC8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A82A20757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x+3xyXZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A82A20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7uc-0008Lk-Gl
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jg-0003Ey-V6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jd-0000QC-3A
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:12 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jc-0000Pk-Hx
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:08 -0400
Received: by mail-wm1-x343.google.com with SMTP id u16so1542429wmc.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=zZWaiNYQl1jkJl1/u6IcLpSy6OiypfwYvSOe5TPvgPY=;
 b=x+3xyXZDxl+LyZF2TYjFcrkjqvoa9/CXNc1QxCOk9PWqAdQjUTjjNyhZyjKvQjUKT1
 ffX+1ZKxmfGX1UrxUE+bS5UAOoVkQb2gNBqYiOOwUwngBtvFW6uQ/rRMcaJ8PmBaAkvl
 5+emvsMS+6+ogxmj8L4i9CoohSRwwSXZ93OE+FYECFDSqa6mgPWhreYTflGamwPdpi+5
 WnOnGEZB2eKK2Wm5a3P+2E3G3WRc9RG4PabQ5KP3rKZ3m9Dr7pqFU7ZWT69VWgEO9FS+
 qHlvDNeG9izV2KhkjZ7M8FxncT8h2zMSpxRgsLn6Xgn77UBByamxjmqALh9My73iBymq
 cePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zZWaiNYQl1jkJl1/u6IcLpSy6OiypfwYvSOe5TPvgPY=;
 b=rtoBmXDvPmSi2hZZ+oPzRY8CSc0tXMCK9fuUGBTx9o9HfviW0mnXGdkgV6EglRSB9h
 MhY3HcfZOPHtVG7ErMXvuMsHYiTw42s+bPb3PD+oLzfw/44BY/cGkk/eYuLgZzjUJgsl
 PLrXHzOK8H1CHKDYBjyDat/HtK9cbaTQ/+N5EJjIj3Svwb82HAouzaIdiVFOYotPyiBU
 y3w02C/MZzVwgxzIdMxRtvo+G9R7MaW7/X/8A41H98eJa/QCwfoifSg7CxRCctjxQwQS
 nhpHcJzvLuY2m8ikt53AsVeKnqZnV/BY+U19Pqr1Vx/jhpLXP5z+Z8+JJgOyjrfhrdEK
 7zvQ==
X-Gm-Message-State: AGi0PuaQKLl+VqWUWF0huvwC8Z9N+YlvUwQt+l/vkBjb+n59sOGtr5uO
 6BiLP895xt6j0erdkN3heMNCaz88aNzv2w==
X-Google-Smtp-Source: APiQypIs/Y55VnIj10Smm6cHsFxP03Htvy43PPc6iWKnRB7yZhmoyybRfvBqzqlDFmz2nN6LayIFOw==
X-Received: by 2002:a1c:7ed7:: with SMTP id z206mr2434347wmc.64.1588247526814; 
 Thu, 30 Apr 2020 04:52:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.52.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:52:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/31] net: cadence_gem: clear RX control descriptor
Date: Thu, 30 Apr 2020 12:51:31 +0100
Message-Id: <20200430115142.13430-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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

From: Ramon Fried <rfried.dev@gmail.com>

The RX ring descriptors control field is used for setting
SOF and EOF (start of frame and end of frame).
The SOF and EOF weren't cleared from the previous descriptors,
causing inconsistencies in ring buffer.
Fix that by clearing the control field of every descriptors we're
processing.

Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20200418085145.489726-1-rfried.dev@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/cadence_gem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index b7b7985bf26..22a0b1b1f9a 100644
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
2.20.1



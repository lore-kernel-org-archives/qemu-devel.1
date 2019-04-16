Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47E5C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECD920675
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UbcPRQfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECD920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36377 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNmN-00025y-QN
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:05:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNf0-0004TX-Jp
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNex-00014z-7X
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:00 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNet-00010w-Cw
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:57:57 -0400
Received: by mail-wm1-x343.google.com with SMTP id z24so25490158wmi.5
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=Cdsm6rjvWmI4e6EeMdiLshilhoveyvisAWdYOPDLvS8=;
	b=UbcPRQfMjFKcki+y5mz4nyoIqifqrFfEvVWwpycZV2t0/2oKu0Lz5rb66YOk8dVH6k
	H+gynXOiulmANFAe2qguw+VjG2W66JVSYZ9qRXku0v6Xq8o/Y1RWFMdE9WsZEqCEQZ4v
	RkJbFT2htqCrk12xUiZjBmZ7EKSwIUkzmlK6Q7XJon+Ae9Yma0+CNogP+8rb1d9sk81F
	wtx4EtltNb5oA1JWEyYhsKsVEW5RwwEjm13xaFOje8hCZXd9l8rS0H7Rq22UDbFAQmOa
	MQJs7Q270tXx3lT37sWvIVPM8LeyvngaBB0ZgBLkT/pjldDazV7f1NfBXkpHDn9jglOP
	nU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Cdsm6rjvWmI4e6EeMdiLshilhoveyvisAWdYOPDLvS8=;
	b=QtEWlMIaTqI2Oz60Q16J8Fd1dREgXTUq46pZDqwM9w5txOo38gMiEIkitkFkIKNg2h
	mG2S/D/xh3KVH/MIXrcIT/nd30DxquYncxRdABwBdELBJPIIxJQUap2lmvwR9jUu8CFB
	NUbzbFBbJ96MFj6pbFOZf0hbRFcJLZi1sA3DNvygJc0fzLr6Iuwi6kGZYZ+4XUpHQr9x
	GFwjueyuXtMDuQKFZr+3s6JLi0MAX2fFiRJ9Af6cTa2jzzU6/PwAUUu96HKrWsKetz7S
	5uSY1oknipOrNkGJmQrdZVNbPw4AaQpux3jMXjKZQHTlGZLAeZ57Tinc37AiQm9y+pE9
	927Q==
X-Gm-Message-State: APjAAAX6TCE0/LvjlgJmoVPwljMS7YvfevoKw+yCbbBDAmR347qOQe8K
	0ZJ4Yjo3QZQ9ynmth+mHlzTsp88RkaI=
X-Google-Smtp-Source: APXvYqwtHpIDl6ni7Lp1l92UaDb4/A9szvAO3aPUVBFX7k8h0YuFc9ho1JyDM6b/e8Xi+bU1t408AA==
X-Received: by 2002:a1c:eb07:: with SMTP id j7mr25520428wmh.138.1555419471361; 
	Tue, 16 Apr 2019 05:57:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	v184sm39476572wma.6.2019.04.16.05.57.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 05:57:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 13:57:20 +0100
Message-Id: <20190416125744.27770-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH 02/26] hw/intc/armv7m_nvic: Allow reading of
 M-profile MVFR* registers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416125720.4KzRHxvj49XKLW7F1q4Q9OuSF2tyR74sIvCQrTMiSCo@z>

For M-profile the MVFR* ID registers are memory mapped, in the
range we implement via the NVIC. Allow them to be read.
(If the CPU has no FPU, these registers are defined to be RAZ.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index ab822f42514..45d72f86bdf 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1222,6 +1222,12 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
             return 0;
         }
         return cpu->env.v7m.sfar;
+    case 0xf40: /* MVFR0 */
+        return cpu->isar.mvfr0;
+    case 0xf44: /* MVFR1 */
+        return cpu->isar.mvfr1;
+    case 0xf48: /* MVFR2 */
+        return cpu->isar.mvfr2;
     default:
     bad_offset:
         qemu_log_mask(LOG_GUEST_ERROR, "NVIC: Bad read offset 0x%x\n", offset);
-- 
2.20.1



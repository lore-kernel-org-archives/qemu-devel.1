Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC725C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:04:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8449B2075E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTZBdI1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8449B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52676 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMDFm-000662-Nx
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 11:04:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMDAm-0002Cd-62
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMDAl-0005Qt-9u
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:58:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMDAl-0005QO-3V
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:58:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id a9so3818497wrp.6
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 07:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=nMoOzpH6IAYwWcudoG5zv/npykvfEGVbBGw4kRp1fOo=;
	b=kTZBdI1pYLx6SGNFbgecaM/n173e5Kfrcz17hRz9ks5F0GzZvzqKubtzO5Y3KUqatf
	of/XM4sV1NcsCAjwhkhUZC3zgz5MKAeT6lBpc4YGpEhx+eUJSYT5yfRGT6xMmfwhKhOZ
	w8n/c0IOl/t+oTVn5xNKh8YnG5ItjH1x6CdY32kH4KcaHGmlf1JMj+/hJD84H7jtsuBV
	pDa1X07sz5ZjLe2HZDfruDhkdo507FtikUM6CO3yqIQeQi/KKbouOMdi1kEdERCbCgeX
	Yn4d8YElVeQwZ6aSwHRFhQapURLYKcgnj3NGGE0mQG/HNKAHP4ni05g1ZhgvSKKXE6w7
	+oxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=nMoOzpH6IAYwWcudoG5zv/npykvfEGVbBGw4kRp1fOo=;
	b=bx4+Re6lTIjyMmHNBdU5o5JuBwK0qqFv56YLvXMp0uoCDH2STaHEqnbYuSHsyAds7a
	CpZqOHEIO5t5WWgLYYEr+w17NZmyBbRmGzs1S2hPOECOhxY0J83MJQJs09tHu2DsWa6k
	mEMSaWs00t6dd2n7zbQMUkB2BtWF9YATf2ofnvcC/DVqSY9ROXbU5exlsxRdNjcbxdGn
	kT9xmRgn1T/u2h+BMdIcZ6EhMpIBn252bOIb/CAKH25WlwtjbIokZ3trZ/wBKvw2FKFL
	QY3lbw+FXAjgUcAJ9AGrej2y0d3MSkfzjDNEPZofrRzOAdXbW6KJ/aX26dLLwBKrqWSq
	WN6g==
X-Gm-Message-State: APjAAAWQ3R0xbR1cnoJA+HAnKilRobeT8RVXxygQANoJj1C6lWrzsKwT
	Koe9TH31lpuBB/g08kCmASjXaA==
X-Google-Smtp-Source: APXvYqwETjTHAdbFs+A+OY4tjWowdDGOttd8eH4paTt1xEc7S3QFSWM9UrxhArxReMiu/wOKDZPDig==
X-Received: by 2002:a5d:4003:: with SMTP id n3mr3375453wrp.76.1556809133631;
	Thu, 02 May 2019 07:58:53 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id z23sm7965533wma.0.2019.05.02.07.58.53
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 07:58:53 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id B9F281FF87;
	Thu,  2 May 2019 15:58:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 15:58:46 +0100
Message-Id: <20190502145846.26226-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <877eb86hcf.fsf@zen.linaroharston>
References: <877eb86hcf.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH] linux-user: avoid treading on gprof's SIGPROF
 signals
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502145846.lBzyRpc3cYGiNZlWoD6xj6CYT6yjFeEQi88W9uETkms@z>

The guest tends to get confused when it receives signals it doesn't
know about. Given the gprof magic has also set up it's own handler we
would do well to avoid stomping on it as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/signal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index e2c0b37173..44b2d3b35a 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -508,6 +508,11 @@ void signal_init(void)
     act.sa_flags = SA_SIGINFO;
     act.sa_sigaction = host_signal_handler;
     for(i = 1; i <= TARGET_NSIG; i++) {
+#ifdef TARGET_GPROF
+        if (i == SIGPROF) {
+            continue;
+        }
+#endif
         host_sig = target_to_host_signal(i);
         sigaction(host_sig, NULL, &oact);
         if (oact.sa_sigaction == (void *)SIG_IGN) {
-- 
2.20.1



Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4844DC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC7B217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC7B217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40988 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP37R-0002mW-Qs
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 06:51:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hP32C-00077u-OH
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hP32B-0003V7-Ql
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:48 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:49353)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hP32B-0003Uc-IK
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:47 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1M4bd0-1hOUXP06vW-001fG9; Fri, 10 May 2019 12:45:45 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 12:45:35 +0200
Message-Id: <20190510104536.17483-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510104536.17483-1-laurent@vivier.eu>
References: <20190510104536.17483-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:P0YC4i9p+55HDi78kXQ9LCtYjqHPaDZL+otsOi5KUhIp/yCpDfV
	N5J4vho4xHSiC6F2uik5CberFNieN+pXALZGX0PUkU2DFTXjGSrolBZR5rUHWP+L/fk+nMK
	uumd0klNDxn1XY8PreUx0j8spLasGp5UKc+5VmcpQqz/acamB2HIYz63ZIYexpCLir7wzwM
	k9uH16rrxHHCKM4VnYDJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iGIZFBUxNC4=:fgaoKx6VuBrOfekjOxLDDN
	dZUoBRFVXmZ+TB08ahXSWHou/R2izKTaGn02ybd02WTVbIZ9NkDu+NRcGmeO0NdAEpl5PHjl1
	V1C+1MXO+jnbEsxx1OWSePQ8ZIkjY2F0f6/909SMwBPCGqmRsdjY6HxH5GPdLKWzVU9scq4gG
	e4WvqderD5cq61KVAnsgdRd557evj7kMif+Egddz4pecCoYaeQpGQRYHbNI2nLBHEvfhhYU8+
	O8cafQctmGyzxWWpCyZQrNkZaiGyrn7bwaTs1vM0smxN7rc9BVcujKfyiS0aoDDCc3Uk7YbTo
	ccLdeNODm9VRwYirFZQZtn/+rHj1iQltH102s32wxrjI65S3WPWgurTDzm51ShJIawxu9wXuG
	GvOCnNHW9coMqxMVpTYWIluHcRyfqmR9x8cFlrBffWKIKpv926xE4dqnHePJLkYHcII/Pg2EN
	rloguQAd66S8pBDuvR54f/4XEUTXtoDD95/zHAirMbhkALn6fAFxpEjNjDcXqxFAbqOrvGyGU
	vOLUMnY5vmWKOIAqnmxXRaa5MgC/pfPFancQPuapjuhgVeq2VLQWerfD35wZnBSnbEU/8PVEc
	yMUgyFZsgkFWFHGMhfrGNV+8g85lPpY99N/wB2PeVgcRY+03LvJAh9aFcFqS9HNumKarEEDZL
	gBSMvZD4qnnopUXTZYRH+5YkRDqOxoZqCHJlvEPhQuC95W96uv4WEuM00W4qcGaN0iEGra11H
	cQhhAdwRiyzoA0Wbri42JTeZSV8qFK0qBYQL9Yci084ZHkX6MOtVNfizg6A=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: [Qemu-devel] [PULL v2 6/7] linux-user: avoid treading on gprof's
 SIGPROF signals
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

From: Alex Bennée <alex.bennee@linaro.org>

The guest tends to get confused when it receives signals it doesn't
know about. Given the gprof magic has also set up it's own handler we
would do well to avoid stomping on it as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190502145846.26226-1-alex.bennee@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/signal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index e2c0b3717357..44b2d3b35a0d 100644
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



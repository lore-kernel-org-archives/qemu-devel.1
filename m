Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8763C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65031217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65031217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38236 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOzq6-0000so-EB
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 03:21:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOzlR-0005lm-FJ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOzlQ-0001j1-Fc
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:17 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:36127)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hOzlQ-0001iM-73
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:16 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MNKuK-1h5qLV3Xj8-00Opf7; Fri, 10 May 2019 09:16:08 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 09:15:56 +0200
Message-Id: <20190510071557.30126-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510071557.30126-1-laurent@vivier.eu>
References: <20190510071557.30126-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hpNSk8jCFA1gGs/HUMOgsJ+gKep+ZKMO7Go9f1u9v+bd64gSuHe
	Fhn4mtwWDfPfWJcxVMpwuoYm+RC2x2HQ963dagxHtlgrSHDZrXnNXp34cUo1HD4sqOtzCyg
	jlLxfd3yCYix9zzdkUkKsmxdGh5xcVDNUrv8yIQBpbSg5wC5H092uDcbDyn7sts22W6FE5F
	q+zrduuayQxqbp9ii1nww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+LoJWPF+eIs=:W9XGFgsfveehGrK7iGXTE4
	xxAHNVumVxtkTyt04QT+1o3JWnRxhu+c2l9eRtluyseIunuP52ZdA/PlHUsk6eOeSxGZg1swF
	c+1AiLTAgIjWTpQMn9ss/rAJtfOAHDAVPi40v7egnW8lQRoqE+G2I9IgBCZCDrRnyOCgrndrx
	ioUDuwk9Xz3w5fKVZRLE/NrDUm3M5LVscIMqqXMYtg2G5l5fcTFXg8yDJmHRR4aV7nZC/ISvs
	aJjIdFrQkUT26IYAv6MgwKYG8BX3cYc0Q/gb71juagTng9lswdXVtNRYBZTXfiAlbtQSo83vB
	RNKihDzN8BOJotnKMXWUyVRhKYr5C4vv/2YqLwLU2muBLLyWO5qcWiYSV/N24mm7lR4B7xD4i
	Jrxj4VRVL97YkYrVaPB4zhu5c5uUX4bkdI/KMekKE0I4AsgGNhEPFIAGaf0cHBtYTFo6HbKEY
	q+fYx6arJN16A+r/x8LA9wEmIqx5Xi+WxzyDilaSAd9geIAFj5Wo7PWCosK+Ik7j7vqDR3Q9E
	YqG6aF04CiRhQ+Vxy6GenbPFP86I4M+/itD57E/NJvaVu9qSIlhsbbinRI++DiNkOfEO7jL8u
	AmO+cvbfj9+i+gGoPEvG+tKR+lDy5y79H//eDSQe/iZinWl86OHf2wRfVXDgwuRZcERvBZhAO
	t4OMSFZdRe95IktdY4uCraMyVl3f2F6v5OT0JarBn/uyPSFl60xDLV63fQrM2mTWTw4px22qN
	nqc4IFFw73Mrep4dKf3kKziSbT50+pHKq1gTmkgEDg0xx/XoxRLqypf6j/g=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 6/7] linux-user: avoid treading on gprof's
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



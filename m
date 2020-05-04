Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20728C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E47206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E47206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZuM-0001Yk-2e
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjr-00034M-H8; Mon, 04 May 2020 07:58:23 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:57893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjo-0001ye-Mx; Mon, 04 May 2020 07:58:23 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MwPjf-1jFYr103BF-00sJdn; Mon, 04 May 2020 13:58:10 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 05/20] MAINTAINERS: Mark the LatticeMico32 target as orphan
Date: Mon,  4 May 2020 13:57:43 +0200
Message-Id: <20200504115758.283914-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504115758.283914-1-laurent@vivier.eu>
References: <20200504115758.283914-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hi4ZlP8k5hKSLyW93PzeAzjqJe7XRZDKE3QUbZJxRddbZ0QtWkK
 bVT5faEL9/nfqe6W5s0oAEPHhkS7yQLTIWeqaeOpNp1Nabf4FtufvCxcnIFsGk2jczIYj3s
 eGuH1PWZ6ATYKIss8VmC5lU0zquPKHNhIWMfqQ3XmMiK3ZZDxSPjkKvYXPAoSzFN70AjxKZ
 5D/GMNs6xYaoMV7eADNFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xchtK2hLMPU=:mTpDgH15Fmum6Aeypk48KQ
 cbP9u2PgvmOPCBawOU7I0CitFqGORSTF9fJautdXkhq0IMHXTApODc8h1v9rIpN/uXzHj2Pb1
 D4SgxcwwNrLsv28aHYHmKgb8Xcf0qJPzgbLYyeSFj0hVEIm80vgnCrRDPxOVjxt4vHhRZvwVN
 aTOIAWxB6MO2yQ+5wpOU3mQu7yV6vJMFUUgLj/66E7gSJzuU+uBV66AyyFzuXZ3oPS7rGR0FW
 mICwAZ1w8DDhu/HyCVX5MByeRAhZ44yE7oxBMz55NOREKfJo2szXFNokg9/7xdAhjbyX7n7r0
 war8ie8OZhojCgMDU42Eo1SUuN5gDXoo0s4/8wbqgD/a9EnOgrsDTylgOftCcdNg4LvS62zzM
 Z9smX4/ii7XltmU2BqWALIL1xI0GD4dZI+bQM3AdHFN3jEaqoxRtmLTY4PzfQL02fyq+m5KYv
 SNW7XEvQ3pMU4Oi+3ZVRsDXl+Hcykv728JgY/rlqTS/g8Xo2nrpWWSVzC45T+4+zNZUc13A+K
 PvK7mgVuyCfbv6tvcT8My1mXJoCfLQKYRsLeF/t7zvEs7d1O3vGUbIYIaV2MPTWKJeq37aiUW
 d9Ws/X0IzHotkdJ7sMQUsQLwZTbDmXLVNvlTCzTolxBVQzh+xmjA2Rejas+h/DppqPtT5XvEc
 P3j8+VXX4IofbVqJQ87vgyw8OGf84mOlrE68qpEdk3YEhnzMw21McXfDVMfx/jZ9nEsXar7+a
 DStnPN12FWw48aq1TTqDjOtRB2GdEh+grrwmgBm4w1u7rMfwoV8R7LS8kYRfq+hV/0y9/B3wd
 jlnWWUhOh4sXbG+AmKld2q//rWZ2rNNhqIftUu2EfJFvM7rdD8UTK3WAkg3JH365NEf1YGd
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 07:58:13
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Michael Walle expressed his desire to orphan the lm32 target [*]:

  I guess it is time to pull the plug. Mainly, because I have
  no time for this anymore. I've always worked on this on my
  spare time and life changed. And secondly, I guess RISC-V is
  taking over ;) It has a far better ecosystem. Also, to my
  knowledge the only (public) user of LM32 is milkymist and this
  project is dead for years now..

  So time to say goodbye. It was fun and I've learned a lot -
  technically and also how a huge open source project works.
  Thank you everyone for that :)

  Basically everything still works and there are even TCG test
  cases which covers all instructions the processor has.

Many thanks to Michael for his substantial contributions to QEMU,
and for maintaining the LM32 target for various years!

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg605024.html

Acked-by: Michael Walle <michael@walle.cc>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200316142827.20867-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8aa8efaf1d7f..d6886be13159 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -184,8 +184,8 @@ F: hw/net/*i82596*
 F: include/hw/net/lasi_82596.h
 
 LM32 TCG CPUs
-M: Michael Walle <michael@walle.cc>
-S: Maintained
+R: Michael Walle <michael@walle.cc>
+S: Orphan
 F: target/lm32/
 F: disas/lm32.c
 F: hw/lm32/
@@ -977,13 +977,13 @@ F: pc-bios/hppa-firmware.img
 LM32 Machines
 -------------
 EVR32 and uclinux BSP
-M: Michael Walle <michael@walle.cc>
-S: Maintained
+R: Michael Walle <michael@walle.cc>
+S: Orphan
 F: hw/lm32/lm32_boards.c
 
 milkymist
-M: Michael Walle <michael@walle.cc>
-S: Maintained
+R: Michael Walle <michael@walle.cc>
+S: Orphan
 F: hw/lm32/milkymist.c
 
 M68K Machines
-- 
2.26.2



Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE34CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D71120684
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D71120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpSR-0000le-5F
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMpGN-0002ul-MX
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMpGM-00058u-Kv
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:31 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:42603)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMpGM-00058A-Bg
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:30 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MfHxt-1hpOG71tW7-00gm6j; Tue, 22 Oct 2019 10:11:16 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/11] linux-user: add strace for dup3
Date: Tue, 22 Oct 2019 10:10:54 +0200
Message-Id: <20191022081104.11814-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022081104.11814-1-laurent@vivier.eu>
References: <20191022081104.11814-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RR4AWW1XqeuM8d8mmcTDsQsW1cV/ZLplwIccKd6itxu9om1ngQt
 bIuBWH5jEdvYUm8H2CzhHCWvFrMRJIOI8pJOS659Zez+hkPE9hioQoETi6WVL0EXrpFmCjX
 TMALwjiixlr/LAriKwxPehRHNADwKdclcqX77kNv5yN7uZlKQKLcqd6EFNj/QFAFw9HgRW2
 ivVmz+HVFT6s1H9dXzbLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bS+SaQOO7/M=:3Z9rYR8sM9R4pL+fWW6aJJ
 kGp3ab5hRwty8N01n79gG0KK+ze7a4ZFg9UsQrnhIi1vv4AE1ZNE8ohRaDFfhU3L9A+qeDeEh
 oXqCE0xYV4yv6YGZ07VKu3BWVru6SWklkFxqi6xyDE8KkW/JagcC4jdFETtyEFJietdUi2f12
 NkvQIgA+AkEcYrkWwCKbqPYAzjQqlvKcwL7bzFz1XUlJI1Vf1rwJyDHCVBqf1UMBJ9v1DKlIN
 VYKyZNQ3IkJhef8oSzHtKvidk7zxc7PEatJSRMsywTnBHsrjAeHCoHZvJ5Atdt4ogigex+j3O
 NNXEYNGH4KsYKp/U0zYpENQ20nIRNM5NrxSgwte9mRus5NOtZHlniC2Kmm5YgnWPmToU/Jiov
 RfHdKXEElj+NXGDxdt1jUPFG0/J0OO370kqH4l8VNZLIhPCA4RUz/0rQlzPPf3Y34V0JJQtJe
 bQbbMPytWEukPGnEPTaclqIFc8n5zMnjnGGSr+OhY6RGEndWLp/AwTrfsvHb5bTjeSN3FH7ZS
 lwScNQf4h3RMqI0NbAbGmxZ1pHpV0UvSizpu8Zoyp8jTHXo6oQn0iat67UUcDRjDD5ZBWjeDr
 QwisggROl2XCPK6hzGcHciv3TR53whpp1UcrfCxo33Ay+1TMSpMw0q+mOGKIv4srm1sPOGgp+
 asDZAyPfq71L7SUIiGSuL1Ffib1qa3NbiZgOg3SWApE3CzakWpmileeXoVgej17dWgHwbZo0u
 pwS2znAde7LYGlLuC9EFuzq10spAi5tJlwefoOw01BsO8BjvNH3QADuLmJpNN/AV2N9GywP+e
 2Jyd8FeUSLcn4Emqh3rxF2E3+G4WiQt/WsuSLFlCRFajbPU5wvocUznvhcFNWXfAZlyobyL/o
 m5sdGhl+abkL6INZLcts2t+GQePqCLj+zFyagwfPs=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
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
Cc: Andreas Schwab <schwab@suse.de>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andreas Schwab <schwab@suse.de>

Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <mvmsgoe17l5.fsf@suse.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.list | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/strace.list b/linux-user/strace.list
index 63a946642d29..863283418ef9 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -121,6 +121,9 @@
 #ifdef TARGET_NR_dup2
 { TARGET_NR_dup2, "dup2" , NULL, NULL, NULL },
 #endif
+#ifdef TARGET_NR_dup3
+{ TARGET_NR_dup3, "dup3" , NULL, NULL, NULL },
+#endif
 #ifdef TARGET_NR_epoll_create
 { TARGET_NR_epoll_create, "epoll_create" , NULL, NULL, NULL },
 #endif
-- 
2.21.0



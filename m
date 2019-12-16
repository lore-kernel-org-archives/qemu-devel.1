Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378F4C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F754206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F754206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igpp1-0005gV-6S
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 07:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1igpjP-0006kc-R5
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1igpjO-0006x0-M6
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:44:11 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:57799 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1igpjO-0006vK-EF
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:44:10 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 043A21A20EE;
 Mon, 16 Dec 2019 13:43:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id C63441A20D0;
 Mon, 16 Dec 2019 13:43:01 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/11] MAINTAINERS: Adjust maintainership for Malta board
Date: Mon, 16 Dec 2019 13:42:50 +0100
Message-Id: <1576500172-11264-10-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576500172-11264-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1576500172-11264-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Change the maintainership for Malta board to improve its quality.

Acked-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1575982519-29852-4-git-send-email-aleksandar.markovic@rt-rk.=
com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b059f4..7803fe7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -955,8 +955,9 @@ F: hw/display/jazz_led.c
 F: hw/dma/rc4030.c
=20
 Malta
-M: Aurelien Jarno <aurelien@aurel32.net>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
+M: Aleksandar Markovic <amarkovic@wavecomp.com>
+M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
+R: Aurelien Jarno <aurelien@aurel32.net>
 S: Maintained
 F: hw/mips/mips_malta.c
 F: hw/mips/gt64xxx_pci.c
--=20
2.7.4



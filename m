Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97712C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632D9206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VUD1fB37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632D9206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39883 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJu2U-00077I-B4
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:08:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0T-0005Mw-Kz
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0S-0004GK-Em
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:45 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:53777 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu0R-00042U-9E; Fri, 26 Apr 2019 02:06:44 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tj6ylGz9s9T; Fri, 26 Apr 2019 16:06:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258793;
	bh=4+ipr73sCxCSk1JgY8chJfZ8CeG8J2usGw/GcxUpe9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUD1fB373d7ModjGwr26qyGBwJ20KvCVkuVGENpruGKwz2C+xt8RQrRhvQzGkmHUW
	1Lls/PCCEi/enVUipuwkKiOrhaTcXvYT7YkzrUP+fTmA83AxMeBZjC7Wzv6rwqeq47
	rhJlcKoSrQLiOig3cSavK28ev5iUs3XHjgTmsthM=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:05:53 +1000
Message-Id: <20190426060627.18153-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 02/36] hw/ppc/prep: Drop useless inclusion of
 "hw/input/i8042.h"
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
Cc: gkurz@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426060553.aNL2r5ydptGoNHPc2RcblwbEjA4Xz85fiRc5A5yfpvs@z>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

In commit 47973a2dbf we split the last generic chipset out of
the PC board, but missed to remove the i8042 keyboard controller.
This omission was later fixed in commit 7cb00357c1, but here we
forgot to remove the "i8042.h" include. Do it now.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190316201528.9140-1-philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/prep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 847d320465..b7f459d475 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -40,7 +40,6 @@
 #include "hw/ide.h"
 #include "hw/loader.h"
 #include "hw/timer/mc146818rtc.h"
-#include "hw/input/i8042.h"
 #include "hw/isa/pc87312.h"
 #include "hw/net/ne2000-isa.h"
 #include "sysemu/arch_init.h"
--=20
2.20.1



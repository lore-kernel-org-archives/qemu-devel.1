Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902DDC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:32:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6122E2089C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6122E2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhuXW-0004e3-1E
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 07:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45222)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhuSH-0006ZM-LA
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhuSF-0007q9-Cn
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:26:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44456)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hhuSE-0007oN-DL
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:26:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 22BE3A70E;
 Mon,  1 Jul 2019 11:26:37 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8369C1B4B0;
 Mon,  1 Jul 2019 11:26:29 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 13:26:12 +0200
Message-Id: <20190701112612.14758-5-philmd@redhat.com>
In-Reply-To: <20190701112612.14758-1-philmd@redhat.com>
References: <20190701112612.14758-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 01 Jul 2019 11:26:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 4/4] hw/mips: Express dependencies of the
 r4k platform with Kconfig
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This platform use standard PC devices connected to an ISA bus.
Networking is provided by a ne2000 chipset.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v4: use 'imply' for VGA_ISA/NE2000_ISA (Thomas)

v3: remove CONFIG_NE2000_ISA (Thomas)
    add PFLASH_CFI01
---
 default-configs/mips-softmmu-common.mak |  1 -
 hw/mips/Kconfig                         | 10 ++++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mi=
ps-softmmu-common.mak
index d545987d42..da29c6c0b2 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -27,7 +27,6 @@ CONFIG_I8257=3Dy
 CONFIG_PIIX4=3Dy
 CONFIG_IDE_ISA=3Dy
 CONFIG_IDE_PIIX=3Dy
-CONFIG_NE2000_ISA=3Dy
 CONFIG_PFLASH_CFI01=3Dy
 CONFIG_I8259=3Dy
 CONFIG_MC146818RTC=3Dy
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index ab006477c7..62aa01b29e 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -1,5 +1,15 @@
 config R4K
     bool
+    select ISA_BUS
+    select SERIAL_ISA
+    select I8259
+    select I8254
+    select MC146818RTC
+    imply VGA_ISA
+    imply NE2000_ISA
+    select IDE_ISA
+    select PCKBD
+    select PFLASH_CFI01
=20
 config MALTA
     bool
--=20
2.20.1



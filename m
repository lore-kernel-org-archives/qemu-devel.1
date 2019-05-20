Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D160C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:46:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A682173C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A682173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42391 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSq7M-00013u-6Y
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 17:46:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSq4c-0007Pu-MI
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSq4b-00008Q-Rj
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:43:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hSq4Z-00006K-P2; Mon, 20 May 2019 17:43:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09CA030842A0;
	Mon, 20 May 2019 21:43:55 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-28.brq.redhat.com [10.40.204.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 12B8F1001E6C;
	Mon, 20 May 2019 21:43:51 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 20 May 2019 23:43:39 +0200
Message-Id: <20190520214342.13709-2-philmd@redhat.com>
In-Reply-To: <20190520214342.13709-1-philmd@redhat.com>
References: <20190520214342.13709-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Mon, 20 May 2019 21:43:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/4] hw/arm/exynos4: Remove unuseful debug code
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>,
	Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/exynos4_boards.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index ea8100f65a8..f0c24b7992e 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -35,20 +35,6 @@
 #include "hw/net/lan9118.h"
 #include "hw/boards.h"
=20
-#undef DEBUG
-
-//#define DEBUG
-
-#ifdef DEBUG
-    #undef PRINT_DEBUG
-    #define  PRINT_DEBUG(fmt, args...) \
-        do { \
-            fprintf(stderr, "  [%s:%d]   "fmt, __func__, __LINE__, ##arg=
s); \
-        } while (0)
-#else
-    #define  PRINT_DEBUG(fmt, args...)  do {} while (0)
-#endif
-
 #define SMDK_LAN9118_BASE_ADDR      0x05000000
=20
 typedef enum Exynos4BoardType {
@@ -140,16 +126,6 @@ exynos4_boards_init_common(MachineState *machine,
     exynos4_board_binfo.gic_cpu_if_addr =3D
             EXYNOS4210_SMP_PRIVATE_BASE_ADDR + 0x100;
=20
-    PRINT_DEBUG("\n ram_size: %luMiB [0x%08lx]\n"
-            " kernel_filename: %s\n"
-            " kernel_cmdline: %s\n"
-            " initrd_filename: %s\n",
-            exynos4_board_ram_size[board_type] / 1048576,
-            exynos4_board_ram_size[board_type],
-            machine->kernel_filename,
-            machine->kernel_cmdline,
-            machine->initrd_filename);
-
     exynos4_boards_init_ram(s, get_system_memory(),
                             exynos4_board_ram_size[board_type]);
=20
--=20
2.20.1



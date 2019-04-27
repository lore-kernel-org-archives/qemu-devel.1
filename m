Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49556C43218
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 14:17:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1C42087F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 14:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1C42087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60848 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKO8T-0007LC-Cm
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 10:17:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKO6m-0006Ge-3D
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKO6l-0000YW-6m
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:15:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hKO6j-0000XJ-BF; Sat, 27 Apr 2019 10:15:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8115046202;
	Sat, 27 Apr 2019 14:15:12 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-83.brq.redhat.com [10.40.204.83])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C2DF02E0B0;
	Sat, 27 Apr 2019 14:15:08 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Sat, 27 Apr 2019 16:14:57 +0200
Message-Id: <20190427141459.19728-2-philmd@redhat.com>
In-Reply-To: <20190427141459.19728-1-philmd@redhat.com>
References: <20190427141459.19728-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Sat, 27 Apr 2019 14:15:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/3] hw/Kconfig: Move the generic XLNX_ZYNQMP
 to the root hw/Kconfig
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190427141457.uENrTan69Zq17GOYOEtnxUIwdpeRZX_kNI9-puTCFvE@z>

The XLNX_ZYNQMP config is used in multiple subdirectories
(timer, intc). Move it to the root hw/Kconfig.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/Kconfig       | 3 +++
 hw/timer/Kconfig | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/Kconfig b/hw/Kconfig
index 88b9f150070..c3c78f43eb5 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -72,3 +72,6 @@ config XILINX
 config XILINX_AXI
     bool
     select PTIMER # for hw/dma/xilinx_axidma.c
+
+config XLNX_ZYNQMP
+    bool
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index 51921eb63f1..eefc95f35ec 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -34,9 +34,6 @@ config TWL92230
     bool
     depends on I2C
=20
-config XLNX_ZYNQMP
-    bool
-
 config ALTERA_TIMER
     bool
     select PTIMER
--=20
2.20.1



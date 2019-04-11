Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593DBC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 18:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FBF42084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 18:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBF42084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53209 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEeMR-00069I-EV
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 14:23:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEeLa-0005l8-Mc
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEeLZ-0006yF-P9
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:22:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hEeLZ-0006xp-HT
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:22:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 666FB300B915;
	Thu, 11 Apr 2019 18:22:48 +0000 (UTC)
Received: from thuth.com (ovpn-116-70.ams2.redhat.com [10.36.116.70])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DC03F5C207;
	Thu, 11 Apr 2019 18:22:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 20:22:40 +0200
Message-Id: <20190411182240.5957-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Thu, 11 Apr 2019 18:22:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1] hw/input: Add a CONFIG_PS2 switch for
 the ps2.c file
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411182240.euk96_tfZPWxjtPyqJlq0nJNKz-Wrcj6O7zYXX0nKy4@z>

ps2.c only needs to be compiled if we are building pckbd.c or pl050.c.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/input/Kconfig       | 5 +++++
 hw/input/Makefile.objs | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index e2e66f0858..316573f782 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -8,10 +8,15 @@ config LM832X
 config PCKBD
     bool
     default y
+    select PS2
     depends on ISA_BUS
=20
 config PL050
     bool
+    select PS2
+
+config PS2
+    bool
=20
 config STELLARIS_INPUT
     bool
diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
index c8b00f71ec..6db5ee0e71 100644
--- a/hw/input/Makefile.objs
+++ b/hw/input/Makefile.objs
@@ -3,7 +3,7 @@ common-obj-y +=3D hid.o
 common-obj-$(CONFIG_LM832X) +=3D lm832x.o
 common-obj-$(CONFIG_PCKBD) +=3D pckbd.o
 common-obj-$(CONFIG_PL050) +=3D pl050.o
-common-obj-y +=3D ps2.o
+common-obj-$(CONFIG_PS2) +=3D ps2.o
 common-obj-$(CONFIG_STELLARIS_INPUT) +=3D stellaris_input.o
 common-obj-$(CONFIG_TSC2005) +=3D tsc2005.o
=20
--=20
2.21.0



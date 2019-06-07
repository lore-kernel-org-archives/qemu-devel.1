Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322D7C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA7872083D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7872083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49556 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZI6M-0006mP-Qx
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 12:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53427)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZGzl-0003ZC-Uh
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZGy6-0003SK-Bj
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:39:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17401)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZGy6-0003Gv-3K
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:39:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 144016EB92;
 Fri,  7 Jun 2019 15:39:43 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC21B7FE99;
 Fri,  7 Jun 2019 15:39:40 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Jun 2019 17:37:24 +0200
Message-Id: <20190607153725.18055-29-philmd@redhat.com>
In-Reply-To: <20190607153725.18055-1-philmd@redhat.com>
References: <20190607153725.18055-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 07 Jun 2019 15:39:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v18 28/29] hw/rx: Fix comments
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/rx/rx-virt.c | 2 +-
 hw/rx/rx62n.c   | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/rx/rx-virt.c b/hw/rx/rx-virt.c
index 49d04d22ea..53f43f62bd 100644
--- a/hw/rx/rx-virt.c
+++ b/hw/rx/rx-virt.c
@@ -55,7 +55,7 @@ static void rxvirt_init(MachineState *machine)
                            &error_fatal);
     memory_region_add_subregion(sysmem, SDRAM_BASE, sdram);
=20
-    /* Initalize CPU */
+    /* Initalize MCU */
     object_initialize_child(OBJECT(machine), "mcu", s,
                             sizeof(RX62NState), TYPE_RX62N,
                             &error_fatal, NULL);
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index e55257c622..a8ed88ef27 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -1,5 +1,5 @@
 /*
- * RX62N device
+ * RX62N Microcontroller
  *
  * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
  * (Rev.1.40 R01UH0033EJ0140)
@@ -202,6 +202,7 @@ static void rx62n_realize(DeviceState *dev, Error **e=
rrp)
         }
     }
=20
+    /* Initalize CPU */
     object_initialize_child(OBJECT(s), "cpu", &s->cpu,
                             sizeof(RXCPU), RX_CPU_TYPE_NAME("rx62n"),
                             errp, NULL);
--=20
2.20.1



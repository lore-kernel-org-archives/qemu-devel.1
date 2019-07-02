Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AD9C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D90E20659
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D90E20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiGTo-000799-FP
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 06:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50933)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hiGJo-0005o6-71
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hiGJm-0007iU-Lm
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60752)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hiGJl-0007ft-Ur
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 06D3D308222F;
 Tue,  2 Jul 2019 10:47:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-102.ams2.redhat.com
 [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C625B19C6F;
 Tue,  2 Jul 2019 10:47:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C9D3511328A3; Tue,  2 Jul 2019 12:47:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 12:47:08 +0200
Message-Id: <20190702104716.9140-11-armbru@redhat.com>
In-Reply-To: <20190702104716.9140-1-armbru@redhat.com>
References: <20190702104716.9140-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 02 Jul 2019 10:47:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/18] hw/core: Move numa.c to hw/core/
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190619201050.19040-10-armbru@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 MAINTAINERS              | 2 +-
 Makefile.target          | 2 +-
 hw/core/Makefile.objs    | 2 ++
 numa.c =3D> hw/core/numa.c | 0
 4 files changed, 4 insertions(+), 2 deletions(-)
 rename numa.c =3D> hw/core/numa.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f4d8c75d27..96eaa1e124 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1266,8 +1266,8 @@ M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Supported
 F: hw/core/machine.c
 F: hw/core/null-machine.c
+F: hw/core/numa.c
 F: hw/cpu/cluster.c
-F: numa.c
 F: qapi/machine.json
 F: qom/cpu.c
 F: include/hw/boards.h
diff --git a/Makefile.target b/Makefile.target
index 72c267f7dc..167ae2174e 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -148,7 +148,7 @@ endif #CONFIG_BSD_USER
 #########################################################
 # System emulator target
 ifdef CONFIG_SOFTMMU
-obj-y +=3D arch_init.o cpus.o gdbstub.o balloon.o ioport.o numa.o
+obj-y +=3D arch_init.o cpus.o gdbstub.o balloon.o ioport.o
 obj-y +=3D qtest.o
 obj-y +=3D hw/
 obj-y +=3D monitor/
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index a799c83815..e3a8307be6 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -22,3 +22,5 @@ common-obj-$(CONFIG_SOFTMMU) +=3D split-irq.o
 common-obj-$(CONFIG_PLATFORM_BUS) +=3D platform-bus.o
 common-obj-$(CONFIG_SOFTMMU) +=3D generic-loader.o
 common-obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
+
+obj-$(CONFIG_SOFTMMU) +=3D numa.o
diff --git a/numa.c b/hw/core/numa.c
similarity index 100%
rename from numa.c
rename to hw/core/numa.c
--=20
2.21.0



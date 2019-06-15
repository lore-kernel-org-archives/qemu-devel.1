Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54009C31E51
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 16:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6FB2184E
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 16:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6FB2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33332 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcBPa-0003h6-Dt
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 12:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36158)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcArN-0004br-79
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcArM-0001vj-27
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41974)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hcArJ-0001k8-JF; Sat, 15 Jun 2019 11:44:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D7AFC307D854;
 Sat, 15 Jun 2019 15:44:48 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-41.brq.redhat.com [10.40.204.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9578F1001B23;
 Sat, 15 Jun 2019 15:44:47 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 15 Jun 2019 17:43:52 +0200
Message-Id: <20190615154352.26824-24-philmd@redhat.com>
In-Reply-To: <20190615154352.26824-1-philmd@redhat.com>
References: <20190615154352.26824-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Sat, 15 Jun 2019 15:44:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [NOTFORMERGE PATCH v2 23/23] Missing symbols when
 building with --disable-tcg
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While it might be normal to disable PSCI on KVM, I doubt the
VFP helpers are correct ;)

Anyway this allow to link the binary and run a KVM guest.

Tested using:

  $ make pc-bios/edk2-aarch64-code.fd
  $ dd if=3D/dev/zero of=3Dflash1.img bs=3D1M count=3D64
  $ aarch64-softmmu/qemu-system-aarch64 \
    -nographic \
    -enable-kvm \
    -M virt,gic-version=3D3 \
    -cpu host \
    \
    -pflash pc-bios/edk2-aarch64-code.fd \
    -pflash flash1.img \
    -drive if=3Dnone,file=3Dbionic-server-cloudimg-arm64.img,id=3Dhd0 \
    -device virtio-blk-device,drive=3Dhd0 \
    \
    -netdev type=3Duser,id=3Dnet0 \
    -device virtio-net-device,netdev=3Dnet0

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/Makefile.objs |  1 +
 target/arm/kvm-missing.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 target/arm/kvm-missing.c

diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index b8aa9c032a..bf1cad2909 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -6,6 +6,7 @@ obj-$(CONFIG_SOFTMMU) +=3D machine.o arch_dump.o monitor.=
o arm-powerctl.o
 obj-$(call land,$(CONFIG_TCG),$(CONFIG_SOFTMMU)) +=3D psci.o
=20
 obj-$(CONFIG_KVM) +=3D kvm.o
+obj-$(CONFIG_KVM) +=3D kvm-missing.o
 obj-$(call land,$(CONFIG_KVM),$(call lnot,$(TARGET_AARCH64))) +=3D kvm32=
.o
 obj-$(call land,$(CONFIG_KVM),$(TARGET_AARCH64)) +=3D kvm64.o
 obj-$(call lnot,$(CONFIG_KVM)) +=3D kvm-stub.o
diff --git a/target/arm/kvm-missing.c b/target/arm/kvm-missing.c
new file mode 100644
index 0000000000..0b32cd4e9c
--- /dev/null
+++ b/target/arm/kvm-missing.c
@@ -0,0 +1,22 @@
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "internals.h"
+
+uint32_t vfp_get_fpscr(CPUARMState *env)
+{
+    return 0;
+}
+
+void vfp_set_fpscr(CPUARMState *env, uint32_t val)
+{
+}
+
+bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
+{
+    return false;
+}
+
+void arm_handle_psci_call(ARMCPU *cpu)
+{
+    abort();
+}
--=20
2.20.1



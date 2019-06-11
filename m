Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A319C06508
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 15:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 661F52080A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 15:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661F52080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60281 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haikg-00077g-BM
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 11:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57370)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1haidu-0004fR-T1
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1haids-0006Nr-8Y
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:24:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50226)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1haidr-0006Mz-Vz
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:24:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 44994223878
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 15:24:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABF0460BF1;
 Tue, 11 Jun 2019 15:24:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DE3F31136423; Tue, 11 Jun 2019 17:24:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 17:24:47 +0200
Message-Id: <20190611152448.29436-12-armbru@redhat.com>
In-Reply-To: <20190611152448.29436-1-armbru@redhat.com>
References: <20190611152448.29436-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 11 Jun 2019 15:24:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/12] MAINTAINERS: Improve section headlines
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

When scripts/get_maintainer.pl reports something like

    John Doe <jdoe@example.org> (maintainer:Overall)

the user is left to wonder *which* of our three "Overall" sections
applies: the one under "Guest CPU cores (TCG)", or the one under
"Guest CPU Cores (KVM)", or the one under "Usermode emulation".

Rename sections under

* "Guest CPU cores (TCG)" from "FOO" to "FOO TCG CPUs"

* "Guest CPU Cores (KVM)" from "FOO" to "FOO KVM CPUs"

* "Guest CPU Cores (Xen)" from "FOO" to "FOO Xen CPUs"

* "Architecture support" from "FOO" to "FOO general architecture
  support"

* "Usermode Emulation" from "Overall" to "Overall usermode emulation"

* "Tiny Code Generator (TCG)" from "FOO target" to "FOO TCG target",
  and from "Common code" to "Common TCG code"

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190606172408.18399-3-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS | 80 ++++++++++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 869766346b..550d6c5959 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -83,7 +83,7 @@ T: git https://github.com/vivier/qemu.git trivial-patch=
es
=20
 Architecture support
 --------------------
-S390
+S390 general architecture support
 M: Cornelia Huck <cohuck@redhat.com>
 S: Supported
 F: default-configs/s390x-softmmu.mak
@@ -109,7 +109,7 @@ L: qemu-s390x@nongnu.org
=20
 Guest CPU cores (TCG):
 ----------------------
-Overall
+Overall TCG CPUs
 M: Richard Henderson <rth@twiddle.net>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
@@ -135,14 +135,14 @@ F: fpu/
 F: include/fpu/
 F: tests/fp/
=20
-Alpha
+Alpha TCG CPUs
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
 F: target/alpha/
 F: tests/tcg/alpha/
 F: disas/alpha.c
=20
-ARM
+ARM TCG CPUs
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
@@ -163,7 +163,7 @@ S: Maintained
 F: hw/arm/smmu*
 F: include/hw/arm/smmu*
=20
-CRIS
+CRIS TCG CPUs
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
 F: target/cris/
@@ -172,14 +172,14 @@ F: include/hw/cris/
 F: tests/tcg/cris/
 F: disas/cris.c
=20
-HPPA (PA-RISC)
+HPPA (PA-RISC) TCG CPUs
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
 F: target/hppa/
 F: hw/hppa/
 F: disas/hppa.c
=20
-LM32
+LM32 TCG CPUs
 M: Michael Walle <michael@walle.cc>
 S: Maintained
 F: target/lm32/
@@ -192,20 +192,20 @@ F: include/hw/char/lm32_juart.h
 F: include/hw/lm32/
 F: tests/tcg/lm32/
=20
-M68K
+M68K TCG CPUs
 M: Laurent Vivier <laurent@vivier.eu>
 S: Maintained
 F: target/m68k/
 F: disas/m68k.c
=20
-MicroBlaze
+MicroBlaze TCG CPUs
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
 F: target/microblaze/
 F: hw/microblaze/
 F: disas/microblaze.c
=20
-MIPS
+MIPS TCG CPUs
 M: Aurelien Jarno <aurelien@aurel32.net>
 M: Aleksandar Markovic <amarkovic@wavecomp.com>
 R: Aleksandar Rikalo <arikalo@wavecomp.com>
@@ -226,7 +226,7 @@ F: include/hw/timer/mips_gictimer.h
 F: tests/tcg/mips/
 K: ^Subject:.*(?i)mips
=20
-Moxie
+Moxie TCG CPUs
 M: Anthony Green <green@moxielogic.com>
 S: Maintained
 F: target/moxie/
@@ -234,7 +234,7 @@ F: disas/moxie.c
 F: hw/moxie/
 F: default-configs/moxie-softmmu.mak
=20
-NiosII
+NiosII TCG CPUs
 M: Chris Wulff <crwulff@gmail.com>
 M: Marek Vasut <marex@denx.de>
 S: Maintained
@@ -244,14 +244,14 @@ F: hw/intc/nios2_iic.c
 F: disas/nios2.c
 F: default-configs/nios2-softmmu.mak
=20
-OpenRISC
+OpenRISC TCG CPUs
 M: Stafford Horne <shorne@gmail.com>
 S: Odd Fixes
 F: target/openrisc/
 F: hw/openrisc/
 F: tests/tcg/openrisc/
=20
-PowerPC
+PowerPC TCG CPUs
 M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Maintained
@@ -260,7 +260,7 @@ F: hw/ppc/
 F: include/hw/ppc/
 F: disas/ppc.c
=20
-RISC-V
+RISC-V TCG CPUs
 M: Palmer Dabbelt <palmer@sifive.com>
 M: Alistair Francis <Alistair.Francis@wdc.com>
 M: Sagar Karandikar <sagark@eecs.berkeley.edu>
@@ -273,7 +273,7 @@ F: include/hw/riscv/
 F: linux-user/host/riscv32/
 F: linux-user/host/riscv64/
=20
-S390
+S390 TCG CPUs
 M: Richard Henderson <rth@twiddle.net>
 M: David Hildenbrand <david@redhat.com>
 S: Maintained
@@ -283,7 +283,7 @@ F: disas/s390.c
 F: tests/tcg/s390x/
 L: qemu-s390x@nongnu.org
=20
-SH4
+SH4 TCG CPUs
 M: Aurelien Jarno <aurelien@aurel32.net>
 S: Odd Fixes
 F: target/sh4/
@@ -291,7 +291,7 @@ F: hw/sh4/
 F: disas/sh4.c
 F: include/hw/sh4/
=20
-SPARC
+SPARC TCG CPUs
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 M: Artyom Tarasenko <atar4qemu@gmail.com>
 S: Maintained
@@ -301,14 +301,14 @@ F: hw/sparc64/
 F: include/hw/sparc/sparc64.h
 F: disas/sparc.c
=20
-UniCore32
+UniCore32 TCG CPUs
 M: Guan Xuetao <gxt@mprc.pku.edu.cn>
 S: Maintained
 F: target/unicore32/
 F: hw/unicore32/
 F: include/hw/unicore32/
=20
-X86
+X86 TCG CPUs
 M: Paolo Bonzini <pbonzini@redhat.com>
 M: Richard Henderson <rth@twiddle.net>
 M: Eduardo Habkost <ehabkost@redhat.com>
@@ -321,7 +321,7 @@ F: disas/i386.c
 F: docs/qemu-cpu-models.texi
 T: git https://github.com/ehabkost/qemu.git x86-next
=20
-Xtensa
+Xtensa TCG CPUs
 M: Max Filippov <jcmvbkbc@gmail.com>
 W: http://wiki.osll.ru/doku.php?id=3Detc:users:jcmvbkbc:qemu-target-xten=
sa
 S: Maintained
@@ -332,7 +332,7 @@ F: disas/xtensa.c
 F: include/hw/xtensa/xtensa-isa.h
 F: default-configs/xtensa*.mak
=20
-TriCore
+TriCore TCG CPUs
 M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
 S: Maintained
 F: target/tricore/
@@ -347,7 +347,7 @@ F: tests/tcg/multiarch/
 Guest CPU Cores (KVM):
 ----------------------
=20
-Overall
+Overall KVM CPUs
 M: Paolo Bonzini <pbonzini@redhat.com>
 L: kvm@vger.kernel.org
 S: Supported
@@ -358,24 +358,24 @@ F: include/hw/kvm/
 F: include/sysemu/kvm*.h
 F: scripts/kvm/kvm_flightrecorder
=20
-ARM
+ARM KVM CPUs
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: target/arm/kvm.c
=20
-MIPS
+MIPS KVM CPUs
 M: James Hogan <jhogan@kernel.org>
 R: Aleksandar Rikalo <arikalo@wavecomp.com>
 S: Maintained
 F: target/mips/kvm.c
=20
-PPC
+PPC KVM CPUs
 M: David Gibson <david@gibson.dropbear.id.au>
 S: Maintained
 F: target/ppc/kvm.c
=20
-S390
+S390 KVM CPUs
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Cornelia Huck <cohuck@redhat.com>
 M: Christian Borntraeger <borntraeger@de.ibm.com>
@@ -394,7 +394,7 @@ T: git https://github.com/cohuck/qemu.git s390-next
 T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
-X86
+X86 KVM CPUs
 M: Paolo Bonzini <pbonzini@redhat.com>
 M: Marcelo Tosatti <mtosatti@redhat.com>
 L: kvm@vger.kernel.org
@@ -405,7 +405,7 @@ F: scripts/kvm/vmxcap
 Guest CPU Cores (Xen):
 ----------------------
=20
-X86
+X86 Xen CPUs
 M: Stefano Stabellini <sstabellini@kernel.org>
 M: Anthony Perard <anthony.perard@citrix.com>
 M: Paul Durrant <paul.durrant@citrix.com>
@@ -2267,7 +2267,7 @@ F: tests/uefi-test-tools/
=20
 Usermode Emulation
 ------------------
-Overall
+Overall usermode emulation
 M: Riku Voipio <riku.voipio@iki.fi>
 S: Maintained
 F: thunk.c
@@ -2288,12 +2288,12 @@ F: scripts/qemu-binfmt-conf.sh
=20
 Tiny Code Generator (TCG)
 -------------------------
-Common code
+Common TCG code
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
 F: tcg/
=20
-AArch64 target
+AArch64 TCG target
 M: Claudio Fontana <claudio.fontana@huawei.com>
 M: Claudio Fontana <claudio.fontana@gmail.com>
 S: Maintained
@@ -2302,33 +2302,33 @@ F: tcg/aarch64/
 F: disas/arm-a64.cc
 F: disas/libvixl/
=20
-ARM target
+ARM TCG target
 M: Andrzej Zaborowski <balrogg@gmail.com>
 S: Maintained
 L: qemu-arm@nongnu.org
 F: tcg/arm/
 F: disas/arm.c
=20
-i386 target
+i386 TCG target
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
 F: tcg/i386/
 F: disas/i386.c
=20
-MIPS target
+MIPS TCG target
 M: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <arikalo@wavecomp.com>
 S: Maintained
 F: tcg/mips/
 F: disas/mips.c
=20
-PPC
+PPC TCG target
 M: Richard Henderson <rth@twiddle.net>
 S: Odd Fixes
 F: tcg/ppc/
 F: disas/ppc.c
=20
-RISC-V
+RISC-V TCG target
 M: Palmer Dabbelt <palmer@sifive.com>
 M: Alistair Francis <Alistair.Francis@wdc.com>
 L: qemu-riscv@nongnu.org
@@ -2336,19 +2336,19 @@ S: Maintained
 F: tcg/riscv/
 F: disas/riscv.c
=20
-S390 target
+S390 TCG target
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
 F: tcg/s390/
 F: disas/s390.c
 L: qemu-s390x@nongnu.org
=20
-SPARC target
+SPARC TCG target
 S: Odd Fixes
 F: tcg/sparc/
 F: disas/sparc.c
=20
-TCI target
+TCI TCG target
 M: Stefan Weil <sw@weilnetz.de>
 S: Maintained
 F: tcg/tci/
--=20
2.21.0



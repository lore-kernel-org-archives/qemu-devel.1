Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC5CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 08:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE6621897
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 08:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3o/dg/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE6621897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvGTy-0007Mq-2D
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 04:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jvGT4-0006Si-Io
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 04:39:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40864
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jvGSy-0002Hw-6d
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 04:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594715947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xSfU+6Ol7KoyB+/CU5ElUB8FlBNqpbeO/omWGT/nOxA=;
 b=K3o/dg/G/etcAr1ty6yCRhApHD5AoaH23LOk5xgMcHRIF19CLpba8Q8RQ9Tif6Ab3VP9C8
 MZoQk6bzvPkCHU6+dS7cLg6KcfAYEfGNO8LiDc5bNNCfVW2QG9eFXmHzHnVbB8CiwAACz1
 d1KcXkS7FchUQQ9ceskLDIyDjM8tpqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-kzEVEJdJO4Omp9dwTjL3fw-1; Tue, 14 Jul 2020 04:38:54 -0400
X-MC-Unique: kzEVEJdJO4Omp9dwTjL3fw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1FD61085;
 Tue, 14 Jul 2020 08:38:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.33.36.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D2D576206;
 Tue, 14 Jul 2020 08:38:45 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>
Subject: [PATCH 1/1] MAINTAINERS: introduce cve or security quotient field
Date: Tue, 14 Jul 2020 14:06:31 +0530
Message-Id: <20200714083631.888605-2-ppandit@redhat.com>
In-Reply-To: <20200714083631.888605-1-ppandit@redhat.com>
References: <20200714083631.888605-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:44:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

QEMU supports numerous virtualisation and emulation use cases.
It also offers many features to support guest's function(s).

All of these use cases and features are not always security relevant.
Because some maybe used in trusted environments only. Some may still
be in experimental stage. While other could be very old and not
used or maintained actively.

For security bug analysis we generally consider use cases wherein
QEMU is used in conjunction with the KVM hypervisor, which enables
guest to use hardware processor's virtualisation features.

The CVE (or Security or Trust) Quotient field tries to capture this
sensitivity pertaining to a feature or section of the code.

It indicates whether a potential issue should be treated as a security
one OR it could be fixed as a regular non-security bug.

Suggested-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 MAINTAINERS | 324 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 324 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe8139f367..badf1dab6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -33,6 +33,14 @@ Descriptions of section entries:
 	   Obsolete:	Old code. Something tagged obsolete generally means
 			it has been replaced by a better system and you
 			should be using that.
+	C: CVE/Security/Trust Quotient
+	   H:High - Feature (or code) is meant to be safe and used by untrusted
+	            guests. So any potential security issue must be processed with
+	            due care and be considered as a CVE issue.
+	   L:Low  - Feature (or code) is not meant to be safe OR is experimental
+	            OR is used in trusted environments only OR is not well
+	            maintained. So any potential security issue can be processed
+	            and fixed as regular non-security bug. No need for a CVE.
 	F: Files and directories with wildcard patterns.
 	   A trailing slash includes all files and subdirectory files.
 	   F:	drivers/net/	all files in and below drivers/net
@@ -87,6 +95,7 @@ S390 general architecture support
 M: Cornelia Huck <cohuck@redhat.com>
 M: Thomas Huth <thuth@redhat.com>
 S: Supported
+C: High
 F: default-configs/s390x-softmmu.mak
 F: gdb-xml/s390*.xml
 F: hw/char/sclp*.[hc]
@@ -115,6 +124,7 @@ Overall TCG CPUs
 M: Richard Henderson <rth@twiddle.net>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
+C: Low
 F: softmmu/cpus.c
 F: cpus-common.c
 F: exec.c
@@ -134,6 +144,7 @@ M: Aurelien Jarno <aurelien@aurel32.net>
 M: Peter Maydell <peter.maydell@linaro.org>
 M: Alex BennÃ©e <alex.bennee@linaro.org>
 S: Maintained
+C: Low
 F: fpu/
 F: include/fpu/
 F: tests/fp/
@@ -141,6 +152,7 @@ F: tests/fp/
 Alpha TCG CPUs
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
+C: Low
 F: target/alpha/
 F: tests/tcg/alpha/
 F: disas/alpha.c
@@ -149,6 +161,7 @@ ARM TCG CPUs
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: target/arm/
 F: tests/tcg/arm/
 F: tests/tcg/aarch64/
@@ -164,6 +177,7 @@ ARM SMMU
 M: Eric Auger <eric.auger@redhat.com>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: High
 F: hw/arm/smmu*
 F: include/hw/arm/smmu*
 
@@ -171,6 +185,7 @@ AVR TCG CPUs
 M: Michael Rolnik <mrolnik@gmail.com>
 R: Sarah Harris <S.E.Harris@kent.ac.uk>
 S: Maintained
+C: Low
 F: gdb-xml/avr-cpu.xml
 F: target/avr/
 F: tests/acceptance/machine_avr6.py
@@ -178,6 +193,7 @@ F: tests/acceptance/machine_avr6.py
 CRIS TCG CPUs
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
+C: Low
 F: target/cris/
 F: hw/cris/
 F: include/hw/cris/
@@ -187,6 +203,7 @@ F: disas/cris.c
 HPPA (PA-RISC) TCG CPUs
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
+C: Low
 F: target/hppa/
 F: hw/hppa/
 F: disas/hppa.c
@@ -196,6 +213,7 @@ F: include/hw/net/lasi_82596.h
 LM32 TCG CPUs
 R: Michael Walle <michael@walle.cc>
 S: Orphan
+C: Low
 F: target/lm32/
 F: disas/lm32.c
 F: hw/lm32/
@@ -209,12 +227,14 @@ F: tests/tcg/lm32/
 M68K TCG CPUs
 M: Laurent Vivier <laurent@vivier.eu>
 S: Maintained
+C: Low
 F: target/m68k/
 F: disas/m68k.c
 
 MicroBlaze TCG CPUs
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
+C: Low
 F: target/microblaze/
 F: hw/microblaze/
 F: disas/microblaze.c
@@ -224,6 +244,7 @@ M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
+C: Low
 F: target/mips/
 F: default-configs/*mips*
 F: disas/*mips*
@@ -244,6 +265,7 @@ K: ^Subject:.*(?i)mips
 Moxie TCG CPUs
 M: Anthony Green <green@moxielogic.com>
 S: Maintained
+C: Low
 F: target/moxie/
 F: disas/moxie.c
 F: hw/moxie/
@@ -253,6 +275,7 @@ NiosII TCG CPUs
 M: Chris Wulff <crwulff@gmail.com>
 M: Marek Vasut <marex@denx.de>
 S: Maintained
+C: Low
 F: target/nios2/
 F: hw/nios2/
 F: hw/intc/nios2_iic.c
@@ -262,6 +285,7 @@ F: default-configs/nios2-softmmu.mak
 OpenRISC TCG CPUs
 M: Stafford Horne <shorne@gmail.com>
 S: Odd Fixes
+C: Low
 F: target/openrisc/
 F: hw/openrisc/
 F: tests/tcg/openrisc/
@@ -270,6 +294,7 @@ PowerPC TCG CPUs
 M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Maintained
+C: High
 F: target/ppc/
 F: hw/ppc/
 F: include/hw/ppc/
@@ -282,6 +307,7 @@ M: Sagar Karandikar <sagark@eecs.berkeley.edu>
 M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
 L: qemu-riscv@nongnu.org
 S: Supported
+C: Low
 F: target/riscv/
 F: hw/riscv/
 F: include/hw/riscv/
@@ -291,12 +317,14 @@ F: linux-user/host/riscv64/
 RENESAS RX CPUs
 M: Yoshinori Sato <ysato@users.sourceforge.jp>
 S: Maintained
+C: Low
 F: target/rx/
 
 S390 TCG CPUs
 M: Richard Henderson <rth@twiddle.net>
 M: David Hildenbrand <david@redhat.com>
 S: Maintained
+C: High
 F: target/s390x/
 F: hw/s390x/
 F: disas/s390.c
@@ -306,6 +334,7 @@ L: qemu-s390x@nongnu.org
 SH4 TCG CPUs
 M: Yoshinori Sato <ysato@users.sourceforge.jp>
 S: Odd Fixes
+C: Low
 F: target/sh4/
 F: hw/sh4/
 F: disas/sh4.c
@@ -315,6 +344,7 @@ SPARC TCG CPUs
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 M: Artyom Tarasenko <atar4qemu@gmail.com>
 S: Maintained
+C: Low
 F: target/sparc/
 F: hw/sparc/
 F: hw/sparc64/
@@ -324,6 +354,7 @@ F: disas/sparc.c
 UniCore32 TCG CPUs
 M: Guan Xuetao <gxt@mprc.pku.edu.cn>
 S: Maintained
+C: Low
 F: target/unicore32/
 F: hw/unicore32/
 F: include/hw/unicore32/
@@ -333,6 +364,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 M: Richard Henderson <rth@twiddle.net>
 M: Eduardo Habkost <ehabkost@redhat.com>
 S: Maintained
+C: High
 F: target/i386/
 F: tests/tcg/i386/
 F: tests/tcg/x86_64/
@@ -345,6 +377,7 @@ Xtensa TCG CPUs
 M: Max Filippov <jcmvbkbc@gmail.com>
 W: http://wiki.osll.ru/doku.php?id=etc:users:jcmvbkbc:qemu-target-xtensa
 S: Maintained
+C: Low
 F: target/xtensa/
 F: hw/xtensa/
 F: tests/tcg/xtensa/
@@ -355,6 +388,7 @@ F: default-configs/xtensa*.mak
 TriCore TCG CPUs
 M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
 S: Maintained
+C: Low
 F: target/tricore/
 F: hw/tricore/
 F: include/hw/tricore/
@@ -362,6 +396,7 @@ F: include/hw/tricore/
 Multiarch Linux User Tests
 M: Alex BennÃ©e <alex.bennee@linaro.org>
 S: Maintained
+C: Low
 F: tests/tcg/multiarch/
 
 Guest CPU Cores (KVM)
@@ -370,6 +405,7 @@ Overall KVM CPUs
 M: Paolo Bonzini <pbonzini@redhat.com>
 L: kvm@vger.kernel.org
 S: Supported
+C: High
 F: */*/kvm*
 F: accel/kvm/
 F: accel/stubs/kvm-stub.c
@@ -381,16 +417,19 @@ ARM KVM CPUs
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: High
 F: target/arm/kvm.c
 
 MIPS KVM CPUs
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 S: Odd Fixes
+C: Low
 F: target/mips/kvm.c
 
 PPC KVM CPUs
 M: David Gibson <david@gibson.dropbear.id.au>
 S: Maintained
+C: High
 F: target/ppc/kvm.c
 
 S390 KVM CPUs
@@ -398,6 +437,7 @@ M: Halil Pasic <pasic@linux.ibm.com>
 M: Cornelia Huck <cohuck@redhat.com>
 M: Christian Borntraeger <borntraeger@de.ibm.com>
 S: Supported
+C: High
 F: target/s390x/kvm.c
 F: target/s390x/kvm_s390x.h
 F: target/s390x/kvm-stub.c
@@ -421,6 +461,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 M: Marcelo Tosatti <mtosatti@redhat.com>
 L: kvm@vger.kernel.org
 S: Supported
+C: High
 F: target/i386/kvm.c
 F: scripts/kvm/vmxcap
 
@@ -430,6 +471,7 @@ Overall
 M: Richard Henderson <rth@twiddle.net>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
+C: Low
 F: include/sysemu/accel.h
 F: accel/accel.c
 F: accel/Makefile.objs
@@ -440,6 +482,7 @@ M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <r.bolshakov@yadro.com>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
+C: Low
 F: accel/stubs/hvf-stub.c
 F: target/i386/hvf/
 F: include/sysemu/hvf.h
@@ -447,6 +490,7 @@ F: include/sysemu/hvf.h
 WHPX CPUs
 M: Sunil Muthuswamy <sunilmut@microsoft.com>
 S: Supported
+C: Low
 F: target/i386/whpx-all.c
 F: target/i386/whp-dispatch.h
 F: accel/stubs/whpx-stub.c
@@ -460,6 +504,7 @@ M: Anthony Perard <anthony.perard@citrix.com>
 M: Paul Durrant <paul@xen.org>
 L: xen-devel@lists.xenproject.org
 S: Supported
+C: High
 F: */xen*
 F: accel/xen/*
 F: hw/9pfs/xen-9p*
@@ -486,6 +531,7 @@ M: Colin Xu <colin.xu@intel.com>
 L: haxm-team@intel.com
 W: https://github.com/intel/haxm/issues
 S: Maintained
+C: Low
 F: accel/stubs/hax-stub.c
 F: include/sysemu/hax.h
 F: target/i386/hax-*
@@ -497,12 +543,14 @@ M: Michael S. Tsirkin <mst@redhat.com>
 M: Cornelia Huck <cohuck@redhat.com>
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
+C: High
 F: linux-headers/
 F: scripts/update-linux-headers.sh
 
 POSIX
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
+C: High
 F: os-posix.c
 F: include/sysemu/os-posix.h
 F: util/*posix*.c
@@ -511,16 +559,19 @@ F: include/qemu/*posix*.h
 NETBSD
 M: Kamil Rytarowski <kamil@netbsd.org>
 S: Maintained
+C: High
 K: ^Subject:.*(?i)NetBSD
 
 OPENBSD
 M: Brad Smith <brad@comstyle.com>
 S: Maintained
+C: High
 K: ^Subject:.*(?i)OpenBSD
 
 W32, W64
 M: Stefan Weil <sw@weilnetz.de>
 S: Maintained
+C: High
 F: *win32*
 F: */*win32*
 F: include/*/*win32*
@@ -531,6 +582,7 @@ Alpha Machines
 --------------
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
+C: Low
 F: hw/alpha/
 F: hw/isa/smc37c669-superio.c
 F: tests/tcg/alpha/system/
@@ -542,6 +594,7 @@ M: Beniamino Galvani <b.galvani@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/*/allwinner*
 F: include/hw/*/allwinner*
 F: hw/arm/cubieboard.c
@@ -550,6 +603,7 @@ Allwinner-h3
 M: Niek Linnenbank <nieklinnenbank@gmail.com>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/*/allwinner-h3*
 F: include/hw/*/allwinner-h3*
 F: hw/arm/orangepi.c
@@ -559,6 +613,7 @@ ARM PrimeCell and CMSDK devices
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/char/pl011.c
 F: include/hw/char/pl011.h
 F: hw/display/pl110*
@@ -593,6 +648,7 @@ ARM cores
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: High
 F: hw/intc/arm*
 F: hw/intc/gic_internal.h
 F: hw/misc/a9scu.c
@@ -614,6 +670,7 @@ M: Igor Mitsyanko <i.mitsyanko@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/*/exynos*
 F: include/hw/arm/exynos4210.h
 
@@ -622,6 +679,7 @@ M: Rob Herring <robh@kernel.org>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/arm/highbank.c
 F: hw/net/xgmac.c
 
@@ -630,6 +688,7 @@ M: Antony Pavlov <antonynpavlov@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
+C: Low
 F: include/hw/arm/digic.h
 F: hw/*/digic*
 F: include/hw/*/digic*
@@ -640,6 +699,7 @@ M: Anup Patel <anup.patel@wdc.com>
 M: Alistair Francis <Alistair.Francis@wdc.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
+C: Low
 F: hw/rtc/goldfish_rtc.c
 F: include/hw/rtc/goldfish_rtc.h
 
@@ -648,6 +708,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 R: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/arm/gumstix.c
 
 i.MX25 PDK
@@ -655,6 +716,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 R: Jean-Christophe Dubois <jcd@tribudubois.net>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/arm/fsl-imx25.c
 F: hw/arm/imx25_pdk.c
 F: hw/misc/imx25_ccm.c
@@ -668,6 +730,7 @@ M: Peter Chubb <peter.chubb@nicta.com.au>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/arm/kzm.c
 F: hw/*/imx_*
 F: hw/*/*imx31*
@@ -678,6 +741,7 @@ Integrator CP
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/arm/integratorcp.c
 F: hw/misc/arm_integrator_debug.c
 F: include/hw/misc/arm_integrator_debug.h
@@ -689,6 +753,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 R: Jean-Christophe Dubois <jcd@tribudubois.net>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/arm/mcimx6ul-evk.c
 F: hw/arm/fsl-imx6ul.c
 F: hw/misc/imx6ul_ccm.c
@@ -700,6 +765,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 R: Andrey Smirnov <andrew.smirnov@gmail.com>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/arm/mcimx7d-sabre.c
 F: hw/arm/fsl-imx7.c
 F: hw/misc/imx7_*.c
@@ -712,6 +778,7 @@ MPS2
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/arm/mps2.c
 F: hw/arm/mps2-tz.c
 F: hw/misc/mps2-*.c
@@ -734,6 +801,7 @@ Musca
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/arm/musca.c
 F: docs/system/arm/musca.rst
 
@@ -742,6 +810,7 @@ M: Jan Kiszka <jan.kiszka@web.de>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/arm/musicpal.c
 F: docs/system/arm/musicpal.rst
 
@@ -750,6 +819,7 @@ M: Andrzej Zaborowski <balrogg@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/arm/nseries.c
 F: hw/display/blizzard.c
 F: hw/input/lm832x.c
@@ -767,6 +837,7 @@ M: Andrzej Zaborowski <balrogg@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/arm/palm.c
 F: hw/input/tsc210x.c
 F: include/hw/input/tsc2xxx.h
@@ -778,6 +849,7 @@ R: Andrew Baumann <Andrew.Baumann@microsoft.com>
 R: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/arm/raspi.c
 F: hw/arm/raspi_platform.h
 F: hw/*/bcm283*
@@ -788,6 +860,7 @@ Real View
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/arm/realview*
 F: hw/cpu/realview_mpcore.c
 F: hw/intc/realview_gic.c
@@ -799,6 +872,7 @@ M: Andrzej Zaborowski <balrogg@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/arm/mainstone.c
 F: hw/arm/spitz.c
 F: hw/arm/tosa.c
@@ -820,6 +894,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 R: Jean-Christophe Dubois <jcd@tribudubois.net>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/arm/sabrelite.c
 F: hw/arm/fsl-imx6.c
 F: hw/misc/imx6_*.c
@@ -836,12 +911,14 @@ M: Peter Maydell <peter.maydell@linaro.org>
 R: Leif Lindholm <leif@nuviainc.com>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/arm/sbsa-ref.c
 
 Sharp SL-5500 (Collie) PDA
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/arm/collie.c
 F: hw/arm/strongarm*
 
@@ -849,6 +926,7 @@ Stellaris
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/*/stellaris*
 F: include/hw/input/gamepad.h
 F: docs/system/arm/stellaris.rst
@@ -857,6 +935,7 @@ Versatile Express
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/arm/vexpress.c
 F: docs/system/arm/vexpress.rst
 
@@ -864,6 +943,7 @@ Versatile PB
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/*/versatile*
 F: include/hw/i2c/arm_sbcon_i2c.h
 F: hw/misc/arm_sysctl.c
@@ -873,6 +953,7 @@ Virt
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/arm/virt*
 F: include/hw/arm/virt.h
 
@@ -882,6 +963,7 @@ M: Alistair Francis <alistair@alistair23.me>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/*/xilinx_*
 F: hw/*/cadence_*
 F: hw/misc/zynq*
@@ -894,6 +976,7 @@ M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/*/xlnx*.c
 F: include/hw/*/xlnx*.h
 F: include/hw/ssi/xilinx_spips.h
@@ -904,6 +987,7 @@ ARM ACPI Subsystem
 M: Shannon Zhao <shannon.zhaosl@gmail.com>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/arm/virt-acpi-build.c
 
 STM32F205
@@ -911,6 +995,7 @@ M: Alistair Francis <alistair@alistair23.me>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/arm/stm32f205_soc.c
 F: hw/misc/stm32f2xx_syscfg.c
 F: hw/char/stm32f2xx_usart.c
@@ -924,6 +1009,7 @@ M: Alistair Francis <alistair@alistair23.me>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/arm/stm32f405_soc.c
 F: hw/misc/stm32f4xx_syscfg.c
 F: hw/misc/stm32f4xx_exti.c
@@ -933,6 +1019,7 @@ M: Alistair Francis <alistair@alistair23.me>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/arm/netduino2.c
 
 Netduino Plus 2
@@ -940,6 +1027,7 @@ M: Alistair Francis <alistair@alistair23.me>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/arm/netduinoplus2.c
 
 SmartFusion2
@@ -947,6 +1035,7 @@ M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/arm/msf2-soc.c
 F: hw/misc/msf2-sysreg.c
 F: hw/timer/mss-timer.c
@@ -963,6 +1052,7 @@ M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/arm/msf2-som.c
 
 ASPEED BMCs
@@ -972,6 +1062,7 @@ R: Andrew Jeffery <andrew@aj.id.au>
 R: Joel Stanley <joel@jms.id.au>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/*/*aspeed*
 F: hw/misc/pca9552.c
 F: include/hw/*/*aspeed*
@@ -984,6 +1075,7 @@ M: Joel Stanley <joel@jms.id.au>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/*/nrf51*.c
 F: hw/*/microbit*.c
 F: include/hw/*/nrf51*.h
@@ -997,6 +1089,7 @@ AVR MCUs
 M: Michael Rolnik <mrolnik@gmail.com>
 R: Sarah Harris <S.E.Harris@kent.ac.uk>
 S: Maintained
+C: Low
 F: default-configs/avr-softmmu.mak
 F: hw/avr/
 F: include/hw/char/avr_usart.h
@@ -1010,6 +1103,7 @@ Arduino
 M: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
 R: Sarah Harris <S.E.Harris@kent.ac.uk>
 S: Maintained
+C: Low
 F: hw/avr/arduino.c
 
 CRIS Machines
@@ -1017,6 +1111,7 @@ CRIS Machines
 Axis Dev88
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
+C: Low
 F: hw/cris/axis_dev88.c
 F: hw/*/etraxfs_*.c
 
@@ -1026,6 +1121,7 @@ HP B160L
 M: Richard Henderson <rth@twiddle.net>
 R: Helge Deller <deller@gmx.de>
 S: Odd Fixes
+C: Low
 F: default-configs/hppa-softmmu.mak
 F: hw/hppa/
 F: pc-bios/hppa-firmware.img
@@ -1035,11 +1131,13 @@ LM32 Machines
 EVR32 and uclinux BSP
 R: Michael Walle <michael@walle.cc>
 S: Orphan
+C: Low
 F: hw/lm32/lm32_boards.c
 
 milkymist
 R: Michael Walle <michael@walle.cc>
 S: Orphan
+C: Low
 F: hw/lm32/milkymist.c
 
 M68K Machines
@@ -1047,12 +1145,14 @@ M68K Machines
 an5206
 M: Thomas Huth <huth@tuxfamily.org>
 S: Odd Fixes
+C: Low
 F: hw/m68k/an5206.c
 F: hw/m68k/mcf5206.c
 
 mcf5208
 M: Thomas Huth <huth@tuxfamily.org>
 S: Odd Fixes
+C: Low
 F: hw/m68k/mcf5208.c
 F: hw/m68k/mcf_intc.c
 F: hw/char/mcf_uart.c
@@ -1062,6 +1162,7 @@ F: include/hw/m68k/mcf*.h
 NeXTcube
 M: Thomas Huth <huth@tuxfamily.org>
 S: Odd Fixes
+C: Low
 F: hw/m68k/next-*.c
 F: hw/display/next-fb.c
 F: include/hw/m68k/next-cube.h
@@ -1069,6 +1170,7 @@ F: include/hw/m68k/next-cube.h
 q800
 M: Laurent Vivier <laurent@vivier.eu>
 S: Maintained
+C: Low
 F: hw/m68k/q800.c
 F: hw/misc/mac_via.c
 F: hw/nubus/*
@@ -1085,12 +1187,14 @@ MicroBlaze Machines
 petalogix_s3adsp1800
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
+C: Low
 F: hw/microblaze/petalogix_s3adsp1800_mmu.c
 F: include/hw/char/xilinx_uartlite.h
 
 petalogix_ml605
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
+C: Low
 F: hw/microblaze/petalogix_ml605_mmu.c
 
 MIPS Machines
@@ -1099,6 +1203,7 @@ Jazz
 M: HervÃ© Poussineau <hpoussin@reactos.org>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
+C: Low
 F: hw/mips/jazz.c
 F: hw/display/jazz_led.c
 F: hw/dma/rc4030.c
@@ -1108,6 +1213,7 @@ M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 M: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
 R: Aurelien Jarno <aurelien@aurel32.net>
 S: Maintained
+C: Low
 F: hw/isa/piix4.c
 F: hw/acpi/piix4.c
 F: hw/mips/malta.c
@@ -1120,6 +1226,7 @@ Mipssim
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Odd Fixes
+C: Low
 F: hw/mips/mipssim.c
 F: hw/net/mipsnet.c
 
@@ -1128,6 +1235,7 @@ M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Obsolete
+C: Low
 F: hw/mips/r4k.c
 
 Fuloong 2E
@@ -1136,6 +1244,7 @@ M: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Odd Fixes
+C: Low
 F: hw/mips/fuloong2e.c
 F: hw/isa/vt82c686.c
 F: hw/pci-host/bonito.c
@@ -1145,12 +1254,14 @@ Loongson-3 virtual platforms
 M: Huacai Chen <chenhc@lemote.com>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Maintained
+C: Low
 F: hw/intc/loongson_liointc.c
 
 Boston
 M: Paul Burton <pburton@wavecomp.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
+C: Low
 F: hw/core/loader-fit.c
 F: hw/mips/boston.c
 F: hw/pci-host/xilinx-pcie.c
@@ -1161,6 +1272,7 @@ OpenRISC Machines
 or1k-sim
 M: Jia Liu <proljc@gmail.com>
 S: Maintained
+C: Low
 F: hw/openrisc/openrisc_sim.c
 
 PowerPC Machines
@@ -1169,6 +1281,7 @@ PowerPC Machines
 M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/ppc/ppc405_boards.c
 
 Bamboo
@@ -1181,6 +1294,7 @@ e500
 M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/ppc/e500*
 F: hw/gpio/mpc8xxx.c
 F: hw/i2c/mpc_i2c.c
@@ -1194,6 +1308,7 @@ mpc8544ds
 M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/ppc/mpc8544ds.c
 F: hw/ppc/mpc8544_guts.c
 
@@ -1202,6 +1317,7 @@ M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 R: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/ppc/mac_newworld.c
 F: hw/pci-host/uninorth.c
 F: hw/pci-bridge/dec.[hc]
@@ -1221,6 +1337,7 @@ M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 R: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/ppc/mac_oldworld.c
 F: hw/pci-host/grackle.c
 F: hw/misc/macio/
@@ -1234,6 +1351,7 @@ PReP
 M: HervÃ© Poussineau <hpoussin@reactos.org>
 L: qemu-ppc@nongnu.org
 S: Maintained
+C: Low
 F: hw/ppc/prep.c
 F: hw/ppc/prep_systemio.c
 F: hw/ppc/rs6000_mc.c
@@ -1250,6 +1368,7 @@ sPAPR
 M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Supported
+C: Low
 F: hw/*/spapr*
 F: include/hw/*/spapr*
 F: hw/*/xics*
@@ -1267,6 +1386,7 @@ M: CÃ©dric Le Goater <clg@kaod.org>
 M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Maintained
+C: Low
 F: hw/ppc/pnv*
 F: hw/intc/pnv*
 F: hw/intc/xics_pnv.c
@@ -1280,12 +1400,14 @@ virtex_ml507
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/ppc/virtex_ml507.c
 
 sam460ex
 M: BALATON Zoltan <balaton@eik.bme.hu>
 L: qemu-ppc@nongnu.org
 S: Maintained
+C: Low
 F: hw/ppc/sam460ex.c
 F: hw/ppc/ppc440_pcix.c
 F: hw/display/sm501*
@@ -1301,6 +1423,7 @@ OpenTitan
 M: Alistair Francis <Alistair.Francis@wdc.com>
 L: qemu-riscv@nongnu.org
 S: Supported
+C: Low
 F: hw/riscv/opentitan.c
 F: hw/char/ibex_uart.c
 F: hw/intc/ibex_plic.c
@@ -1313,6 +1436,7 @@ RX Machines
 rx-gdbsim
 M: Yoshinori Sato <ysato@users.sourceforge.jp>
 S: Maintained
+C: Low
 F: docs/system/target-rx.rst
 F: hw/rx/rx-gdbsim.c
 F: tests/acceptance/machine_rx_gdbsim.py
@@ -1323,6 +1447,7 @@ R2D
 M: Yoshinori Sato <ysato@users.sourceforge.jp>
 R: Magnus Damm <magnus.damm@gmail.com>
 S: Maintained
+C: Low
 F: hw/sh4/r2d.c
 F: hw/intc/sh_intc.c
 F: include/hw/sh4/sh_intc.h
@@ -1331,6 +1456,7 @@ Shix
 M: Yoshinori Sato <ysato@users.sourceforge.jp>
 R: Magnus Damm <magnus.damm@gmail.com>
 S: Odd Fixes
+C: Low
 F: hw/sh4/shix.c
 F: hw/intc/sh_intc.c
 F: include/hw/sh4/sh_intc.h
@@ -1340,6 +1466,7 @@ SPARC Machines
 Sun4m
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 S: Maintained
+C: Low
 F: hw/sparc/sun4m.c
 F: hw/sparc/sun4m_iommu.c
 F: hw/display/cg3.c
@@ -1355,6 +1482,7 @@ F: pc-bios/openbios-sparc32
 Sun4u
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 S: Maintained
+C: Low
 F: hw/sparc64/sun4u.c
 F: hw/sparc64/sun4u_iommu.c
 F: include/hw/sparc/sun4u_iommu.h
@@ -1368,6 +1496,7 @@ F: tests/acceptance/machine_sparc64_sun4u.py
 Sun4v
 M: Artyom Tarasenko <atar4qemu@gmail.com>
 S: Maintained
+C: Low
 F: hw/sparc64/niagara.c
 F: hw/rtc/sun4v-rtc.c
 F: include/hw/rtc/sun4v-rtc.h
@@ -1376,6 +1505,7 @@ Leon3
 M: Fabien Chouteau <chouteau@adacore.com>
 M: KONRAD Frederic <frederic.konrad@adacore.com>
 S: Maintained
+C: Low
 F: hw/sparc/leon3.c
 F: hw/*/grlib*
 F: include/hw/*/grlib*
@@ -1388,6 +1518,7 @@ M: Cornelia Huck <cohuck@redhat.com>
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@de.ibm.com>
 S: Supported
+C: High
 F: hw/char/sclp*.[hc]
 F: hw/char/terminal3270.c
 F: hw/s390x/
@@ -1403,6 +1534,7 @@ S390-ccw boot
 M: Christian Borntraeger <borntraeger@de.ibm.com>
 M: Thomas Huth <thuth@redhat.com>
 S: Supported
+C: High
 F: hw/s390x/ipl.*
 F: pc-bios/s390-ccw/
 F: pc-bios/s390-ccw.img
@@ -1413,6 +1545,7 @@ L: qemu-s390x@nongnu.org
 S390 PCI
 M: Matthew Rosato <mjrosato@linux.ibm.com>
 S: Supported
+C: High
 F: hw/s390x/s390-pci*
 L: qemu-s390x@nongnu.org
 
@@ -1421,6 +1554,7 @@ UniCore32 Machines
 PKUnity-3 SoC initramfs-with-busybox
 M: Guan Xuetao <gxt@mprc.pku.edu.cn>
 S: Maintained
+C: Low
 F: hw/*/puv3*
 F: hw/unicore32/
 
@@ -1430,6 +1564,7 @@ PC
 M: Michael S. Tsirkin <mst@redhat.com>
 M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Supported
+C: High
 F: include/hw/i386/
 F: hw/i386/
 F: hw/pci-host/i440fx.c
@@ -1455,6 +1590,7 @@ PC Chipset
 M: Michael S. Tsirkin <mst@redhat.com>
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Supported
+C: High
 F: hw/char/debugcon.c
 F: hw/char/parallel*
 F: hw/char/serial*
@@ -1487,6 +1623,7 @@ microvm
 M: Sergio Lopez <slp@redhat.com>
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
+C: High
 F: docs/microvm.rst
 F: hw/i386/microvm.c
 F: include/hw/i386/microvm.h
@@ -1496,6 +1633,7 @@ Machine core
 M: Eduardo Habkost <ehabkost@redhat.com>
 M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Supported
+C: High
 F: hw/core/cpu.c
 F: hw/core/machine-qmp-cmds.c
 F: hw/core/machine.c
@@ -1515,16 +1653,19 @@ Xtensa Machines
 sim
 M: Max Filippov <jcmvbkbc@gmail.com>
 S: Maintained
+C: Low
 F: hw/xtensa/sim.c
 
 virt
 M: Max Filippov <jcmvbkbc@gmail.com>
 S: Maintained
+C: Low
 F: hw/xtensa/virt.c
 
 XTFPGA (LX60, LX200, ML605, KC705)
 M: Max Filippov <jcmvbkbc@gmail.com>
 S: Maintained
+C: Low
 F: hw/xtensa/xtfpga.c
 F: hw/net/opencores_eth.c
 
@@ -1533,12 +1674,14 @@ Devices
 EDU
 M: Jiri Slaby <jslaby@suse.cz>
 S: Maintained
+C: Low
 F: hw/misc/edu.c
 
 IDE
 M: John Snow <jsnow@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: include/hw/ide.h
 F: include/hw/ide/
 F: hw/ide/
@@ -1554,6 +1697,7 @@ T: git https://github.com/jnsnow/qemu.git ide
 IPMI
 M: Corey Minyard <minyard@acm.org>
 S: Maintained
+C: Low
 F: include/hw/ipmi/*
 F: hw/ipmi/*
 F: hw/smbios/smbios_type_38.c
@@ -1564,6 +1708,7 @@ Floppy
 M: John Snow <jsnow@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: hw/block/fdc.c
 F: include/hw/block/fdc.h
 F: tests/qtest/fdc-test.c
@@ -1573,12 +1718,14 @@ OMAP
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/*/omap*
 F: include/hw/arm/omap.h
 
 IPack
 M: Alberto Garcia <berto@igalia.com>
 S: Odd Fixes
+C: Low
 F: hw/char/ipoctal232.c
 F: hw/ipack/
 
@@ -1586,6 +1733,7 @@ PCI
 M: Michael S. Tsirkin <mst@redhat.com>
 M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Supported
+C: High
 F: include/hw/pci/*
 F: hw/misc/pci-testdev.c
 F: hw/pci/*
@@ -1598,6 +1746,7 @@ ACPI/SMBIOS
 M: Michael S. Tsirkin <mst@redhat.com>
 M: Igor Mammedov <imammedo@redhat.com>
 S: Supported
+C: High
 F: include/hw/acpi/*
 F: include/hw/firmware/smbios.h
 F: hw/mem/*
@@ -1614,6 +1763,7 @@ R: Dongjiu Geng <gengdongjiu@huawei.com>
 R: Xiang Zheng <zhengxiang9@huawei.com>
 L: qemu-arm@nongnu.org
 S: Maintained
+C: Low
 F: hw/acpi/ghes.c
 F: include/hw/acpi/ghes.h
 F: docs/specs/acpi_hest_ghes.rst
@@ -1622,6 +1772,7 @@ ppc4xx
 M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
+C: Low
 F: hw/ppc/ppc4*.c
 F: hw/i2c/ppc4xx_i2c.c
 F: include/hw/ppc/ppc4xx.h
@@ -1631,11 +1782,13 @@ Character devices
 M: Marc-AndrÃ© Lureau <marcandre.lureau@redhat.com>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Odd Fixes
+C: High
 F: hw/char/
 
 Network devices
 M: Jason Wang <jasowang@redhat.com>
 S: Odd Fixes
+C: High
 F: hw/net/
 F: include/hw/net/
 F: tests/qtest/virtio-net-test.c
@@ -1646,6 +1799,7 @@ Parallel NOR Flash devices
 M: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
 T: git https://gitlab.com/philmd/qemu.git pflash-next
 S: Maintained
+C: High
 F: hw/block/pflash_cfi*.c
 F: include/hw/block/flash.h
 
@@ -1653,6 +1807,7 @@ SCSI
 M: Paolo Bonzini <pbonzini@redhat.com>
 R: Fam Zheng <fam@euphon.net>
 S: Supported
+C: High
 F: include/hw/scsi/*
 F: hw/scsi/*
 F: tests/qtest/virtio-scsi-test.c
@@ -1661,6 +1816,7 @@ T: git https://github.com/bonzini/qemu.git scsi-next
 SSI
 M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
+C: Low
 F: hw/ssi/*
 F: hw/block/m25p80.c
 F: include/hw/ssi/ssi.h
@@ -1670,11 +1826,13 @@ F: tests/qtest/m25p80-test.c
 Xilinx SPI
 M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
+C: Low
 F: hw/ssi/xilinx_*
 
 SD (Secure Card)
 M: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
 S: Odd Fixes
+C: Low
 F: include/hw/sd/sd*
 F: hw/sd/core.c
 F: hw/sd/sd*
@@ -1684,6 +1842,7 @@ F: tests/qtest/sd*
 USB
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
+C: High
 F: hw/usb/*
 F: tests/qtest/usb-*-test.c
 F: docs/usb2.txt
@@ -1696,11 +1855,13 @@ USB (serial adapter)
 M: Gerd Hoffmann <kraxel@redhat.com>
 M: Samuel Thibault <samuel.thibault@ens-lyon.org>
 S: Maintained
+C: High
 F: hw/usb/dev-serial.c
 
 VFIO
 M: Alex Williamson <alex.williamson@redhat.com>
 S: Supported
+C: High
 F: hw/vfio/*
 F: include/hw/vfio/
 
@@ -1708,6 +1869,7 @@ vfio-ccw
 M: Cornelia Huck <cohuck@redhat.com>
 M: Eric Farman <farman@linux.ibm.com>
 S: Supported
+C: High
 F: hw/vfio/ccw.c
 F: hw/s390x/s390-ccw.c
 F: include/hw/s390x/s390-ccw.h
@@ -1721,6 +1883,7 @@ M: Tony Krowiak <akrowiak@linux.ibm.com>
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Pierre Morel <pmorel@linux.ibm.com>
 S: Supported
+C: High
 F: hw/s390x/ap-device.c
 F: hw/s390x/ap-bridge.c
 F: include/hw/s390x/ap-device.h
@@ -1732,6 +1895,7 @@ L: qemu-s390x@nongnu.org
 vhost
 M: Michael S. Tsirkin <mst@redhat.com>
 S: Supported
+C: High
 F: hw/*/*vhost*
 F: docs/interop/vhost-user.json
 F: docs/interop/vhost-user.rst
@@ -1742,6 +1906,7 @@ F: include/sysemu/vhost-user-backend.h
 virtio
 M: Michael S. Tsirkin <mst@redhat.com>
 S: Supported
+C: High
 F: hw/*/virtio*
 F: hw/virtio/Makefile.objs
 F: hw/virtio/trace-events
@@ -1752,6 +1917,7 @@ virtio-balloon
 M: Michael S. Tsirkin <mst@redhat.com>
 M: David Hildenbrand <david@redhat.com>
 S: Maintained
+C: High
 F: hw/virtio/virtio-balloon*.c
 F: include/hw/virtio/virtio-balloon.h
 F: softmmu/balloon.c
@@ -1761,6 +1927,7 @@ virtio-9p
 M: Greg Kurz <groug@kaod.org>
 M: Christian Schoenebeck <qemu_oss@crudebyte.com>
 S: Odd Fixes
+C: Low
 F: hw/9pfs/
 X: hw/9pfs/xen-9p*
 F: fsdev/
@@ -1772,6 +1939,7 @@ virtio-blk
 M: Stefan Hajnoczi <stefanha@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: hw/block/virtio-blk.c
 F: hw/block/dataplane/*
 F: tests/qtest/virtio-blk-test.c
@@ -1781,6 +1949,7 @@ virtio-ccw
 M: Cornelia Huck <cohuck@redhat.com>
 M: Halil Pasic <pasic@linux.ibm.com>
 S: Supported
+C: High
 F: hw/s390x/virtio-ccw*.[hc]
 F: hw/s390x/vhost-vsock-ccw.c
 T: git https://github.com/cohuck/qemu.git s390-next
@@ -1791,6 +1960,7 @@ virtiofs
 M: Dr. David Alan Gilbert <dgilbert@redhat.com>
 M: Stefan Hajnoczi <stefanha@redhat.com>
 S: Supported
+C: High
 F: tools/virtiofsd/*
 F: hw/virtio/vhost-user-fs*
 F: include/hw/virtio/vhost-user-fs.h
@@ -1799,6 +1969,7 @@ F: docs/interop/virtiofsd.rst
 virtio-input
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
+C: High
 F: hw/input/vhost-user-input.c
 F: hw/input/virtio-input*.c
 F: include/hw/virtio/virtio-input.h
@@ -1807,6 +1978,7 @@ F: contrib/vhost-user-input/*
 virtio-iommu
 M: Eric Auger <eric.auger@redhat.com>
 S: Maintained
+C: High
 F: hw/virtio/virtio-iommu*.c
 F: include/hw/virtio/virtio-iommu.h
 
@@ -1814,6 +1986,7 @@ virtio-serial
 M: Laurent Vivier <lvivier@redhat.com>
 R: Amit Shah <amit@kernel.org>
 S: Supported
+C: High
 F: hw/char/virtio-serial-bus.c
 F: hw/char/virtio-console.c
 F: include/hw/virtio/virtio-serial.h
@@ -1823,6 +1996,7 @@ virtio-rng
 M: Laurent Vivier <lvivier@redhat.com>
 R: Amit Shah <amit@kernel.org>
 S: Supported
+C: High
 F: hw/virtio/virtio-rng.c
 F: include/hw/virtio/virtio-rng.h
 F: include/sysemu/rng*.h
@@ -1832,6 +2006,7 @@ F: tests/qtest/virtio-rng-test.c
 virtio-crypto
 M: Gonglei <arei.gonglei@huawei.com>
 S: Supported
+C: High
 F: hw/virtio/virtio-crypto.c
 F: hw/virtio/virtio-crypto-pci.c
 F: include/hw/virtio/virtio-crypto.h
@@ -1839,6 +2014,7 @@ F: include/hw/virtio/virtio-crypto.h
 virtio-mem
 M: David Hildenbrand <david@redhat.com>
 S: Supported
+C: High
 W: https://virtio-mem.gitlab.io/
 F: hw/virtio/virtio-mem.c
 F: hw/virtio/virtio-mem-pci.h
@@ -1849,6 +2025,7 @@ nvme
 M: Keith Busch <kbusch@kernel.org>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: hw/block/nvme*
 F: tests/qtest/nvme-test.c
 
@@ -1856,6 +2033,7 @@ megasas
 M: Hannes Reinecke <hare@suse.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: Low
 F: hw/scsi/megasas.c
 F: hw/scsi/mfi.h
 F: tests/qtest/megasas-test.c
@@ -1863,6 +2041,7 @@ F: tests/qtest/megasas-test.c
 Network packet abstractions
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
 S: Maintained
+C: High
 F: include/net/eth.h
 F: net/eth.c
 F: hw/net/net_rx_pkt*
@@ -1871,6 +2050,7 @@ F: hw/net/net_tx_pkt*
 Vmware
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
 S: Maintained
+C: High
 F: hw/net/vmxnet*
 F: hw/scsi/vmw_pvscsi*
 F: tests/qtest/vmxnet3-test.c
@@ -1878,6 +2058,7 @@ F: tests/qtest/vmxnet3-test.c
 Rocker
 M: Jiri Pirko <jiri@resnulli.us>
 S: Maintained
+C: High
 F: hw/net/rocker/
 F: tests/rocker/
 F: docs/specs/rocker.txt
@@ -1885,6 +2066,7 @@ F: docs/specs/rocker.txt
 NVDIMM
 M: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
 S: Maintained
+C: High
 F: hw/acpi/nvdimm.c
 F: hw/mem/nvdimm.c
 F: include/hw/mem/nvdimm.h
@@ -1893,27 +2075,32 @@ F: docs/nvdimm.txt
 e1000x
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
 S: Maintained
+C: High
 F: hw/net/e1000x*
 
 e1000e
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
 S: Maintained
+C: High
 F: hw/net/e1000e*
 
 eepro100
 M: Stefan Weil <sw@weilnetz.de>
 S: Maintained
+C: High
 F: hw/net/eepro100.c
 
 tulip
 M: Sven Schnelle <svens@stackframe.org>
 S: Maintained
+C: High
 F: hw/net/tulip.c
 F: hw/net/tulip.h
 
 Generic Loader
 M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
+C: High
 F: hw/core/generic-loader.c
 F: include/hw/core/generic-loader.h
 F: docs/generic-loader.txt
@@ -1921,12 +2108,14 @@ F: docs/generic-loader.txt
 Intel Hexadecimal Object File Loader
 M: Su Hang <suhang16@mails.ucas.ac.cn>
 S: Maintained
+C: Low
 F: tests/qtest/hexloader-test.c
 F: tests/data/hex-loader/test.hex
 
 CHRP NVRAM
 M: Thomas Huth <thuth@redhat.com>
 S: Maintained
+C: High
 F: hw/nvram/chrp_nvram.c
 F: include/hw/nvram/chrp_nvram.h
 F: tests/qtest/prom-env-test.c
@@ -1934,6 +2123,7 @@ F: tests/qtest/prom-env-test.c
 VM Generation ID
 M: Ben Warren <ben@skyportsystems.com>
 S: Maintained
+C: Low
 F: hw/acpi/vmgenid.c
 F: include/hw/acpi/vmgenid.h
 F: docs/specs/vmgenid.txt
@@ -1944,6 +2134,7 @@ Unimplemented device
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
 S: Maintained
+C: Low
 F: include/hw/misc/unimp.h
 F: hw/misc/unimp.c
 
@@ -1951,12 +2142,14 @@ Empty slot
 M: Artyom Tarasenko <atar4qemu@gmail.com>
 R: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
 S: Maintained
+C: Low
 F: include/hw/misc/empty_slot.h
 F: hw/misc/empty_slot.c
 
 Standard VGA
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
+C: Low
 F: hw/display/vga*
 F: hw/display/bochs-display.c
 F: include/hw/display/vga.h
@@ -1965,12 +2158,14 @@ F: include/hw/display/bochs-vbe.h
 ramfb
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
+C: High
 F: hw/display/ramfb*.c
 F: include/hw/display/ramfb.h
 
 virtio-gpu
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
+C: High
 F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.*
 F: include/hw/virtio/virtio-gpu.h
@@ -1978,6 +2173,7 @@ F: include/hw/virtio/virtio-gpu.h
 vhost-user-blk
 M: Raphael Norwitz <raphael.norwitz@nutanix.com>
 S: Maintained
+C: High
 F: contrib/vhost-user-blk/
 F: contrib/vhost-user-scsi/
 F: hw/block/vhost-user-blk.c
@@ -1991,6 +2187,7 @@ vhost-user-gpu
 M: Marc-AndrÃ© Lureau <marcandre.lureau@redhat.com>
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
+C: High
 F: docs/interop/vhost-user-gpu.rst
 F: contrib/vhost-user-gpu
 F: hw/display/vhost-user-*
@@ -1998,12 +2195,14 @@ F: hw/display/vhost-user-*
 Cirrus VGA
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Odd Fixes
+C: Low
 W: https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful/
 F: hw/display/cirrus*
 
 EDID Generator
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
+C: Low
 F: hw/display/edid*
 F: include/hw/display/edid.h
 F: qemu-edid.c
@@ -2012,6 +2211,7 @@ PIIX4 South Bridge (i82371AB)
 M: HervÃ© Poussineau <hpoussin@reactos.org>
 M: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
 S: Maintained
+C: High
 F: hw/isa/piix4.c
 F: include/hw/southbridge/piix.h
 
@@ -2020,6 +2220,7 @@ M: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
 R: Laszlo Ersek <lersek@redhat.com>
 R: Gerd Hoffmann <kraxel@redhat.com>
 S: Supported
+C: High
 F: docs/specs/fw_cfg.txt
 F: hw/nvram/fw_cfg.c
 F: stubs/fw_cfg.c
@@ -2034,6 +2235,7 @@ M: David Gibson <david@gibson.dropbear.id.au>
 M: CÃ©dric Le Goater <clg@kaod.org>
 L: qemu-ppc@nongnu.org
 S: Supported
+C: High
 F: hw/*/*xive*
 F: include/hw/*/*xive*
 F: docs/*/*xive*
@@ -2042,6 +2244,7 @@ Renesas peripherals
 M: Yoshinori Sato <ysato@users.sourceforge.jp>
 R: Magnus Damm <magnus.damm@gmail.com>
 S: Maintained
+C: Low
 F: hw/char/renesas_sci.c
 F: hw/char/sh_serial.c
 F: hw/timer/renesas_*.c
@@ -2053,6 +2256,7 @@ F: include/hw/timer/renesas_*.h
 Renesas RX peripherals
 M: Yoshinori Sato <ysato@users.sourceforge.jp>
 S: Maintained
+C: Low
 F: hw/intc/rx_icu.c
 F: hw/rx/
 F: include/hw/intc/rx_icu.h
@@ -2063,6 +2267,7 @@ Subsystems
 Audio
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
+C: High
 F: audio/
 F: hw/audio/
 F: include/hw/audio/
@@ -2075,6 +2280,7 @@ M: Kevin Wolf <kwolf@redhat.com>
 M: Max Reitz <mreitz@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: block*
 F: block/
 F: hw/block/
@@ -2093,6 +2299,7 @@ M: Stefan Hajnoczi <stefanha@redhat.com>
 M: Fam Zheng <fam@euphon.net>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: util/async.c
 F: util/aio-*.c
 F: util/aio-*.h
@@ -2109,6 +2316,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 R: Fam Zheng <fam@euphon.net>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: include/scsi/*
 F: scsi/*
 
@@ -2116,6 +2324,7 @@ Block Jobs
 M: John Snow <jsnow@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: blockjob.c
 F: include/block/blockjob.h
 F: job.c
@@ -2131,6 +2340,7 @@ T: git https://github.com/jnsnow/qemu.git jobs
 Block QAPI, monitor, command line
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
+C: High
 F: blockdev.c
 F: blockdev-hmp-cmds.c
 F: block/qapi.c
@@ -2144,6 +2354,7 @@ M: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
 R: John Snow <jsnow@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: include/qemu/hbitmap.h
 F: include/block/dirty-bitmap.h
 F: block/monitor/bitmap-qmp-cmds.c
@@ -2159,6 +2370,7 @@ Character device backends
 M: Marc-AndrÃ© Lureau <marcandre.lureau@redhat.com>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
+C: High
 F: chardev/
 F: include/chardev/
 F: qapi/char.json
@@ -2166,11 +2378,13 @@ F: qapi/char.json
 Character Devices (Braille)
 M: Samuel Thibault <samuel.thibault@ens-lyon.org>
 S: Maintained
+C: High
 F: chardev/baum.c
 
 Command line option argument parsing
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
+C: High
 F: include/qemu/option.h
 F: tests/test-keyval.c
 F: tests/test-qemu-opts.c
@@ -2180,22 +2394,26 @@ F: util/qemu-option.c
 Coverity model
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
+C: Low
 F: scripts/coverity-model.c
 
 Coverity Scan integration
 M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
+C: Low
 F: scripts/coverity-scan/
 
 Device Tree
 M: Alistair Francis <alistair.francis@wdc.com>
 R: David Gibson <david@gibson.dropbear.id.au>
 S: Maintained
+C: Low
 F: device_tree.c
 F: include/sysemu/device_tree.h
 
 Dump
 S: Supported
+C: Low
 M: Marc-AndrÃ© Lureau <marcandre.lureau@redhat.com>
 F: dump/
 F: hw/misc/vmcoreinfo.c
@@ -2210,6 +2428,7 @@ F: stubs/dump.c
 Error reporting
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
+C: High
 F: include/qapi/error.h
 F: include/qemu/error-report.h
 F: qapi/error.json
@@ -2226,12 +2445,14 @@ GDB stub
 M: Alex BennÃ©e <alex.bennee@linaro.org>
 R: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
 S: Maintained
+C: Low
 F: gdbstub*
 F: gdb-xml/
 
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Supported
+C: High
 F: include/exec/ioport.h
 F: include/exec/memop.h
 F: include/exec/memory.h
@@ -2246,6 +2467,7 @@ F: scripts/coccinelle/memory-region-housekeeping.cocci
 SPICE
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Supported
+C: High
 F: include/ui/qemu-spice.h
 F: include/ui/spice-display.h
 F: ui/spice-*.c
@@ -2257,6 +2479,7 @@ F: docs/spice-port-fqdn.txt
 Graphics
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Odd Fixes
+C: Low
 F: ui/
 F: include/ui/
 F: qapi/ui.json
@@ -2265,11 +2488,13 @@ F: util/drm.c
 Cocoa graphics
 M: Peter Maydell <peter.maydell@linaro.org>
 S: Odd Fixes
+C: Low
 F: ui/cocoa.m
 
 Main loop
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
+C: High
 F: include/qemu/main-loop.h
 F: include/sysemu/runstate.h
 F: util/main-loop.c
@@ -2283,6 +2508,7 @@ F: qapi/run-state.json
 Human Monitor (HMP)
 M: Dr. David Alan Gilbert <dgilbert@redhat.com>
 S: Maintained
+C: Low
 F: monitor/monitor-internal.h
 F: monitor/misc.c
 F: monitor/monitor.c
@@ -2297,6 +2523,7 @@ F: util/qemu-print.c
 Network device backends
 M: Jason Wang <jasowang@redhat.com>
 S: Maintained
+C: High
 F: net/
 F: include/net/
 F: qemu-bridge-helper.c
@@ -2309,12 +2536,14 @@ M: Giuseppe Lettieri <g.lettieri@iet.unipi.it>
 M: Vincenzo Maffione <v.maffione@gmail.com>
 W: http://info.iet.unipi.it/~luigi/netmap/
 S: Maintained
+C: High
 F: net/netmap.c
 
 Host Memory Backends
 M: Eduardo Habkost <ehabkost@redhat.com>
 M: Igor Mammedov <imammedo@redhat.com>
 S: Maintained
+C: High
 F: backends/hostmem*.c
 F: include/sysemu/hostmem.h
 T: git https://github.com/ehabkost/qemu.git machine-next
@@ -2322,6 +2551,7 @@ T: git https://github.com/ehabkost/qemu.git machine-next
 Cryptodev Backends
 M: Gonglei <arei.gonglei@huawei.com>
 S: Maintained
+C: High
 F: include/sysemu/cryptodev*.h
 F: backends/cryptodev*.c
 
@@ -2329,6 +2559,7 @@ Python scripts
 M: Eduardo Habkost <ehabkost@redhat.com>
 M: Cleber Rosa <crosa@redhat.com>
 S: Odd fixes
+C: Low
 F: python/qemu/*py
 F: scripts/*.py
 F: tests/*.py
@@ -2336,12 +2567,14 @@ F: tests/*.py
 Benchmark util
 M: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
 S: Maintained
+C: Low
 F: scripts/simplebench/
 
 QAPI
 M: Markus Armbruster <armbru@redhat.com>
 M: Michael Roth <mdroth@linux.vnet.ibm.com>
 S: Supported
+C: High
 F: qapi/
 X: qapi/*.json
 F: include/qapi/
@@ -2361,12 +2594,14 @@ QAPI Schema
 M: Eric Blake <eblake@redhat.com>
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
+C: Low
 F: qapi/*.json
 T: git https://repo.or.cz/qemu/armbru.git qapi-next
 
 QObject
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
+C: Low
 F: qobject/
 F: include/qapi/qmp/
 X: include/qapi/qmp/dispatch.h
@@ -2385,6 +2620,7 @@ T: git https://repo.or.cz/qemu/armbru.git qapi-next
 QEMU Guest Agent
 M: Michael Roth <mdroth@linux.vnet.ibm.com>
 S: Maintained
+C: Low
 F: qga/
 F: docs/interop/qemu-ga.rst
 F: scripts/qemu-guest-agent/
@@ -2397,6 +2633,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 R: Daniel P. Berrange <berrange@redhat.com>
 R: Eduardo Habkost <ehabkost@redhat.com>
 S: Supported
+C: High
 F: docs/qdev-device-use.txt
 F: hw/core/qdev*
 F: hw/core/bus.c
@@ -2415,6 +2652,7 @@ F: tests/test-qdev-global-props.c
 QMP
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
+C: Low
 F: monitor/monitor-internal.h
 F: monitor/qmp*
 F: monitor/misc.c
@@ -2432,6 +2670,7 @@ M: Thomas Huth <thuth@redhat.com>
 M: Laurent Vivier <lvivier@redhat.com>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
+C: Low
 F: softmmu/qtest.c
 F: accel/qtest.c
 F: tests/qtest/
@@ -2443,12 +2682,14 @@ R: Paolo Bonzini <pbonzini@redhat.com>
 R: Bandan Das <bsd@redhat.com>
 R: Stefan Hajnoczi <stefanha@redhat.com>
 S: Maintained
+C: Low
 F: tests/qtest/fuzz/
 F: scripts/oss-fuzz/
 
 Register API
 M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
+C: High
 F: hw/core/register.c
 F: include/hw/register.h
 F: include/hw/registerfields.h
@@ -2456,6 +2697,7 @@ F: include/hw/registerfields.h
 SLIRP
 M: Samuel Thibault <samuel.thibault@ens-lyon.org>
 S: Maintained
+C: Low
 F: slirp/
 F: net/slirp.c
 F: include/net/slirp.h
@@ -2464,17 +2706,20 @@ T: git https://people.debian.org/~sthibault/qemu.git slirp
 Streams
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
+C: Low
 F: hw/core/stream.c
 F: include/hw/stream.h
 
 Stubs
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
+C: Low
 F: stubs/
 
 Tracing
 M: Stefan Hajnoczi <stefanha@redhat.com>
 S: Maintained
+C: Low
 F: trace/
 F: trace-events
 F: docs/qemu-option-trace.rst.inc
@@ -2488,6 +2733,7 @@ T: git https://github.com/stefanha/qemu.git tracing
 TPM
 M: Stefan Berger <stefanb@linux.ibm.com>
 S: Maintained
+C: Low
 F: tpm.c
 F: stubs/tpm.c
 F: hw/tpm/*
@@ -2500,12 +2746,14 @@ T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
 
 Checkpatch
 S: Odd Fixes
+C: Low
 F: scripts/checkpatch.pl
 
 Migration
 M: Juan Quintela <quintela@redhat.com>
 M: Dr. David Alan Gilbert <dgilbert@redhat.com>
 S: Maintained
+C: High
 F: hw/core/vmstate-if.c
 F: include/hw/vmstate-if.h
 F: include/migration/
@@ -2519,6 +2767,7 @@ F: qapi/migration.json
 D-Bus
 M: Marc-AndrÃ© Lureau <marcandre.lureau@redhat.com>
 S: Maintained
+C: High
 F: backends/dbus-vmstate.c
 F: tests/dbus-vmstate*
 F: util/dbus.c
@@ -2529,12 +2778,14 @@ F: docs/interop/dbus-vmstate.rst
 Seccomp
 M: Eduardo Otubo <otubo@redhat.com>
 S: Supported
+C: High
 F: qemu-seccomp.c
 F: include/sysemu/seccomp.h
 
 Cryptography
 M: Daniel P. Berrange <berrange@redhat.com>
 S: Maintained
+C: High
 F: crypto/
 F: include/crypto/
 F: tests/test-crypto-*
@@ -2547,6 +2798,7 @@ Coroutines
 M: Stefan Hajnoczi <stefanha@redhat.com>
 M: Kevin Wolf <kwolf@redhat.com>
 S: Maintained
+C: High
 F: util/*coroutine*
 F: include/qemu/coroutine*
 F: tests/test-coroutine.c
@@ -2554,12 +2806,14 @@ F: tests/test-coroutine.c
 Buffers
 M: Daniel P. Berrange <berrange@redhat.com>
 S: Odd fixes
+C: Low
 F: util/buffer.c
 F: include/qemu/buffer.h
 
 I/O Channels
 M: Daniel P. Berrange <berrange@redhat.com>
 S: Maintained
+C: High
 F: io/
 F: include/io/
 F: tests/test-io-*
@@ -2567,6 +2821,7 @@ F: tests/test-io-*
 User authorization
 M: Daniel P. Berrange <berrange@redhat.com>
 S: Maintained
+C: High
 F: authz/
 F: qapi/authz.json
 F: include/authz/
@@ -2576,6 +2831,7 @@ Sockets
 M: Daniel P. Berrange <berrange@redhat.com>
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
+C: High
 F: include/qemu/sockets.h
 F: util/qemu-sockets.c
 F: qapi/sockets.json
@@ -2583,6 +2839,7 @@ F: qapi/sockets.json
 File monitor
 M: Daniel P. Berrange <berrange@redhat.com>
 S: Odd fixes
+C: Low
 F: util/filemonitor*.c
 F: include/qemu/filemonitor.h
 F: tests/test-util-filemonitor.c
@@ -2590,6 +2847,7 @@ F: tests/test-util-filemonitor.c
 Throttling infrastructure
 M: Alberto Garcia <berto@igalia.com>
 S: Supported
+C: High
 F: block/throttle-groups.c
 F: include/block/throttle-groups.h
 F: include/qemu/throttle*.h
@@ -2601,6 +2859,7 @@ L: qemu-block@nongnu.org
 UUID
 M: Fam Zheng <fam@euphon.net>
 S: Supported
+C: Low
 F: util/uuid.c
 F: include/qemu/uuid.h
 F: tests/test-uuid.c
@@ -2608,6 +2867,7 @@ F: tests/test-uuid.c
 COLO Framework
 M: zhanghailiang <zhang.zhanghailiang@huawei.com>
 S: Maintained
+C: High
 F: migration/colo*
 F: include/migration/colo.h
 F: include/migration/failover.h
@@ -2617,6 +2877,7 @@ COLO Proxy
 M: Zhang Chen <chen.zhang@intel.com>
 M: Li Zhijian <lizhijian@cn.fujitsu.com>
 S: Supported
+C: High
 F: docs/colo-proxy.txt
 F: net/colo*
 F: net/filter-rewriter.c
@@ -2627,6 +2888,7 @@ M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
 R: Paolo Bonzini <pbonzini@redhat.com>
 W: https://wiki.qemu.org/Features/record-replay
 S: Supported
+C: High
 F: replay/*
 F: block/blkreplay.c
 F: net/filter-replay.c
@@ -2638,17 +2900,20 @@ F: tests/acceptance/replay_kernel.py
 IOVA Tree
 M: Peter Xu <peterx@redhat.com>
 S: Maintained
+C: Low
 F: include/qemu/iova-tree.h
 F: util/iova-tree.c
 
 elf2dmp
 M: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
 S: Maintained
+C: Low
 F: contrib/elf2dmp/
 
 I2C and SMBus
 M: Corey Minyard <cminyard@mvista.com>
 S: Maintained
+C: High
 F: hw/i2c/core.c
 F: hw/i2c/smbus_slave.c
 F: hw/i2c/smbus_master.c
@@ -2662,6 +2927,7 @@ EDK2 Firmware
 M: Laszlo Ersek <lersek@redhat.com>
 M: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
 S: Supported
+C: High
 F: pc-bios/descriptors/??-edk2-*.json
 F: pc-bios/edk2-*
 F: roms/Makefile.edk2
@@ -2677,6 +2943,7 @@ M: Michael S. Tsirkin <mst@redhat.com>
 M: Peter Xu <peterx@redhat.com>
 R: Jason Wang <jasowang@redhat.com>
 S: Supported
+C: High
 F: hw/i386/intel_iommu.c
 F: hw/i386/intel_iommu_internal.h
 F: include/hw/i386/intel_iommu.h
@@ -2686,17 +2953,20 @@ Usermode Emulation
 Overall usermode emulation
 M: Riku Voipio <riku.voipio@iki.fi>
 S: Maintained
+C: Low
 F: thunk.c
 F: accel/tcg/user-exec*.c
 
 BSD user
 S: Orphan
+C: Low
 F: bsd-user/
 F: default-configs/*-bsd-user.mak
 
 Linux user
 M: Laurent Vivier <laurent@vivier.eu>
 S: Maintained
+C: Low
 F: linux-user/
 F: default-configs/*-linux-user.mak
 F: scripts/qemu-binfmt-conf.sh
@@ -2709,12 +2979,14 @@ Tiny Code Generator (TCG)
 Common TCG code
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
+C: Low
 F: tcg/
 F: include/tcg/
 
 TCG Plugins
 M: Alex BennÃ©e <alex.bennee@linaro.org>
 S: Maintained
+C: Low
 F: docs/devel/tcg-plugins.rst
 F: plugins/
 F: tests/plugin
@@ -2722,6 +2994,7 @@ F: tests/plugin
 AArch64 TCG target
 M: Richard Henderson <richard.henderson@linaro.org>
 S: Maintained
+C: Low
 L: qemu-arm@nongnu.org
 F: tcg/aarch64/
 F: disas/arm-a64.cc
@@ -2730,6 +3003,7 @@ F: disas/libvixl/
 ARM TCG target
 M: Andrzej Zaborowski <balrogg@gmail.com>
 S: Maintained
+C: Low
 L: qemu-arm@nongnu.org
 F: tcg/arm/
 F: disas/arm.c
@@ -2737,6 +3011,7 @@ F: disas/arm.c
 i386 TCG target
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
+C: Low
 F: tcg/i386/
 F: disas/i386.c
 
@@ -2745,11 +3020,13 @@ M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
+C: Low
 F: tcg/mips/
 
 PPC TCG target
 M: Richard Henderson <rth@twiddle.net>
 S: Odd Fixes
+C: Low
 F: tcg/ppc/
 F: disas/ppc.c
 
@@ -2758,24 +3035,28 @@ M: Palmer Dabbelt <palmer@dabbelt.com>
 M: Alistair Francis <Alistair.Francis@wdc.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
+C: Low
 F: tcg/riscv/
 F: disas/riscv.c
 
 S390 TCG target
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
+C: Low
 F: tcg/s390/
 F: disas/s390.c
 L: qemu-s390x@nongnu.org
 
 SPARC TCG target
 S: Odd Fixes
+C: Low
 F: tcg/sparc/
 F: disas/sparc.c
 
 TCI TCG target
 M: Stefan Weil <sw@weilnetz.de>
 S: Maintained
+C: Low
 F: tcg/tci/
 F: tcg/tci.c
 F: disas/tci.c
@@ -2786,12 +3067,14 @@ VMDK
 M: Fam Zheng <fam@euphon.net>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: block/vmdk.c
 
 RBD
 M: Jason Dillaman <dillaman@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: block/rbd.c
 
 Sheepdog
@@ -2799,18 +3082,21 @@ M: Liu Yuan <namei.unix@gmail.com>
 L: qemu-block@nongnu.org
 L: sheepdog@lists.wpkg.org
 S: Odd Fixes
+C: Low
 F: block/sheepdog.c
 
 VHDX
 M: Jeff Cody <codyprime@gmail.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: block/vhdx*
 
 VDI
 M: Stefan Weil <sw@weilnetz.de>
 L: qemu-block@nongnu.org
 S: Maintained
+C: High
 F: block/vdi.c
 
 iSCSI
@@ -2819,6 +3105,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 M: Peter Lieven <pl@kamp.de>
 L: qemu-block@nongnu.org
 S: Odd Fixes
+C: Low
 F: block/iscsi.c
 F: block/iscsi-opts.c
 
@@ -2826,6 +3113,7 @@ Network Block Device (NBD)
 M: Eric Blake <eblake@redhat.com>
 L: qemu-block@nongnu.org
 S: Maintained
+C: High
 F: block/nbd*
 F: nbd/
 F: include/block/nbd*
@@ -2839,45 +3127,53 @@ NFS
 M: Peter Lieven <pl@kamp.de>
 L: qemu-block@nongnu.org
 S: Maintained
+C: High
 F: block/nfs.c
 
 SSH
 M: Richard W.M. Jones <rjones@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: block/ssh.c
 
 CURL
 L: qemu-block@nongnu.org
 S: Odd Fixes
+C: Low
 F: block/curl.c
 
 GLUSTER
 L: qemu-block@nongnu.org
 L: integration@gluster.org
 S: Odd Fixes
+C: Low
 F: block/gluster.c
 
 Null Block Driver
 M: Fam Zheng <fam@euphon.net>
 L: qemu-block@nongnu.org
 S: Supported
+C: Low
 F: block/null.c
 
 NVMe Block Driver
 M: Fam Zheng <fam@euphon.net>
 L: qemu-block@nongnu.org
 S: Supported
+C: Low
 F: block/nvme*
 
 Bootdevice
 M: Gonglei <arei.gonglei@huawei.com>
 S: Maintained
+C: Low
 F: bootdevice.c
 
 Quorum
 M: Alberto Garcia <berto@igalia.com>
 S: Supported
+C: High
 F: block/quorum.c
 L: qemu-block@nongnu.org
 
@@ -2885,30 +3181,35 @@ blklogwrites
 M: Ari Sundholm <ari@tuxera.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: block/blklogwrites.c
 
 blkverify
 M: Stefan Hajnoczi <stefanha@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: block/blkverify.c
 
 bochs
 M: Stefan Hajnoczi <stefanha@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: Low
 F: block/bochs.c
 
 cloop
 M: Stefan Hajnoczi <stefanha@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: Low
 F: block/cloop.c
 
 dmg
 M: Stefan Hajnoczi <stefanha@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: block/dmg.c
 
 parallels
@@ -2916,6 +3217,7 @@ M: Stefan Hajnoczi <stefanha@redhat.com>
 M: Denis V. Lunev <den@openvz.org>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: block/parallels.c
 F: docs/interop/parallels.txt
 
@@ -2923,12 +3225,14 @@ qed
 M: Stefan Hajnoczi <stefanha@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: block/qed.c
 
 raw
 M: Kevin Wolf <kwolf@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: block/linux-aio.c
 F: include/block/raw-aio.h
 F: block/raw-format.c
@@ -2942,6 +3246,7 @@ M: Julia Suvorova <jusual@redhat.com>
 M: Stefan Hajnoczi <stefanha@redhat.com>
 L: qemu-block@nongnu.org
 S: Maintained
+C: High
 F: block/io_uring.c
 F: stubs/io_uring.c
 
@@ -2950,6 +3255,7 @@ M: Kevin Wolf <kwolf@redhat.com>
 M: Max Reitz <mreitz@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: block/qcow2*
 F: docs/interop/qcow2.txt
 
@@ -2957,6 +3263,7 @@ qcow
 M: Kevin Wolf <kwolf@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: block/qcow.c
 
 blkdebug
@@ -2964,30 +3271,35 @@ M: Kevin Wolf <kwolf@redhat.com>
 M: Max Reitz <mreitz@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: block/blkdebug.c
 
 vpc
 M: Kevin Wolf <kwolf@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: High
 F: block/vpc.c
 
 vvfat
 M: Kevin Wolf <kwolf@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: Low
 F: block/vvfat.c
 
 Image format fuzzer
 M: Stefan Hajnoczi <stefanha@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
+C: Low
 F: tests/image-fuzzer/
 
 Replication
 M: Wen Congyang <wencongyang2@huawei.com>
 M: Xie Changlong <xiechanglong.d@gmail.com>
 S: Supported
+C: Low
 F: replication*
 F: block/replication.c
 F: tests/test-replication.c
@@ -2997,6 +3309,7 @@ PVRDMA
 M: Yuval Shaia <yuval.shaia.ml@gmail.com>
 M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Maintained
+C: High
 F: hw/rdma/*
 F: hw/rdma/vmw/*
 F: docs/pvrdma.txt
@@ -3006,6 +3319,7 @@ F: qapi/rdma.json
 Semihosting
 M: Alex BennÃ©e <alex.bennee@linaro.org>
 S: Maintained
+C: Low
 F: hw/semihosting/
 F: include/hw/semihosting/
 
@@ -3016,6 +3330,7 @@ M: Alex BennÃ©e <alex.bennee@linaro.org>
 M: Fam Zheng <fam@euphon.net>
 R: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
 S: Maintained
+C: Low
 F: .github/lockdown.yml
 F: .travis.yml
 F: scripts/travis/
@@ -3031,6 +3346,7 @@ FreeBSD Hosted Continuous Integration
 M: Ed Maste <emaste@freebsd.org>
 M: Li-Wen Hsu <lwhsu@freebsd.org>
 S: Maintained
+C: Low
 F: .cirrus.yml
 W: https://cirrus-ci.com/github/qemu/qemu
 
@@ -3040,12 +3356,14 @@ M: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
 M: Alex BennÃ©e <alex.bennee@linaro.org>
 R: Wainer dos Santos Moschetta <wainersm@redhat.com>
 S: Maintained
+C: Low
 F: .gitlab-ci.yml
 
 Guest Test Compilation Support
 M: Alex BennÃ©e <alex.bennee@linaro.org>
 R: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
 S: Maintained
+C: Low
 F: tests/tcg/Makefile
 F: tests/tcg/Makefile.include
 
@@ -3055,6 +3373,7 @@ R: Cleber Rosa <crosa@redhat.com>
 R: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
 R: Wainer dos Santos Moschetta <wainersm@redhat.com>
 S: Odd Fixes
+C: Low
 F: tests/acceptance/
 
 Documentation
@@ -3062,11 +3381,13 @@ Documentation
 Build system architecture
 M: Daniel P. Berrange <berrange@redhat.com>
 S: Odd Fixes
+C: Low
 F: docs/devel/build-system.txt
 
 GIT Data Mining Config
 M: Alex BennÃ©e <alex.bennee@linaro.org>
 S: Odd Fixes
+C: Low
 F: gitdm.config
 F: contrib/gitdm/*
 
@@ -3079,6 +3400,7 @@ Build System
 GIT submodules
 M: Daniel P. Berrange <berrange@redhat.com>
 S: Odd Fixes
+C: Low
 F: scripts/git-submodule.sh
 
 UI translations
@@ -3088,6 +3410,7 @@ F: po/*.po
 Sphinx documentation configuration and build machinery
 M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
+C: Low
 F: docs/conf.py
 F: docs/*/conf.py
 
@@ -3096,4 +3419,5 @@ Miscellaneous
 Performance Tools and Tests
 M: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
 S: Maintained
+C: Low
 F: scripts/performance/
-- 
2.26.2



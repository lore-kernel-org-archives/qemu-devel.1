Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4A0C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D1B2064A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D1B2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHqC2-0000LP-5s
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iHq0E-0004zy-5I
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iHq0B-0005YE-M8
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:58:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53570)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iHq0B-0005XC-EI
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:58:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3066F30917AC;
 Tue,  8 Oct 2019 13:58:09 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E094760166;
 Tue,  8 Oct 2019 13:58:00 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 09/12] roms: add microvm-bios (qboot) as binary and git
 submodule
Date: Tue,  8 Oct 2019 15:55:35 +0200
Message-Id: <20191008135537.197867-10-slp@redhat.com>
In-Reply-To: <20191008135537.197867-1-slp@redhat.com>
References: <20191008135537.197867-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 08 Oct 2019 13:58:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, Sergio Lopez <slp@redhat.com>, mst@redhat.com,
 lersek@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qboot is a minimalist x86 firmware for booting Linux kernels. It does
the mininum amount of work required for the task, and it's able to
boot both PVH images and bzImages without relying on option roms.

This characteristics make it an ideal companion for the microvm
machine type.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 .gitmodules              |   3 +++
 pc-bios/bios-microvm.bin | Bin 0 -> 65536 bytes
 roms/Makefile            |   6 ++++++
 roms/qboot               |   1 +
 4 files changed, 10 insertions(+)
 create mode 100644 pc-bios/bios-microvm.bin
 create mode 160000 roms/qboot

diff --git a/.gitmodules b/.gitmodules
index c5c474169d..19792c9a11 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -58,3 +58,6 @@
 [submodule "roms/opensbi"]
 	path =3D roms/opensbi
 	url =3D 	https://git.qemu.org/git/opensbi.git
+[submodule "roms/qboot"]
+	path =3D roms/qboot
+	url =3D https://github.com/bonzini/qboot
diff --git a/pc-bios/bios-microvm.bin b/pc-bios/bios-microvm.bin
new file mode 100644
index 0000000000000000000000000000000000000000..45eabc516692e2d134bbb630d=
133c7c2dcc9a9b6
GIT binary patch
literal 65536
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
F
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

literal 0
HcmV?d00001

diff --git a/roms/Makefile b/roms/Makefile
index 6cf07d3b44..7c672536e4 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -67,6 +67,7 @@ default:
 	@echo "  opensbi32-virt     -- update OpenSBI for 32-bit virt machine"
 	@echo "  opensbi64-virt     -- update OpenSBI for 64-bit virt machine"
 	@echo "  opensbi64-sifive_u -- update OpenSBI for 64-bit sifive_u machi=
ne"
+	@echo "  bios-microvm       -- update bios-microvm.bin (qboot)"
 	@echo "  clean              -- delete the files generated by the previo=
us" \
 	                              "build targets"
=20
@@ -185,6 +186,10 @@ opensbi64-sifive_u:
 		PLATFORM=3D"sifive/fu540"
 	cp opensbi/build/platform/sifive/fu540/firmware/fw_jump.bin ../pc-bios/=
opensbi-riscv64-sifive_u-fw_jump.bin
=20
+bios-microvm:
+	$(MAKE) -C qboot
+	cp qboot/bios.bin ../pc-bios/bios-microvm.bin
+
 clean:
 	rm -rf seabios/.config seabios/out seabios/builds
 	$(MAKE) -C sgabios clean
@@ -197,3 +202,4 @@ clean:
 	$(MAKE) -C skiboot clean
 	$(MAKE) -f Makefile.edk2 clean
 	$(MAKE) -C opensbi clean
+	$(MAKE) -C qboot clean
diff --git a/roms/qboot b/roms/qboot
new file mode 160000
index 0000000000..cb1c49e0cf
--- /dev/null
+++ b/roms/qboot
@@ -0,0 +1 @@
+Subproject commit cb1c49e0cfac99b9961d136ac0194da62c28cf64
--=20
2.21.0



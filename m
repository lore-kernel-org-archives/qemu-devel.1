Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBECC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 17:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D763020835
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 17:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D763020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57072 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIz98-0002ZH-63
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 13:23:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz2U-0005mM-Tr
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz2T-0006Qm-71
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:17:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hIz2S-0006M1-TB
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:17:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA6CD300272A;
	Tue, 23 Apr 2019 17:16:50 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-125-214.rdu2.redhat.com
	[10.10.125.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 130F019729;
	Tue, 23 Apr 2019 17:16:43 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org,
	imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com,
	mst@redhat.com, peter.maydell@linaro.org, philmd@redhat.com,
	qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 19:15:19 +0200
Message-Id: <20190423171520.4511-12-lersek@redhat.com>
In-Reply-To: <20190423171520.4511-1-lersek@redhat.com>
References: <20190423171520.4511-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Tue, 23 Apr 2019 17:16:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/12] Makefile: install the edk2 firmware
 images and their descriptors
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423171519.enIqfjB89bULhfQz_Eyt72vBJx37DMSTKGvV6tfwYwE@z>

Decompress and install the edk2 firmware blobs as part of "make install",
unless blob installation was disabled with configure's "--disable-blobs"
option.

Additionally, decompress the blobs as a pre-requisite for building softmm=
u
binaries -- this is helpful for both "make check" and other ad-hoc tests
one might want to run in the build directory.

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---

Notes:
    pull:
   =20
    - pick up Phil's T-b
   =20
    - pick up Igor's R-b
   =20
    v4:
   =20
    - no change
   =20
    v3:
   =20
    - pick up Michal's R-b
   =20
    - pick up Phil's R-b
   =20
    - pick up Michael's R-b
   =20
    - Decompress fd.bz2 files with bzip2 rather than fd.xz files with xz,=
 so
      that decompression at "make install" time succeed on older build OS=
es
      too [Peter]. Note that "BUNZIP2" matches the name of the actual
      command "bunzip2" (i.e. it is sensible), and that it consists of 7
      characters, satisfying the quiet-command limit.
   =20
    - do not pick up Phil's T-b, consequently
   =20
    - do not pick up Igor's T-b for the same reason
   =20
    v2:
   =20
    - adapt to tracking the edk2 flash device files in compressed form [D=
an,
      Michael, Phil]
   =20
    - do not pick up Michal's and Michael's R-b's due to the above change

 configure  |  1 +
 Makefile   | 29 +++++++++++++++++++-
 .gitignore |  1 +
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 1c563a70276a..e1ad87b697e0 100755
--- a/configure
+++ b/configure
@@ -7892,6 +7892,7 @@ for bios_file in \
     $source_path/pc-bios/*.img \
     $source_path/pc-bios/openbios-* \
     $source_path/pc-bios/u-boot.* \
+    $source_path/pc-bios/edk2-*.fd.bz2 \
     $source_path/pc-bios/palcode-*
 do
     LINKS=3D"$LINKS pc-bios/$(basename $bios_file)"
diff --git a/Makefile b/Makefile
index 04a0d4505085..626a04d305cc 100644
--- a/Makefile
+++ b/Makefile
@@ -296,6 +296,10 @@ ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_=
CSV) $(SRC_PATH)/ui/Makefile
 $(KEYCODEMAP_GEN): .git-submodule-status
 $(KEYCODEMAP_CSV): .git-submodule-status
=20
+edk2-decompressed =3D $(basename $(wildcard pc-bios/edk2-*.fd.bz2))
+pc-bios/edk2-%.fd: pc-bios/edk2-%.fd.bz2
+	$(call quiet-command,bzip2 -d -c $< > $@,"BUNZIP2",$<)
+
 # Don't try to regenerate Makefile or configure
 # We don't generate any of them
 Makefile: ;
@@ -445,6 +449,7 @@ $(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
 $(SOFTMMU_SUBDIR_RULES): $(crypto-obj-y)
 $(SOFTMMU_SUBDIR_RULES): $(io-obj-y)
 $(SOFTMMU_SUBDIR_RULES): config-all-devices.mak
+$(SOFTMMU_SUBDIR_RULES): $(edk2-decompressed)
=20
 subdir-%:
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V=3D"$(V)" TARGE=
T_DIR=3D"$*/" all,)
@@ -633,6 +638,7 @@ clean:
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
 		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
 		-exec rm {} +
+	rm -f $(edk2-decompressed)
 	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS cscope.* *=
.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f qemu-img-cmds.h
@@ -723,9 +729,14 @@ spapr-rtas.bin slof.bin skiboot.lid \
 palcode-clipper \
 u-boot.e500 u-boot-sam460-20100605.bin \
 qemu_vga.ndrv \
+edk2-licenses.txt \
 hppa-firmware.img
+
+DESCS=3D50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
+60-edk2-aarch64.json 60-edk2-arm.json 60-edk2-i386.json 60-edk2-x86_64.j=
son
 else
 BLOBS=3D
+DESCS=3D
 endif
=20
 # Note that we manually filter-out the non-Sphinx documentation which
@@ -786,7 +797,8 @@ endif
=20
 ICON_SIZES=3D16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
=20
-install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-loc=
alstatedir
+install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-loc=
alstatedir \
+	$(if $(INSTALL_BLOBS),$(edk2-decompressed))
 ifneq ($(TOOLS),)
 	$(call install-prog,$(subst qemu-ga,qemu-ga$(EXESUF),$(TOOLS)),$(DESTDI=
R)$(bindir))
 endif
@@ -808,6 +820,21 @@ ifneq ($(BLOBS),)
 	set -e; for x in $(BLOBS); do \
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)"; \
 	done
+endif
+ifdef INSTALL_BLOBS
+	set -e; for x in $(edk2-decompressed); do \
+		$(INSTALL_DATA) $$x "$(DESTDIR)$(qemu_datadir)"; \
+	done
+endif
+ifneq ($(DESCS),)
+	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/firmware"
+	set -e; tmpf=3D$$(mktemp); trap 'rm -f -- "$$tmpf"' EXIT; \
+	for x in $(DESCS); do \
+		sed -e 's,@DATADIR@,$(DESTDIR)$(qemu_datadir),' \
+			"$(SRC_PATH)/pc-bios/descriptors/$$x" > "$$tmpf"; \
+		$(INSTALL_DATA) "$$tmpf" \
+			"$(DESTDIR)$(qemu_datadir)/firmware/$$x"; \
+	done
 endif
 	for s in $(ICON_SIZES); do \
 		mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/$${s}/apps"; \
diff --git a/.gitignore b/.gitignore
index 8f782218044e..fd6e6c38c7b9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -97,6 +97,7 @@
 *.gcno
 *.gcov
 /pc-bios/bios-pq/status
+/pc-bios/edk2-*.fd
 /pc-bios/vgabios-pq/status
 /pc-bios/optionrom/linuxboot.asm
 /pc-bios/optionrom/linuxboot.bin
--=20
2.19.1.3.g30247aa5d201




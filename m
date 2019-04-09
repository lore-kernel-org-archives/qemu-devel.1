Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22943C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 13:47:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E67612070D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 13:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67612070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41974 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDr67-0006XJ-2S
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 09:47:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDr4S-0005bM-PI
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:45:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDr4R-00013i-QX
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:45:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDr4R-00013Q-FZ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:45:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C870C30832CE;
	Tue,  9 Apr 2019 13:45:50 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F5DE5D9C9;
	Tue,  9 Apr 2019 13:45:48 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
	Olaf Hering <olaf@aepfle.de>
Date: Tue,  9 Apr 2019 15:45:35 +0200
Message-Id: <20190409134536.15548-2-philmd@redhat.com>
In-Reply-To: <20190409134536.15548-1-philmd@redhat.com>
References: <20190409134536.15548-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 09 Apr 2019 13:45:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.0 v3 1/2] roms: Rename the EFIROM
 variable to avoid clashing with iPXE
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409134535.byHUy3u14u4IcWdNtE-4HhEJsWo7jjx9XUWZIvvZQnU@z>

The iPXE's 'veryclean' recipe removes $(EFIROM) even if the EFIROM
macro originates from elsewhere:

  $ git checkout f590a812c21~
  $ make -C roms clean EFIROM=3D$(type -P EfiRom)
  make: Entering directory '/source/qemu/roms'
  [...]
  make -C ipxe/src veryclean
  make[1]: Entering directory '/source/qemu/roms/ipxe/src'
  rm -f bin{,-*}/*.* bin{,-*}/.certificate.* bin{,-*}/.certificates.* bin=
{,-*}/.private_key.* bin{,-*}/errors bin{,-*}/NIC ./util/zbin ./util/elf2=
efi32 ./util/elf2efi64 /usr/bin/EfiRom ./util/efifatbin ./util/iccfix ./u=
til/einfo TAGS bin{,-*}/symtab
  rm: cannot remove '/usr/bin/EfiRom': Permission denied
  make[1]: *** [Makefile.housekeeping:1564: clean] Error 1
  make[1]: Leaving directory '/source/qemu/roms/ipxe/src'
  make: *** [Makefile:152: clean] Error 2
  make: Leaving directory '/source/qemu/roms'

Before f590a812c21 this variable could be overridden or unset,
and the 'veryclean' Makefile rule would not complain.

Commit f590a812c21 enforces this variable to the Intel EfiRom
tool provided by the EDK2 project.

To avoid the name clash and make the difference between the
projects obvious, rename the variable used by the EDK2 project
as EDK2_EFIROM.

Fixes: f590a812c21074e82228de3e1dfb57b75fc02b62
Reported-by: Olaf Hering <olaf@aepfle.de>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 roms/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index 78d5dd18c30..d28252dafdf 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -47,7 +47,7 @@ SEABIOS_EXTRAVERSION=3D"-prebuilt.qemu.org"
 # We need that to combine multiple images (legacy bios,
 # efi ia32, efi x64) into a single rom binary.
 #
-EFIROM =3D edk2/BaseTools/Source/C/bin/EfiRom
+EDK2_EFIROM =3D edk2/BaseTools/Source/C/bin/EfiRom
=20
 default:
 	@echo "nothing is build by default"
@@ -102,8 +102,8 @@ pxe-rom-%: build-pxe-roms
=20
 efirom: $(patsubst %,efi-rom-%,$(pxerom_variants))
=20
-efi-rom-%: build-pxe-roms build-efi-roms $(EFIROM)
-	$(EFIROM) -f "0x$(VID)" -i "0x$(DID)" -l 0x02 \
+efi-rom-%: build-pxe-roms build-efi-roms $(EDK2_EFIROM)
+	$(EDK2_EFIROM) -f "0x$(VID)" -i "0x$(DID)" -l 0x02 \
 		-b ipxe/src/bin/$(VID)$(DID).rom \
 		-ec ipxe/src/bin-i386-efi/$(VID)$(DID).efidrv \
 		-ec ipxe/src/bin-x86_64-efi/$(VID)$(DID).efidrv \
@@ -120,7 +120,7 @@ build-efi-roms: build-pxe-roms
 		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
 		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
=20
-$(EFIROM):
+$(EDK2_EFIROM):
 	$(MAKE) -C edk2/BaseTools
=20
 slof:
--=20
2.20.1



Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B2EC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 15:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D786B21726
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 15:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D786B21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43557 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCQsL-0006Dw-WD
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 11:35:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCQqr-0005TV-PG
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCQqn-00037J-OA
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:33:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCQqj-0002oA-CW
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:33:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8AC0330821BE;
	Fri,  5 Apr 2019 15:33:29 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.179])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 902335D704;
	Fri,  5 Apr 2019 15:33:27 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
	Olaf Hering <olaf@aepfle.de>
Date: Fri,  5 Apr 2019 17:33:13 +0200
Message-Id: <20190405153314.2068-2-philmd@redhat.com>
In-Reply-To: <20190405153314.2068-1-philmd@redhat.com>
References: <20190405153314.2068-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Fri, 05 Apr 2019 15:33:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.0 v2 1/2] roms: Rename the EFIROM
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
Cc: Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405153313.ShYDMsV09Lc2G1QMe3oDoWL6pon-2AN1Y4BD49FR2B8@z>

The iPXE project already uses the EFIROM for a tool named 'efirom'
which is not the Intel EfiRom used by the EDK2 project. To make
the difference obvious, rename the variable.

This fixes a long standing issue which is now masked since commit
f590a812c21 "roms: build the EfiRom utility from the roms/edk2
submodule" (but would reappear in the next commit):

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

Reported-by: Olaf Hering <olaf@aepfle.de>
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



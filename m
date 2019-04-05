Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87284C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 15:35:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9A021726
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 15:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9A021726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43575 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCQsT-0006Nt-IN
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 11:35:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCQqt-0005UF-Ni
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCQqo-00038N-LJ
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:33:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCQqk-0002qn-Hh
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:33:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 031713084028;
	Fri,  5 Apr 2019 15:33:32 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.179])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0944B5D704;
	Fri,  5 Apr 2019 15:33:29 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
	Olaf Hering <olaf@aepfle.de>
Date: Fri,  5 Apr 2019 17:33:14 +0200
Message-Id: <20190405153314.2068-3-philmd@redhat.com>
In-Reply-To: <20190405153314.2068-1-philmd@redhat.com>
References: <20190405153314.2068-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Fri, 05 Apr 2019 15:33:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.0 v2 2/2] roms: Allow the EDK2_EFIROM
 variable to be overridden
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
Message-ID: <20190405153314.oCC5y5SHPutYZXPl9QqaVYYrNU0p6jWL6ESM2TS6Dpc@z>

Since commit f590a812c210 we build the EDK2 EfiRom utility
unconditionally. This has been tested on all the Linux
distribution providing continuous integration (namely Debian
and Fedora). Not all distributions are able to build the
EfiRom without specific patches (In particular SUSE which
enforces the PIE protection, see [*]).

Restore the possibility to other distributions to override
the EDK2_EFIROM variable.

[*] https://lists.opensuse.org/opensuse-factory/2017-06/msg00403.html

Reported-by: Olaf Hering <olaf@aepfle.de>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 roms/Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/roms/Makefile b/roms/Makefile
index d28252dafdf..ea19aa9b33c 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -47,7 +47,11 @@ SEABIOS_EXTRAVERSION=3D"-prebuilt.qemu.org"
 # We need that to combine multiple images (legacy bios,
 # efi ia32, efi x64) into a single rom binary.
 #
-EDK2_EFIROM =3D edk2/BaseTools/Source/C/bin/EfiRom
+# By default we build the latest EDK2 stable EfiRom utility.
+# If you have to use another one, you can also pass the location on
+# the command line, i.e. "make EDK2_EFIROM=3D$(type -P EfiRom) efirom"
+#
+EDK2_EFIROM ?=3D edk2/BaseTools/Source/C/bin/EfiRom
=20
 default:
 	@echo "nothing is build by default"
@@ -120,8 +124,11 @@ build-efi-roms: build-pxe-roms
 		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
 		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
=20
+# Do not compile $(EDK2_EFIROM) if the variable is overridden
+ifeq "$(origin EDK2_EFIROM)" "file"
 $(EDK2_EFIROM):
 	$(MAKE) -C edk2/BaseTools
+endif
=20
 slof:
 	$(MAKE) -C SLOF CROSS=3D$(powerpc64_cross_prefix) qemu
--=20
2.20.1



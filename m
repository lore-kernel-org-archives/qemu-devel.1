Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1283C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 11:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B4F206DD
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 11:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B4F206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40662 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCNSU-0003e5-IR
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 07:56:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCNRg-0003Mq-Sp
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCNRf-0004O9-Lb
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:55:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCNRf-0004N2-3T
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:55:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D55F3164680;
	Fri,  5 Apr 2019 11:55:41 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.179])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E2F1646D9;
	Fri,  5 Apr 2019 11:55:33 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Olaf Hering <olaf@aepfle.de>, qemu-devel@nongnu.org,
	Laszlo Ersek <lersek@redhat.com>
Date: Fri,  5 Apr 2019 13:55:29 +0200
Message-Id: <20190405115529.11590-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Fri, 05 Apr 2019 11:55:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.0] roms: Allow the EFIROM variable to be
 overridden
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
Message-ID: <20190405115529.yWVMyVbv8nZqCjyYJ73vnTeBE6L9p11ChVnSGHBbruM@z>

Since commit f590a812c210 we build the EfiRom utility
unconditionally. This has been tested on all the Linux
distribution providing continuous integration (namely
Debian and Fedora). Not all distributions are able to
build the EfiRom without specific patches (In particular
SUSE which enforces the PIE protection, see [*]).
Restore the possibility to other distributions to
override the EFIROM variable.

[*] https://lists.opensuse.org/opensuse-factory/2017-06/msg00403.html

Reported-by: Olaf Hering <olaf@aepfle.de>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 roms/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/roms/Makefile b/roms/Makefile
index 78d5dd18c30..0bcfa665ccf 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -47,7 +47,7 @@ SEABIOS_EXTRAVERSION=3D"-prebuilt.qemu.org"
 # We need that to combine multiple images (legacy bios,
 # efi ia32, efi x64) into a single rom binary.
 #
-EFIROM =3D edk2/BaseTools/Source/C/bin/EfiRom
+EFIROM ?=3D edk2/BaseTools/Source/C/bin/EfiRom
=20
 default:
 	@echo "nothing is build by default"
@@ -120,8 +120,11 @@ build-efi-roms: build-pxe-roms
 		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
 		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
=20
+# Do not compile $(EFIROM) if the variable is overridden
+ifeq "$(origin EFIROM)" "file"
 $(EFIROM):
 	$(MAKE) -C edk2/BaseTools
+endif
=20
 slof:
 	$(MAKE) -C SLOF CROSS=3D$(powerpc64_cross_prefix) qemu
--=20
2.20.1



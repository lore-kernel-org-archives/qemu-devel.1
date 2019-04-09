Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C824EC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 13:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B172084B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 13:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B172084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41990 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDr7w-0007pm-Py
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 09:49:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDr4V-0005bg-F1
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDr4U-00014d-Di
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:45:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDr4U-00014Q-5v
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:45:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7955F88AB3;
	Tue,  9 Apr 2019 13:45:53 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 41AE75D9C9;
	Tue,  9 Apr 2019 13:45:51 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
	Olaf Hering <olaf@aepfle.de>
Date: Tue,  9 Apr 2019 15:45:36 +0200
Message-Id: <20190409134536.15548-3-philmd@redhat.com>
In-Reply-To: <20190409134536.15548-1-philmd@redhat.com>
References: <20190409134536.15548-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Tue, 09 Apr 2019 13:45:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.0 v3 2/2] roms: Allow passing configure
 options to the EDK2 build tools
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
Message-ID: <20190409134536.jD3fG90gTVGpQDJtg92ULzNuSEpixijOU1Ye3G9uDj4@z>

Since commit f590a812c210 we build the EDK2 EfiRom utility
unconditionally.

Some distributions require to use extra compiler/linker flags,
i.e. SUSE which enforces the PIE protection (see [*]).

EDK2 build tools already provide a set of variables for that,
use them to allow the caller to easily inject compiler/linker
options..

Now build scripts can pass extra options, example:

  $ make -C roms \
      EDK2_BASETOOLS_OPTFLAGS=3D'-fPIE' \
      efirom

[*] https://lists.opensuse.org/opensuse-factory/2017-06/msg00403.html

Reported-by: Olaf Hering <olaf@aepfle.de>
Suggested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 roms/Makefile | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/roms/Makefile b/roms/Makefile
index d28252dafdf..1ff78b63bb3 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -120,8 +120,21 @@ build-efi-roms: build-pxe-roms
 		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
 		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
=20
+# Build scripts can pass compiler/linker flags to the EDK2 build tools
+# via the EDK2_BASETOOLS_OPTFLAGS (CPPFLAGS and CFLAGS) and
+# EDK2_BASETOOLS_LDFLAGS (LDFLAGS) environment variables.
+#
+# Example:
+#
+#  make -C roms \
+#    EDK2_BASETOOLS_OPTFLAGS=3D'...' \
+#    EDK2_BASETOOLS_LDFLAGS=3D'...' \
+#    efirom
+#
 $(EDK2_EFIROM):
-	$(MAKE) -C edk2/BaseTools
+	$(MAKE) -C edk2/BaseTools \
+		EXTRA_OPTFLAGS=3D'$(EDK2_BASETOOLS_OPTFLAGS)' \
+		EXTRA_LDFLAGS=3D'$(EDK2_BASETOOLS_LDFLAGS)'
=20
 slof:
 	$(MAKE) -C SLOF CROSS=3D$(powerpc64_cross_prefix) qemu
--=20
2.20.1



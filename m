Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7E5C282DD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 17:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5DC4206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 17:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5DC4206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57133 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIzCe-0005N5-4i
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 13:27:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz1u-0005Kc-1y
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz1s-0005wf-4L
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hIz1r-0005ui-U2
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 795C6821DE;
	Tue, 23 Apr 2019 17:16:21 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-125-214.rdu2.redhat.com
	[10.10.125.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D874E19729;
	Tue, 23 Apr 2019 17:16:18 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org,
	imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com,
	mst@redhat.com, peter.maydell@linaro.org, philmd@redhat.com,
	qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 19:15:14 +0200
Message-Id: <20190423171520.4511-7-lersek@redhat.com>
In-Reply-To: <20190423171520.4511-1-lersek@redhat.com>
References: <20190423171520.4511-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 23 Apr 2019 17:16:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 06/12] roms/Makefile: replace the $(EDK2_EFIROM)
 target with "edk2-basetools"
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
Message-ID: <20190423171514.bNmJGr_TIxngKl8CVoGcFpNokL5UFyp9jlpRpqsgkP0@z>

We don't (can't) have a recipe for building just $(EDK2_EFIROM);
therefore, while we call the target $(EDK2_EFIROM), we actually build all
of the edk2 BaseTools. Rename the target to edk2-basetools, and update th=
e
iPXE prerequisite accordingly. This will let other targets depend on
"edk2-basetools", where an $(EDK2_EFIROM) pre-requisite would be
misleading.

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---

Notes:
    pull:
   =20
    - pick up Phil's R-b / T-b
   =20
    - pick up Michael's A-b
   =20
    - pick up Igor's R-b
   =20
    v4:
   =20
    - rebase: resolve conflicts with
   =20
      - commit d912e795e029 ("roms: Rename the EFIROM variable to avoid
        clashing with iPXE", 2019-04-09)
   =20
      - commit 1cab464136b4 ("roms: Allow passing configure options to th=
e
        EDK2 build tools", 2019-04-09)
   =20
    - refresh commit message accordingly: replace EFIROM references with
      EDK2_EFIROM references
   =20
    - drop all previous feedback tags, consequently :(
   =20
      - Phil's R-b / T-b
      - Michal's R-b
      - Michael's R-b
      - Igor's T-b
   =20
    v3:
   =20
    - pick up Igor's T-b
   =20
    v2:
   =20
    - pick up Phil's R-b / T-b
   =20
    - pick up Michal's and Michael's R-b's

 roms/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index 1ff78b63bb3a..93c3d467be14 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -102,7 +102,7 @@ pxe-rom-%: build-pxe-roms
=20
 efirom: $(patsubst %,efi-rom-%,$(pxerom_variants))
=20
-efi-rom-%: build-pxe-roms build-efi-roms $(EDK2_EFIROM)
+efi-rom-%: build-pxe-roms build-efi-roms edk2-basetools
 	$(EDK2_EFIROM) -f "0x$(VID)" -i "0x$(DID)" -l 0x02 \
 		-b ipxe/src/bin/$(VID)$(DID).rom \
 		-ec ipxe/src/bin-i386-efi/$(VID)$(DID).efidrv \
@@ -131,7 +131,7 @@ build-efi-roms: build-pxe-roms
 #    EDK2_BASETOOLS_LDFLAGS=3D'...' \
 #    efirom
 #
-$(EDK2_EFIROM):
+edk2-basetools:
 	$(MAKE) -C edk2/BaseTools \
 		EXTRA_OPTFLAGS=3D'$(EDK2_BASETOOLS_OPTFLAGS)' \
 		EXTRA_LDFLAGS=3D'$(EDK2_BASETOOLS_LDFLAGS)'
--=20
2.19.1.3.g30247aa5d201




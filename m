Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7002C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:03:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8342A20830
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8342A20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50215 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDzmR-0007TR-Nn
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 19:03:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDzjm-0005d8-UB
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDzjl-0001Rn-9A
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:01:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hDzjk-0001ON-S9
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:01:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3C50C02492F;
	Tue,  9 Apr 2019 23:01:01 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-114.rdu2.redhat.com
	[10.10.120.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 592941001DC0;
	Tue,  9 Apr 2019 23:00:59 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org,
	imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com,
	mst@redhat.com, peter.maydell@linaro.org, philmd@redhat.com,
	qemu-devel@nongnu.org
Date: Wed, 10 Apr 2019 01:00:16 +0200
Message-Id: <20190409230022.6462-7-lersek@redhat.com>
In-Reply-To: <20190409230022.6462-1-lersek@redhat.com>
References: <20190409230022.6462-1-lersek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Tue, 09 Apr 2019 23:01:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1 v4 06/12] roms/Makefile: replace the
 $(EDK2_EFIROM) target with "edk2-basetools"
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409230016.obHnztCCIu0IeFTYfnRdm4Us2NTHzVkC5p9pWtCFYoI@z>

We don't (can't) have a recipe for building just $(EDK2_EFIROM);
therefore, while we call the target $(EDK2_EFIROM), we actually build all
of the edk2 BaseTools. Rename the target to edk2-basetools, and update th=
e
iPXE prerequisite accordingly. This will let other targets depend on
"edk2-basetools", where an $(EDK2_EFIROM) pre-requisite would be
misleading.

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---

Notes:
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




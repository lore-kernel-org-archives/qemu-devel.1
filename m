Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD48C31E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 20:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945D721841
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 20:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945D721841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55090 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbsls-0000Cw-TH
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 16:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56255)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hbsji-0006kJ-SA
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 16:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hbsjh-0006vn-Ls
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 16:23:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4701)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hbsjh-0006uB-DB
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 16:23:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B66408553F
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 20:23:44 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-141.ams2.redhat.com
 [10.36.116.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07D2D5C1A1;
 Fri, 14 Jun 2019 20:23:43 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 22:23:30 +0200
Message-Id: <20190614202333.19355-4-lersek@redhat.com>
In-Reply-To: <20190614202333.19355-1-lersek@redhat.com>
References: <20190614202333.19355-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 14 Jun 2019 20:23:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/6] roms/Makefile.edk2: remove
 edk2-stable201903 network feature test macros
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At tag "edk2-stable201905", the build flags HTTP_BOOT_ENABLE and
TLS_ENABLE have become useless. Their roles have been taken by
NETWORK_HTTP_BOOT_ENABLE and NETWORK_TLS_ENABLE, respectively. Remove the
old build flags.

Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Ref: https://bugs.launchpad.net/qemu/+bug/1831477
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 roms/Makefile.edk2 | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/roms/Makefile.edk2 b/roms/Makefile.edk2
index 071d6e454b68..6a19498d0738 100644
--- a/roms/Makefile.edk2
+++ b/roms/Makefile.edk2
@@ -57,8 +57,7 @@ submodules:
 		--arch=3DAARCH64 \
 		--platform=3DArmVirtPkg/ArmVirtQemu.dsc \
 		-D NETWORK_IP6_ENABLE \
-		-D NETWORK_HTTP_BOOT_ENABLE \
-		-D HTTP_BOOT_ENABLE
+		-D NETWORK_HTTP_BOOT_ENABLE
 	cp edk2/Build/ArmVirtQemu-AARCH64/DEBUG_$(call toolchain,aarch64)/FV/QE=
MU_EFI.fd \
 		$@
 	truncate --size=3D64M $@
@@ -69,8 +68,7 @@ submodules:
 		--arch=3DARM \
 		--platform=3DArmVirtPkg/ArmVirtQemu.dsc \
 		-D NETWORK_IP6_ENABLE \
-		-D NETWORK_HTTP_BOOT_ENABLE \
-		-D HTTP_BOOT_ENABLE
+		-D NETWORK_HTTP_BOOT_ENABLE
 	cp edk2/Build/ArmVirtQemu-ARM/DEBUG_$(call toolchain,arm)/FV/QEMU_EFI.f=
d \
 		$@
 	truncate --size=3D64M $@
@@ -82,9 +80,7 @@ submodules:
 		--platform=3DOvmfPkg/OvmfPkgIa32.dsc \
 		-D NETWORK_IP6_ENABLE \
 		-D NETWORK_HTTP_BOOT_ENABLE \
-		-D HTTP_BOOT_ENABLE \
 		-D NETWORK_TLS_ENABLE \
-		-D TLS_ENABLE \
 		-D TPM2_ENABLE \
 		-D TPM2_CONFIG_ENABLE
 	cp edk2/Build/OvmfIa32/DEBUG_$(call toolchain,i386)/FV/OVMF_CODE.fd $@
@@ -96,9 +92,7 @@ submodules:
 		--platform=3DOvmfPkg/OvmfPkgIa32.dsc \
 		-D NETWORK_IP6_ENABLE \
 		-D NETWORK_HTTP_BOOT_ENABLE \
-		-D HTTP_BOOT_ENABLE \
 		-D NETWORK_TLS_ENABLE \
-		-D TLS_ENABLE \
 		-D TPM2_ENABLE \
 		-D TPM2_CONFIG_ENABLE \
 		-D SECURE_BOOT_ENABLE \
@@ -112,9 +106,7 @@ submodules:
 		--platform=3DOvmfPkg/OvmfPkgX64.dsc \
 		-D NETWORK_IP6_ENABLE \
 		-D NETWORK_HTTP_BOOT_ENABLE \
-		-D HTTP_BOOT_ENABLE \
 		-D NETWORK_TLS_ENABLE \
-		-D TLS_ENABLE \
 		-D TPM2_ENABLE \
 		-D TPM2_CONFIG_ENABLE
 	cp edk2/Build/OvmfX64/DEBUG_$(call toolchain,x86_64)/FV/OVMF_CODE.fd $@
@@ -127,9 +119,7 @@ submodules:
 		--platform=3DOvmfPkg/OvmfPkgIa32X64.dsc \
 		-D NETWORK_IP6_ENABLE \
 		-D NETWORK_HTTP_BOOT_ENABLE \
-		-D HTTP_BOOT_ENABLE \
 		-D NETWORK_TLS_ENABLE \
-		-D TLS_ENABLE \
 		-D TPM2_ENABLE \
 		-D TPM2_CONFIG_ENABLE \
 		-D SECURE_BOOT_ENABLE \
--=20
2.19.1.3.g30247aa5d201




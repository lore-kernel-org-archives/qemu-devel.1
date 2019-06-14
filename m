Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCBDC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 20:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D0621841
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 20:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D0621841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55088 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbslp-00006F-L7
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 16:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56217)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hbsje-0006hl-Kp
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 16:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hbsjd-0006rp-GY
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 16:23:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50172)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hbsjd-0006r4-B2
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 16:23:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1E2F136899
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 20:23:40 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-141.ams2.redhat.com
 [10.36.116.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2867E5C1A1;
 Fri, 14 Jun 2019 20:23:36 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 22:23:28 +0200
Message-Id: <20190614202333.19355-2-lersek@redhat.com>
In-Reply-To: <20190614202333.19355-1-lersek@redhat.com>
References: <20190614202333.19355-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 14 Jun 2019 20:23:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/6] roms/Makefile.edk2: define
 edk2-stable201905 network feature test macros
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

Due to edk2 commits 631195044ff0 ("OvmfPkg: Update DSC/FDF to use
NetworkPkg's include fragment file.", 2019-05-16) and 157a3b1aa50f
("ArmVirtPkg: Update DSC/FDF to use NetworkPkg's include fragment file.",
2019-05-16), we'll have to pefix the HTTP_BOOT_ENABLE and TLS_ENABLE buil=
d
flags with "NETWORK_", for building edk2 at tag "edk2-stable201905".

Right now the new flags are no-ops, so we can insert them separately,
before advancing our edk2 submodule reference. We will remove the old
flags afterwards.

Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Ref: https://bugs.launchpad.net/qemu/+bug/1831477
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 roms/Makefile.edk2 | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/roms/Makefile.edk2 b/roms/Makefile.edk2
index 822c547fec64..071d6e454b68 100644
--- a/roms/Makefile.edk2
+++ b/roms/Makefile.edk2
@@ -57,6 +57,7 @@ submodules:
 		--arch=3DAARCH64 \
 		--platform=3DArmVirtPkg/ArmVirtQemu.dsc \
 		-D NETWORK_IP6_ENABLE \
+		-D NETWORK_HTTP_BOOT_ENABLE \
 		-D HTTP_BOOT_ENABLE
 	cp edk2/Build/ArmVirtQemu-AARCH64/DEBUG_$(call toolchain,aarch64)/FV/QE=
MU_EFI.fd \
 		$@
@@ -68,6 +69,7 @@ submodules:
 		--arch=3DARM \
 		--platform=3DArmVirtPkg/ArmVirtQemu.dsc \
 		-D NETWORK_IP6_ENABLE \
+		-D NETWORK_HTTP_BOOT_ENABLE \
 		-D HTTP_BOOT_ENABLE
 	cp edk2/Build/ArmVirtQemu-ARM/DEBUG_$(call toolchain,arm)/FV/QEMU_EFI.f=
d \
 		$@
@@ -79,7 +81,9 @@ submodules:
 		--arch=3DIA32 \
 		--platform=3DOvmfPkg/OvmfPkgIa32.dsc \
 		-D NETWORK_IP6_ENABLE \
+		-D NETWORK_HTTP_BOOT_ENABLE \
 		-D HTTP_BOOT_ENABLE \
+		-D NETWORK_TLS_ENABLE \
 		-D TLS_ENABLE \
 		-D TPM2_ENABLE \
 		-D TPM2_CONFIG_ENABLE
@@ -91,7 +95,9 @@ submodules:
 		--arch=3DIA32 \
 		--platform=3DOvmfPkg/OvmfPkgIa32.dsc \
 		-D NETWORK_IP6_ENABLE \
+		-D NETWORK_HTTP_BOOT_ENABLE \
 		-D HTTP_BOOT_ENABLE \
+		-D NETWORK_TLS_ENABLE \
 		-D TLS_ENABLE \
 		-D TPM2_ENABLE \
 		-D TPM2_CONFIG_ENABLE \
@@ -105,7 +111,9 @@ submodules:
 		--arch=3DX64 \
 		--platform=3DOvmfPkg/OvmfPkgX64.dsc \
 		-D NETWORK_IP6_ENABLE \
+		-D NETWORK_HTTP_BOOT_ENABLE \
 		-D HTTP_BOOT_ENABLE \
+		-D NETWORK_TLS_ENABLE \
 		-D TLS_ENABLE \
 		-D TPM2_ENABLE \
 		-D TPM2_CONFIG_ENABLE
@@ -118,7 +126,9 @@ submodules:
 		--arch=3DX64 \
 		--platform=3DOvmfPkg/OvmfPkgIa32X64.dsc \
 		-D NETWORK_IP6_ENABLE \
+		-D NETWORK_HTTP_BOOT_ENABLE \
 		-D HTTP_BOOT_ENABLE \
+		-D NETWORK_TLS_ENABLE \
 		-D TLS_ENABLE \
 		-D TPM2_ENABLE \
 		-D TPM2_CONFIG_ENABLE \
--=20
2.19.1.3.g30247aa5d201




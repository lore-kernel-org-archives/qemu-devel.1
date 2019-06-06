Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC649C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A6DA20673
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6DA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60656 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYsWI-0007dH-G2
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 09:33:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hYsUJ-0006LJ-DY
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hYsUI-0008Qj-8t
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:31:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hYsUI-0008NX-3L
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:31:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A2F7EE56A
	for <qemu-devel@nongnu.org>; Thu,  6 Jun 2019 13:31:20 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-196.ams2.redhat.com
	[10.36.116.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 78FC56841C;
	Thu,  6 Jun 2019 13:31:18 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu devel list <qemu-devel@nongnu.org>
Date: Thu,  6 Jun 2019 15:31:05 +0200
Message-Id: <20190606133110.13754-2-lersek@redhat.com>
In-Reply-To: <20190606133110.13754-1-lersek@redhat.com>
References: <20190606133110.13754-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Thu, 06 Jun 2019 13:31:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/6] roms/Makefile.edk2: define
 edk2-stable201905 network feature test macros
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




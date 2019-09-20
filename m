Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BF9C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C68B2067B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C68B2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBHCk-00071o-Au
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 07:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBHAc-0004mf-Qv
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBHAb-0001Ap-27
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:33:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55636)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBHAa-0001A5-PX
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:33:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7E0A33DE04;
 Fri, 20 Sep 2019 11:33:47 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB11D10027AA;
 Fri, 20 Sep 2019 11:33:43 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Justin Terry <juterry@microsoft.com>
Subject: [PATCH v2 2/3] tests/docker: Add fedora-win10sdk-cross image
Date: Fri, 20 Sep 2019 13:33:28 +0200
Message-Id: <20190920113329.16787-3-philmd@redhat.com>
In-Reply-To: <20190920113329.16787-1-philmd@redhat.com>
References: <20190920113329.16787-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 20 Sep 2019 11:33:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To build WHPX (Windows Hypervisor) binaries, we need the WHPX
headers provided by the Windows SDK.

Add a script that fetches the required MSI/CAB files from the
latest SDK (currently 10.0.18362.1).

Headers are accessible under /opt/win10sdk/include.

Set the QEMU_CONFIGURE_OPTS environment variable accordingly,
enabling HAX and WHPX. Due to CPP warnings related to Microsoft
specific #pragmas, we also need to use the '--disable-werror'
configure flag.

Cc: Justin Terry <juterry@microsoft.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/docker/Makefile.include                 |  2 ++
 .../dockerfiles/fedora-win10sdk-cross.docker  | 23 ++++++++++++++++
 tests/docker/dockerfiles/win10sdk-dl.sh       | 27 +++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 tests/docker/dockerfiles/fedora-win10sdk-cross.docker
 create mode 100755 tests/docker/dockerfiles/win10sdk-dl.sh

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index 50a400b573..aa2e4e56dd 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -125,6 +125,8 @@ docker-image-debian-ppc64-cross: docker-image-debian1=
0
 docker-image-debian-riscv64-cross: docker-image-debian10
 docker-image-debian-sh4-cross: docker-image-debian10
 docker-image-debian-sparc64-cross: docker-image-debian10
+docker-image-fedora-win10sdk-cross: docker-image-fedora
+docker-image-fedora-win10sdk-cross: EXTRA_FILES:=3D$(DOCKER_FILES_DIR)/w=
in10sdk-dl.sh
=20
 docker-image-travis: NOUSER=3D1
=20
diff --git a/tests/docker/dockerfiles/fedora-win10sdk-cross.docker b/test=
s/docker/dockerfiles/fedora-win10sdk-cross.docker
new file mode 100644
index 0000000000..55ca933d40
--- /dev/null
+++ b/tests/docker/dockerfiles/fedora-win10sdk-cross.docker
@@ -0,0 +1,23 @@
+#
+# Docker MinGW64 cross-compiler target with WHPX header installed
+#
+# This docker target builds on the Fedora 30 base image.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+FROM qemu:fedora
+
+RUN dnf install -y \
+        cabextract \
+        msitools \
+        wget
+
+# Install WHPX headers from Windows Software Development Kit:
+# https://developer.microsoft.com/en-us/windows/downloads/windows-10-sdk
+ADD win10sdk-dl.sh /usr/local/bin/win10sdk-dl.sh
+RUN /usr/local/bin/win10sdk-dl.sh
+
+ENV QEMU_CONFIGURE_OPTS ${QEMU_CONFIGURE_OPTS} \
+    --cross-prefix=3Dx86_64-w64-mingw32- \
+    --extra-cflags=3D-I/opt/win10sdk/include --disable-werror \
+    --enable-hax --enable-whpx
diff --git a/tests/docker/dockerfiles/win10sdk-dl.sh b/tests/docker/docke=
rfiles/win10sdk-dl.sh
new file mode 100755
index 0000000000..1c35c2a252
--- /dev/null
+++ b/tests/docker/dockerfiles/win10sdk-dl.sh
@@ -0,0 +1,27 @@
+#!/bin/bash
+#
+# Install WHPX headers from Windows Software Development Kit
+# https://developer.microsoft.com/en-us/windows/downloads/windows-10-sdk
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+WINDIR=3D/opt/win10sdk
+mkdir -p ${WINDIR}
+pushd ${WINDIR}
+# Get the bundle base for Windows SDK v10.0.18362.1
+BASE_URL=3D$(curl --silent --include 'http://go.microsoft.com/fwlink/?pr=
d=3D11966&pver=3D1.0&plcid=3D0x409&clcid=3D0x409&ar=3DWindows10&sar=3DSDK=
&o1=3D10.0.18362.1' | sed -nE 's_Location: (.*)/\r_\1_p')/Installers
+# Fetch the MSI containing the headers
+wget --no-verbose ${BASE_URL}/'Windows SDK Desktop Headers x86-x86_en-us=
.msi'
+while true; do
+    # Fetch all cabinets required by this MSI
+    CAB_NAME=3D$(msiextract Windows\ SDK\ Desktop\ Headers\ x86-x86_en-u=
s.msi 3>&1 2>&3 3>&-| sed -nE "s_.*Error opening file $PWD/(.*): No such =
file or directory_\1_p")
+    test -z "${CAB_NAME}" && break
+    wget --no-verbose ${BASE_URL}/${CAB_NAME}
+done
+rm *.{cab,msi}
+mkdir /opt/win10sdk/include
+# Only keep the WHPX headers
+for inc in "${WINDIR}/Program Files/Windows Kits/10/Include/10.0.18362.0=
/um"/WinHv*; do
+    ln -s "${inc}" /opt/win10sdk/include
+done
+popd > /dev/null
--=20
2.20.1



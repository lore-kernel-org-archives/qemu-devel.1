Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE10C3A5A2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 00:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF0021897
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 00:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF0021897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5JYG-0000Tq-GK
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 20:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i5JXD-0008K2-Qb
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 20:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i5JXA-0000zF-P5
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 20:52:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60554)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i5JXA-0000yP-HB
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 20:52:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0A4BC3680A;
 Wed,  4 Sep 2019 00:52:27 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-123-245.rdu2.redhat.com
 [10.10.123.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 368BD60A9F;
 Wed,  4 Sep 2019 00:52:20 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 20:52:18 -0400
Message-Id: <20190904005218.12536-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 04 Sep 2019 00:52:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] Fedora images: use URLs from stable
 "archives.fedoraproject.org"
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
Cc: Yash Mankad <ymankad@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_16 test,
from tests/acceptance/linux_initrd.py, is currently failing to fetch
the "vmlinuz" file.  The reason for the failure is that the Fedora
project retires older versions from the "dl.fedoraproject.org" URL,
and keeps them in "archives.fedoraproject.org".  As an added note,
that test uses a Fedora 28 image, because of the specific Linux kernel
version requirements of the test.

For the sake of stability, let's use URLs from the archived and
supposedely ever stable URLs.  The good news is that the currently
supported versions are also hosted on the later.  This change limits
itself to change the URLs, while keeping the fetched files the same
(as can be evidenced by the unchanged hashes).

Documentation and the "vm tests" fedora definition were also updated.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 qemu-doc.texi                          |  6 +++---
 tests/acceptance/boot_linux_console.py | 25 +++++++++++++++----------
 tests/acceptance/linux_initrd.py       |  5 +++--
 tests/vm/fedora                        |  2 +-
 4 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 577d1e8376..37795f86fb 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -440,15 +440,15 @@ of <protocol>.
=20
 Example: boot from a remote Fedora 20 live ISO image
 @example
-qemu-system-x86_64 --drive media=3Dcdrom,file=3Dhttp://dl.fedoraproject.=
org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-2=
0-1.iso,readonly
+qemu-system-x86_64 --drive media=3Dcdrom,file=3Dhttps://archives.fedorap=
roject.org/pub/archive/fedora/linux/releases/20/Live/x86_64/Fedora-Live-D=
esktop-x86_64-20-1.iso,readonly
=20
-qemu-system-x86_64 --drive media=3Dcdrom,file.driver=3Dhttp,file.url=3Dh=
ttp://dl.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/Fedor=
a-Live-Desktop-x86_64-20-1.iso,readonly
+qemu-system-x86_64 --drive media=3Dcdrom,file.driver=3Dhttp,file.url=3Dh=
ttp://archives.fedoraproject.org/pub/archive/fedora/linux/releases/20/Liv=
e/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
 @end example
=20
 Example: boot from a remote Fedora 20 cloud image using a local overlay =
for
 writes, copy-on-read, and a readahead of 64k
 @example
-qemu-img create -f qcow2 -o backing_file=3D'json:@{"file.driver":"http",=
, "file.url":"https://dl.fedoraproject.org/pub/fedora/linux/releases/20/I=
mages/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",, "file.readahead":"6=
4k"@}' /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
+qemu-img create -f qcow2 -o backing_file=3D'json:@{"file.driver":"http",=
, "file.url":"http://archives.fedoraproject.org/pub/archive/fedora/linux/=
releases/20/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",, "file.=
readahead":"64k"@}' /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
=20
 qemu-system-x86_64 -drive file=3D/tmp/Fedora-x86_64-20-20131211.1-sda.qc=
ow2,copy-on-read=3Don
 @end example
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 2504ef0150..8a9a314ab4 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -76,8 +76,9 @@ class BootLinuxConsole(Test):
         :avocado: tags=3Darch:x86_64
         :avocado: tags=3Dmachine:pc
         """
-        kernel_url =3D ('https://download.fedoraproject.org/pub/fedora/l=
inux/'
-                      'releases/29/Everything/x86_64/os/images/pxeboot/v=
mlinuz')
+        kernel_url =3D ('https://archives.fedoraproject.org/pub/archive/=
fedora'
+                      '/linux/releases/29/Everything/x86_64/os/images/px=
eboot'
+                      '/vmlinuz')
         kernel_hash =3D '23bebd2680757891cf7adedb033532163a792495'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
=20
@@ -250,8 +251,9 @@ class BootLinuxConsole(Test):
         :avocado: tags=3Darch:aarch64
         :avocado: tags=3Dmachine:virt
         """
-        kernel_url =3D ('https://download.fedoraproject.org/pub/fedora/l=
inux/'
-                      'releases/29/Everything/aarch64/os/images/pxeboot/=
vmlinuz')
+        kernel_url =3D ('https://archives.fedoraproject.org/pub/archive/=
fedora'
+                      '/linux/releases/29/Everything/aarch64/os/images/p=
xeboot'
+                      '/vmlinuz')
         kernel_hash =3D '8c73e469fc6ea06a58dc83a628fc695b693b8493'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
=20
@@ -271,8 +273,9 @@ class BootLinuxConsole(Test):
         :avocado: tags=3Darch:arm
         :avocado: tags=3Dmachine:virt
         """
-        kernel_url =3D ('https://download.fedoraproject.org/pub/fedora/l=
inux/'
-                      'releases/29/Everything/armhfp/os/images/pxeboot/v=
mlinuz')
+        kernel_url =3D ('https://archives.fedoraproject.org/pub/archive/=
fedora'
+                      '/linux/releases/29/Everything/armhfp/os/images/px=
eboot'
+                      '/vmlinuz')
         kernel_hash =3D 'e9826d741b4fb04cadba8d4824d1ed3b7fb8b4d4'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
=20
@@ -318,8 +321,9 @@ class BootLinuxConsole(Test):
         :avocado: tags=3Darch:s390x
         :avocado: tags=3Dmachine:s390_ccw_virtio
         """
-        kernel_url =3D ('https://download.fedoraproject.org/pub/fedora-s=
econdary/'
-                      'releases/29/Everything/s390x/os/images/kernel.img=
')
+        kernel_url =3D ('https://archives.fedoraproject.org/pub/archive'
+                      '/fedora-secondary/releases/29/Everything/s390x/os=
/images'
+                      '/kernel.img')
         kernel_hash =3D 'e8e8439103ef8053418ef062644ffd46a7919313'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
=20
@@ -360,8 +364,9 @@ class BootLinuxConsole(Test):
         :avocado: tags=3Darch:ppc64
         :avocado: tags=3Dmachine:pseries
         """
-        kernel_url =3D ('https://download.fedoraproject.org/pub/fedora-s=
econdary/'
-                      'releases/29/Everything/ppc64le/os/ppc/ppc64/vmlin=
uz')
+        kernel_url =3D ('https://archives.fedoraproject.org/pub/archive'
+                      '/fedora-secondary/releases/29/Everything/ppc64le/=
os'
+                      '/ppc/ppc64/vmlinuz')
         kernel_hash =3D '3fe04abfc852b66653b8c3c897a59a689270bc77'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
=20
diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_in=
itrd.py
index 23be5a63aa..c61d9826a4 100644
--- a/tests/acceptance/linux_initrd.py
+++ b/tests/acceptance/linux_initrd.py
@@ -54,8 +54,9 @@ class LinuxInitrd(Test):
         QEMU has supported up to 4 GiB initrd for recent kernel
         Expect guest can reach 'Unpacking initramfs...'
         """
-        kernel_url =3D ('https://mirrors.kernel.org/fedora/releases/28/'
-                      'Everything/x86_64/os/images/pxeboot/vmlinuz')
+        kernel_url =3D ('https://archives.fedoraproject.org/pub/archive/=
fedora'
+                      '/linux/releases/28/Everything/x86_64/os/images/px=
eboot/'
+                      'vmlinuz')
         kernel_hash =3D '238e083e114c48200f80d889f7e32eeb2793e02a'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
         max_size =3D 2 * (1024 ** 3) + 1
diff --git a/tests/vm/fedora b/tests/vm/fedora
index e8fa5bf0d2..7fec1479fb 100755
--- a/tests/vm/fedora
+++ b/tests/vm/fedora
@@ -23,7 +23,7 @@ class FedoraVM(basevm.BaseVM):
     name =3D "fedora"
     arch =3D "x86_64"
=20
-    base =3D "http://dl.fedoraproject.org/pub/fedora/linux/releases/30/"
+    base =3D "https://archives.fedoraproject.org/pub/archive/fedora/linu=
x/releases/30/"
     link =3D base + "Server/x86_64/iso/Fedora-Server-netinst-x86_64-30-1=
.2.iso"
     repo =3D base + "Server/x86_64/os/"
     full =3D base + "Everything/x86_64/os/"
--=20
2.21.0



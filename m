Received: from eggs.gnu.org ([209.51.188.92]:57881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2QAN-0000PV-MX
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2QAN-0001gI-1g
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:48:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1h2QAM-0001ds-Qu
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:48:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 239BE753D1
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 00:48:42 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Sat,  9 Mar 2019 01:48:18 +0100
Message-Id: <20190309004826.9027-3-lersek@redhat.com>
In-Reply-To: <20190309004826.9027-1-lersek@redhat.com>
References: <20190309004826.9027-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/10] roms/edk2-funcs.sh: require gcc-4.8+ for
 building i386 and x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, imammedo@redhat.com, kraxel@redhat.com, mst@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org

Adapt the qemu_edk2_get_toolchain() function in "roms/edk2-funcs.sh" in
advance to edk2 commit 8d7cdfae8cb8 ("OvmfPkg: require GCC48 or later",
2019-01-08), which is part of the "edk2-stable201903" tag.

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 roms/edk2-funcs.sh | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
index 908c7665c6ed..22a5dc8f6ab6 100644
--- a/roms/edk2-funcs.sh
+++ b/roms/edk2-funcs.sh
@@ -149,23 +149,11 @@ qemu_edk2_get_toolchain()
       # Run "git-blame" on "OvmfPkg/build.sh" in edk2 for more informati=
on on
       # the mapping below.
       case "$gcc_version" in
-        ([1-3].*|4.[0-3].*)
+        ([1-3].*|4.[0-7].*)
           printf '%s: unsupported gcc version "%s"\n' \
             "$program_name" "$gcc_version" >&2
           return 1
           ;;
-        (4.4.*)
-          printf 'GCC44\n'
-          ;;
-        (4.5.*)
-          printf 'GCC45\n'
-          ;;
-        (4.6.*)
-          printf 'GCC46\n'
-          ;;
-        (4.7.*)
-          printf 'GCC47\n'
-          ;;
         (4.8.*)
           printf 'GCC48\n'
           ;;
--=20
2.19.1.3.g30247aa5d201

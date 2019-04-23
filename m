Received: from eggs.gnu.org ([209.51.188.92]:36656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz1R-00056z-1Z
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz1Q-0005NQ-1V
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:15:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hIz1P-0005Ml-SH
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:15:55 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Tue, 23 Apr 2019 19:15:10 +0200
Message-Id: <20190423171520.4511-3-lersek@redhat.com>
In-Reply-To: <20190423171520.4511-1-lersek@redhat.com>
References: <20190423171520.4511-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/12] roms/edk2-funcs.sh: require gcc-4.8+ for
 building i386 and x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org, imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com, mst@redhat.com, peter.maydell@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org

Adapt the qemu_edk2_get_toolchain() function in "roms/edk2-funcs.sh" in
advance to edk2 commit 8d7cdfae8cb8 ("OvmfPkg: require GCC48 or later",
2019-01-08), which is part of the "edk2-stable201903" tag.

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---

Notes:
    pull:
   =20
    - pick up Igor's R-b
   =20
    v4:
   =20
    - no change
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

 roms/edk2-funcs.sh | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
index 8930479dcb44..d1cb1e4a111e 100644
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

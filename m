Received: from eggs.gnu.org ([2001:4830:134:3::10]:41611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1db4zk-00045o-56
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1db4zg-0008RA-E3
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:07:56 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:13828)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1db4zg-0008Qk-7b
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:07:52 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Fri, 28 Jul 2017 14:07:45 +0100
Message-ID: <1501247265-22367-3-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1501247265-22367-1-git-send-email-yongbok.kim@imgtec.com>
References: <1501247265-22367-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] Revert "elf-loader: warn about invalid
 endianness"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Aurelien Jarno <aurelien@aurel32.net>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This reverts c8e1158cf611 "elf-loader: warn about invalid endianness"
as it produces a useless message every time an LE kernel image is
passed via -kernel on a ppc64-pseries machine. The pseries machine
already checks for ELF_LOAD_WRONG_ENDIAN and tries with big_endian=3D0.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 hw/core/loader.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index c17ace0..e5e8cbb 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -480,7 +480,6 @@ int load_elf_ram(const char *filename,
     }
=20
     if (target_data_order !=3D e_ident[EI_DATA]) {
-        fprintf(stderr, "%s: wrong endianness\n", filename);
         ret =3D ELF_LOAD_WRONG_ENDIAN;
         goto fail;
     }
--=20
2.7.4

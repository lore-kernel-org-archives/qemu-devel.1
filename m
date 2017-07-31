Received: from eggs.gnu.org ([2001:4830:134:3::10]:60655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc8Nw-0004tE-TU
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc8Ns-0004hO-Q3
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:57:16 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 31 Jul 2017 13:21:33 +0300
Message-Id: <72cd500b725fd9a3bbefeb468d54c192fdc28318.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/25] linux-user/sh4: fix incorrect memory write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

not hit since 2009! :)

linux-user/elfload.c:1102:20: warning: Out of bound memory access (access=
 exceeds upper limit of memory block)
        (*regs[i]) =3D tswap32(env->gregs[i]);
        ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 2a902f7806..79062882ba 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1099,7 +1099,7 @@ static inline void elf_core_copy_regs(target_elf_gr=
egset_t *regs,
     int i;
=20
     for (i =3D 0; i < 16; i++) {
-        (*regs[i]) =3D tswapreg(env->gregs[i]);
+        (*regs)[i] =3D tswapreg(env->gregs[i]);
     }
=20
     (*regs)[TARGET_REG_PC] =3D tswapreg(env->pc);
--=20
2.11.0

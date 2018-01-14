Received: from eggs.gnu.org ([2001:4830:134:3::10]:41433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ealxv-000082-LY
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 12:21:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ealxr-0002If-1z
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 12:21:03 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:47702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1ealxq-0002Hk-Rg
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 12:20:58 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 14 Jan 2018 18:20:51 +0100
Message-Id: <20180114172053.1051-4-samuel.thibault@ens-lyon.org>
In-Reply-To: <20180114172053.1051-1-samuel.thibault@ens-lyon.org>
References: <20180114172053.1051-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/5] slirp: remove unnecessary struct declaration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/libslirp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index f90f0f524c..540b3e5903 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -3,7 +3,6 @@
=20
 #include "qemu-common.h"
=20
-struct Slirp;
 typedef struct Slirp Slirp;
=20
 int get_dns_addr(struct in_addr *pdns_addr);
--=20
2.15.1

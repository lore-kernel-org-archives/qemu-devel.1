Received: from eggs.gnu.org ([2001:4830:134:3::10]:57643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1f2b5G-0001by-AK
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 07:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1f2b5D-0003Qn-Mz
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 07:23:38 -0400
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <0dd4c8f5-d60e-e564-652f-cd0101f6ee68@web.de>
Date: Sun, 1 Apr 2018 13:23:29 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="oHqQrQThYtqZljZ0AD0MFrqMP7zIOIUsz"
Subject: [Qemu-devel] [PATCH] build: Silence dtc directory creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial <qemu-trivial@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oHqQrQThYtqZljZ0AD0MFrqMP7zIOIUsz
From: Jan Kiszka <jan.kiszka@web.de>
To: qemu-trivial <qemu-trivial@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <0dd4c8f5-d60e-e564-652f-cd0101f6ee68@web.de>
Subject: [PATCH] build: Silence dtc directory creation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Jan Kiszka <jan.kiszka@siemens.com>

Align with other mkdir calls.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 727ef118f3..fc6f21001f 100644
--- a/Makefile
+++ b/Makefile
@@ -485,7 +485,7 @@ subdir-dtc: .git-submodule-status dtc/libfdt dtc/test=
s
 	$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS) CPPFLAGS=3D"$(DTC_CPPFLAG=
S)" CFLAGS=3D"$(DTC_CFLAGS)" LDFLAGS=3D"$(LDFLAGS)" ARFLAGS=3D"$(ARFLAGS)=
" CC=3D"$(CC)" AR=3D"$(AR)" LD=3D"$(LD)" $(SUBDIR_MAKEFLAGS) libfdt/libfd=
t.a,)
=20
 dtc/%: .git-submodule-status
-	mkdir -p $@
+	@mkdir -p $@
=20
 # Overriding CFLAGS causes us to lose defines added in the sub-makefile.=

 # Not overriding CFLAGS leads to mis-matches between compilation modes.
--=20
2.13.6


--oHqQrQThYtqZljZ0AD0MFrqMP7zIOIUsz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlrAwTQACgkQitSsb3rl5xQ/0QCgphvlkbG9g4MaY9daQrICGaNN
oWkAoM15oBKmN2IXjg3yA1kgdd0cvi2a
=jSb+
-----END PGP SIGNATURE-----

--oHqQrQThYtqZljZ0AD0MFrqMP7zIOIUsz--

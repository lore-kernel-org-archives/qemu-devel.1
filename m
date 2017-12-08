Received: from eggs.gnu.org ([2001:4830:134:3::10]:46571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eN6zw-0006ha-Fn
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 19:58:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eN6zv-0007Tr-MC
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 19:58:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eN6zv-0007TZ-Fi
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 19:58:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B35085542
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 00:58:38 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  8 Dec 2017 01:58:15 +0100
Message-Id: <20171208005825.14587-3-marcandre.lureau@redhat.com>
In-Reply-To: <20171208005825.14587-1-marcandre.lureau@redhat.com>
References: <20171208005825.14587-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/12] build-sys: silence make by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

In particular, do not print anything when there is nothing to do, in
particular, after a successful build:

$ make
make[1]: '/home/elmarco/src/qemu/build/capstone/libcapstone.a' is up to d=
ate.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 rules.mak | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rules.mak b/rules.mak
index 6e943335f3..b760d54908 100644
--- a/rules.mak
+++ b/rules.mak
@@ -131,6 +131,11 @@ modules:
 # If called with only a single argument, will print nothing in quiet mod=
e.
 quiet-command =3D $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && =
$1, @$1))
=20
+makeflags_ =3D $(makeflags_0)
+makeflags_0 =3D --no-print-directory -s
+makeflags_1 =3D
+MAKEFLAGS +=3D $(makeflags_$(V))
+
 # cc-option
 # Usage: CFLAGS+=3D$(call cc-option, -falign-functions=3D0, -malign-func=
tions=3D0)
=20
--=20
2.15.1.355.g36791d7216

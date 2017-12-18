Received: from eggs.gnu.org ([2001:4830:134:3::10]:44182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eQzFG-0002YR-7d
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eQzFE-0004bR-2q
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eQzFD-0004Zk-SQ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:27 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Dec 2017 18:30:19 +0100
Message-Id: <20171218173023.21417-7-armbru@redhat.com>
In-Reply-To: <20171218173023.21417-1-armbru@redhat.com>
References: <20171218173023.21417-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/10] qemu-options: Polish section "TPM device
 options"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>

Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-options.hx | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index a173378d98..372cbabb7f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2927,19 +2927,18 @@ The general form of a TPM device option is:
=20
 @item -tpmdev @var{backend} ,id=3D@var{id} [,@var{options}]
 @findex -tpmdev
-Backend type must be either one of the following:
-@option{passthrough}, @option{emulator}.
=20
 The specific backend type will determine the applicable options.
 The @code{-tpmdev} option creates the TPM backend and requires a
 @code{-device} option that specifies the TPM frontend interface model.
=20
-Options to each backend are described below.
+Use @code{-tpmdev help} to print all available TPM backend types.
=20
-Use 'help' to print all available TPM backend types.
-@example
-qemu -tpmdev help
-@end example
+@end table
+
+The available backends are:
+
+@table @option
=20
 @item -tpmdev passthrough, id=3D@var{id}, path=3D@var{path}, cancel-path=
=3D@var{cancel-path}
=20
@@ -2992,10 +2991,11 @@ To create a TPM emulator backend device with char=
dev socket backend:
=20
 @end example
=20
+ETEXI
+
+STEXI
 @end table
-
 ETEXI
-
 DEFHEADING()
=20
 #endif
--=20
2.13.6

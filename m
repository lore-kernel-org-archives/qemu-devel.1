Received: from eggs.gnu.org ([2001:4830:134:3::10]:58692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dIfMz-0006jT-6y
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dIfMy-0004Ar-CN
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:07:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dIfMy-0004AT-6T
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:07:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  7 Jun 2017 19:07:33 +0100
Message-Id: <20170607180736.11011-3-stefanha@redhat.com>
In-Reply-To: <20170607180736.11011-1-stefanha@redhat.com>
References: <20170607180736.11011-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 2/5] coccinelle: fix typo in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/coccinelle/return_directly.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/return_directly.cocci b/scripts/coccinell=
e/return_directly.cocci
index 48680f2..4cf50e7 100644
--- a/scripts/coccinelle/return_directly.cocci
+++ b/scripts/coccinelle/return_directly.cocci
@@ -1,4 +1,4 @@
-// replace 'R =3D X; return R;' with 'return R;'
+// replace 'R =3D X; return R;' with 'return X;'
 @@
 identifier VAR;
 expression E;
--=20
2.9.4

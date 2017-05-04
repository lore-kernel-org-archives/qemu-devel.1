Received: from eggs.gnu.org ([2001:4830:134:3::10]:56294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic0-00022F-FK
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ibx-0008EV-2c
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6Ibw-0008Dl-RN
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D28E9804E4
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  4 May 2017 17:23:38 +0200
Message-Id: <1493911445-19568-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1493911445-19568-1-git-send-email-armbru@redhat.com>
References: <1493911445-19568-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/28] tests/check-qdict: Fix missing brackets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Gcc 7 (on Fedora 26) spotted odd use of integers instead of a
boolean; it's got a point.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170406154107.9178-1-dgilbert@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qdict.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index 81162ee..6f3fbcf 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -559,7 +559,7 @@ static void qdict_join_test(void)
         g_assert(qdict_size(dict1) =3D=3D 2);
         g_assert(qdict_size(dict2) =3D=3D !overwrite);
=20
-        g_assert(qdict_get_int(dict1, "foo") =3D=3D overwrite ? 84 : 42)=
;
+        g_assert(qdict_get_int(dict1, "foo") =3D=3D (overwrite ? 84 : 42=
));
         g_assert(qdict_get_int(dict1, "bar") =3D=3D 23);
=20
         if (!overwrite) {
--=20
2.7.4

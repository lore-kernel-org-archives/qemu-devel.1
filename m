Received: from eggs.gnu.org ([2001:4830:134:3::10]:49227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcN-0007Tm-Jx
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcL-0004yN-2J
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49338 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0pcK-0004y8-Tt
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 887324072CF5
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 14:30:28 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Mar 2018 09:30:07 -0500
Message-Id: <20180327143014.1767669-8-eblake@redhat.com>
In-Reply-To: <20180327143014.1767669-1-eblake@redhat.com>
References: <20180327143014.1767669-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/14] qapi: restrict allow-oob value to be
 "true"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

It was missed in the first version of OOB series.  We should check this
to make sure we throw the right error when fault value is passed in.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180326063901.27425-5-peterx@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 2c05e3c2845..3e14bc41f2c 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -872,7 +872,7 @@ def check_keys(expr_elem, meta, required, optional=3D=
[]):
             raise QAPISemError(info,
                                "'%s' of %s '%s' should only use false va=
lue"
                                % (key, meta, name))
-        if key =3D=3D 'boxed' and value is not True:
+        if (key =3D=3D 'boxed' or key =3D=3D 'allow-oob') and value is n=
ot True:
             raise QAPISemError(info,
                                "'%s' of %s '%s' should only use true val=
ue"
                                % (key, meta, name))
--=20
2.14.3

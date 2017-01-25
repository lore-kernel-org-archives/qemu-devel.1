Received: from eggs.gnu.org ([2001:4830:134:3::10]:49456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cWNEL-0001Ph-7E
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:03:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cWNEI-0000Dt-0G
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:03:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cWNEH-0000DZ-Rc
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:03:13 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2BC283F3E
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 13:03:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 25 Jan 2017 17:03:06 +0400
Message-Id: <20170125130308.16104-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] qapi2texi: add type information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The type information was dropped from v6 of the "qapi doc generation"
series, since the syntax being used was still under discussion.

However, the documentation without the type information is incomplete
and you have to refer to the json schema for the details. With type
information, you can hopefully only use the generated documentation.

See the second patch summary for a short description of the syntax.

Marc-Andr=C3=A9 Lureau (2):
  qapi2texi: change texi formatters
  qapi2texi: produce type information

 scripts/qapi2texi.py | 114 ++++++++++++++++++++++++++++++++++++++-------=
------
 1 file changed, 85 insertions(+), 29 deletions(-)

--=20
2.11.0.295.gd7dffce1c

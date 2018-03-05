Received: from eggs.gnu.org ([2001:4830:134:3::10]:49735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1estwA-00077d-Q1
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:30:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1estw9-0004zG-0B
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:30:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37492 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1estw8-0004qs-Rk
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:30:08 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E8AAD142B
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 17:29:58 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  5 Mar 2018 18:29:47 +0100
Message-Id: <20180305172951.2150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] qapi: generate a literal qobject for
 introspection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

This is a small series of a few preliminary patches taken off the
"[PATCH v4 00/51]" qapi-conditional series that were already reviewed
by Markus. They are improvements worthwhile for 2.12 inclusion.

Marc-Andr=C3=A9 Lureau (4):
  qapi2texi: minor python code simplification
  qlit: use QType instead of int
  qlit: add qobject_from_qlit()
  qapi: generate a literal qobject for introspection

 scripts/qapi/doc.py                |  7 ++-
 scripts/qapi/introspect.py         | 76 +++++++++++++++++-------------
 include/qapi/qmp/qlit.h            |  4 +-
 monitor.c                          |  2 +-
 qobject/qlit.c                     | 37 +++++++++++++++
 tests/check-qlit.c                 | 28 +++++++++++
 tests/test-qobject-input-visitor.c | 11 +++--
 docs/devel/qapi-code-gen.txt       | 29 ++++++++----
 8 files changed, 141 insertions(+), 53 deletions(-)

--=20
2.16.2.346.g9779355e34

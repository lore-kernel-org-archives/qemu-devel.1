Received: from eggs.gnu.org ([2001:4830:134:3::10]:34513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fqiPa-0004jX-Mu
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fqiPW-0005EB-GI
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:19:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60740 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fqiPW-0005Cr-BI
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:19:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5D0726364
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 17:19:41 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Aug 2018 19:19:30 +0200
Message-Id: <20180817171932.31976-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] Remainder of "Simplify qobject refcount"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

"qobject: modify qobject_ref() to assert on NULL" was left out during
the merge of "Simplify qobject refcount" series. Rebased, and added a
preliminary simplification patch.

thanks

Marc-Andr=C3=A9 Lureau (2):
  qdict: add qdict_steal()
  qobject: modify qobject_ref() to assert on NULL

 include/qapi/qmp/qdict.h   |  1 +
 include/qapi/qmp/qobject.h |  7 ++++---
 block.c                    |  6 ++++--
 block/blkdebug.c           |  3 ++-
 block/quorum.c             |  3 ++-
 monitor.c                  |  5 ++---
 qobject/block-qdict.c      |  7 ++-----
 qobject/qdict.c            | 22 ++++++++++++++++++++++
 8 files changed, 39 insertions(+), 15 deletions(-)

--=20
2.18.0.547.g1d89318c48

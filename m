Received: from eggs.gnu.org ([2001:4830:134:3::10]:37244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6GHM-0000N0-6Q
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6GHH-0006Do-Bi
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:54:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d6GHH-0006DO-5F
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:54:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29D7061D0F
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 12:54:37 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 May 2017 16:54:28 +0400
Message-Id: <20170504125432.21653-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] qmp-shell: learn to connect to qemu-ga
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

Hi,

This series adds a -N option to skip negotiate phase that qemu-ga
doesn't implement. This allows to use qmp-shell with qemu-ga for
testing.

Marc-Andr=C3=A9 Lureau (4):
  qmp-shell: add -N option to skip negotiate
  qmp-shell: ignore query-commands error
  qmp-shell: don't show version greeting if unavailable
  qmp-shell: improve help

 scripts/qmp/qmp-shell | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

--=20
2.12.0.191.gc5d8de91d

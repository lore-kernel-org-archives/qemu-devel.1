Received: from eggs.gnu.org ([2001:4830:134:3::10]:42511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e2kU7-0001XF-Jr
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e2kU3-0000Xj-AM
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:53:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e2kU3-0000Wh-5C
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:53:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C8CC2D0FA6
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 20:53:34 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 12 Oct 2017 22:53:26 +0200
Message-Id: <20171012205330.29942-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] vhost-user patches
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

The following changes since commit a0b261db8c030813e30a39eae47359ac2a37f7=
e2:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-re=
quest' into staging (2017-10-12 10:02:09 +0100)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/vu-pull-request

for you to fetch changes up to 13384f158ce043744cf7542162a34953c7e05a70:

  libvhost-user: Support VHOST_USER_SET_SLAVE_REQ_FD (2017-10-12 16:57:50=
 +0200)

----------------------------------------------------------------

----------------------------------------------------------------

Dr. David Alan Gilbert (4):
  libvhost-user: vu_queue_started
  vhost-user-bridge: Only process received packets on started queues
  libvhost-user: Update and fix feature and request lists
  libvhost-user: Support VHOST_USER_SET_SLAVE_REQ_FD

 contrib/libvhost-user/libvhost-user.h | 19 +++++++++++++++-
 contrib/libvhost-user/libvhost-user.c | 43 +++++++++++++++++++++++++++++=
+-----
 tests/vhost-user-bridge.c             |  1 +
 3 files changed, 56 insertions(+), 7 deletions(-)

--=20
2.15.0.rc0.40.gaefcc5f6f

Received: from eggs.gnu.org ([2001:4830:134:3::10]:34705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cfnxC-0007hy-Ve
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:24:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cfnx8-0007lA-7n
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:24:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cfnx8-0007ku-20
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:24:30 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DFC74E4F2
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 13:24:30 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 20 Feb 2017 14:24:23 +0100
Message-Id: <1487597065-27023-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] ui patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

  Hi,

Two little patches for opengl support.

please pull,
  Gerd

The following changes since commit ad584d37f2a86b392c25f3f00cc1f1532676c2=
d1:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2017-02-16 17:46:52 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-ui-20170220-1

for you to fetch changes up to 0ea1523fb6703aa0dcd65e66b59e96fec028e60a:

  egl-helpers: Support newer MESA versions (2017-02-20 12:46:09 +0100)

----------------------------------------------------------------
ui: opengl fixes, for spice and egl-helpers.

----------------------------------------------------------------
Frediano Ziglio (1):
      egl-helpers: Support newer MESA versions

Marc-Andr=C3=A9 Lureau (1):
      spice: allow to specify drm rendernode

 include/ui/egl-helpers.h |  3 +--
 qemu-options.hx          |  6 +++++-
 ui/egl-helpers.c         | 14 +++++++++++---
 ui/spice-core.c          |  5 ++++-
 4 files changed, 21 insertions(+), 7 deletions(-)

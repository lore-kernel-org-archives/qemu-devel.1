Received: from eggs.gnu.org ([2001:4830:134:3::10]:49972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dz6Bi-0001fr-LT
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dz6Bf-0000Nt-FF
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:15:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dz6Bf-0000Mg-8T
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:15:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD1B0128B
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 19:15:29 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon,  2 Oct 2017 20:15:17 +0100
Message-Id: <20171002191521.15748-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] Small vhost-user fixes and tweaks
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com
List-ID: <qemu-devel.nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This set has a small set of fixes for vhost-user and also
  enables the SET_SLAVE_REQ_FD feature in libvhost-user.
  (Where it just stashes the fd).

Dave

Dr. David Alan Gilbert (4):
  libvhost-user: vu_queue_started
  vhost-user-bridge: Only process received packets on started queues
  libvhost-user: Update and fix feature and request lists
  libvhost-user: Support VHOST_USER_SET_SLAVE_REQ_FD

 contrib/libvhost-user/libvhost-user.c | 43 +++++++++++++++++++++++++++++=
+-----
 contrib/libvhost-user/libvhost-user.h | 19 +++++++++++++++-
 tests/vhost-user-bridge.c             |  1 +
 3 files changed, 56 insertions(+), 7 deletions(-)

--=20
2.13.6

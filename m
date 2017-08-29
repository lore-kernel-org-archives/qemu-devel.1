Received: from eggs.gnu.org ([2001:4830:134:3::10]:45784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dmiQy-0007oq-Su
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dmiQv-0001dU-Pj
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:28:08 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 29 Aug 2017 17:27:49 +0200
Message-Id: <20170829152751.3174-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] vhost-user-bridge reconnect regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: victork@redhat.com, qemu-stable@nongnu.org, mst@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

libvhost-user doesn't support resuming with the same trick vubr had
since commit 523b018dde3b7650fe5401d0499b30cf2f117515. The following
two patches fix that regression.

Thanks

Marc-Andr=C3=A9 Lureau (2):
  libvhost-user: support resuming vq->last_avail_idx based on used_idx
  vhost-user-bridge: fix resume regression (since 2.9)

 contrib/libvhost-user/libvhost-user.h |  7 +++++++
 contrib/libvhost-user/libvhost-user.c | 13 +++++++++++++
 tests/vhost-user-bridge.c             |  7 +++++++
 3 files changed, 27 insertions(+)

--=20
2.14.1.146.gd35faa819

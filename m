Received: from eggs.gnu.org ([2001:4830:134:3::10]:47877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctGiv-0004K5-ML
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctGiu-00069Z-Tn
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:45:29 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 29 Mar 2017 18:45:12 +0200
Message-Id: <1490805920-17029-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [for-2.9 0/8] Fixes and cleanups around SocketAddress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pbonzini@redhat.com

What makes this 2.9 material is the crash bug fixed in PATCH 2 and the
QAPI/QMP interface cleanups in PATCH 7+8.

Sheepdog tests still in progress (with Kashyap's help), but I'm
sending this out now in the hope of getting a head start on review.

Markus Armbruster (8):
  nbd sockets vnc: Mark problematic address family tests TODO
  char: Fix socket with "type": "vsock" address
  io vnc sockets: Clean up SocketAddressKind switches
  block: Document -drive problematic code and bugs
  gluster: Prepare for SocketAddressFlat extension
  qapi-schema: SocketAddressFlat variants 'vsock' and 'fd'
  nbd: Tidy up blockdev-add interface
  sheepdog: Fix blockdev-add

 block.c               |  41 ++++++++++++++-
 block/file-posix.c    |   6 +++
 block/gluster.c       |  28 ++++++----
 block/nbd.c           | 140 ++++++++++++++++++++++++++++++++++++++++----=
------
 block/nfs.c           |   7 +++
 block/rbd.c           |   6 +++
 block/sheepdog.c      |  18 +++----
 block/ssh.c           |   8 +++
 blockdev-nbd.c        |   1 +
 chardev/char-socket.c |   9 ++--
 io/dns-resolver.c     |   6 ++-
 qapi-schema.json      |  19 +++----
 qapi/block-core.json  |   6 +--
 ui/vnc.c              |  11 +++-
 util/qemu-sockets.c   |   8 +--
 15 files changed, 241 insertions(+), 73 deletions(-)

--=20
2.7.4

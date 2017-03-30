Received: from eggs.gnu.org ([2001:4830:134:3::10]:58797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctZvD-0002jb-5V
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctZv8-0002X5-BN
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:15:27 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 30 Mar 2017 15:14:57 +0200
Message-Id: <1490879707-6060-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v2 for-2.9 00/10] Fixes and cleanups around
 SocketAddress
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

This is RFC because:

1. To give you one more chance to ask for undocumented -drive
   driver=3Dnbd usage compatibility [PATCH 08+09].

2. Another round of sheepdog tests is still in progress (with
   Kashyap's help).

Max, please have a close look at PATCH 11, I hope this is what you
meant when you asked for "parsing @server".

v2:
* PATCH 01+02+04+05 unchanged.
* PATCH 03 error message improved, blank line [Max]
* PATCH 06 commit message typo [Max]
* PATCH 07 new, factored out of old PATCH 7
* PATCH 08-10 updated, please re-review

Markus Armbruster (10):
  nbd sockets vnc: Mark problematic address family tests TODO
  char: Fix socket with "type": "vsock" address
  io vnc sockets: Clean up SocketAddressKind switches
  block: Document -drive problematic code and bugs
  gluster: Prepare for SocketAddressFlat extension
  qapi-schema: SocketAddressFlat variants 'vsock' and 'fd'
  sockets: New helper socket_address_crumple()
  nbd: Tidy up blockdev-add interface
  squash! nbd: Tidy up blockdev-add interface
  sheepdog: Fix blockdev-add

 block.c                | 41 ++++++++++++++++++++++--
 block/file-posix.c     |  6 ++++
 block/gluster.c        | 28 +++++++++++------
 block/nbd.c            | 62 ++++++++++++++++++++++---------------
 block/nfs.c            |  7 +++++
 block/rbd.c            |  6 ++++
 block/sheepdog.c       | 84 +++++++++++++++++++++++++++++++++-----------=
------
 block/ssh.c            |  8 +++++
 blockdev-nbd.c         |  1 +
 chardev/char-socket.c  |  9 ++++--
 include/qemu/sockets.h | 11 +++++++
 io/dns-resolver.c      |  7 +++--
 qapi-schema.json       | 19 +++++-------
 qapi/block-core.json   |  6 ++--
 ui/vnc.c               | 19 ++++++++----
 util/qemu-sockets.c    | 37 ++++++++++++++++++++--
 16 files changed, 258 insertions(+), 93 deletions(-)

--=20
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:39412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIjm-0003rc-TU
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIjj-0003hS-1g
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:51:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cZIji-0003gt-SI
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:51:46 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 497D380462
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 14:51:46 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  2 Feb 2017 18:51:19 +0400
Message-Id: <20170202145141.17138-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/22] chardev clean-ups & tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

The following series contains various patches:
- chardev and other clean-ups
- replace "chardevs" list for a /chardevs container object
- add a few read-only socket properties mainly useful for testing
- add various chardev tests

This series is part of a larger refactoring series that I try to keep
up to date here: https://github.com/elmarco/qemu/commits/chrfe

Marc-Andr=C3=A9 Lureau (22):
  char: remove qemu_chr_be_generic_open
  mux: simplfy muxes_realize_done
  xen: use a better chardev type check
  container: don't leak container reference
  main: free root container
  char: add a /chardevs container
  char: use /chardevs container instead of chardevs list
  char: remove qemu_chardev_add
  char: remove chardevs list
  char: useless NULL check
  qcow2: remove useless NULL check
  char-socket: introduce update_disconnected_filename()
  char-socket: update local address after listen
  char-socket: add 'addr' property
  char-socket: add 'connected' property
  char-udp: flush as much buffer as possible
  tests: add alias check in /char/ringbuf
  tests: add /char/pipe test
  tests: add /char/file test
  tests: add /char/socket test
  tests: add /char/udp test
  tests: add /char/console test

 chardev/char-mux.h    |   2 +-
 include/sysemu/char.h |  12 +-
 block/qcow2.c         |   4 +-
 chardev/char-mux.c    |  11 +-
 chardev/char-pty.c    |   2 +-
 chardev/char-socket.c |  46 ++++++-
 chardev/char-udp.c    |  26 ++--
 chardev/char.c        | 161 +++++++++++------------
 gdbstub.c             |   2 +-
 hw/bt/hci-csr.c       |   2 +-
 qom/container.c       |   1 +
 tests/test-char.c     | 358 ++++++++++++++++++++++++++++++++++++++++++++=
+++++-
 ui/console.c          |   2 +-
 ui/gtk.c              |   2 +-
 vl.c                  |   2 +-
 xen-common.c          |   2 +-
 16 files changed, 510 insertions(+), 125 deletions(-)

--=20
2.11.0.295.gd7dffce1c.dirty

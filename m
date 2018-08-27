Received: from eggs.gnu.org ([2001:4830:134:3::10]:56450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fuPv2-0003eE-Rl
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 18:23:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fuPux-0005X5-S9
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 18:23:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49518 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fuPux-0005Uu-NY
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 18:23:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 059EA26352
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 22:23:26 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 28 Aug 2018 00:23:13 +0200
Message-Id: <20180827222322.26009-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/9] chardev: various cleanups and improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

Some chardev-related patches I have accumulated.
Please review, thanks!

Marc-Andr=C3=A9 Lureau (9):
  char.h: fix gtk-doc comment style
  chardev: mark the calls that allow an implicit mux monitor
  chardev: use a child source for qio input source
  char: update the mux hanlders in class callback
  char-fe: set_handlers() needs an associted chardev
  terminal3270: do not use backend timer sources
  chardev: add a note about frontend sources and context switch
  char-pty: remove check for connection on write
  char-pty: remove write_lock usage

 include/chardev/char-fe.h  | 84 ++++++++++++++++++--------------------
 include/chardev/char-mux.h |  1 -
 include/chardev/char.h     | 81 +++++++++++++++++++-----------------
 chardev/char-fe.c          | 11 +----
 chardev/char-io.c          | 48 +++-------------------
 chardev/char-mux.c         |  5 ++-
 chardev/char-pty.c         | 56 ++-----------------------
 chardev/char.c             | 32 +++++++++++----
 gdbstub.c                  |  6 ++-
 hw/char/terminal3270.c     | 15 +++----
 hw/char/xen_console.c      |  5 ++-
 net/slirp.c                |  5 ++-
 vl.c                       | 10 ++---
 13 files changed, 145 insertions(+), 214 deletions(-)

--=20
2.18.0.547.g1d89318c48

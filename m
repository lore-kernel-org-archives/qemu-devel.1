Received: from eggs.gnu.org ([209.51.188.92]:33410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grRF1-0005uJ-Bd
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:44:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grREx-0004TG-In
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:44:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1grREv-0003x8-Hw
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:44:01 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A5AE804E9
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 17:43:34 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  6 Feb 2019 18:43:22 +0100
Message-Id: <20190206174328.9736-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/6] chardev: various cleanups and
 improvements (resend)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

Some chardev-related patches I have accumulated.
Please review, thanks!

v2:
- rebased
- update commit messages

Marc-Andr=C3=A9 Lureau (6):
  char: update the mux handlers in class callback
  char-fe: set_handlers() needs an associated chardev
  terminal3270: do not use backend timer sources
  chardev: add a note about frontend sources and context switch
  char-pty: remove the check for connection on write
  char-pty: remove write_lock usage

 include/chardev/char-fe.h  |  5 ++--
 include/chardev/char-mux.h |  1 -
 chardev/char-fe.c          | 11 +-------
 chardev/char-mux.c         |  5 ++--
 chardev/char-pty.c         | 56 +++-----------------------------------
 hw/char/terminal3270.c     | 15 ++++------
 6 files changed, 17 insertions(+), 76 deletions(-)

--=20
2.20.1.519.g8feddda32c

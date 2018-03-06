Received: from eggs.gnu.org ([2001:4830:134:3::10]:41440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et5EK-0000rt-QF
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:33:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et5EH-0006hA-NY
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:33:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41340 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1et5EH-0006gm-Jn
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:33:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8821C4021CCA
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 05:33:33 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue,  6 Mar 2018 13:33:11 +0800
Message-Id: <20180306053320.15401-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/9] chardev: qio related non-default
 context support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Based-on: <20180305064324.9238-1-peterx@redhat.com>

This series is based on the QIO part:
  [PATCH v3 0/6] qio: general non-default GMainContext support

v2:
- fix the reported problem by patchew in patch 5
- added some r-bs from Marc-Andre

Please review, thanks.

Peter Xu (9):
  vl: export machine_init_done
  chardev: fix leak in tcp_chr_telnet_init_io()
  chardev: update net listener gcontext
  chardev: allow telnet gsource to switch gcontext
  chardev: introduce chr_machine_done hook
  chardev: use chardev's gcontext for async connect
  chardev: tcp: postpone async connection setup
  chardev: tcp: let TLS run on chardev context
  chardev: tcp: postpone TLS work until machine done

 chardev/char-mux.c         |  33 ++++++++--
 chardev/char-socket.c      | 153 ++++++++++++++++++++++++++++++++++-----=
------
 chardev/char.c             |  43 +++++--------
 include/chardev/char-mux.h |   2 -
 include/chardev/char.h     |   2 +
 include/sysemu/sysemu.h    |   2 +
 stubs/machine-init-done.c  |   2 +
 tests/test-char.c          |   1 -
 vl.c                       |   4 +-
 9 files changed, 169 insertions(+), 73 deletions(-)

--=20
2.14.3

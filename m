Received: from eggs.gnu.org ([2001:4830:134:3::10]:46541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esjxa-0007UI-Oo
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:50:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esjxZ-0001VT-82
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:50:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57622 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1esjxZ-0001Ud-3O
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:50:57 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 81E3A402291E
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 06:50:48 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  5 Mar 2018 14:50:31 +0800
Message-Id: <20180305065040.10353-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/9] chardev: qio related non-default context
 support
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

And it is splitted out from version 2 of the QIO series V2:

  http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg00016.html

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

 chardev/char-mux.c        |  33 ++++++++--
 chardev/char-socket.c     | 153 ++++++++++++++++++++++++++++++++++------------
 chardev/char.c            |  43 ++++++-------
 include/chardev/char.h    |   2 +
 include/sysemu/sysemu.h   |   2 +
 stubs/machine-init-done.c |   2 +
 vl.c                      |   4 +-
 7 files changed, 169 insertions(+), 70 deletions(-)

-- 
2.14.3

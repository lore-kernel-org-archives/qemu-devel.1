Received: from eggs.gnu.org ([2001:4830:134:3::10]:38386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ffPTD-0002zD-6j
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ffPTA-0000vn-5X
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:52:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50496 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ffPT9-0000uz-W6
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:52:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF1BC402315B
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:52:42 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Jul 2018 14:52:36 +0200
Message-Id: <20180717125239.22517-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] chardev: fix setting FD_PASS for socket
 type=fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

This is an alternative series from Daniel "[PATCH] chardev:
unconditionally set FD_PASS feature for socket type=3Dfd".

Instead of unconditionally set FD_PASS feature for any socket address
which has type=3D=3Dfd, we can rely on QIO synchronized initialization an=
d
feature check, as long as "reconnect" option is not provided. The
first 2 patches enforce this case is not supported, as it could give
unexpected or surprising results.

Marc-Andr=C3=A9 Lureau (3):
  char-socket: correctly set has_reconnect when parsing QemuOpts
  char-socket: make 'fd' incompatible with 'reconnect'
  char-socket: delay setting fd-pass feature until connected

 chardev/char-socket.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--=20
2.18.0.129.ge3331758f1

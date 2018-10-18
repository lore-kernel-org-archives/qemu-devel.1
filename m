Received: from eggs.gnu.org ([2001:4830:134:3::10]:38319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gDGtC-0007Vt-Nb
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 18:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gDGt8-00033u-Ny
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 18:35:34 -0400
Received: from smtp50.i.mail.ru ([94.100.177.110]:52460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1gDGt4-0002o8-Mo
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 18:35:28 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Fri, 19 Oct 2018 01:34:58 +0300
Message-Id: <20181018223501.21683-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v3 0/3] chardev: Add websocket support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

v3:
    * Refactoring moved to a separate patch [Daniel]
    * "websock" option renamed to "websocket" [Stefan]
    * Added documentation [Daniel]
v2:
    * Fixed initialization order [Daniel]
    * Function arguments refactoring [Paolo]
    * Added test [Stefan]
    * Added meaningful error message [Stefan]
    * Added "websock:" URI prefix support

Julia Suvorova (3):
  chardev/char-socket: Function headers refactoring
  chardev: Add websocket support
  tests/test-char: Check websocket chardev functionality

 chardev/char-socket.c | 117 ++++++++++++++++++++++++++++-----------
 chardev/char.c        |   8 ++-
 qapi/char.json        |   3 +
 qemu-options.hx       |  13 ++++-
 tests/test-char.c     | 125 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 231 insertions(+), 35 deletions(-)

-- 
2.17.1

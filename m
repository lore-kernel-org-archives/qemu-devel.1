Received: from eggs.gnu.org ([2001:4830:134:3::10]:57524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fuMSR-00013X-4l
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 14:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fuMS8-0007Pk-20
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 14:41:37 -0400
Received: from smtp58.i.mail.ru ([217.69.128.38]:38584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fuMS4-0007AG-Ee
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 14:41:27 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Mon, 27 Aug 2018 21:41:01 +0300
Message-Id: <20180827184103.32190-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v2 0/2] chardev: Add websocket support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

v2:
    * Fixed initialization order [Daniel]
    * Function arguments refactoring [Paolo]
    * Added test [Stefan]
    * Added meaningful error message [Stefan]
    * Added "websock:" URI prefix support

Julia Suvorova (2):
  chardev: Add websocket support
  tests/test-char: Check websocket chardev functionality

 chardev/char-socket.c | 124 ++++++++++++++++++++++++++++++-----------
 chardev/char.c        |   8 ++-
 qapi/char.json        |   3 +
 tests/test-char.c     | 125 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 228 insertions(+), 32 deletions(-)

-- 
2.17.1

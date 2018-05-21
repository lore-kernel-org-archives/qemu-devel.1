Received: from eggs.gnu.org ([2001:4830:134:3::10]:50638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1fKjoL-0002Fb-7n
	for qemu-devel@nongnu.org; Mon, 21 May 2018 08:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1fKjoK-0007lY-C0
	for qemu-devel@nongnu.org; Mon, 21 May 2018 08:21:09 -0400
Received: from ssl.serverraum.org ([2a01:4f8:222:d45::1:2]:42659)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1fKjoK-0007l6-1N
	for qemu-devel@nongnu.org; Mon, 21 May 2018 08:21:08 -0400
From: Michael Walle <michael@walle.cc>
Date: Mon, 21 May 2018 14:20:58 +0200
Message-Id: <20180521122100.22602-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] BQL patches for the lm32 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>

Whoops, forget the include patch chunk for the second patch.

I'll send a pull request next week if there are no comments on the
patches.

since v1:
  add missing #include

Michael Walle (2):
  lm32: take BQL before writing IP/IM register
  target/lm32: hold BQL in gdbstub

 target/lm32/gdbstub.c   | 5 +++++
 target/lm32/op_helper.c | 4 ++++
 2 files changed, 9 insertions(+)

--=20
2.11.0

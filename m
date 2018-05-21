Received: from eggs.gnu.org ([2001:4830:134:3::10]:44197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1fKjNX-0007A4-7u
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1fKjNS-0005WC-HW
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:53:27 -0400
Received: from ssl.serverraum.org ([213.133.101.245]:60575)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1fKjNS-0005Vr-As
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:53:22 -0400
From: Michael Walle <michael@walle.cc>
Date: Mon, 21 May 2018 13:52:50 +0200
Message-Id: <20180521115252.10759-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] BQL patches for the lm32 target
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

I'll send a pull request next week if there are no comments on the
patches.

Michael Walle (2):
  lm32: take BQL before writing IP/IM register
  target/lm32: hold BQL in gdbstub

 target/lm32/gdbstub.c   | 4 ++++
 target/lm32/op_helper.c | 4 ++++
 2 files changed, 8 insertions(+)

--=20
2.11.0

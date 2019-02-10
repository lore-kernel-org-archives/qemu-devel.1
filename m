Received: from eggs.gnu.org ([209.51.188.92]:60274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1gsxLD-0005zx-Tj
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 17:12:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1gsxLA-0003an-T2
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 17:12:47 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:42705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1gsxL5-0003GZ-K5
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 17:12:41 -0500
Received: by mail-ot1-x32e.google.com with SMTP id i5so3959283oto.9
	for <qemu-devel@nongnu.org>; Sun, 10 Feb 2019 14:12:23 -0800 (PST)
MIME-Version: 1.0
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Sun, 10 Feb 2019 23:12:11 +0100
Message-ID: <CABLmASFLwswYELUGHKjZct6XnEYb4tKn1XEuCAgwniN7NM110g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Bug: Lost slirp functionality on qemu-system-ppc build
 for windows.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>

Hi,

I just cross compiled Qemu-system-ppc for Windows on Fedora 29 and
discovered slirp does not work anymore. Tap networking works fine.
Bisecting got me here:

a9d8b3ec4385793815d7121785730422fa3dfb68 is the first bad commit
commit a9d8b3ec4385793815d7121785730422fa3dfb68
Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Date:   Thu Jan 17 15:43:52 2019 +0400

    slirp: replace remaining qemu headers dependency

    Except for the migration code which is gated by WITH_QEMU, only
    include our own headers, so libslirp can be built standalone.

    Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
    Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

:040000 040000 cd06df21ed96497cd12f2a20adb3d66cb0da8010
ab5afd3f50910e39b2b700722cd47de8f0cf9e2c M    slirp


Best,
Howard

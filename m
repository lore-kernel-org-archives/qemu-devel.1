Received: from eggs.gnu.org ([2001:4830:134:3::10]:37488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1fOh6M-0002O9-Le
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 06:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1fOh6L-0008Vc-MC
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 06:16:06 -0400
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:42380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1fOh6L-0008V2-GH
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 06:16:05 -0400
Received: by mail-ot0-x229.google.com with SMTP id l13-v6so28686734otk.9
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 03:16:05 -0700 (PDT)
MIME-Version: 1.0
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Fri, 1 Jun 2018 16:15:52 +0600
Message-ID: <CANzW0muSNEuBquUdmU2E_vfpc6zTdsoQh6KG2ooQDBAwq12u6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] virtio-vsock feature has no TCG (non-KVM) support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Please, add important note to https://wiki.qemu.org/Features/VirtioVsock pa=
ge,
that this feature only supported in KVM accelerated mode. It's not obvious.
Furthermore, it isn't checked by qemu when invoking with "-device
vhost-vsock-pci,..." and user encounters this only when communicating (via
AF_VSOCK) application fails to connect() with weird "Connection timed out"
error.
--=20

=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
  =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=BD=
=D0=BA=D0=BE

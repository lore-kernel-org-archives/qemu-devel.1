Received: from eggs.gnu.org ([209.51.188.92]:36580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGLkf-0004aZ-Mk
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 06:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGLke-0002iI-JR
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 06:55:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:50834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hGLke-0002fu-Aw
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 06:55:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hGLkc-0001Si-SV
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 10:55:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D02C82E80C7
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 10:55:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Apr 2019 10:37:35 -0000
From: Prem Anand <1544524@bugs.launchpad.net>
Reply-To: Bug 1544524 <1544524@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160211115903.17778.55276.malonedeb@soybean.canonical.com>
Message-Id: <155541105529.21013.8091076072969556373.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1544524] Re: "info chardev" not showing the real
 port in use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Yes. This was fixed some time back and I can confirm it working with
qemu 2.8

QEMU 2.8.1 monitor - type 'help' for more information
(qemu) info chardev
parallel0: filename=3Dvc
serial0: filename=3Dtelnet:127.0.0.1:35293,server <-> 127.0.0.1:52820
compat_monitor0: filename=3Dstdio

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1544524

Title:
  "info chardev" not showing the real port in use

Status in QEMU:
  Fix Released

Bug description:
  With Qemu 2.1.2
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  pharidos@uks2:~$ qemu-system-x86_64 -hda Disk.qcow2 -serial telnet::0,ser=
ver,nowait -nographic
  QEMU 2.1.2 monitor - type 'help' for more information
  (qemu) info chardev
  parallel0: filename=3Dnull
  serial0: filename=3Dtelnet:0.0.0.0:44189,server
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^^^^^^^^^^^^^^^^^^^^^^^^^^^ serial cons=
ole is using port 44189
  compat_monitor0: filename=3Dstdio
  (qemu)

  With Qemu 2.5.0
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  pharidos@uks2:~$ qemu-system-x86_64 -hda Disk.qcow2 -serial  telnet::0,se=
rver,nowait -nographic
  QEMU 2.5.0 monitor - type 'help' for more information
  (qemu) info chardev
  parallel0: filename=3Dnull
  serial0: filename=3Ddisconnected:telnet::0,server
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ serial co=
nsole port not shown
  compat_monitor0: filename=3Dstdio
  (qemu)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1544524/+subscriptions

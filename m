Received: from eggs.gnu.org ([209.51.188.92]:56228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gpvcJ-0001we-P0
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 08:45:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gpvcI-0003as-LR
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 08:45:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:42632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gpvcI-0003OW-DC
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 08:45:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gpvbv-0006nl-Dw
	for <qemu-devel@nongnu.org>; Sat, 02 Feb 2019 13:45:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 682D22E80C7
	for <qemu-devel@nongnu.org>; Sat,  2 Feb 2019 13:45:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 Feb 2019 13:32:16 -0000
From: Richard Jones <rjones@redhat.com>
Reply-To: Bug 1814381 <1814381@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154911433612.20173.9806415794048827550.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1814381] [NEW] qemu can't resolve ::1 when no
 network is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

I'm not sure if this is a qemu thing or a getaddrinfo/glibc thing, or
even just something about my laptop.  However we have a test failure
in nbdkit which only occurs when my laptop is not connected to wifi or
other networking.  It boils down to:

=C2=A0=C2=A0$ qemu-img info --image-opts "file.driver=3Dnbd,file.host=3D::1=
,file.port=3D1234"
=C2=A0=C2=A0qemu-img: Could not open 'file.driver=3Dnbd,file.host=3D::1,fil=
e.port=3D1234': address resolution failed for ::1:1234: Address family for =
hostname not supported

In a successful case it should connect to a local NBD server on port
1234, but if you don't have that you will see:

=C2=A0=C2=A0qemu-img: Could not open
'file.driver=3Dnbd,file.host=3D::1,file.port=3D1234': Failed to connect
socket: Connection refused

I can =E2=80=98ping6 ::1=E2=80=99 fine.

It also works if I replace =E2=80=98::1=E2=80=99 with =E2=80=98localhost6=
=E2=80=99.

My /etc/hosts contains:

127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdoma=
in4
::1         localhost localhost.localdomain localhost6 localhost6.localdoma=
in6

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1814381

Title:
  qemu can't resolve ::1 when no network is available

Status in QEMU:
  New

Bug description:
  I'm not sure if this is a qemu thing or a getaddrinfo/glibc thing, or
  even just something about my laptop.  However we have a test failure
  in nbdkit which only occurs when my laptop is not connected to wifi or
  other networking.  It boils down to:

  =C2=A0=C2=A0$ qemu-img info --image-opts "file.driver=3Dnbd,file.host=3D:=
:1,file.port=3D1234"
  =C2=A0=C2=A0qemu-img: Could not open 'file.driver=3Dnbd,file.host=3D::1,f=
ile.port=3D1234': address resolution failed for ::1:1234: Address family fo=
r hostname not supported

  In a successful case it should connect to a local NBD server on port
  1234, but if you don't have that you will see:

  =C2=A0=C2=A0qemu-img: Could not open
  'file.driver=3Dnbd,file.host=3D::1,file.port=3D1234': Failed to connect
  socket: Connection refused

  I can =E2=80=98ping6 ::1=E2=80=99 fine.

  It also works if I replace =E2=80=98::1=E2=80=99 with =E2=80=98localhost6=
=E2=80=99.

  My /etc/hosts contains:

  127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdo=
main4
  ::1         localhost localhost.localdomain localhost6 localhost6.localdo=
main6

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1814381/+subscriptions

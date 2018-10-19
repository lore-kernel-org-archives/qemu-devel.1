Received: from eggs.gnu.org ([2001:4830:134:3::10]:58849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gDQxc-0007cq-Av
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gDQxW-0008Ai-PF
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:20:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:57018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gDQxW-00088M-H2
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:20:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gDQxV-0007gk-88
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 09:20:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 36E862E80C0
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 09:20:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Oct 2018 09:07:40 -0000
From: dcb <1798780@bugs.launchpad.net>
Reply-To: Bug 1798780 <1798780@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153994006052.15678.15962440455123359491.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1798780] [NEW] hw/usb/dev-mtp.c:1616: bad test ?
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

hw/usb/dev-mtp.c:1616:52: warning: logical =E2=80=98or=E2=80=99 of collecti=
vely
exhaustive tests is always true [-Wlogical-op]

Source code is

                if ((ret =3D=3D -1) && (errno !=3D EINTR || errno !=3D EAGA=
IN ||
                                    errno !=3D EWOULDBLOCK)) {

Maybe better code

                if ((ret =3D=3D -1) && (errno !=3D EINTR && errno !=3D EAGA=
IN &&
                                    errno !=3D EWOULDBLOCK)) {

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1798780

Title:
  hw/usb/dev-mtp.c:1616: bad test ?

Status in QEMU:
  New

Bug description:
  hw/usb/dev-mtp.c:1616:52: warning: logical =E2=80=98or=E2=80=99 of collec=
tively
  exhaustive tests is always true [-Wlogical-op]

  Source code is

                  if ((ret =3D=3D -1) && (errno !=3D EINTR || errno !=3D EA=
GAIN ||
                                      errno !=3D EWOULDBLOCK)) {

  Maybe better code

                  if ((ret =3D=3D -1) && (errno !=3D EINTR && errno !=3D EA=
GAIN &&
                                      errno !=3D EWOULDBLOCK)) {

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1798780/+subscriptions

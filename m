Received: from eggs.gnu.org ([2001:4830:134:3::10]:38188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYANF-0005j6-NR
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYAND-00007G-3B
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:16:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:41269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dYANC-00006w-TJ
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:16:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dYANB-0007SR-Fb
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 12:16:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 751442E807E
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 12:16:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Jul 2017 11:56:07 -0000
From: Thomas Huth <1196727@bugs.launchpad.net>
Reply-To: Bug 1196727 <1196727@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130701220319.19436.23553.malonedeb@chaenomeles.canonical.com>
Message-Id: <150055176790.24314.4415527643982016261.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1196727] Re: SLIRP on Windows 7 64-bit host or is
 it me?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... can you still reproduce this problem with
the latest version of QEMU (currently v2.9.0)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1196727

Title:
  SLIRP on Windows 7 64-bit host or is it me?

Status in QEMU:
  Incomplete

Bug description:
   Version: 1.5.1 and tried latest in Git, compiled for x86_64 Windows 64-b=
it
        Host: Windows 7 64-bit
      Guest: FreeBSD 9.1 i386, RHEL 6.4 x86_64, SLES 11.2 x86_64, OpenSUSE =
12.3 ppc64, Fedora 18 ppc64
   libiconv: 1.14
          glib: 2.28.8
  gettext: 0.18.1.1
   pixman: 0.30.0
     libSDL: 1.2.14
     Driver: virtio-net-pci
       Emu: full (non-KVM)

  I'm new to Windows 7 64-bit as a host for QEMU (previously I was
  running QEMU on Windows XP with no issues) so it could be me, now on
  Windows 7 SLIRP only works for me connecting internally from the host
  to the guest via SLIRP redirect, but any outbound requests from the
  guest to the Internet are failing with the following:

  if_start...
  m_get...
   m =3D 61f7bd40
  ip_input...
   m =3D 61f7bd40
   m_len =3D 48
  tcp_input...
   m =3D 61f7bd40  iphlen =3D 20  inso =3D 0
  tcp_fconnect...
   so =3D 33e140
   connect()ing, addr.sin_port=3D80, addr.sin_addr.s_addr=3D206.190.36.45
   tcp fconnect errno =3D 10035-Unknown error
  icmp_error...
   msrc =3D 61f7bd40
   msrc_len =3D 48
   10.0.2.5 to 206.190.36.45
  m_get...
   m =3D 61f7b6c0
  ip_output...
   so =3D 0
   m0 =3D 61f7b6c0
  if_output...
   so =3D 0
   ifm =3D 61f7b6c0
  if_start...
  arp_table_search...
   ip =3D 0x502000a
   found hw addr =3D 52:54:00:12:34:56
  m_free...
   m =3D 61f7b6c0
  tcp_close...
   tp =3D 377840
  m_free...
   m =3D 0
  m_free...
   m =3D 61f7bd40

  Am I doing something wrong with my Windows host configuration or is
  this a bug in SLIRP only on W64 and not W32?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1196727/+subscriptions

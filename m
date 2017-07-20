Received: from eggs.gnu.org ([2001:4830:134:3::10]:34431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYKjh-0001s9-Eb
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 19:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYKje-0000Yq-8q
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 19:20:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:50107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dYKje-0000YB-2h
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 19:19:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dYKjc-00036a-H5
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 23:19:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1C8452E80C7
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 23:19:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Jul 2017 23:03:25 -0000
From: Kenneth Salerno <kennethsalerno@yahoo.com>
Reply-To: Bug 1196727 <1196727@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130701220319.19436.23553.malonedeb@chaenomeles.canonical.com>
	<150055176790.24314.4415527643982016261.malone@soybean.canonical.com>
Message-Id: <2140528502.1970774.1500591805995@mail.yahoo.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1196727] Re: SLIRP on Windows 7 64-bit host
 or is it me?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi, you can close this ticket. I can't remember what I did to get it
working.

Sent from Yahoo Mail on Android =

 =

  On Thu, Jul 20, 2017 at 8:16 AM, Thomas Huth<1196727@bugs.launchpad.net> =
wrote:   Triaging old bug tickets ... can you still reproduce this problem =
with
the latest version of QEMU (currently v2.9.0)?

** Changed in: qemu
=C2=A0 =C2=A0 =C2=A0 Status: New =3D> Incomplete

-- =

You received this bug notification because you are subscribed to the bug
report.
https://bugs.launchpad.net/bugs/1196727

Title:
=C2=A0 SLIRP on Windows 7 64-bit host or is it me?

Status in QEMU:
=C2=A0 Incomplete

Bug description:
=C2=A0 Version: 1.5.1 and tried latest in Git, compiled for x86_64 Windows =
64-bit
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Host: Windows 7 64-bit
=C2=A0 =C2=A0 =C2=A0 Guest: FreeBSD 9.1 i386, RHEL 6.4 x86_64, SLES 11.2 x8=
6_64, OpenSUSE 12.3 ppc64, Fedora 18 ppc64
=C2=A0 libiconv: 1.14
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 glib: 2.28.8
=C2=A0 gettext: 0.18.1.1
=C2=A0 pixman: 0.30.0
=C2=A0 =C2=A0 libSDL: 1.2.14
=C2=A0 =C2=A0 Driver: virtio-net-pci
=C2=A0 =C2=A0 =C2=A0 Emu: full (non-KVM)

=C2=A0 I'm new to Windows 7 64-bit as a host for QEMU (previously I was
=C2=A0 running QEMU on Windows XP with no issues) so it could be me, now on
=C2=A0 Windows 7 SLIRP only works for me connecting internally from the host
=C2=A0 to the guest via SLIRP redirect, but any outbound requests from the
=C2=A0 guest to the Internet are failing with the following:

=C2=A0 if_start...
=C2=A0 m_get...
=C2=A0 m =3D 61f7bd40
=C2=A0 ip_input...
=C2=A0 m =3D 61f7bd40
=C2=A0 m_len =3D 48
=C2=A0 tcp_input...
=C2=A0 m =3D 61f7bd40=C2=A0 iphlen =3D 20=C2=A0 inso =3D 0
=C2=A0 tcp_fconnect...
=C2=A0 so =3D 33e140
=C2=A0 connect()ing, addr.sin_port=3D80, addr.sin_addr.s_addr=3D206.190.36.=
45
=C2=A0 tcp fconnect errno =3D 10035-Unknown error
=C2=A0 icmp_error...
=C2=A0 msrc =3D 61f7bd40
=C2=A0 msrc_len =3D 48
=C2=A0 10.0.2.5 to 206.190.36.45
=C2=A0 m_get...
=C2=A0 m =3D 61f7b6c0
=C2=A0 ip_output...
=C2=A0 so =3D 0
=C2=A0 m0 =3D 61f7b6c0
=C2=A0 if_output...
=C2=A0 so =3D 0
=C2=A0 ifm =3D 61f7b6c0
=C2=A0 if_start...
=C2=A0 arp_table_search...
=C2=A0 ip =3D 0x502000a
=C2=A0 found hw addr =3D 52:54:00:12:34:56
=C2=A0 m_free...
=C2=A0 m =3D 61f7b6c0
=C2=A0 tcp_close...
=C2=A0 tp =3D 377840
=C2=A0 m_free...
=C2=A0 m =3D 0
=C2=A0 m_free...
=C2=A0 m =3D 61f7bd40

=C2=A0 Am I doing something wrong with my Windows host configuration or is
=C2=A0 this a bug in SLIRP only on W64 and not W32?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1196727/+subscriptions

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

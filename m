Received: from eggs.gnu.org ([208.118.235.92]:35907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fve3s-0006iK-O2
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 03:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fve39-0007af-A3
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 03:41:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:53830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fve39-0007aY-3H
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 03:40:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fve37-0004Ct-U5
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 07:40:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D66142E80CC
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 07:40:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Aug 2018 07:33:31 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1787505 <1787505@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153446472677.27869.256879611828000197.malonedeb@chaenomeles.canonical.com>
	<153567644287.1705.5166937795587958652.malone@soybean.canonical.com>
Message-Id: <CAFEAcA9xKZg9XqBQvBWTrBK+rgTFb8b-JUQqv8W5h5BG58KDsQ@mail.gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1787505] Re: Solaris host: no network
 connection, mouse pointer mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 31 August 2018 at 01:47, Michele Denber <1787505@bugs.launchpad.net> wro=
te:
> Anyone?  I'm still trying to get my networking working.  On this page:
> https://en.wikibooks.org/wiki/QEMU/Networking#User_mode_networking, it
> says
>
> "The guest OS will see an E1000 NIC with a virtual DHCP server on
> 10.0.2.2 and will be allocated an address starting from 10.0.2.15. A
> virtual DNS server will be accessible on 10.0.2.3, and a virtual SAMBA
> file server (if present) will be accessible on 10.0.2.4 allowing you to
> access files on the host via SAMBA file shares."
>
> That's fine, but my LAN is on 192.186.0.x not, 10.2.0.x.  The following
> starts qemu but

10.0.2.x, and this is the "virtual" bit of network inside QEMU,
whose numbering is unrelated to your own network.

User questions probably are better on the mailing list, not
inside bug reports.

thanks
-- PMM

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1787505

Title:
  Solaris host: no network connection, mouse pointer mismatch

Status in QEMU:
  New

Bug description:
  This is probably a bit far afield but on a Solaris 10 SPARC host (Sun
  M3000) running a Windows XP guest like this:

  ./qemu-system-x86_64 -m 1024 -boot d  -smp 3 -net nic -net user -hda
  /bkpool/qemuimages/XP.img -cdrom /bkpool/qemuimages/xp.iso &

  the vnc server starts up and Windows boots normally.  However, there
  is no network connectivity.  There are no network devices visible in
  XP's Networking tab of Control Panel and a ping of the local router
  reports "unreachable".

  Also, the keyboard works fine but the guest mouse pointer is offset
  from the host mouse position by an amount that varies by screen
  position.  This makes it impossible to point to locations near the
  edge of the qemu window.  This seems to be a previously reported
  problem, but the suggested fix, " -device usb-tablet", prevents qemu
  from even starting:

  qemu-system-x86_64: -device usb-tablet: No 'usb-bus' bus found for
  device 'usb-tablet'

  The physical mouse is connected to the USB port of a Sun Ray 2fs
  controlling the M3000 via Sun Ray server.  I apologize if this is a
  configuration issue and not a bug but I don't know where else to
  report it and have been unable to find a solution in the
  documentation.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1787505/+subscriptions

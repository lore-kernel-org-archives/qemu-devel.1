Received: from eggs.gnu.org ([2001:4830:134:3::10]:47812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eeKam-0008BF-O6
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 07:55:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eeKah-0000bP-PM
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 07:55:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:51040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eeKah-0000Zi-Je
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 07:55:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eeKag-000121-6N
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 12:55:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2F2412E8551
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 12:55:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jan 2018 12:41:21 -0000
From: Daniel Berrange <1089496@bugs.launchpad.net>
Reply-To: Bug 1089496 <1089496@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121212172623.19173.36082.malonedeb@wampee.canonical.com>
Message-Id: <151679768167.10986.9740815152177972829.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1089496] Re: qemu doesn't set vnc port correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The problem with this is that the behaviour is inherently ambiguous. We
have no way to distinguish whether a user specifying ":5804" wants  port
11704 or port 5804, so it is not in fact easy to fix.

If we were writing this again from scratch I would avoid the offset
concept entirely and always require absolute port, but given where we
are, unconditionally treating the port number as an offset relative to
5900 is the only sane approach, unless we introduce completely new
syntax.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1089496

Title:
  qemu doesn't set vnc port correctly

Status in QEMU:
  Invalid

Bug description:
  Qemu Version: 1.1.1

  In the past it was possible to set the port for vnc with:
  -vnc :1
  That would mean the port would be 5901, Starting from 5900 plus the given=
 number. However, it was also possible to set the port directly with a cust=
om given port. Usually i set the port to something like 5801. With qemu-1.1=
.1 (and maybe prior versions too, i usually use spice) that's not possible =
anymore. For example:
  -vnc 192.168.1.1:5804
  Here the 'real' port would be 11704 (that's 5900 + 5804). I'm sure that w=
orked correctly in the past and i'm pretty sure it's easy to fix.

  Would be nice if we can fix that.

  System Info:
  Portage 2.1.11.31 (default/linux/amd64/10.0/no-multilib, gcc-4.5.4, glibc=
-2.15-r3, 3.5.7-gentoo x86_64)
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  8f5b300da8f952f8bbdd956b7d782c5cdb61dd06fd45f7755b8cfea51937a1f8

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1089496/+subscriptions

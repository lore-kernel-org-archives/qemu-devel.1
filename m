Received: from eggs.gnu.org ([2001:4830:134:3::10]:53165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dulV6-0002Kl-GZ
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 16:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dulV3-0004w7-3g
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 16:21:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:34346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dulV2-0004vE-Ta
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 16:21:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dulV0-0002M2-Uw
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 20:21:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0E4152E84CC
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 20:21:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Sep 2017 20:10:51 -0000
From: Matheus Izvekov <1673976@bugs.launchpad.net>
Reply-To: Bug 1673976 <1673976@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170318142657.21676.52259.malonedeb@chaenomeles.canonical.com>
Message-Id: <150593825149.6235.5292831257661210346.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1673976] Re: core dump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I can confirm this. The ninja build system is also affected.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1673976

Title:
  core dump

Status in QEMU:
  New

Bug description:
  I'm running a command (locale-gen) inside of an armv7h chroot mounted
  on my x86_64 desktop by putting qemu-arm-static into /usr/bin/ of the
  chroot file system and I get a core dump.

  locale-gen
  Generating locales...
  =C2=A0=C2=A0en_US.UTF-8...localedef: ../sysdeps/unix/sysv/linux/spawni.c:=
360: __spawnix: Assertion `ec >=3D 0' failed.
  qemu: uncaught target signal 6 (Aborted) - core dumped
  /usr/bin/locale-gen: line 41:    34 Aborted                 (core dumped)=
 localedef -i $input -c -f $charset -A /usr/share/locale/locale.alias $loca=
le

  I've done this same thing successfully for years, but this breakage
  has appeared some time in the last 3 or so months. Possibly with the
  update to qemu version 2.8.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1673976/+subscriptions

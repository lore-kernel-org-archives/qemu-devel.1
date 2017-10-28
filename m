Received: from eggs.gnu.org ([2001:4830:134:3::10]:59919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8R1n-0003xf-PX
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8R1k-0008I4-LG
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:19:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:52106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8R1k-0008Fv-Ec
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:19:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8R1j-0001Rg-A0
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:19:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 42ECA2E80CC
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:19:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 13:00:59 -0000
From: Thomas Huth <1358287@bugs.launchpad.net>
Reply-To: Bug 1358287 <1358287@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140818133018.28331.75813.malonedeb@chaenomeles.canonical.com>
Message-Id: <150919566003.4605.12875542088247614859.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1358287] Re: -readconfig file doesn't interpret
 memory size correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1358287

Title:
  -readconfig file doesn't interpret memory size correctly

Status in QEMU:
  Incomplete

Bug description:
  I'm running Qemu 2.1 and have issues with the config file format.

  Specifically Qemu wrote the following snippet with '-writeconfig':

  [memory]
    size =3D "1024"

  However, upon starting a VM with this setting it only receives 128MiB
  (the default size).

  I'm reverting back to using the command line option now - that works.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1358287/+subscriptions

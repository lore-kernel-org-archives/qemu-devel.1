Received: from eggs.gnu.org ([2001:4830:134:3::10]:58060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eUPpe-000152-7O
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 23:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eUPpa-0001Gl-9S
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 23:30:14 -0500
Received: from indium.canonical.com ([91.189.90.7]:58754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eUPpa-0001Fx-3A
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 23:30:10 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eUPpY-0007PH-CY
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 04:30:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5B8A72E8060
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 04:30:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Dec 2017 04:17:27 -0000
From: Launchpad Bug Tracker <1358287@bugs.launchpad.net>
Reply-To: Bug 1358287 <1358287@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140818133018.28331.75813.malonedeb@chaenomeles.canonical.com>
Message-Id: <151443464725.28609.8118381305991674030.malone@loganberry.canonical.com>
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

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1358287

Title:
  -readconfig file doesn't interpret memory size correctly

Status in QEMU:
  Expired

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

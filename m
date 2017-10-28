Received: from eggs.gnu.org ([2001:4830:134:3::10]:42748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RtF-0004fQ-Ry
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 10:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RtA-0004n7-Uq
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 10:15:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:57800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8RtA-0004lh-Og
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 10:15:04 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8Rt8-0002cJ-Qi
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 14:15:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 73B2A2E80CC
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 14:15:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 13:57:34 -0000
From: Christian Theune <christian@theune.cc>
Reply-To: Bug 1358287 <1358287@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140818133018.28331.75813.malonedeb@chaenomeles.canonical.com>
Message-Id: <150919905483.20484.2143141074222658783.malone@soybean.canonical.com>
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

Good question. Over time I've got some feedback that the whole config
file mechanism is really just a second class citizen anyway. I'm happy
for now (running 2.7) and don't really care too much.

Nevertheless: I'd be absolutely excited if I could reliably configure
(and have nice documentation that I'd even be willing to help create)
Qemu instances just with a config file ...

Feel free to close this issue to get rid of old cruft ... :)

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

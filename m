Received: from eggs.gnu.org ([2001:4830:134:3::10]:60246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1edgFX-0003Ld-0U
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:51:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1edgFS-0007zY-Tk
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:51:15 -0500
Received: from indium.canonical.com ([91.189.90.7]:58470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1edgFS-0007xQ-Mz
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:51:10 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1edgFR-0001UL-Eb
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 17:51:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6C43D2E854B
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 17:51:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jan 2018 17:43:59 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1657010 <1657010@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170117063435.21322.40478.malonedeb@gac.canonical.com>
Message-Id: <151664303962.20366.9065186876032690438.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1657010] Re: RFE: Please implement -cpu best or a
 CPU fallback option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I think we've ended up with '-cpu max', present since QEMU 2.9 for x86
and perhaps for some other architectures, but not Arm yet.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1657010

Title:
  RFE: Please implement -cpu best or a CPU fallback option

Status in QEMU:
  New

Bug description:
  QEMU should implement a -cpu best option or some other way to make
  this work:

  qemu -M pc,accel=3Dkvm:tcg -cpu best

  qemu -M pc,accel=3Dkvm:tcg -cpu host:qemu64

  See also:

  https://bugzilla.redhat.com/show_bug.cgi?id=3D1277744#c6

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1657010/+subscriptions

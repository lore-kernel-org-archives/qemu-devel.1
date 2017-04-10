Received: from eggs.gnu.org ([2001:4830:134:3::10]:52048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cxYmR-0008Sv-GZ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cxYmO-0001DV-Eg
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:50:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:55509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cxYmO-0001DI-6e
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:50:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cxYmL-0007VM-Vj
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 12:50:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 91BBE2E81E9
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 12:50:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Apr 2017 12:42:09 -0000
From: Gerd Hoffmann <1635339@bugs.launchpad.net>
Reply-To: Bug 1635339 <1635339@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161020160532.23339.63373.malonedeb@soybean.canonical.com>
	<20170410115617.12199.51724.malone@gac.canonical.com>
Message-Id: <1491828129.30990.23.camel@redhat.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1635339] Re: qxl_pre_save assertion failure
 on vm "save"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Mo, 2017-04-10 at 11:56 +0000, Frediano Ziglio wrote:
> Is this problem limited to commands or also to data attached to the comma=
nds?

Everything which contains QXLReleaseInfo and is released via release
ring.

> To me looks like a limitation Qemu should remove on the long run.

That is an option, but it is tricky backward-compatibility wise.
What was the reason to move the commands to bar1?

cheers,
  Gerd

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1635339

Title:
  qxl_pre_save assertion failure on vm "save"

Status in QEMU:
  Confirmed

Bug description:
  When I try and save my Windows 10 VM, I see an assertion failure, and
  the machine is shut down.

  I see the following in the log:

  main_channel_handle_parsed: agent start
  qemu-system-x86_64: /build/qemu-Zwynhi/qemu-2.5+dfsg/hw/display/qxl.c:210=
1: qxl_pre_save: Assertion `d->last_release_offset < d->vga.vram_size' fail=
ed.
  2016-10-20 11:52:42.713+0000: shutting down

  Please let me know what other information would be relevant!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1635339/+subscriptions

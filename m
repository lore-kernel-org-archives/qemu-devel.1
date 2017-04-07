Received: from eggs.gnu.org ([2001:4830:134:3::10]:47097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwcsB-0000LQ-Az
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 19:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwcs6-0000o2-Fs
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 19:00:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:34518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cwcs6-0000nd-8w
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 19:00:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cwcs5-0007Ou-5a
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 23:00:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 214522E80BF
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 23:00:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2017 22:50:52 -0000
From: elmarco <marcandre.lureau@gmail.com>
Reply-To: Bug 1635339 <1635339@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161020160532.23339.63373.malonedeb@soybean.canonical.com>
Message-Id: <20170407225052.2289.61131.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1635339] Re: qxl_pre_save assertion failure on vm
 "save"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Your approach works ok Gerd with a migration blocker. Are you going to
send a patch?

I am afraid we would have to make this code permanent though, since
there has been several releases of this driver already, and it's much
nicer to block migration than to crash a VM.

I have reached out to wddm driver about the bug.

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

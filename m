Received: from eggs.gnu.org ([2001:4830:134:3::10]:38646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwTyp-0005tW-V1
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwTym-0004gZ-PW
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:31:11 -0400
Received: from indium.canonical.com ([91.189.90.7]:37154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cwTym-0004gD-K9
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:31:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cwTyk-0000FC-48
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 13:31:06 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F2D832E827E
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 13:30:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2017 13:22:33 -0000
From: Gerd Hoffmann <1635339@bugs.launchpad.net>
Reply-To: Bug 1635339 <1635339@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161020160532.23339.63373.malonedeb@soybean.canonical.com>
Message-Id: <20170407132233.30835.30093.malone@soybean.canonical.com>
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

I put my money on that one:

https://cgit.freedesktop.org/spice/win32/qxl-wddm-
dod/commit/?id=3Df6e099db39e7d0787f294d5fd0dce328b5210faa

commit f6e099db39e7d0787f294d5fd0dce328b5210faa
Author: Sameeh Jubran <sameeh@daynix.com>
Date:   Sun Sep 11 16:05:24 2016 +0300

    Use the second bar (VRAM) for qxl command buffer.
    =

    Based on a patch by Sandy Stutsman <sstutsma@redhat.com>
    =

    Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
    Acked-by: Frediano Ziglio <fziglio@redhat.com>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1635339

Title:
  qxl_pre_save assertion failure on vm "save"

Status in QEMU:
  New

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

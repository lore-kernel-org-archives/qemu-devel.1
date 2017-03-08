Received: from eggs.gnu.org ([2001:4830:134:3::10]:34042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cllM0-00049P-LD
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 18:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cllLv-0007WG-Od
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 18:50:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:41494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cllLv-0007Uv-I0
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 18:50:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cllLt-0004jO-Sn
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 23:50:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A27F52E808D
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 23:50:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Mar 2017 23:43:09 -0000
From: Herbie Robinson <1670509@bugs.launchpad.net>
Reply-To: Bug 1670509 <1670509@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170306224936.27687.97076.malonedeb@gac.canonical.com>
Message-Id: <20170308234309.6329.78163.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1670509] Re: sgabios outputs incorrect video modes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I don't think my e-mailed patch got through...  I'm going to keep
trying, but in case anyone needs the patch in the interim...

** Patch added: "0001-SGABIOS-fix-wrong-video-attrs-for-int-10h-ah-13h.patc=
h"
   https://bugs.launchpad.net/qemu/+bug/1670509/+attachment/4834118/+files/=
0001-SGABIOS-fix-wrong-video-attrs-for-int-10h-ah-13h.patch

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1670509

Title:
  sgabios outputs incorrect video modes

Status in QEMU:
  New
Status in sgabios package in Ubuntu:
  New

Bug description:
  When run with a bootstrap loader that uses int 0x10 with 0x1301 in
  %ax, incorrect video modes are output to the serial port.  I believe
  the VGA image will be correct.  This might also affect the returned
  values for some interrupts.

  This is caused because the set_cursor_position routine fails to save
  and restore %bx.

  I'm working on a fix for this.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1670509/+subscriptions

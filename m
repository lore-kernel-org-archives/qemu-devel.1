Received: from eggs.gnu.org ([2001:4830:134:3::10]:59049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d2Ylh-0000aU-UC
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d2Ylh-0004FK-4W
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:50:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:38638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d2Ylg-0004FA-VL
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:50:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d2Ylf-0005Jf-SH
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:50:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D2CE62E80C8
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:50:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Apr 2017 07:43:04 -0000
From: Thomas Huth <1637447@bugs.launchpad.net>
Reply-To: Bug 1637447 <1637447@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161028093031.16469.50340.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170424074305.19998.87568.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1637447] Re: VNC/RFB: QEMU reports incorrect name
 (length)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1637447

Title:
  VNC/RFB: QEMU reports incorrect name (length)

Status in QEMU:
  Fix Released

Bug description:
  If the name of a machine (as set with the -name argument) has a length
  longer than 1024, (RFB) VNC clients will not receive a correct RFB
  ServerInit message.

  I suspect this is the problem:

  https://github.com/qemu/qemu/blob/v2.7.0-rc5/ui/vnc.c#L2459

  The return value of snprintf is used as the value for the name-length fie=
ld in the ServerInit message.
  This is problematic for names that were truncated to 1024, as the length =
will now be bigger than the actual name.

  I think a quick fix would be to simply report min(size,1024) to the
  client...

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1637447/+subscriptions

Received: from eggs.gnu.org ([2001:4830:134:3::10]:39383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3lbG-00071d-Vo
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3lbC-0002xJ-U6
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:44:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:59597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d3lbC-0002x6-Nq
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:44:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d3lbB-0008HT-Mx
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 15:44:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A195D2E80C6
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 15:44:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Apr 2017 15:32:36 -0000
From: Thomas Huth <1284090@bugs.launchpad.net>
Reply-To: Bug 1284090 <1284090@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140224123257.31623.72910.malonedeb@gac.canonical.com>
Message-Id: <20170427153236.26915.31001.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1284090] Re: RFE: QMP: report error reason in
 BLOCK_IO_ERROR message
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
   Importance: Undecided =3D> Wishlist

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1284090

Title:
  RFE: QMP: report error reason in BLOCK_IO_ERROR message

Status in QEMU:
  New

Bug description:
  when a disk drive is configured with the error policy enospc for write er=
rors, the monitoring client needs a way to distinguish
  betwwen generic I/O error and the I/O error for space exausted.

  The JSON QMP protocol lacks this information: the BLOCK_IO_ERROR
  message does not provide a reason or code for the error verified, so
  the monitoring client cannot distinguish the source of the errors.

  verified against git 105a060188dc6fdd4551571a966514d1a5f6815a

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1284090/+subscriptions

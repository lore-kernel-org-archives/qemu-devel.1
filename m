Received: from eggs.gnu.org ([2001:4830:134:3::10]:37094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f3k4h-0006jc-0v
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f3k4c-0007jI-1T
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:11:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:49988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f3k4b-0007ib-Rj
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:11:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f3k4a-0001Qf-PA
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 15:11:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B9AB92E80C9
	for <qemu-devel@nongnu.org>; Wed,  4 Apr 2018 15:11:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Apr 2018 15:00:02 -0000
From: Zixuan Wang <1367365@bugs.launchpad.net>
Reply-To: Bug 1367365 <1367365@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140909163714.17873.62405.malonedeb@chaenomeles.canonical.com>
Message-Id: <152285400282.2364.3959673064204123664.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1367365] Re: qemu-img fixed vhd issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Sorry for the mistaken operation (changed to confirmed), I didn't mean
to change the status

** Changed in: qemu
       Status: Triaged =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1367365

Title:
  qemu-img fixed vhd issues

Status in QEMU:
  Confirmed

Bug description:
  qemu-img returns fixed vhd images file format to be raw.

  This happens because only the header is seeked for image signatures
  when getting the image format. In fact, unlike dynamic vhd images,
  differencing vhds don't have the footer copied in the header.

  An easy fix would be to just search the last 512B for the 'conectix'
  signature.

  Also, the fixed vhds created by qemu-img seem to be corrupted from
  Powershell POV.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1367365/+subscriptions

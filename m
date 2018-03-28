Received: from eggs.gnu.org ([2001:4830:134:3::10]:48256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f18v6-0003JH-Ig
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 07:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f18v3-0001fI-EO
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 07:07:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:45838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f18v3-0001fB-8u
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 07:07:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f18v2-00025q-CU
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 11:07:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 53A702E8025
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 11:07:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Mar 2018 10:53:02 -0000
From: Thomas Huth <1367365@bugs.launchpad.net>
Reply-To: Bug 1367365 <1367365@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140909163714.17873.62405.malonedeb@chaenomeles.canonical.com>
Message-Id: <152223438283.21459.2738035260506041562.launchpad@wampee.canonical.com>
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

** Changed in: qemu
       Status: Incomplete =3D> Triaged

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1367365

Title:
  qemu-img fixed vhd issues

Status in QEMU:
  Triaged

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

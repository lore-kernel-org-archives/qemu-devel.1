Received: from eggs.gnu.org ([2001:4830:134:3::10]:33724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOdDy-0004S3-6e
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOdDv-0004rf-8Q
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:60535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cOdDv-0004rL-2N
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cOdDt-0002Sc-2f
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 04:30:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E85FF2E80CE
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 04:30:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Jan 2017 04:17:46 -0000
From: Launchpad Bug Tracker <1119686@bugs.launchpad.net>
Reply-To: Bug 1119686 <1119686@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130208193040.11551.94134.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170104041746.27545.80352.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1119686] Re: Incorrect handling of icebp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1119686

Title:
  Incorrect handling of icebp

Status in QEMU:
  Expired

Bug description:
  Wine conformance suite tests the behavior of various low-level Windows
  API functions. One of the tests involves checking the interaction of
  breakpoints and exceptions, and in particular the 'icebp' breakpoint.
  This test works on a Windows XP machine running either on the metal or
  in VMware ESX but fails when run in QEmu.

  To reproduce the issue grab the attached 'exception.exe' file and run
  it. If you get 'Test failed' lines like below then it means the
  problem is still present:

      exception.c:202: exception 0: 80000004 flags:0 addr:003F0000
      exception.c:208: Test failed: 0: Wrong exception address 003F0000/003=
F0001
      exception.c:214: this is the last test seen before the exception
      exception: unhandled exception 80000004 at 003F0000
      exception.c:202: exception 0: c0000027 flags:2 addr:7C80E0B9
      exception.c:205: Test failed: 0: Wrong exception code c0000027/800000=
04
      exception.c:208: Test failed: 0: Wrong exception address 7C80E0B9/003=
F0001

  Note that this bug was not present in QEmu 1.1.2+dfsg-5 (Debian
  Testing) but is now present in 1.4.0~rc0+dfsg-1exp (Debian
  Experimental).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1119686/+subscriptions

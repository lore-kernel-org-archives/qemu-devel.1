Received: from eggs.gnu.org ([2001:4830:134:3::10]:56379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dJXz9-0005Dh-0l
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 00:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dJXz5-0000sr-SM
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 00:26:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:41651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dJXz5-0000sl-Mh
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 00:26:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dJXz2-0003lQ-03
	for <qemu-devel@nongnu.org>; Sat, 10 Jun 2017 04:26:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B88732E8293
	for <qemu-devel@nongnu.org>; Sat, 10 Jun 2017 04:26:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Jun 2017 04:17:25 -0000
From: Launchpad Bug Tracker <1662050@bugs.launchpad.net>
Reply-To: Bug 1662050 <1662050@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170206024535.14624.3001.malonedeb@soybean.canonical.com>
Message-Id: <149706824520.22076.7004496139159116468.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1662050] Re: qemu-img convert a overlay qcow2
 image into a entire image
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
https://bugs.launchpad.net/bugs/1662050

Title:
  qemu-img convert a overlay qcow2 image into a entire image

Status in QEMU:
  Expired

Bug description:
  I have a base image file "base.qcow2" and a delta qcow2 image file
  "delta.qcow2" whose backing file is "base.qcow2".

  Now I use qemu-img to convert "delta.qcow2" and will get a new image
  file "new.qcow2" which is entire and equivalent to combination of
  "base.qcow2" and "delta.qcow2".

  In fact,I don't want to get a complete image.I just want to convert
  delta qcow2 image file "A" to a New delta overlay qcow2 image "B"
  which is equivalent to "A". So the "new.qcow2" is not what i want. I
  have to admit that this is not bug. Could you please take this as a
  new feature and enable qemu-img to convert qcow2 overlay itself?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1662050/+subscriptions

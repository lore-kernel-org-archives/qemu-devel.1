Received: from eggs.gnu.org ([2001:4830:134:3::10]:58714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cawUV-0003v6-8D
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 22:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cawUR-0003NU-98
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 22:30:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:40132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cawUQ-0003NI-Ps
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 22:30:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cawUO-0004H3-V1
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 03:30:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DFE2C2E8029
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 03:30:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Feb 2017 03:21:19 -0000
From: wayen <1662050@bugs.launchpad.net>
Reply-To: Bug 1662050 <1662050@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170206024535.14624.3001.malonedeb@soybean.canonical.com>
Message-Id: <20170207032120.4151.79250.launchpad@chaenomeles.canonical.com>
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

** Description changed:

  I have a base image file "base.qcow2" and a delta qcow2 image file
  "delta.qcow2" whose backing file is "base.qcow2".
  =

  Now I use qemu-img to convert "delta.qcow2" and will get a new image
  file "new.qcow2" which is entire and equivalent to combination of
  "base.qcow2" and "delta.qcow2".
  =

- In fact, i just want to convert the delta qcow2 image file and get a New
- delta overlay qcow2 image file. So the "new.qcow2" is not what i want. I
- have to admit that this is not bug. Could you please take this as a new
- feature and enable qemu-img to convert qcow2 overlay itself?
+ In fact,I don't want to get a complete image.I just want to convert
+ delta qcow2 image file "A" to a New delta overlay qcow2 image "B" which
+ is equivalent to "A". So the "new.qcow2" is not what i want. I have to
+ admit that this is not bug. Could you please take this as a new feature
+ and enable qemu-img to convert qcow2 overlay itself?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1662050

Title:
  qemu-img convert a overlay qcow2 image into a entire image

Status in QEMU:
  Incomplete

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

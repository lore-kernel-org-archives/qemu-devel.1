Received: from eggs.gnu.org ([2001:4830:134:3::10]:37957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1caZT5-0004C2-VL
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 21:55:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1caZT2-0005iT-OQ
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 21:55:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:45418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1caZT2-0005iL-Is
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 21:55:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1caZT0-0001l2-Mp
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 02:55:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E4B4E2E80CC
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 02:55:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Feb 2017 02:45:35 -0000
From: wayen <1662050@bugs.launchpad.net>
Reply-To: Bug 1662050 <1662050@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170206024535.14624.3001.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1662050] [NEW] qemu-img convert a delta qcow2
 image into a complete image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

I have a base image file "base.qcow2" and a delta qcow2 image file
"delta.qcow2" whose backing file is "base.qcow2".

Now I use qemu-img to convert "delta.qcow2" and will get a new image
file "new.qcow2" which is complete and equivalent to combination of
"base.qcow2" and "delta.qcow2".

In fact, i just want to convert the delta qcow2 image file and get a new
delta overlay qcow2 image file. So the "new.qcow2" is not what i want. I
have to admit that this is not bug. Could you please take this as a new
feature and enable qemu-img to convert images in-place?

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: feature

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1662050

Title:
  qemu-img convert a delta qcow2 image into a complete image

Status in QEMU:
  New

Bug description:
  I have a base image file "base.qcow2" and a delta qcow2 image file
  "delta.qcow2" whose backing file is "base.qcow2".

  Now I use qemu-img to convert "delta.qcow2" and will get a new image
  file "new.qcow2" which is complete and equivalent to combination of
  "base.qcow2" and "delta.qcow2".

  In fact, i just want to convert the delta qcow2 image file and get a
  new delta overlay qcow2 image file. So the "new.qcow2" is not what i
  want. I have to admit that this is not bug. Could you please take this
  as a new feature and enable qemu-img to convert images in-place?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1662050/+subscriptions

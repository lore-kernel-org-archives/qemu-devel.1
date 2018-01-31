Received: from eggs.gnu.org ([2001:4830:134:3::10]:35887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1egr3Z-00011R-OB
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 07:00:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1egr3W-0001iZ-JK
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 07:00:01 -0500
Received: from indium.canonical.com ([91.189.90.7]:36402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1egr3W-0001hT-DE
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 06:59:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1egr3U-00037D-JH
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 11:59:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9115D2E8550
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 11:59:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 31 Jan 2018 11:48:36 -0000
From: michelkogan <1332297@bugs.launchpad.net>
Reply-To: Bug 1332297 <1332297@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140619191312.10674.6213.malonedeb@soybean.canonical.com>
Message-Id: <151739931643.25138.11078540924417074148.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1332297] Re: qemu-img: crash on check of an image
 with large value in the 'size' header field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Have the same proble: qemu-img: Check failed: Cannot allocate memory

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1332297

Title:
  qemu-img: crash on check of an image with large value in the 'size'
  header field

Status in QEMU:
  Expired

Bug description:
  The qemu-img crashes on the next command:

  qemu-img check test_image

  'test_image' can be found in the attachment. It's a fuzzed test image
  with the qcow2 image header only. Suppositional cause of the failure
  is the value of 'size' header field set to maximum uint_64 value.

  System information:

  qemu.git: 6baa963f4dcc2118
  Host: Linux 3.14.7-200.fc20.x86_64 #1 SMP Wed Jun 11 22:38:05 UTC 2014 x8=
6_64  GNU/Linux

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1332297/+subscriptions

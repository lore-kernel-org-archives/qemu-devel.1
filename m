Received: from eggs.gnu.org ([2001:4830:134:3::10]:48381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUrzx-000692-F6
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 04:30:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUrzt-0006Tq-J0
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 04:30:13 -0500
Received: from indium.canonical.com ([91.189.90.7]:43287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUrzt-0006Rt-DL
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 04:30:09 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUrzr-0004sa-DZ
	for <qemu-devel@nongnu.org>; Sat, 21 Jan 2017 09:30:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 55EDC2E8084
	for <qemu-devel@nongnu.org>; Sat, 21 Jan 2017 09:30:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Jan 2017 09:20:33 -0000
From: Quentin Casasnovas <601946@bugs.launchpad.net>
Reply-To: Bug 601946 <601946@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100705154408.6052.2473.malonedeb@potassium.ubuntu.com>
Message-Id: <20170121092033.25029.88092.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 601946] Re: [Feature request] qemu-img
 multi-threaded compressed image conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

That was also my feeling, so nice to get a confirmation!

Another related thing would be to allow qemu-nbd to write compressed
blocks its backing image - today if you use a qcow2 with compression,
any block which is written to gets uncompressed in the resulting image
and you need to recompress the image offline with qemu-img.

Would you have any pointers/documentation on how best to implement this
so both qemu-img and qemu-nbd can use multithreaded compressed writes ?
I'm totally new to qemu block subsystem.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/601946

Title:
  [Feature request] qemu-img multi-threaded compressed image conversion

Status in QEMU:
  New

Bug description:
  Feature request:
  qemu-img multi-threaded compressed image conversion

  Suppose I want to convert raw image to compressed qcow2. Multi-
  threaded conversion will be much faster, because bottleneck is
  compressing data.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/601946/+subscriptions

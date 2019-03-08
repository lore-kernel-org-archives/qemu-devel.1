Received: from eggs.gnu.org ([209.51.188.92]:45393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h2Hlp-0006G0-J1
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h2Hln-000211-IV
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:50:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:57156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1h2Hlm-0001kN-Pj
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:50:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1h2Hlf-0003pL-3y
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 15:50:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F38D72E80CD
	for <qemu-devel@nongnu.org>; Fri,  8 Mar 2019 15:50:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Mar 2019 15:34:19 -0000
From: Scott Moser <ssmoser2+ubuntu@gmail.com>
Reply-To: Bug 1819182 <1819182@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155205925919.27918.10336996226499931700.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1819182] [NEW] info does not recognize file
 format of vpc with subformat=fixed
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

After creating or converting an image to vpc with 'subformat=3Dfixed'
'qemu-img info' incorrectly identifies the image as 'raw' format.

$ qemu-img --version
qemu-img version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.10)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

$ qemu-img create -f vpc -o subformat=3Dfixed my.vpc 2G
Formatting 'my.vpc', fmt=3Dvpc size=3D2147483648 subformat=3Dfixed

$ qemu-img info my.vpc
image: my.vpc
file format: raw
virtual size: 2.0G (2147992064 bytes)
disk size: 4.0K

$ qemu-img info -f vpc my.vpc
image: my.vpc
file format: vpc
virtual size: 2.0G (2147991552 bytes)
disk size: 4.0K

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1819182

Title:
  info does not recognize file format of vpc with subformat=3Dfixed

Status in QEMU:
  New

Bug description:
  After creating or converting an image to vpc with 'subformat=3Dfixed'
  'qemu-img info' incorrectly identifies the image as 'raw' format.

  $ qemu-img --version
  qemu-img version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.10)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

  $ qemu-img create -f vpc -o subformat=3Dfixed my.vpc 2G
  Formatting 'my.vpc', fmt=3Dvpc size=3D2147483648 subformat=3Dfixed

  $ qemu-img info my.vpc
  image: my.vpc
  file format: raw
  virtual size: 2.0G (2147992064 bytes)
  disk size: 4.0K

  $ qemu-img info -f vpc my.vpc
  image: my.vpc
  file format: vpc
  virtual size: 2.0G (2147991552 bytes)
  disk size: 4.0K

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1819182/+subscriptions

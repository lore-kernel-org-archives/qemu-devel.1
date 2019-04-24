Received: from eggs.gnu.org ([209.51.188.92]:47227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAeO-0005sb-Er
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAeN-00082l-5y
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:40:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:38140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJAeM-00081c-Vb
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:40:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJAeM-0003up-0o
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:40:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F37282E80C7
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:40:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 05:32:41 -0000
From: Thomas Huth <1796754@bugs.launchpad.net>
Reply-To: Bug 1796754 <1796754@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153902784309.8245.8166003544722634075.malonedeb@soybean.canonical.com>
Message-Id: <155608396284.6968.11514017285376412656.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1796754] Re: ioctl SIOCGIFCONF causes
 qemu-aarch64-static to crash with "received signal outside vCPU context"
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
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1796754

Title:
  ioctl SIOCGIFCONF causes qemu-aarch64-static to crash with "received
  signal outside vCPU context"

Status in QEMU:
  Fix Released

Bug description:
  To reproduce it, compile the attached crash.c under aarch64 to a.out and =
execute on x86_64
  qemu-aarch64-static ./a.out

  It will print the following and crash:

  socket=3D3
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x6003=
8cd6
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x6000=
157a

  The version of qemu-aarch64-static is

  qemu-aarch64 version 3.0.0 (qemu-3.0.0-1.fc29)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

  But it did also happen in previous versions so it is not a regression
  but a bug existed ever since.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1796754/+subscriptions

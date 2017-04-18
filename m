Received: from eggs.gnu.org ([2001:4830:134:3::10]:44164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d0Z98-0008Mv-RZ
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 15:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d0Z93-0008He-T5
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 15:50:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:60490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d0Z93-0008H2-N7
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 15:50:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d0Z90-0004vy-5X
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 19:50:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 06DB92E80C3
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 19:50:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Apr 2017 19:41:37 -0000
From: pranith <1682093@bugs.launchpad.net>
Reply-To: Bug 1682093 <1682093@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170412105411.12710.65118.malonedeb@gac.canonical.com>
Message-Id: <20170418194138.12939.21799.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1682093] Re: aarch64-softmmu "bad ram pointer"
 crash
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
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1682093

Title:
  aarch64-softmmu "bad ram pointer" crash

Status in QEMU:
  Invalid

Bug description:
  I am developing a piece of software called SimBench which is a
  benchmarking system for full system simulators. I am currently porting
  this to aarch64, using QEMU as a test platform.

  I have encountered a 'bad ram pointer' crash. I've attempted to build
  a minimum test case, but I haven't managed to replicate the behaviour
  in isolation, so I've created a branch of my project which exhibits
  the crash: https://bitbucket.org/Awesomeclaw/simbench/get/qemu-
  bug.tar.gz

  The package can be compiled using:

  make

  and then run using:

  qemu-system-aarch64  -M virt -m 512 -cpu cortex-a57 -kernel
  out/armv8/virt/simbench -nographic

  I have replicated the issue in both qemu 2.8.1 and in 2.9.0-rc3, on
  Fedora 23. Please let me know if you need any more information or any
  logs/core dumps/etc.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1682093/+subscriptions

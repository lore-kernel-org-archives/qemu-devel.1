Received: from eggs.gnu.org ([2001:4830:134:3::10]:60946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTXsf-0001zj-83
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTXsb-0001EA-59
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:26:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:56710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fTXsa-0001DO-T0
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:25:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fTXsZ-0001Cm-P4
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 19:25:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AB3D32E8030
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 19:25:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Jun 2018 19:13:45 -0000
From: Richard Jones <rjones@redhat.com>
Reply-To: Bug 1462944 <1462944@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150608092329.15949.23710.malonedeb@chaenomeles.canonical.com>
Message-Id: <152900362598.25684.8217702628540914178.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1462944] Re: vpc file causes qemu-img to consume
 lots of time and memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I suspect this bug is probably still around, and if not then this class
of bugs is certainly still around.  What we have done in management
tools like Open Stack is to confine qemu-img using simple ulimits when
inspecting any untrusted image, and that solves the problem so it's
probably fine to close this bug now.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1462944

Title:
  vpc file causes qemu-img to consume lots of time and memory

Status in QEMU:
  Incomplete

Bug description:
  The attached vpc file causes 'qemu-img info' to consume 3 or 4 seconds
  of CPU time and 1.3 GB of heap, causing a minor denial of service.

  $ /usr/bin/time ~/d/qemu/qemu-img info afl12.img
  block-vpc: The header checksum of 'afl12.img' is incorrect.
  qemu-img: Could not open 'afl12.img': block-vpc: free_data_block_offset p=
oints after the end of file. The image has been truncated.
  1.19user 3.15system 0:04.35elapsed 99%CPU (0avgtext+0avgdata 1324504maxre=
sident)k
  0inputs+0outputs (0major+327314minor)pagefaults 0swaps

  The file was found using american-fuzzy-lop.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1462944/+subscriptions

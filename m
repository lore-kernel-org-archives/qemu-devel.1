Received: from eggs.gnu.org ([2001:4830:134:3::10]:56509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTWd7-0001KE-RM
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTWd3-0001g4-Pr
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:05:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:60642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fTWd3-0001eG-Iz
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:05:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fTWd2-0006jX-Hf
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 18:05:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 777802E8024
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 18:05:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Jun 2018 17:48:17 -0000
From: Thomas Huth <1462944@bugs.launchpad.net>
Reply-To: Bug 1462944 <1462944@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150608092329.15949.23710.malonedeb@chaenomeles.canonical.com>
Message-Id: <152899849748.7095.13259885863343880972.malone@wampee.canonical.com>
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

Is there still something left to do here, or could we close this ticket
nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

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

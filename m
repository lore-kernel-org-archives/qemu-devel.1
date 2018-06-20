Received: from eggs.gnu.org ([2001:4830:134:3::10]:45469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fVZWh-0005Cw-Kb
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fVZWe-0007vw-EC
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:35:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:46180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fVZWe-0007vk-7C
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:35:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fVZWd-0004gC-0T
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 09:35:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E9E302E8033
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 09:35:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Jun 2018 09:21:26 -0000
From: srinivas kv <srinivas.kv@fastenex.co.in>
Reply-To: Bug 1470481 <1470481@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150701120650.14797.87262.malonedeb@wampee.canonical.com>
Message-Id: <152948648655.2025.8944813916717486834.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1470481] Re: qemu-img converts large vhd files
 into only approx. 127GB raw file causing the VM to crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I have qemu-img 1.4.1 included in Suse Linux Enterprise server version
11 SP3. I will see whether I can update it and then try the conversion
and post the results.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1470481

Title:
  qemu-img converts large vhd files into only approx. 127GB raw file
  causing the VM to crash

Status in QEMU:
  Incomplete

Bug description:
  I have a VHD file for Windows 2014 server OS. I use the following
  command to convert VHD file (20GB) to a RAW file for KVM.

  qemu-img convert -f vpc -O raw WIN-SNRGCQV6O3O.VHD disk.img

  The output file is about 127GB. When install the VM and boot it up,
  the OS crashes with STOP error after the intial screen. I found on the
  internet that the file limit of 127GB is an existing bug. Kindly fix
  the problem. The workaround to use a Hyper-V to convert to fixed disk
  is not a feasible solution.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1470481/+subscriptions

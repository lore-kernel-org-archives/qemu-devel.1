Received: from eggs.gnu.org ([209.51.188.92]:59823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gw7Cg-0002t3-RP
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gw7Ce-0007O6-QD
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:21:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:57750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gw7Ce-0007IZ-IP
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:21:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gw7CR-0001Sb-Tz
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 15:20:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E13582E8024
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 15:20:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Feb 2019 15:07:50 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1816614 <1816614@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155058813971.5667.8533936321163963042.malonedeb@soybean.canonical.com>
Message-Id: <155058887060.28267.16203991103890365807.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1816614] Re: error: static assertion failed: "arm
 generic timer needs __Int128 defined"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi there; this bug database is for issues in upstream QEMU. The assert()
you have hit is not in upstream QEMU at all, so it must be something
that Xilinx have added. For questions about Xilinx's version, you should
talk to them, not us.

That said, I think the answer is likely to be "they don't support
building for 32-bit hosts", and you'll find that if you use a 64-bit
host OS instead it will work.


** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1816614

Title:
  error: static assertion failed: "arm generic timer needs __Int128
  defined"

Status in QEMU:
  Invalid

Bug description:
  Hi,

  Accordingly to the instruction from https://xilinx-wiki.atlassian.net/wik=
i/spaces/A/pages/18842060/QEMU we have downloaded the Xilinx QEMU and tried=
 to build it on Ubuntu 16.04.5 32Bit OS. We have done all the following ste=
ps from the instruction:
  $ git clone git://github.com/Xilinx/qemu.git
  $ cd qemu
  $ git submodule update --init dtc
  $ ./configure --target-list=3D"aarch64-softmmu,microblazeel-softmmu" --en=
able-fdt --disable-kvm --disable-xen
  $ make =

  and we have got the error during the compilation:
  /home/qemu/include/qemu/int128.h:168:1: error: static assertion failed: "=
arm generic timer needs __Int128 defined"
   _Static_assert(0, "arm generic timer needs __Int128 defined");
   ^
  /home/qemu/rules.mak:66: recipe for target 'stubs/qmp_pc_dimm.o' failed

  Could you please help to solve this issue.

  Last commit: commit  0b2f6a40631acd7e0cf789ea86b188d76c11149d

  Thanks,
  Best Regards,
  Piotr

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1816614/+subscriptions

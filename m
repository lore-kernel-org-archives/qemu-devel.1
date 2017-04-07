Received: from eggs.gnu.org ([2001:4830:134:3::10]:43743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUCK-0003ce-4l
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUCF-0001cz-75
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:45:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:39312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cwUCF-0001cN-1d
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:45:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cwUCD-0008Ul-Ke
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 13:45:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 894802E80C8
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 13:45:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2017 13:32:09 -0000
From: Thomas Huth <1014681@bugs.launchpad.net>
Reply-To: Bug 1014681 <1014681@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120618143358.15172.76386.malonedeb@wampee.canonical.com>
Message-Id: <20170407133209.1943.4008.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1014681] Re: BSOD with newer host kernels (x64)
 and W2k8S guest (x64)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Which version of QEMU have you been using here? Can you still reproduce
this with the latest version of QEMU (version 2.9)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1014681

Title:
  BSOD with newer host kernels (x64) and W2k8S guest (x64)

Status in QEMU:
  Incomplete

Bug description:
  Hallo, I attempted to move virtual machines from one host to another
  but got stuck with Windows-BSODs on the target host. The host-side
  console message is "virtio_ioport_write: unexpected address 0x13 value
  0x1". Eventually there are overlaps to bug #990364, but I'm not sure.

  Host machine: 2x Opteron 4238 a 6 cores, 32GB RAM, Linux x86_64
  Guest machine(s): Windows 2008 Server R2 x64

  I tried different combinations of component versions, but only kernel
  2.6.34 could run the guests (but has other difficulties). See testet
  variants in comment.

  Run arguments are attached. Minidump follows immediately.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1014681/+subscriptions

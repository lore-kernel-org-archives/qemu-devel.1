Received: from eggs.gnu.org ([209.51.188.92]:37758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hFr54-0000S9-LP
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 22:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hFr52-0002Xz-Uk
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 22:10:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:49048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hFr52-0002VB-Cv
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 22:10:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hFr50-00054l-SN
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 02:10:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D0CEF2E8070
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 02:10:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Apr 2019 02:00:50 -0000
From: shawn <shawnanastasio@yahoo.com>
Reply-To: Bug 1824744 <1824744@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155529202334.8409.17401063591999151604.malonedeb@wampee.canonical.com>
Message-Id: <155529365048.21129.10780887912805384723.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1824744] Re: ivshmem PCI device exposes wrong
 endianness on ppc64le
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Summary changed:

- ivshmem device PCI device exposes wrong endianness on ppc64le
+ ivshmem PCI device exposes wrong endianness on ppc64le

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1824744

Title:
  ivshmem PCI device exposes wrong endianness on ppc64le

Status in QEMU:
  New

Bug description:
  On a ppc64le host with a ppc64le guest running on QEMU 3.1.0 when an
  ivshmem device is used, the ivshmem device appears to expose the wrong
  endianness for the values in BAR 0.

  For example, when the guest is assigned an ivshmem device ID of 1, the
  IVPosition register (u32, offset 8 in BAR 0) returns 0x1000000 instead
  of 0x1. I tested on an x86_64 machine and the IVPosition reads 0x1 as
  expected.

  It seems possible that there's a ppc64*=3D=3Dbigendian assumption
  somewhere that is erroneously affecting ppc64le.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1824744/+subscriptions

Received: from eggs.gnu.org ([2001:4830:134:3::10]:39531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dxzgy-00017J-7y
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 14:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dxzgt-0008Te-Ac
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 14:07:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:41446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dxzgt-0008T7-4V
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 14:07:11 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dxzgq-0006Qm-T3
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 18:07:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D9C532E807B
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 18:07:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Sep 2017 17:47:43 -0000
From: Francis Ginther <francis.ginther@canonical.com>
Reply-To: Bug 1006655 <1006655@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120530234408.16043.24886.malonedeb@chaenomeles.canonical.com>
Message-Id: <150670726371.17422.6069611530548201500.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1006655] Re: Can't convert to vmdk with the
 streamOptimized subformat
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

** Tags added: id-5880d8a1fc49f942b6e55443

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1006655

Title:
  Can't convert to vmdk with the streamOptimized subformat

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu-kvm package in Ubuntu:
  Invalid

Bug description:
  Hi all,
  I'm trying to convert a qcow2 image file to the vmdk (on Ubuntu Server 12=
.04):

  # qemu-img convert -f qcow2 -O vmdk -o Stream spv-2912.qcow2 spv-2912-3.v=
mdk -o subformat=3DstreamOptimized
  VMDK: can't write to allocated cluster for streamOptimized
  qemu-img: error while writing sector 65: Input/output error

  Same result with any input format. Others subformats work but the
  StreamOptimized is by far the most important one. The only workaround
  I found is to migrate to raw and then to use VBoxManage (VirtualBox).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1006655/+subscriptions

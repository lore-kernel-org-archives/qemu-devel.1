Received: from eggs.gnu.org ([2001:4830:134:3::10]:38091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d7g6Q-0005DD-2s
	for qemu-devel@nongnu.org; Mon, 08 May 2017 06:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d7g6L-0004zn-4v
	for qemu-devel@nongnu.org; Mon, 08 May 2017 06:41:18 -0400
Received: from indium.canonical.com ([91.189.90.7]:54944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d7g6K-0004zf-VU
	for qemu-devel@nongnu.org; Mon, 08 May 2017 06:41:13 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d7g6I-0003zg-PM
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 10:41:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 632A42E80DD
	for <qemu-devel@nongnu.org>; Mon,  8 May 2017 10:41:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 May 2017 10:33:18 -0000
From: Benjamin Wang <1689245@bugs.launchpad.net>
Reply-To: Bug 1689245 <1689245@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170508082429.4330.4394.malonedeb@soybean.canonical.com>
Message-Id: <20170508103318.13465.57776.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1689245] Re: qcow2 image converted from Photon OS
 can't be started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I try this steps and meet the similar issue:
1. Deploy a VM in ESXi from https://bintray.com/vmware/photon/download_file=
?file_path=3Dphoton-custom-hw10-1.0-62c543d.ova
2. Copy vmdk and flat.vmdk file
3. Convert from vmdk format to raw via qeum-img(qemu-img convert -f vmdk -O=
 raw Photon.vmdk Photon.raw)
4. Launch the qcow2 image. The VM is started. And the splash screen is show=
ed. But then there is no any output.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1689245

Title:
  qcow2 image converted from Photon OS can't be started

Status in QEMU:
  New

Bug description:
  Steps to reproduce the issue:
  1. Download the ovf from this place:
  https://bintray.com/vmware/photon/download_file?file_path=3Dphoton-custom=
-hw10-1.0-62c543d.ova
  2. Extract vmdk from ova file.
  3. Convert from vmdk fromat to qcow2 via qeum-img
  4. Launch the qcow2 image. The VM is started. But there is no any output.=
 CPU usage is 100%

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1689245/+subscriptions

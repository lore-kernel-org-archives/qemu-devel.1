Received: from eggs.gnu.org ([2001:4830:134:3::10]:50791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fFmDv-000585-Ln
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fFmDq-0003ge-Mb
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:55:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:44102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fFmDq-0003g8-GQ
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:54:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fFmDp-0002ol-IU
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 19:54:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8B1B12E80CB
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 19:54:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 May 2018 19:41:56 -0000
From: Thomas Huth <1453025@bugs.launchpad.net>
Reply-To: Bug 1453025 <1453025@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150508080511.29421.69925.malonedeb@wampee.canonical.com>
Message-Id: <152572211658.2228.4260685442149934406.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1453025] Re: remote usb3.0 redir failed,
 when guest os has more than one vcpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU / libvirt / spice? Or could we close
this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1453025

Title:
  remote usb3.0 redir failed, when guest os has more than one vcpus

Status in QEMU:
  Incomplete

Bug description:
  I was testing usb3.0 redirection, it worked fine with one vcpu.
  But when I set vcpu to a number greater than one, the redirection failed.

  Host and guest are Fedora 20 and Windows 7.
  Client is remote-viwer.

  version: qemu 2.3.0  libvirt 1.2.15 spice 0.12.5

  libvirt xml:

  <vcpu placement=3D'static'>2</vcpu>
  <controller type=3D'usb' index=3D'0' model=3D'nec-xhci'>
  </controller>

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1453025/+subscriptions

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f159R-0005YW-4M
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 03:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f159N-0006bL-UM
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 03:05:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:37564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f159N-0006ab-Oe
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 03:05:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f159M-0006Qs-Rb
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 07:05:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C415A2E80C7
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 07:05:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Mar 2018 06:56:00 -0000
From: Spencer Yu <1759492@bugs.launchpad.net>
Reply-To: Bug 1759492 <1759492@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152222016058.20812.16076175479601945611.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1759492] [NEW] suspend/resume is not supported
 for vm with tpm device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

I have used libvirt with qemu to create a vm with tpm device, when I suspen=
d the vm and resume it, libvirt will
raise error:
libvirtError: internal error: process exited while connecting to monitor: E=
nter char_pty_open
I find some materials:
https://wiki.qemu.org/Features/TPM
https://lists.gnu.org/archive/html/qemu-devel/2015-05/msg05355.html
They present qemu haven't supported tpm suspend/resume, Does someone have a=
ny advice on how to resolve the problem?

qemu version: 2.10.2
vm image version: centos 7.2

Thanks

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1759492

Title:
  suspend/resume is not supported for vm with tpm device

Status in QEMU:
  New

Bug description:
  I have used libvirt with qemu to create a vm with tpm device, when I susp=
end the vm and resume it, libvirt will
  raise error:
  libvirtError: internal error: process exited while connecting to monitor:=
 Enter char_pty_open
  I find some materials:
  https://wiki.qemu.org/Features/TPM
  https://lists.gnu.org/archive/html/qemu-devel/2015-05/msg05355.html
  They present qemu haven't supported tpm suspend/resume, Does someone have=
 any advice on how to resolve the problem?

  qemu version: 2.10.2
  vm image version: centos 7.2

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1759492/+subscriptions

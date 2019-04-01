Received: from eggs.gnu.org ([209.51.188.92]:51705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hArhf-0000d4-Ue
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 03:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hArhe-0000hO-P9
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 03:49:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:60594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hArhe-0000fY-HQ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 03:49:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hArhc-0004vG-Mn
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 07:49:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 911252E86BF
	for <qemu-devel@nongnu.org>; Mon,  1 Apr 2019 07:49:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Apr 2019 07:37:56 -0000
From: Thomas Huth <1530246@bugs.launchpad.net>
Reply-To: Bug 1530246 <1530246@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20151231021806.18234.18002.malonedeb@wampee.canonical.com>
Message-Id: <155410427673.17907.4300125555818605349.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1530246] Re: Suppressing kvm rdmsr errors to
 console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I think this has been likely fixed by the following commit here:
https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?i=
d=3Dfab0aa3b776f0a3af1db1f5
... which is part of upstream kernel v4.15.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1530246

Title:
  Suppressing kvm rdmsr errors to console

Status in QEMU:
  Fix Released

Bug description:
  I am seeing numerous kvm rdmsr messages logged to /dev/tty1 (console),
  and would like to know how to suppress these messages. I've attempted
  "echo 1 > /sys/module/kvm/parameters/ignore_msrs" and the messages
  still appear on tty1.

  I'm seeing the following rdmsr messages:
  kvm [22212]: vcpu0 ignored rdmsr: 0x606
  kvm [22212]: vcpu0 ignored rdmsr: 0x611
  kvm [22212]: vcpu0 ignored rdmsr: 0x639
  kvm [22212]: vcpu0 ignored rdmsr: 0x641
  kvm [22212]: vcpu0 ignored rdmsr: 0x619
  kvm [22212]: vcpu0 ignored rdmsr: 0x1ad

  =

  The following QEMU/KVM RPMs are installed:
  ipxe-roms-qemu-20130517-7.gitc4bce43.el7.noarch
  libvirt-daemon-driver-qemu-1.2.17-13.el7_2.2.x86_64
  libvirt-daemon-kvm-1.2.17-13.el7_2.2.x86_64
  qemu-img-ev-2.3.0-31.el7_2.4.1.x86_64
  qemu-kvm-common-ev-2.3.0-31.el7_2.4.1.x86_64
  qemu-kvm-ev-2.3.0-31.el7_2.4.1.x86_64
  qemu-kvm-tools-ev-2.3.0-31.el7_2.4.1.x86_64

  uname -a
  Linux server 3.10.0-327.el7.x86_64 #1 SMP Thu Nov 19 22:10:57 UTC 2015 x8=
6_64 x86_64 x86_64 GNU/Linux

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1530246/+subscriptions

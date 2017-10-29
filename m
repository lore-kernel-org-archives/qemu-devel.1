Received: from eggs.gnu.org ([2001:4830:134:3::10]:43348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8kF3-0002XF-ET
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 05:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8kF0-00031z-AQ
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 05:50:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:46130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8kF0-00030U-4A
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 05:50:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8kEx-000839-HC
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 09:50:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7D8902E80C0
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 09:50:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 29 Oct 2017 09:37:45 -0000
From: Dmitry Ilyin <1723488@bugs.launchpad.net>
Reply-To: Bug 1723488 <1723488@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150791693020.21864.9239859411466983104.malonedeb@gac.canonical.com>
Message-Id: <150926986530.20564.3646019042153671385.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1723488] Re: HAX on Windows, memory lease error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The main problem is that HAX currently doesn't work properly at all on my b=
oth Windows 8.1 and Mac OS X 10.12.6 machines. =

I can give other examples  if it is necessary

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1723488

Title:
  HAX on Windows, memory lease error

Status in QEMU:
  New

Bug description:
  Today I tried to use QEMU on Windows 8.1 x64 with Intel HAX.

  Command line: qemu-system-x86_64.exe -accel hax -m 8000 -hda
  /opt/disk/ubuntu.img -cdrom /opt/iso/ubuntu-17.04-server-amd64.iso

  Host machine has 32Gb physical memory, I got error:

  HAX is working and emulator runs in fast virt mode.
  **
  ERROR:A:/msys64/home/admin/git/qemu/target/i386/hax-mem.c:210:hax_process=
_section: assertion failed: (size <=3D UINT32_MAX)

  When using -m 4000 (and below) everything is fine. But if I try use
  >4000 and <8000 I get crash with errors:

  HAX is working and emulator runs in fast virt mode.
  hax_transaction_commit: Failed mapping @0x0000000100000000+0x78800000 fla=
gs 00
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1723488/+subscriptions

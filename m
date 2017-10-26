Received: from eggs.gnu.org ([2001:4830:134:3::10]:51100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7hXY-0007G6-8u
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7hXT-0005Vj-AA
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:45:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:33506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7hXT-0005Us-3c
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:45:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7hXS-0006o3-0p
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 12:45:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 052372E80C7
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 12:45:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Oct 2017 12:28:06 -0000
From: Thomas Huth <1120383@bugs.launchpad.net>
Reply-To: Bug 1120383 <1120383@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130209144638.12597.95779.malonedeb@wampee.canonical.com>
Message-Id: <150902088711.17279.16748030127735202393.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1120383] Re: incremental live block migration of
 qemu 1.3.1 doesn't work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If I've got the comments right, this bug has been fixed, so closing this
now. If there is an issue remaining, please open a new bug.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1120383

Title:
  incremental live block migration of qemu 1.3.1 doesn't work

Status in QEMU:
  Fix Released

Bug description:
  We tested qemu 1.3.1 for live migration of block device. It failed
  with error.   Since qemu-kvm 1.2.0 is ok for this test, we think this
  problem is introduced by new qemu 1.3.x releases.

  To reproduce:

  1. compile qemu 1.3.1:
      # cd qemu-1.3.1
      # ./configure --prefix=3D/usr --sysconfdir=3D/etc --target-list=3Dx86=
_64-softmmu
      # make; make install

  2. prepare source(172.16.1.13):
      # qemu-img create -f qcow2 os.img -b /home/reno/wheezyx64     ###Note=
: wheezyx64 is a template image for Debian Wheezy =

      # qemu-system-x86_64 -hda os.img -m 512 --enable-kvm -vnc :51 -monito=
r stdio

  3. prepare destination(172.16.1.14):
      # qemu-img create -f qcow2 os.img -b /home/reno/wheezyx64    =

      # qemu-system-x86_64 -hda os.img -m 512 --enable-kvm -vnc :51 -incomi=
ng tcp:0:4444

  4. do live migrate:
      on source monitor command prompt, input:
      (qemu) migrate -i tcp:172.16.1.14:4444

  monitor command will quit immediately and on destination host, there are =
errors thrown:
      Receiving block device images
      Co-routine re-entered recursively
      Aborted

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1120383/+subscriptions

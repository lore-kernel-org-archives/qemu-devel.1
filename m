Received: from eggs.gnu.org ([2001:4830:134:3::10]:51503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1egeHl-0001ea-JI
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 17:22:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1egeGh-0002Ns-Ei
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 17:21:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:33980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1egeGg-0002LF-VM
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 17:20:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1egeGe-0003mZ-6D
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 22:20:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 27E3D2E8578
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 22:20:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jan 2018 22:08:02 -0000
From: Richard Jones <rjones@redhat.com>
Reply-To: Bug 1186984 <1186984@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130603131956.10716.33997.malonedeb@wampee.canonical.com>
Message-Id: <151735008306.7142.7086181616356895604.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1186984] Re: large -initrd can wrap around in
 memory causing memory corruption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The answer is I don't know.  Closing this bug seems correct unless
someone can reproduce the original problem.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1186984

Title:
  large -initrd can wrap around in memory causing memory corruption

Status in QEMU:
  Incomplete

Bug description:
  We don't use large -initrd in libguestfs any more, but I noticed that
  a large -initrd file now crashes qemu spectacularly:

  $ ls -lh /tmp/kernel /tmp/initrd =

  -rw-r--r--. 1 rjones rjones 273M Jun  3 14:02 /tmp/initrd
  lrwxrwxrwx. 1 rjones rjones   35 Jun  3 14:02 /tmp/kernel -> /boot/vmlinu=
z-3.9.4-200.fc18.x86_64

  $ ./x86_64-softmmu/qemu-system-x86_64 -L pc-bios \
      -kernel /tmp/kernel -initrd /tmp/initrd -hda /tmp/test1.img -serial s=
tdio \
      -append console=3DttyS0

  qemu crashes with one of several errors:

  PFLASH: Possible BUG - Write block confirm

  qemu: fatal: Trying to execute code outside RAM or ROM at
  0x00000000000b96cd

  If -enable-kvm is used:

  KVM: injection failed, MSI lost (Operation not permitted)

  In all cases the SDL display fills up with coloured blocks before the
  crash (see the attached screenshot).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1186984/+subscriptions

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cGNsk-0002Fr-PY
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cGNsg-0001Gc-7S
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:30:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:55362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cGNsg-0001GJ-1a
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:30:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cGNse-0007KM-ET
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 10:30:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6BC482E80CC
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 10:30:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Dec 2016 10:24:47 -0000
From: Vasya <1649236@bugs.launchpad.net>
Reply-To: Bug 1649236 <1649236@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20161212102447.23016.40899.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1649236] [NEW] Commit snapshot fails with
 Permission denied when daemonized
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

When running qemu with daemonize option it is impossible to run "commit
all" in monitor.

I run qemu 2.7.0 under gentoo 64 bit distribution with following command
line:

qemu-system-x86_64 -m 4096 -cpu host -smp 2 -enable-kvm -snapshot \
    -drive file=3Dvm.img,if=3Dvirtio \
    -net nic,model=3Dvirtio,macaddr=3D11:11:11:11:11:11 \
    -net tap,ifname=3Dtap$PORT,script=3Dno,downscript=3Dno \
    -vnc :1 -daemonize \
    -chardev vc,id=3Dmon0 -mon chardev=3Dmon0,mode=3Dreadline \
    -chardev socket,id=3Dmon1,host=3Dlocalhost,port=3D10001,server,nowait -=
mon chardev=3Dmon1,mode=3Dcontrol =


I connect to vm through VNC viewer and press CTRL+ALT+2 and run "commit all=
" command.
Following error is shown:
`commit` error for `all`: Permission denied

When I run my VM without `daemonize` option the command "commit all"
works without errors.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: commit daemonize

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1649236

Title:
  Commit snapshot fails with Permission denied when daemonized

Status in QEMU:
  New

Bug description:
  When running qemu with daemonize option it is impossible to run
  "commit all" in monitor.

  I run qemu 2.7.0 under gentoo 64 bit distribution with following
  command line:

  qemu-system-x86_64 -m 4096 -cpu host -smp 2 -enable-kvm -snapshot \
      -drive file=3Dvm.img,if=3Dvirtio \
      -net nic,model=3Dvirtio,macaddr=3D11:11:11:11:11:11 \
      -net tap,ifname=3Dtap$PORT,script=3Dno,downscript=3Dno \
      -vnc :1 -daemonize \
      -chardev vc,id=3Dmon0 -mon chardev=3Dmon0,mode=3Dreadline \
      -chardev socket,id=3Dmon1,host=3Dlocalhost,port=3D10001,server,nowait=
 -mon chardev=3Dmon1,mode=3Dcontrol =


  I connect to vm through VNC viewer and press CTRL+ALT+2 and run "commit a=
ll" command.
  Following error is shown:
  `commit` error for `all`: Permission denied

  When I run my VM without `daemonize` option the command "commit all"
  works without errors.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1649236/+subscriptions

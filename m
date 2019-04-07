Received: from eggs.gnu.org ([209.51.188.92]:35055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hD37j-0002He-W3
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 04:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hD37i-0001mU-8M
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 04:25:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:59864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hD37g-0001kJ-6i
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 04:25:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hD37c-0002C3-AO
	for <qemu-devel@nongnu.org>; Sun, 07 Apr 2019 08:25:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4AA0E2E80CC
	for <qemu-devel@nongnu.org>; Sun,  7 Apr 2019 08:25:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Apr 2019 08:17:32 -0000
From: sles <1807073@bugs.launchpad.net>
Reply-To: Bug 1807073 <1807073@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154406426264.32667.2616897072259419283.malonedeb@chaenomeles.canonical.com>
Message-Id: <155462505297.21252.8956715668662426160.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1807073] Re: qemu-guest-agent stop work when
 fsfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Just got almost the same
Ubuntu 16.04 as guest on Centos 7 host,
all will latest updates.

Execute of
virsh qemu-agent-command inetgw2 '{"execute":"guest-fsfreeze-freeze"}'

failed with agent not available ( or something like this), but fsfreeze exe=
cuted in OS
Apr  7 02:28:54 inetgw2 qemu-ga: info: guest-fsfreeze called

snapshot was created =

after this =

virsh qemu-agent-command inetgw2 '{"execute":"guest-fsfreeze-thaw"}'
failed too with agent not available

So Ubuntu 16.04 VM stuck in  freezed i/o state.
 qemu-guest-age 1:2.5+dfsg-5

Same version...

Thank you!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1807073

Title:
  qemu-guest-agent stop work when fsfreeze

Status in QEMU:
  New

Bug description:
  Create a live snapshot, we should first to fsfreeze the file system. We d=
o have only one disk mounted to /:
  Filesystem      Size  Used Avail Use% Mounted on
  udev             48G     0   48G   0% /dev
  tmpfs           9.5G  8.7M  9.5G   1% /run
  /dev/vda1       485G  1.5G  484G   1% /
  tmpfs            48G     0   48G   0% /dev/shm
  tmpfs           5.0M     0  5.0M   0% /run/lock
  tmpfs            48G     0   48G   0% /sys/fs/cgroup
  tmpfs           9.5G     0  9.5G   0% /run/user/0

  snapshot action is OK, when we restore the snapshot, the file system beca=
me read-only, and syslog seems stop writing until we fsck /dev/vda1 and mou=
nt -o rw,remount /:
  Dec  5 00:39:16 systemd[1]: Started Session 180 of user root.
  Dec  5 00:45:05 qemu-ga: info: guest-fsfreeze called
  Dec  5 07:00:45 kernel: [  114.623823] EXT4-fs (vda1): re-mounted. Opts: =
(null)

  So after snapshoting, wo do fsthaw the file system,  maybe the qga
  dose not respond or stop work, this action dose not execute
  successfully and there is no log to show the status of qemu-guest-
  agent.

  Version:
  libvirt 1.2.17
  qemu 2.3.0
  qemu-guest-agent 2.5

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1807073/+subscriptions

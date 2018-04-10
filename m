Received: from eggs.gnu.org ([2001:4830:134:3::10]:57737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f5mLG-0005n5-Uo
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 02:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f5mLB-00084T-2i
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 02:01:19 -0400
Received: from indium.canonical.com ([91.189.90.7]:40378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f5mLA-000844-TA
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 02:01:13 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f5mL9-0003wa-Nh
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 06:01:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AD9A62E8070
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 06:01:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Apr 2018 05:55:08 -0000
From: Thomas Huth <1762558@bugs.launchpad.net>
Reply-To: Bug 1762558 <1762558@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152330957721.2718.12035311068510492278.malonedeb@wampee.canonical.com>
Message-Id: <152333970873.30312.11544902540045307331.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1762558] Re: Many crashes with "memslot_get_virt:
 slot_id 170 too big"-type errors in 2.12.0 rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

These error messages ("memslot_get_virt") do not come from QEMU, but
from spice, so please report this problem to the Spice project first
(see https://www.spice-space.org/support.html for how to file a bug
there).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1762558

Title:
  Many crashes with "memslot_get_virt: slot_id 170 too big"-type errors
  in 2.12.0 rc2

Status in QEMU:
  New

Bug description:
  Since qemu 2.12.0 rc2 - qemu-2.12.0-0.6.rc2.fc29 - landed in Fedora
  Rawhide, just about all of our openQA-automated tests of Rawhide
  guests which run with qxl / SPICE graphics in the guest have died
  partway in, always shortly after the test switches from the installer
  (an X environment) to a console on a tty. qemu is, I think, hanging.
  There are always some errors like this right around the time of the
  hang:

  [2018-04-09T20:13:42.0736 UTC] [debug] QEMU: id 0, group 0, virt start 0,=
 virt end ffffffffffffffff, generation 0, delta 0
  [2018-04-09T20:13:42.0736 UTC] [debug] QEMU: id 1, group 1, virt start 7f=
42dbc00000, virt end 7f42dfbfe000, generation 0, delta 7f42dbc00000
  [2018-04-09T20:13:42.0736 UTC] [debug] QEMU: id 2, group 1, virt start 7f=
42d7a00000, virt end 7f42dba00000, generation 0, delta 7f42d7a00000
  [2018-04-09T20:13:42.0736 UTC] [debug] QEMU: =

  [2018-04-09T20:13:42.0736 UTC] [debug] QEMU: (process:45812): Spice-CRITI=
CAL **: memslot.c:111:memslot_get_virt: slot_id 218 too big, addr=3Dda8e21f=
bda8e21fb

  or occasionally like this:

  [2018-04-09T20:13:58.0717 UTC] [debug] QEMU: id 0, group 0, virt start 0,=
 virt end ffffffffffffffff, generation 0, delta 0
  [2018-04-09T20:13:58.0720 UTC] [debug] QEMU: id 1, group 1, virt start 7f=
f093c00000, virt end 7ff097bfe000, generation 0, delta 7ff093c00000
  [2018-04-09T20:13:58.0720 UTC] [debug] QEMU: id 2, group 1, virt start 7f=
f08fa00000, virt end 7ff093a00000, generation 0, delta 7ff08fa00000
  [2018-04-09T20:13:58.0720 UTC] [debug] QEMU: =

  [2018-04-09T20:13:58.0720 UTC] [debug] QEMU: (process:25622): Spice-WARNI=
NG **: memslot.c:68:memslot_validate_virt: virtual address out of range
  [2018-04-09T20:13:58.0720 UTC] [debug] QEMU:     virt=3D0x0+0x18 slot_id=
=3D0 group_id=3D1
  [2018-04-09T20:13:58.0721 UTC] [debug] QEMU:     slot=3D0x0-0x0 delta=3D0=
x0
  [2018-04-09T20:13:58.0721 UTC] [debug] QEMU: =

  [2018-04-09T20:13:58.0721 UTC] [debug] QEMU: (process:25622): Spice-WARNI=
NG **: display-channel.c:2426:display_channel_validate_surface: invalid sur=
face_id 1048576
  [2018-04-09T20:14:14.0728 UTC] [debug] QEMU: id 0, group 0, virt start 0,=
 virt end ffffffffffffffff, generation 0, delta 0
  [2018-04-09T20:14:14.0728 UTC] [debug] QEMU: id 1, group 1, virt start 7f=
f093c00000, virt end 7ff097bfe000, generation 0, delta 7ff093c00000
  [2018-04-09T20:14:14.0728 UTC] [debug] QEMU: id 2, group 1, virt start 7f=
f08fa00000, virt end 7ff093a00000, generation 0, delta 7ff08fa00000
  [2018-04-09T20:14:14.0728 UTC] [debug] QEMU: =

  [2018-04-09T20:14:14.0728 UTC] [debug] QEMU: (process:25622): Spice-CRITI=
CAL **: memslot.c:122:memslot_get_virt: address generation is not valid, gr=
oup_id 1, slot_id 0, gen 110, slot_gen 0

  The same tests running on Fedora 28 guests on the same hosts are not
  hanging, and the same tests were not hanging right before the qemu
  package got updated, so this seems very strongly tied to the new qemu.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1762558/+subscriptions

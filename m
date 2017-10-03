Received: from eggs.gnu.org ([2001:4830:134:3::10]:58331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzJvZ-0000vK-D8
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzJuo-00084H-Kr
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:55:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:44678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dzJuo-00081Y-AP
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:55:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dzJul-0005J6-LV
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 09:54:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 59D7B2E80D6
	for <qemu-devel@nongnu.org>; Tue,  3 Oct 2017 09:54:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Oct 2017 09:42:45 -0000
From: Thomas Huth <1321464@bugs.launchpad.net>
Reply-To: Bug 1321464 <1321464@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140520214851.1935.57767.malonedeb@gac.canonical.com>
Message-Id: <150702376600.28506.9781900912932354751.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1321464] Re: qemu/block/qcow2.c:1942: possible
 performance problem ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks for reporting this, but it looks like the related code has been
removed a while ago (there is no more "pad_buf" in qcow.c or qcow2.c),
so closing this ticket. If you still can reproduce the (same or similar)
problem with the latest version of QEMU, please open a new ticket
instead.

** Changed in: qemu
       Status: New =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1321464

Title:
  qemu/block/qcow2.c:1942: possible performance problem ?

Status in QEMU:
  Won't Fix

Bug description:
  I just ran static analyser cppcheck over today (20140520) qemu source
  code.

  It said many things, including

  [qemu/block/qcow2.c:1942] -> [qemu/block/qcow2.c:1943]: (performance) Buf=
fer 'pad_buf' is being writ
  ten before its old content has been used.

  Source code is

              memset(pad_buf, 0, s->cluster_size);
              memcpy(pad_buf, buf, nb_sectors * BDRV_SECTOR_SIZE);

  Worth tuning ?

  Similar problem here

  [qemu/block/qcow.c:815] -> [qemu/block/qcow.c:816]: (performance) Buffer =
'pad_buf' is being written =

  before its old content has been used.

  and

  [qemu/hw/i386/acpi-build.c:1265] -> [qemu/hw/i386/acpi-build.c:1267]: (pe=
rformance) Buffer 'dsdt' is
   being written before its old content has been used.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1321464/+subscriptions

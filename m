Received: from eggs.gnu.org ([2001:4830:134:3::10]:51317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dwtNx-0001k9-4W
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dwtNs-00030M-4E
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:11:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:48620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dwtNr-0002zQ-TL
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:11:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dwtNq-0003PU-4p
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 17:10:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 231452E8053
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 17:10:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Sep 2017 17:04:55 -0000
From: Erich Spaker <erichspaker@gmail.com>
Reply-To: Bug 1719689 <1719689@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150644549574.30872.12487281678930398558.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1719689] [NEW] [feature request] add flag to
 treat warnings as errors
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

Since booting could potentially take a lot of time and warnings are
likely to indicate that something is wrong, it would be useful to have a
command line flag which would abort the boot if there are any warnings.

An example might be network configuration. The following output most
likely indicates that there is something the user has to fix before
starting and being able to use the guest os.

Warning: hub port hub0port0 has no peer
Warning: vlan 0 with no nics
Warning: netdev hub0port0 has no peer
Warning: requested NIC (anonymous, model vitrio-net-device) was not created=
 (not supported by this machine?)

Ideally, there would be an option the user could pass which would cause
qemu to print these warnings then exit, rather than boot the kernel.

Alternatively, or additionally, a dry run option would be helpful for
the same purpose: making sure qemu get to the booting the kernel stage
with everything in working order so that you do not have to wait for the
kernel to boot and then shut down while debugging things like networking
(things which can be debugged (at least partially) without booting, or
trying to boot, the guest os).

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: feature-request

** Summary changed:

- add flag to abort boot after any warnings
+ [feature request] add flag to treat warnings as errors

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1719689

Title:
  [feature request] add flag to treat warnings as errors

Status in QEMU:
  New

Bug description:
  Since booting could potentially take a lot of time and warnings are
  likely to indicate that something is wrong, it would be useful to have
  a command line flag which would abort the boot if there are any
  warnings.

  An example might be network configuration. The following output most
  likely indicates that there is something the user has to fix before
  starting and being able to use the guest os.

  Warning: hub port hub0port0 has no peer
  Warning: vlan 0 with no nics
  Warning: netdev hub0port0 has no peer
  Warning: requested NIC (anonymous, model vitrio-net-device) was not creat=
ed (not supported by this machine?)

  Ideally, there would be an option the user could pass which would
  cause qemu to print these warnings then exit, rather than boot the
  kernel.

  Alternatively, or additionally, a dry run option would be helpful for
  the same purpose: making sure qemu get to the booting the kernel stage
  with everything in working order so that you do not have to wait for
  the kernel to boot and then shut down while debugging things like
  networking (things which can be debugged (at least partially) without
  booting, or trying to boot, the guest os).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1719689/+subscriptions

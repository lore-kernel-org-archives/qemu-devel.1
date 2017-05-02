Received: from eggs.gnu.org ([2001:4830:134:3::10]:52352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d5USi-00036K-BY
	for qemu-devel@nongnu.org; Tue, 02 May 2017 05:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d5USf-0006R2-9p
	for qemu-devel@nongnu.org; Tue, 02 May 2017 05:51:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:47988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d5USf-0006Qb-4T
	for qemu-devel@nongnu.org; Tue, 02 May 2017 05:51:13 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d5USU-0003H3-IC
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 09:51:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6E6032E81A2
	for <qemu-devel@nongnu.org>; Tue,  2 May 2017 09:50:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 May 2017 09:42:17 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reply-To: Bug 1687578 <1687578@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170502092542.26484.80835.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170502094217.26570.4469.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1687578] Re: when migrate vm, reboot in guest os,
 the guest os sometime hang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,
  What's the last thing the guest outputs before the hang?
  Does it get back to the bios or does it hang before that?
  Has the migration finished at that point or is it still going?

Dave

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1687578

Title:
  when migrate vm, reboot in guest os, the guest os sometime hang

Status in QEMU:
  New

Bug description:
  qemu version:v2.9.0-rc5 release

  1.virsh migrate --live 165cf436-312f-47e7-90f2-f8aa63f34893 --copy-storag=
e-inc qemu+ssh://10.59.163.38/system
  2.run reboot in guest os, add reboot in /etc/rc.local
  3.guest os hang sometime.

  strace output of qemu:

  ppoll([{fd=3D9, events=3DPOLLIN}, {fd=3D8, events=3DPOLLIN}, {fd=3D4, eve=
nts=3DPOLLIN}, {fd=3D6, events=3DPOLLIN}, {fd=3D30, events=3DPOLLIN}, {fd=
=3D31, events=3DPOLLIN}], 6, {0, 0}, NULL, 8) =3D 0 (Timeout)
  ppoll([{fd=3D9, events=3DPOLLIN}, {fd=3D8, events=3DPOLLIN}, {fd=3D4, eve=
nts=3DPOLLIN}, {fd=3D6, events=3DPOLLIN}, {fd=3D30, events=3DPOLLIN}, {fd=
=3D31, events=3DPOLLIN}], 6, {0, 698000000}, NULL, 8) =3D 0 (Timeout)
  poll([{fd=3D20, events=3DPOLLOUT}], 1, 0)   =3D 1 ([{fd=3D20, revents=3DP=
OLLOUT|POLLHUP}])
  ppoll([{fd=3D9, events=3DPOLLIN}, {fd=3D8, events=3DPOLLIN}, {fd=3D4, eve=
nts=3DPOLLIN}, {fd=3D6, events=3DPOLLIN}, {fd=3D30, events=3DPOLLIN}, {fd=
=3D31, events=3DPOLLIN}], 6, {0, 999000000}, NULL, 8^C <unfinished ...>

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1687578/+subscriptions

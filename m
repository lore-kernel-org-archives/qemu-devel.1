Received: from eggs.gnu.org ([2001:4830:134:3::10]:60934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fISXl-0000Z7-Qm
	for qemu-devel@nongnu.org; Tue, 15 May 2018 01:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fISXh-0006Kb-G6
	for qemu-devel@nongnu.org; Tue, 15 May 2018 01:30:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:45778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fISXh-0006Jz-9z
	for qemu-devel@nongnu.org; Tue, 15 May 2018 01:30:33 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fISXg-0006vm-0p
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 05:30:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 02F802E8033
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 05:30:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 May 2018 05:13:50 -0000
From: Thomas Huth <658904@bugs.launchpad.net>
Reply-To: Bug 658904 <658904@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20101012023257.6994.73536.malonedeb@potassium.ubuntu.com>
Message-Id: <152636123079.1272.13178245401517888536.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 658904] Re: QEMU refers to VLAN,
 but doesn't mean 802.1Q
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This issue has finally been addressed here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Daf1a5c3eb41521b4f090a=
d61

** Changed in: qemu
       Status: New =3D> Fix Released

** Changed in: qemu
       Status: Fix Released =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/658904

Title:
  QEMU refers to VLAN, but doesn't mean 802.1Q

Status in QEMU:
  Fix Committed

Bug description:
  Throughout the (sparse) documentation and the cmd-line help text, Qemu
  refers to VLAN ("virtual" LANs), which are unrelated to 802.1Q (tagged
  ethernet) VLAN, which, IMHO is _very_ confusing. Beyond that, it's
  also unnecessary, as the network in question isn't "virtual", only the
  devices used to implement it are.

  To avoid further frustration and confusion, can the term VLAN,
  _please_ be removed from source and documentation and replaced with
  something more suitable? Perhaps vNIC (seems like VMware is using that
  term for a similiar concept)?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/658904/+subscriptions

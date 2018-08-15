Received: from eggs.gnu.org ([2001:4830:134:3::10]:57922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpqUc-0004v5-4I
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpqUY-0007iG-9w
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:45:22 -0400
Received: from indium.canonical.com ([91.189.90.7]:53392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fpqUY-0007hz-18
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:45:18 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fpqUX-0007Be-8E
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:45:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3B6E22E851B
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:45:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Aug 2018 07:30:23 -0000
From: Thomas Huth <658904@bugs.launchpad.net>
Reply-To: Bug 658904 <658904@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20101012023257.6994.73536.malonedeb@potassium.ubuntu.com>
Message-Id: <153431822476.26633.3475047740996162718.launchpad@gac.canonical.com>
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

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/658904

Title:
  QEMU refers to VLAN, but doesn't mean 802.1Q

Status in QEMU:
  Fix Released

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

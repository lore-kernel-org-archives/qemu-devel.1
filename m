Received: from eggs.gnu.org ([2001:4830:134:3::10]:47226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fxZJi-0006ah-Lv
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 11:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fxZJb-0006aS-Hz
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 11:02:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:43260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fxZJb-0005h3-7A
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 11:01:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fxZJ2-0007fE-KG
	for <qemu-devel@nongnu.org>; Wed, 05 Sep 2018 15:01:20 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8AC372E80D1
	for <qemu-devel@nongnu.org>; Wed,  5 Sep 2018 15:01:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Sep 2018 14:48:09 -0000
From: "Emilio G. Cota" <1735049@bugs.launchpad.net>
Reply-To: Bug 1735049 <1735049@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151192504398.10243.14437635177032457733.malonedeb@wampee.canonical.com>
Message-Id: <153615888911.31864.10638431692528014998.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1735049] Re: Need MTTCG support for x86 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Patches are now on the list to enable MTTCG for i386 and x86_64 guests.
See v2 here:

https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg00237.html

I'm hoping these patches will be in the next QEMU release.

Regarding your last question:
> For instance, has support for strong-on-weak memory consistency been adde=
d into QEMU GIT at this point?

Yes, TCG inserts the appropriate barriers around memory accesses since
commit b32dc3370a ("tcg: Implement implicit ordering semantics",
2017-09-05)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1735049

Title:
  Need MTTCG support for x86 guests

Status in QEMU:
  In Progress

Bug description:
  MTTCG support is notably absent for x86_64 guests.  The last Wiki
  update on MTTCG was back in 2015, and I am having some difficulty
  determining the current status of the underlying requirements to
  enable this feature on x86 hosts.

  For instance, has support for strong-on-weak memory consistency been
  added into QEMU GIT at this point?

  Thanks!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1735049/+subscriptions

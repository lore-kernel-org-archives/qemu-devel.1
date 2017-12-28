Received: from eggs.gnu.org ([2001:4830:134:3::10]:58421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eUPq7-0001Pf-4t
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 23:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eUPq6-0001wo-9z
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 23:30:43 -0500
Received: from indium.canonical.com ([91.189.90.7]:59868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eUPq6-0001w5-4Y
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 23:30:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eUPq5-0007oj-2q
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 04:30:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 147CD2E80C8
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 04:30:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Dec 2017 04:17:33 -0000
From: Launchpad Bug Tracker <1007490@bugs.launchpad.net>
Reply-To: Bug 1007490 <1007490@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120601154929.16290.63387.malonedeb@wampee.canonical.com>
Message-Id: <151443465329.28609.9028143659313325125.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1007490] Re: Missing binfmt string for init
 script.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1007490

Title:
  Missing binfmt string for init script.

Status in QEMU:
  Expired

Bug description:
  ./scripts/qemu-binfmt-conf.sh

  needs

  echo
  ':armCompiler:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x08\x00\=
x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xf=
f\xff\xfe\xff\xff\xff:/usr/bin
  /qemu-static-arm-binfmt:P' > /proc/sys/fs/binfmt_misc/register

  Some executables (specifically compilers like /usr/libexec/gcc/armv7a-
  unknown-linux-gnueabi/4.5.3/cc1 on gentoo) have unusual headers, and
  don't get recognized as arm binaries.

  Bug also mentioned on my blog:
  http://mirage335.dyndns.org/forums/viewtopic.php?f=3D4&t=3D11&sid=3D01f0c=
a9cc76c78b6f600fa25cc99d62b

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1007490/+subscriptions

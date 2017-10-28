Received: from eggs.gnu.org ([2001:4830:134:3::10]:48963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8SVp-00042K-Ud
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 10:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8SVm-0001yn-Ul
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 10:55:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:34556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8SVm-0001xF-Oo
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 10:54:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8SVl-0006Gj-G8
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 14:54:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6E35D2E80CB
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 14:54:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 14:45:00 -0000
From: Thomas Huth <1007490@bugs.launchpad.net>
Reply-To: Bug 1007490 <1007490@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120601154929.16290.63387.malonedeb@wampee.canonical.com>
Message-Id: <150920190018.4653.17420634034133304846.malone@chaenomeles.canonical.com>
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

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1007490

Title:
  Missing binfmt string for init script.

Status in QEMU:
  Incomplete

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

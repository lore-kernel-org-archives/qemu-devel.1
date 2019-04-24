Received: from eggs.gnu.org ([209.51.188.92]:41100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAPg-0005JK-8A
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAPd-00050I-MN
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:25:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:35606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJAPc-0004t0-M3
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:25:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJAPa-0002Gy-VE
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:25:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EA9312E80C8
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:25:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 05:18:33 -0000
From: Thomas Huth <1813034@bugs.launchpad.net>
Reply-To: Bug 1813034 <1813034@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154825664980.17863.13835329741356483876.malonedeb@chaenomeles.canonical.com>
Message-Id: <155608311470.16887.12517373532247581811.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1813034] Re: create_elf_tables() doesn't set
 AT_PLATFORM for 32bit ARM platforms
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
https://bugs.launchpad.net/bugs/1813034

Title:
  create_elf_tables() doesn't set AT_PLATFORM for 32bit ARM  platforms

Status in QEMU:
  Fix Released

Bug description:
  The dynamic linker uses AT_PLATFORM from getauxval to substitute
  $PLATFORM in certain places (man ld.so). It would be nice if it was
  set to 'v6l', 'v7l' and whatever other platforms there are according
  to the chosen CPU or via an environment variable. AT_PLATFORM is not
  guaranteed to be set, so this isn't a major bug, but this is one case
  where it makes things difficult.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1813034/+subscriptions

Received: from eggs.gnu.org ([209.51.188.92]:38418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gtfnM-0000GK-0C
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:40:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gtfnL-0005ry-2J
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:40:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:40014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gtfnK-0005qZ-RZ
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:40:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gtfnJ-0005lk-4u
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 21:40:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2407C2E80C9
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 21:40:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Feb 2019 21:34:17 -0000
From: Richard Henderson <rth@twiddle.net>
Reply-To: Bug 1813034 <1813034@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154825664980.17863.13835329741356483876.malonedeb@chaenomeles.canonical.com>
Message-Id: <155000725725.19204.10846055840278737276.malone@soybean.canonical.com>
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

Patches posted:
https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg02863.html

** Changed in: qemu
     Assignee: (unassigned) =3D> Richard Henderson (rth)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1813034

Title:
  create_elf_tables() doesn't set AT_PLATFORM for 32bit ARM  platforms

Status in QEMU:
  New

Bug description:
  The dynamic linker uses AT_PLATFORM from getauxval to substitute
  $PLATFORM in certain places (man ld.so). It would be nice if it was
  set to 'v6l', 'v7l' and whatever other platforms there are according
  to the chosen CPU or via an environment variable. AT_PLATFORM is not
  guaranteed to be set, so this isn't a major bug, but this is one case
  where it makes things difficult.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1813034/+subscriptions

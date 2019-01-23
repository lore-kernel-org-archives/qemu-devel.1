Received: from eggs.gnu.org ([209.51.188.92]:33393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gmKPL-0002pA-F0
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:25:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gmKPK-0002Cg-Il
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:25:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:39394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gmKPK-0002Br-Cv
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:25:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gmKPJ-0007Ad-13
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 15:25:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D426B2E80D2
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 15:25:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Jan 2019 15:17:29 -0000
From: ShiftPlusOne <1813034@bugs.launchpad.net>
Reply-To: Bug 1813034 <1813034@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154825664980.17863.13835329741356483876.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1813034] [NEW] create_elf_tables() doesn't set
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

Public bug reported:

The dynamic linker uses AT_PLATFORM from getauxval to substitute
$PLATFORM in certain places (man ld.so). It would be nice if it was set
to 'v6l', 'v7l' and whatever other platforms there are according to the
chosen CPU or via an environment variable. AT_PLATFORM is not guaranteed
to be set, so this isn't a major bug, but this is one case where it
makes things difficult.

** Affects: qemu
     Importance: Undecided
         Status: New

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

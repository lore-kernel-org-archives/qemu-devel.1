Received: from eggs.gnu.org ([209.51.188.92]:57130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gkXuE-000062-NL
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:26:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gkXuD-0005NK-U2
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:26:10 -0500
Received: from indium.canonical.com ([91.189.90.7]:50624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gkXuD-0005Mg-Nw
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:26:09 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gkXuC-0002gV-JW
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 17:26:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8F4262E80C7
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 17:26:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Jan 2019 17:20:15 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1795148 <1795148@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153823442833.30132.5797682134380809612.malonedeb@soybean.canonical.com>
Message-Id: <154783201537.2523.491779516327012669.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1795148] Re: address_space_stw_le_cached:
 Assertion `addr < cache->len && 2 <= cache ->len - addr' failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In the absence of further information from the submitter, it seems
reasonable to assume that this is indeed the bug fixed by commit
db812c4073c77 (which resulted in this assertion when running OpenBSD
guests). That commit is in 3.1, which was released in December.


** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1795148

Title:
  address_space_stw_le_cached: Assertion `addr < cache->len && 2 <=3D
  cache ->len - addr' failed

Status in QEMU:
  Fix Released

Bug description:
  When running OpenBSD-current as a guest, the following assertion is
  hit after a few seconds, resulting in the virtual machine to crash:

  ```
  qemu-system-x86_64: /build/qemu/src/qemu-3.0.0/include/exec/memory_ldst_c=
ached.inc.h:85: address_space_stw_le_cached: Assertion `addr < cache->len &=
& 2 <=3D cache->len - addr' failed.
  ```

  Host is Arch Linux stable, running on x86_64.

  Qemu version is 3.0.0, installed via the standard Arch Linux package.

  Version 2.12.1 didn't exhibit this behavior.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1795148/+subscriptions

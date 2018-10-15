Received: from eggs.gnu.org ([2001:4830:134:3::10]:35841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gBzWV-0001ZF-Fu
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gBzWS-0000s3-5V
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:50:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:33332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gBzWR-0000oB-Ut
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:50:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gBzWN-0008Fa-9A
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 09:50:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D23982E80D2
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 09:50:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Oct 2018 09:39:18 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1795148 <1795148@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153823442833.30132.5797682134380809612.malonedeb@soybean.canonical.com>
Message-Id: <153959635885.15830.14259272628561611229.malone@gac.canonical.com>
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

I suspect this is a known bug, fixed in master in commit db812c4073c77.
You could test that by cherry-picking it to 3.0 or just testing against
master.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1795148

Title:
  address_space_stw_le_cached: Assertion `addr < cache->len && 2 <=3D
  cache ->len - addr' failed

Status in QEMU:
  New

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

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gBws6-00010v-O5
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gBws3-0005iJ-Is
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:00:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:43450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gBws3-0005hO-Ap
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:00:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gBws1-0001Hm-2U
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 07:00:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 10FFA2E80CC
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 07:00:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Oct 2018 06:46:07 -0000
From: Thomas Huth <1795148@bugs.launchpad.net>
Reply-To: Bug 1795148 <1795148@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153823442833.30132.5797682134380809612.malonedeb@soybean.canonical.com>
Message-Id: <153958596760.3499.1457781402179866020.malone@soybean.canonical.com>
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

Do you know how to use "git bisect"? If so, could you maybe try to
bisect which commit between v2.12.0 and v3.0.0 introduced this problem?

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

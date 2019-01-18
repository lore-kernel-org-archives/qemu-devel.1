Received: from eggs.gnu.org ([209.51.188.92]:55748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gkXp0-0005Km-9s
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:20:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gkXoz-00083K-GY
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:20:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:48452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gkXoz-0007zJ-Az
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:20:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gkXow-0001Iv-Pl
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 17:20:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 43B532E80D1
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 17:20:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Jan 2019 17:01:25 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 741115 <741115@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110323164949.17887.98157.malonedeb@soybean.canonical.com>
Message-Id: <154783088576.16257.14307662353267598647.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 741115] Re: Add support of coprocessor cp15,
 cp14 registers exposion in the embedded gdb server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Since QEMU 3.0 the QEMU gdb stub supports read-only access to most
cp14/cp15 registers. The gdb 'info all-registers' command will print all
the registers (integer, fp and system registers), or individual
registers can be read with commands like "print /x $SCTLR".

Write access isn't supported (that is a lot trickier to do in a reliable
way since QEMU's internals make assumptions that system registers can
only be changed in the ways that the guest validly can, and there's no
easy API to connect to the debug stub that would allow the user to
change system registers in only safe ways).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/741115

Title:
  Add support of coprocessor cp15, cp14 registers exposion in the
  embedded gdb server

Status in QEMU:
  New

Bug description:
  Please add support of exposion of ARM coprocesor registers/logic at the e=
mbedded gdb server,
   for example of cp15, cp14, etc registers.

  Related project http://jtagarmgdbsrvr.sourceforge.net/index.html

  Also filled bug in the GDB
  http://sourceware.org/bugzilla/show_bug.cgi?id=3D12602

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/741115/+subscriptions

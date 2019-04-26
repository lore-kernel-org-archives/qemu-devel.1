Received: from eggs.gnu.org ([209.51.188.92]:53277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hK2t9-00065p-3Z
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 11:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hK2t8-0004eN-2s
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 11:35:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:37988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hK2t7-0004c7-TT
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 11:35:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hK2t4-0004h2-An
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 15:35:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D951F2E81B0
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 15:35:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Apr 2019 15:23:42 -0000
From: Floyd42 <1826568@bugs.launchpad.net>
Reply-To: Bug 1826568 <1826568@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155629222212.6615.9281610848583512798.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1826568] [NEW] RISC-V Disassembler/translator
 instruction decoding disagreement
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


When running QEMU V3.1.0 for platform  RISC-V, 64bit, Spike V1.10 with "-d =
in_asm -singlestep -D qemu_log.txt", my (faulty) test code brought up this =
message in the logs:

  0x000000008002cade:  051300009517e2bf  illegal         =

  Disassembler disagrees with translator over instruction decoding
  Please report this to qemu-devel@nongnu.org


You may want to resolve the disagreement.

Axel

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1826568

Title:
  RISC-V Disassembler/translator instruction decoding disagreement

Status in QEMU:
  New

Bug description:
  =

  When running QEMU V3.1.0 for platform  RISC-V, 64bit, Spike V1.10 with "-=
d in_asm -singlestep -D qemu_log.txt", my (faulty) test code brought up thi=
s message in the logs:

    0x000000008002cade:  051300009517e2bf  illegal         =

    Disassembler disagrees with translator over instruction decoding
    Please report this to qemu-devel@nongnu.org

  =

  You may want to resolve the disagreement.

  Axel

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1826568/+subscriptions

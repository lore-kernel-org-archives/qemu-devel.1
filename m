Received: from eggs.gnu.org ([209.51.188.92]:41054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gtpMc-00023i-A5
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:53:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gtpEq-0004cN-EK
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:45:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:47262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gtpEm-0004KG-UB
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:45:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gtpEh-0000eX-Nt
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 07:45:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AFF9F2E804F
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 07:45:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Feb 2019 07:37:04 -0000
From: RTOS Pharos <1815721@bugs.launchpad.net>
Reply-To: Bug 1815721 <1815721@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155004342499.19242.14077661245921319117.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1815721] [NEW] RISC-V PLIC enable interrupt for
 multicore
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

Hello all,

There is a bug in Qemu related to the enabling of external interrupts
for multicores (Virt machine).

After correcting Qemu as described in #1815078
(https://bugs.launchpad.net/qemu/+bug/1815078), when we try to enable
interrupts for core 1 at address 0x0C00_2080 we don't seem to be able to
trigger an external interrupt  (e.g. UART0).

This works perfectly for core 0, but fore core 1 it does not work at
all. I assume that given bug #1815078 does not enable any external
interrupt then this feature has not been tested. I tried to look at the
qemu source code but with no luck so far.

I guess the problem is related to function parse_hart_config (in
sfive_plic.c) that initializes incorrectly the
plic->addr_config[addrid].hartid, which is later on read in
sifive_plic_update. But this is a guess.

Best regards,
Pharos team

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815721

Title:
  RISC-V PLIC enable interrupt for multicore

Status in QEMU:
  New

Bug description:
  Hello all,

  There is a bug in Qemu related to the enabling of external interrupts
  for multicores (Virt machine).

  After correcting Qemu as described in #1815078
  (https://bugs.launchpad.net/qemu/+bug/1815078), when we try to enable
  interrupts for core 1 at address 0x0C00_2080 we don't seem to be able
  to trigger an external interrupt  (e.g. UART0).

  This works perfectly for core 0, but fore core 1 it does not work at
  all. I assume that given bug #1815078 does not enable any external
  interrupt then this feature has not been tested. I tried to look at
  the qemu source code but with no luck so far.

  I guess the problem is related to function parse_hart_config (in
  sfive_plic.c) that initializes incorrectly the
  plic->addr_config[addrid].hartid, which is later on read in
  sifive_plic_update. But this is a guess.

  Best regards,
  Pharos team

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1815721/+subscriptions

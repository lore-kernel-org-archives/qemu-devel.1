Received: from eggs.gnu.org ([2001:4830:134:3::10]:60170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f0s7T-00041r-Me
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 13:10:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f0s7P-0007nm-79
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 13:10:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:34870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f0s7P-0007nL-0n
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 13:10:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f0s7O-0005xx-6e
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 17:10:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 26AEE2E80C8
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 17:10:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Mar 2018 17:00:29 -0000
From: Fa Bi <1759333@bugs.launchpad.net>
Reply-To: Bug 1759333 <1759333@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152217002978.21179.18362367542097684091.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1759333] [NEW] Illegal Instruction with HVF when
 encountering SSE instructions in the emulator
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

The latest version of QEMU doesn't seem to support emulated SSE instruction=
s with HVF acceleration on macOS.
The decoder will treat SSE instructions as invalid, get the instruction siz=
es wrong and quickly crash the guest OS because of illegal instructions.
After having a quick look at target/i386/hvf/x86_decode.c, it seems that SS=
E instruction emulation isn't implemented in the current version of the x86=
 emulator.

A way to reproduce the issue is to run a macOS 10.13 guest with HVF
acceleration enabled, this will crash in the guest once it's loading up
the GUI (and also print a "Unimplemented handler" warning from
target/i386/hvf/x86_emu.c).

** Affects: qemu
     Importance: Undecided
         Status: New

** Summary changed:

- Illegal Instruction with HVF when encountering SSE instructions in Privil=
eged Mode
+ Illegal Instruction with HVF when encountering SSE instructions in the em=
ulator

** Description changed:

  The latest version of QEMU doesn't seem to support emulated SSE instructi=
ons with HVF acceleration on macOS.
  The decoder will treat SSE instructions as invalid, get the instruction s=
izes wrong and quickly crash the guest OS because of illegal instructions.
  After having a quick look at target/i386/hvf/x86_decode.c, it seems that =
SSE instruction emulation isn't implemented in the current version of the x=
86 emulator.
  =

  A way to reproduce the issue is to run a macOS 10.13 guest with HVF
- acceleration enabled, this will crash once it's loading up the GUI.
+ acceleration enabled, this will crash in the guest once it's loading up
+ the GUI (and also print a "Unimplemented handler" warning from
+ target/i386/hvf/x86_emu.c).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1759333

Title:
  Illegal Instruction with HVF when encountering SSE instructions in the
  emulator

Status in QEMU:
  New

Bug description:
  The latest version of QEMU doesn't seem to support emulated SSE instructi=
ons with HVF acceleration on macOS.
  The decoder will treat SSE instructions as invalid, get the instruction s=
izes wrong and quickly crash the guest OS because of illegal instructions.
  After having a quick look at target/i386/hvf/x86_decode.c, it seems that =
SSE instruction emulation isn't implemented in the current version of the x=
86 emulator.

  A way to reproduce the issue is to run a macOS 10.13 guest with HVF
  acceleration enabled, this will crash in the guest once it's loading
  up the GUI (and also print a "Unimplemented handler" warning from
  target/i386/hvf/x86_emu.c).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1759333/+subscriptions

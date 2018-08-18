Received: from eggs.gnu.org ([2001:4830:134:3::10]:53445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fr6Nv-0002vU-3r
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 14:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fr6Nq-0002Ze-5f
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 14:55:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:44430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fr6Np-0002Z8-W9
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 14:55:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fr6Np-0004oo-0N
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 18:55:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EF3F22E8025
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 18:55:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Aug 2018 18:50:28 -0000
From: Donald R Laster Jr <1787754@bugs.launchpad.net>
Reply-To: Bug 1787754 <1787754@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153461822839.4954.4145341192703066894.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1787754] [NEW] qemu sparc -cpu help does not
 generate correct display
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

The output for the "-cpu help" on the Sparc executables is not
generating accurate information.

Running

./qemu-sparc64 -cpu help

produces:

Sparc  Fujitsu Sparc64 IU 0004000200000000 FPU 00000000 MMU 00000000 NWINS 4
Sparc Fujitsu Sparc64 III IU 0004000300000000 FPU 00000000 MMU 00000000 NWI=
NS 5
Sparc Fujitsu Sparc64 IV IU 0004000400000000 FPU 00000000 MMU 00000000 NWIN=
S 8
Sparc Fujitsu Sparc64 V IU 0004000551000000 FPU 00000000 MMU 00000000 NWINS=
 8
Sparc  TI UltraSparc I IU 0017001040000000 FPU 00000000 MMU 00000000 NWINS 8
Sparc TI UltraSparc II IU 0017001120000000 FPU 00000000 MMU 00000000 NWINS 8
Sparc TI UltraSparc IIi IU 0017001291000000 FPU 00000000 MMU 00000000 NWINS=
 8
Sparc TI UltraSparc IIe IU 0017001314000000 FPU 00000000 MMU 00000000 NWINS=
 8
Sparc Sun UltraSparc III IU 003e001434000000 FPU 00000000 MMU 00000000 NWIN=
S 8
Sparc Sun UltraSparc III Cu IU 003e001541000000 FPU 00000000 MMU 00000001 N=
WINS 8
Sparc Sun UltraSparc IIIi IU 003e001634000000 FPU 00000000 MMU 00000000 NWI=
NS 8
Sparc Sun UltraSparc IV IU 003e001831000000 FPU 00000000 MMU 00000002 NWINS=
 8
Sparc Sun UltraSparc IV+ IU 003e001922000000 FPU 00000000 MMU 00000000 NWIN=
S 8 +cmt
Sparc Sun UltraSparc IIIi+ IU 003e002200000000 FPU 00000000 MMU 00000001 NW=
INS 8
Sparc Sun UltraSparc T1 IU 003e002302000000 FPU 00000000 MMU 00000003 NWINS=
 8 +hypv +cmt +gl
Sparc Sun UltraSparc T2 IU 003e002402000000 FPU 00000000 MMU 00000003 NWINS=
 8 +hypv +cmt +gl
Sparc NEC UltraSparc I IU 0022001040000000 FPU 00000000 MMU 00000000 NWINS 8
Default CPU feature flags (use '-' to remove): float swap mul div flush fsq=
rt fmul vis1 vis2 fsmuld
Available CPU feature flags (use '+' to add): float128 hypv cmt gl
Numerical features (use '=3D' to set): iu_version fpu_version mmu_version n=
windows

The entries appear to supposed to be (partial list from source code):

TI-SuperSparc-II
TI-SuperSparc-II
TI-SuperSparc-II
TI-MicroSparc-I
TI-MicroSparc-I
TI-MicroSparc-I
Sun-UltraSparc-T1
TI-UltraSparc-IIi
Sun-UltraSparc-T1

The output is from qemu 2.12.0.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: minor

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1787754

Title:
  qemu sparc -cpu help does not generate correct display

Status in QEMU:
  New

Bug description:
  The output for the "-cpu help" on the Sparc executables is not
  generating accurate information.

  Running

  ./qemu-sparc64 -cpu help

  produces:

  Sparc  Fujitsu Sparc64 IU 0004000200000000 FPU 00000000 MMU 00000000 NWIN=
S 4
  Sparc Fujitsu Sparc64 III IU 0004000300000000 FPU 00000000 MMU 00000000 N=
WINS 5
  Sparc Fujitsu Sparc64 IV IU 0004000400000000 FPU 00000000 MMU 00000000 NW=
INS 8
  Sparc Fujitsu Sparc64 V IU 0004000551000000 FPU 00000000 MMU 00000000 NWI=
NS 8
  Sparc  TI UltraSparc I IU 0017001040000000 FPU 00000000 MMU 00000000 NWIN=
S 8
  Sparc TI UltraSparc II IU 0017001120000000 FPU 00000000 MMU 00000000 NWIN=
S 8
  Sparc TI UltraSparc IIi IU 0017001291000000 FPU 00000000 MMU 00000000 NWI=
NS 8
  Sparc TI UltraSparc IIe IU 0017001314000000 FPU 00000000 MMU 00000000 NWI=
NS 8
  Sparc Sun UltraSparc III IU 003e001434000000 FPU 00000000 MMU 00000000 NW=
INS 8
  Sparc Sun UltraSparc III Cu IU 003e001541000000 FPU 00000000 MMU 00000001=
 NWINS 8
  Sparc Sun UltraSparc IIIi IU 003e001634000000 FPU 00000000 MMU 00000000 N=
WINS 8
  Sparc Sun UltraSparc IV IU 003e001831000000 FPU 00000000 MMU 00000002 NWI=
NS 8
  Sparc Sun UltraSparc IV+ IU 003e001922000000 FPU 00000000 MMU 00000000 NW=
INS 8 +cmt
  Sparc Sun UltraSparc IIIi+ IU 003e002200000000 FPU 00000000 MMU 00000001 =
NWINS 8
  Sparc Sun UltraSparc T1 IU 003e002302000000 FPU 00000000 MMU 00000003 NWI=
NS 8 +hypv +cmt +gl
  Sparc Sun UltraSparc T2 IU 003e002402000000 FPU 00000000 MMU 00000003 NWI=
NS 8 +hypv +cmt +gl
  Sparc NEC UltraSparc I IU 0022001040000000 FPU 00000000 MMU 00000000 NWIN=
S 8
  Default CPU feature flags (use '-' to remove): float swap mul div flush f=
sqrt fmul vis1 vis2 fsmuld
  Available CPU feature flags (use '+' to add): float128 hypv cmt gl
  Numerical features (use '=3D' to set): iu_version fpu_version mmu_version=
 nwindows

  The entries appear to supposed to be (partial list from source code):

  TI-SuperSparc-II
  TI-SuperSparc-II
  TI-SuperSparc-II
  TI-MicroSparc-I
  TI-MicroSparc-I
  TI-MicroSparc-I
  Sun-UltraSparc-T1
  TI-UltraSparc-IIi
  Sun-UltraSparc-T1

  The output is from qemu 2.12.0.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1787754/+subscriptions

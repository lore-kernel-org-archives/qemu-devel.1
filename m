Received: from eggs.gnu.org ([2001:4830:134:3::10]:49995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1frzvQ-0004q5-2O
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1frzvP-00070f-7B
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:13:56 -0400
Received: from mail-it0-x233.google.com ([2607:f8b0:4001:c0b::233]:34695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1frzvP-0006zI-1h
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:13:55 -0400
Received: by mail-it0-x233.google.com with SMTP id x79-v6so1274418ita.1
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 23:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <153461822839.4954.4145341192703066894.malonedeb@chaenomeles.canonical.com>
In-Reply-To: <153461822839.4954.4145341192703066894.malonedeb@chaenomeles.canonical.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 21 Aug 2018 08:13:42 +0200
Message-ID: <CACXAS8AyjbZzu=vOCWOntyC+U6CPk4wgFKqXDGhY4ibBWni9HA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1787754] [NEW] qemu sparc -cpu help does not
 generate correct display
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 1787754@bugs.launchpad.net
Cc: qemu-devel <qemu-devel@nongnu.org>

On Sat, Aug 18, 2018 at 8:56 PM Donald R Laster Jr
<1787754@bugs.launchpad.net> wrote:
>
> Public bug reported:
>
> The output for the "-cpu help" on the Sparc executables is not
> generating accurate information.
>
> Running
>
> ./qemu-sparc64 -cpu help
>
> produces:
>
> Sparc  Fujitsu Sparc64 IU 0004000200000000 FPU 00000000 MMU 00000000 NWINS 4
> Sparc Fujitsu Sparc64 III IU 0004000300000000 FPU 00000000 MMU 00000000 NWINS 5
> Sparc Fujitsu Sparc64 IV IU 0004000400000000 FPU 00000000 MMU 00000000 NWINS 8
> Sparc Fujitsu Sparc64 V IU 0004000551000000 FPU 00000000 MMU 00000000 NWINS 8
> Sparc  TI UltraSparc I IU 0017001040000000 FPU 00000000 MMU 00000000 NWINS 8
> Sparc TI UltraSparc II IU 0017001120000000 FPU 00000000 MMU 00000000 NWINS 8
> Sparc TI UltraSparc IIi IU 0017001291000000 FPU 00000000 MMU 00000000 NWINS 8
> Sparc TI UltraSparc IIe IU 0017001314000000 FPU 00000000 MMU 00000000 NWINS 8
> Sparc Sun UltraSparc III IU 003e001434000000 FPU 00000000 MMU 00000000 NWINS 8
> Sparc Sun UltraSparc III Cu IU 003e001541000000 FPU 00000000 MMU 00000001 NWINS 8
> Sparc Sun UltraSparc IIIi IU 003e001634000000 FPU 00000000 MMU 00000000 NWINS 8
> Sparc Sun UltraSparc IV IU 003e001831000000 FPU 00000000 MMU 00000002 NWINS 8
> Sparc Sun UltraSparc IV+ IU 003e001922000000 FPU 00000000 MMU 00000000 NWINS 8 +cmt
> Sparc Sun UltraSparc IIIi+ IU 003e002200000000 FPU 00000000 MMU 00000001 NWINS 8
> Sparc Sun UltraSparc T1 IU 003e002302000000 FPU 00000000 MMU 00000003 NWINS 8 +hypv +cmt +gl
> Sparc Sun UltraSparc T2 IU 003e002402000000 FPU 00000000 MMU 00000003 NWINS 8 +hypv +cmt +gl
> Sparc NEC UltraSparc I IU 0022001040000000 FPU 00000000 MMU 00000000 NWINS 8
> Default CPU feature flags (use '-' to remove): float swap mul div flush fsqrt fmul vis1 vis2 fsmuld
> Available CPU feature flags (use '+' to add): float128 hypv cmt gl
> Numerical features (use '=' to set): iu_version fpu_version mmu_version nwindows
>
> The entries appear to supposed to be (partial list from source code):
>
> TI-SuperSparc-II
> TI-SuperSparc-II
> TI-SuperSparc-II
> TI-MicroSparc-I
> TI-MicroSparc-I
> TI-MicroSparc-I
> Sun-UltraSparc-T1
> TI-UltraSparc-IIi
> Sun-UltraSparc-T1
>
The T1 entries are in the list above. The Micro- and Super- SPARC
entries are not supposed to be there because they are 32 bit CPUs and
thus not compatible with qemu-sparc64.
Works as designed.

Regards,
Artyom

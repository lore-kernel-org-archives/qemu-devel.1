Received: from eggs.gnu.org ([2001:4830:134:3::10]:37768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP6We-0005T2-IL
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 08:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP6Wa-0002Es-GE
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 08:20:24 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:52372)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP6Wa-0002E2-4U
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 08:20:20 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <CADR1n+V8R1LOGzbwdBDt5axeZ0mqh=WSCsfUo0Vr2nmE6BYqTQ@mail.gmail.com>
	<8760fqorbp.fsf@frigg.lan>
	<CAFEAcA-434=WhBxC=KB2HBhrPG9b+z1i3jqeFgiE=H8ceZJYzg@mail.gmail.com>
	<87mv91tn7d.fsf@linaro.org>
Date: Sun, 25 Jun 2017 15:20:06 +0300
In-Reply-To: <87mv91tn7d.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
	message of "Wed, 21 Jun 2017 15:44:22 +0100")
Message-ID: <87r2y8gsy1.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Tracing guest virtual addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jayanto Minocha <jayanto@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

Alex Benn=C3=A9e writes:

> Peter Maydell <peter.maydell@linaro.org> writes:

>> On 20 June 2017 at 12:02, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wrot=
e:
>>> Jayanto Minocha writes:
>>>> But that is only used to instrument the cpu_ld/cpu_st macros, which is=
 only
>>>> called in the case of a tlb miss.
>>>=20
>>>> I've been going over the archives, and it looks like I need to instrum=
ent
>>>> tcg_out_tlb_load. Am I on the right path ?
>>>=20
>>> That event should trace all guest memory accesses performed by the CPU.=
 If you
>>> found any case where this does not hold, it is likely a bug and I'd app=
reciate
>>> it if you can point me to the smallest possible failing example.
>>=20
>> Does it catch memory accesses that are performed via helper functions,
>> or only ones done by inline TCG code?

> AFAICT it inserts a helper call on the TCG ld/st ops. I wonder why not
> just ensure we always take the slow path and put the helpers in the
> access functions there? You could even apply an address mask if you only
> want to look at certain address ranges.

It also catches accesses performed by helpers.


Cheers,
  Lluis

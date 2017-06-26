Received: from eggs.gnu.org ([2001:4830:134:3::10]:34296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPSkw-0005UC-T9
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPSkt-0006JF-FW
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:04:38 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:56939 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPSkt-0006Ik-1q
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:04:35 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <CADR1n+V8R1LOGzbwdBDt5axeZ0mqh=WSCsfUo0Vr2nmE6BYqTQ@mail.gmail.com>
	<8760fqorbp.fsf@frigg.lan>
	<CAFEAcA-434=WhBxC=KB2HBhrPG9b+z1i3jqeFgiE=H8ceZJYzg@mail.gmail.com>
	<87mv91tn7d.fsf@linaro.org> <87r2y8gsy1.fsf@frigg.lan>
	<87efu89di5.fsf@linaro.org> <87shindrqi.fsf@frigg.lan>
	<CAFEAcA8VqE13i3BBs34KSh6cY=McxP=CmxU8nXpp4WaPTSLiRg@mail.gmail.com>
Date: Mon, 26 Jun 2017 15:04:25 +0300
In-Reply-To: <CAFEAcA8VqE13i3BBs34KSh6cY=McxP=CmxU8nXpp4WaPTSLiRg@mail.gmail.com>
	(Peter Maydell's message of "Mon, 26 Jun 2017 10:32:37 +0100")
Message-ID: <87mv8vc5va.fsf@frigg.lan>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Jayanto Minocha <jayanto@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell writes:

> On 26 June 2017 at 10:26, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wrote:
>> There's two places where memory access tracing is triggered:
>>=20
>> * tcg_gen_qemu_ld/st_...
>> * ld/st templates (both softmmu and user)
>>=20
>> AFAIK, helpers use the ld/st templates to access guest memory.

> Mostly, but there are one or two special cases, for instance
> the ARM HELPER(dc_zva) in target/arm/helper.c, which has a
> fastpath that uses tlb_vaddr_to_host to look up the host memory
> address and then memset to do the clear-to-zeroes operation.

Should that be replaced with a cpu_memset or similar?

Cheers,
  Lluis

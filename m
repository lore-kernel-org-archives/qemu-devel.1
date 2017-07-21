Received: from eggs.gnu.org ([2001:4830:134:3::10]:56475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dYbxI-0002qQ-4J
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dYbxH-0004X5-7f
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:43:12 -0400
Date: Fri, 21 Jul 2017 19:43:03 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170721174303.bhzslryhi53uevfp@aurel32.net>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-13-alex.bennee@linaro.org>
	<4d6ac494-d606-ebaf-6498-7c526467ac62@twiddle.net>
	<87tw266rm3.fsf@linaro.org>
	<20170721132140.xy2uqronprhzjiga@aurel32.net>
	<87mv7x7vbq.fsf@linaro.org>
	<CAFEAcA9kEa2PCjEKn1A=-bM7jjFhZc8pjef2J_c9qL8p4bLdaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFEAcA9kEa2PCjEKn1A=-bM7jjFhZc8pjef2J_c9qL8p4bLdaQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 12/23]
 target/arm/translate-a64.c: add FP16 FAGCT to AdvSIMD 3 Same
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?iso-8859-15?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 2017-07-21 14:58, Peter Maydell wrote:
> On 21 July 2017 at 14:50, Alex Benn=E9e <alex.bennee@linaro.org> wrote:
> > Aurelien Jarno <aurelien@aurel32.net> writes:
> >> As said in another email, some architectures actually use more than one
> >> float_status. We therefore need to implement a solution like the one
> >> proposed by Richard.
> >
> > Ahh you mean more than one float_status for a given vCPU context?
>=20
> Yep. ARM's cpu state struct has
>         float_status fp_status;
>         float_status standard_fp_status;
>=20
> which we use to handle (1) operations which use the state
> controlled by the FPSCR value and (2) operations which
> ignore the FPSCR and use the "Standard FPSCR Value" (generally
> Neon ops). More info in the comment in cpu.h...

Indeed. This is also the case on:
- i386: one float_status for the x87 FPU, one for MMX and one for SSE.
- mips: one for the FPU and one for the MSA FP (SIMD operations).
- ppc: one for the FPU instructions and one for the VEC instructions.

Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

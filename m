Received: from eggs.gnu.org ([2001:4830:134:3::10]:46592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aaron@os.amperecomputing.com>) id 1gDEtL-0002ot-Fa
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aaron@os.amperecomputing.com>) id 1gDEtG-0000o4-Rm
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:27:35 -0400
Received: from mail-dm3nam03on070b.outbound.protection.outlook.com
	([2a01:111:f400:fe49::70b]:2326
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Aaron@os.amperecomputing.com>)
	id 1gDEtG-0000mB-Jl
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:27:30 -0400
From: Aaron Lindsay <Aaron@os.amperecomputing.com>
Date: Thu, 18 Oct 2018 20:27:27 +0000
Message-ID: <20181018202719.GG12691@quinoa.localdomain>
References: <20181018182758.18646-1-richard.henderson@linaro.org>
	<20181018182758.18646-4-richard.henderson@linaro.org>
In-Reply-To: <20181018182758.18646-4-richard.henderson@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <78D5B81BF1EE674886E3F37551E86D1F@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/3] target/arm: Flush only the TLBs
 affected by TTBR*_EL1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>

On Oct 18 11:27, Richard Henderson wrote:
> @@ -2761,12 +2763,12 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] =3D {
>        .fieldoffset =3D offsetof(CPUARMState, cp15.esr_el[1]), .resetvalu=
e =3D 0, },
>      { .name =3D "TTBR0_EL1", .state =3D ARM_CP_STATE_BOTH,
>        .opc0 =3D 3, .opc1 =3D 0, .crn =3D 2, .crm =3D 0, .opc2 =3D 0,
> -      .access =3D PL1_RW, .writefn =3D vmsa_ttbr_write, .resetvalue =3D =
0,
> +      .access =3D PL1_RW, .writefn =3D vmsa_ttbr1_write, .resetvalue =3D=
 0,

It's a little confusing that vmsa_ttbr1_write is used for TTBR0_EL1. Is
the '1' indicating the EL instead of which TTBR is being used?

-Aaron

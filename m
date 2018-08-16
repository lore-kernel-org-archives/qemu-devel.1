Received: from eggs.gnu.org ([2001:4830:134:3::10]:37578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqLZB-0001Hg-D6
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqLZ5-0007Oc-88
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:56:09 -0400
Received: from mail-bn3nam01on0115.outbound.protection.outlook.com
	([104.47.33.115]:32792
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fqLZ4-0007Mm-VR
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:56:03 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 16 Aug 2018 16:55:58 +0000
Message-ID: <BN7PR08MB4868A40586A86698B355ED27C63E0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-40-git-send-email-aleksandar.markovic@rt-rk.com>,
	<0b4d8d60-98d2-8515-c08e-f767a886e331@linaro.org>
In-Reply-To: <0b4d8d60-98d2-8515-c08e-f767a886e331@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v9 39/84] target/mips: Add emulation of
 nanoMIPS 32-bit branch instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Richard Henderson <richard.henderson@linaro.org>
> Sent: Thursday, August 16, 2018 6:31 PM
>=20
> Subject: Re: [PATCH v9 39/84] target/mips: Add emulation of nanoMIPS 32-b=
it branch instructions
>=20
> On 08/16/2018 07:57 AM, Aleksandar Markovic wrote:
> > +    } else {
> > +        /* Conditional compact branch */
> > +        TCGLabel *fs =3D gen_new_label();
> > +        save_cpu_state(ctx, 0);
>=20
> I will note that save_cpu_state(ctx, 0) is concerned about updating the B=
MASK
> bits for branch delay slots, which nanomips does not have.  The function =
could
> probably usefully be renamed so that's clearer.
>=20

This and other similar cases will be fixed in v10. Perhaps even the naming =
of save_cpu_state().

>=20
> >      case NM_P_J:
> > +        switch (extract32(ctx->opcode, 12, 4)) {
> > +        case NM_JALRC:
> > +        case NM_JALRC_HB:
> > +            gen_compute_branch(ctx, OPC_JALR, 4, rs, rt, 0, 0);
> > +            break;
>=20
> All of these branches need to be using the new functions that you just ad=
ded.
> There are even more incorrect uses to follow.
>=20

All occurrences will be fixed in v10.=

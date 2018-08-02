Received: from eggs.gnu.org ([2001:4830:134:3::10]:37112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flHo8-0002Am-VB
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flHo3-0007KO-Uk
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:54:40 -0400
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com
	([104.47.38.129]:46816
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1flHo3-0007Jv-HH
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:54:35 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 2 Aug 2018 17:54:31 +0000
Message-ID: <BN7PR08MB48680C56DDDD8ED505E9DB97C62C0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-46-git-send-email-aleksandar.markovic@rt-rk.com>
	<599465e2-9620-61a4-9a73-a8464c06cbab@linaro.org>
	<BN7PR08MB48688BC84CBE8C74D095A46AC62C0@BN7PR08MB4868.namprd08.prod.outlook.com>,
	<ec7bec8f-800b-6840-a6e7-c07e4d667f34@linaro.org>
In-Reply-To: <ec7bec8f-800b-6840-a6e7-c07e4d667f34@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 45/76] target/mips: Implement emulation
 of nanoMIPS LLWP/SCWP pair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Richard Henderson <richard.henderson@linaro.org>
> Sent: Thursday, August 2, 2018 7:28 PM
>=20
> On 08/02/2018 08:29 AM, Aleksandar Markovic wrote:
> > Hi, Richard,
> >
> > We are going to remove obsoleted helpers, that was just an honest mista=
ke made in a rush.
> >
> > For unprotected access to gpr, we are going to insert if(reg1 !=3D 0) i=
n two places.
>=20
> Be careful that you do not eliminate side effects in the process.  This
> includes things like check_dspr2, and any helper that sets overflow_flag =
or
> carry_flag.
>=20
> I cannot see how you will avoid that when adding only two if statements.
>=20

I was referring just to SCWP handler function. For DSP patches, for v6, we =
worked assiduously to eliminate all unprotected accesses to gpr.

>=20
> > However, it looks there is a bigger problem now in SCWP. QEMU crashes w=
ith this message:
> >
> > /qemu/tcg/tcg.c:2862: tcg fatal error
> >
> > This happens in user mode only, system mode case runs fine.
> >
> > the problem seems to appear as a consequence of using tcg_gen_brcond_*(=
().
> >
> > Do you have any idea what are we doing wrong here?
>=20
> If you send me a binary that triggers this error, I'll look at it.

Will do it tomorrow morning.

Aleksandar=

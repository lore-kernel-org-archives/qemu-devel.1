Received: from eggs.gnu.org ([2001:4830:134:3::10]:51078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flCIn-00056E-Sh
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 08:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flCIj-0005vU-1r
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 08:01:57 -0400
Received: from mail-by2nam03on0112.outbound.protection.outlook.com
	([104.47.42.112]:3680
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1flCIi-0005uY-Km
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 08:01:52 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 2 Aug 2018 12:01:47 +0000
Message-ID: <BN7PR08MB486824C8AD422E4875DC3AE9C62C0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-50-git-send-email-aleksandar.markovic@rt-rk.com>,
	<d976385b-45d7-df12-d965-dc7a4241bb0e@linaro.org>
In-Reply-To: <d976385b-45d7-df12-d965-dc7a4241bb0e@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 49/76] target/mips: Adjust
 exception_resume_pc() for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

Hi, Richard.

> From: Richard Henderson <richard.henderson@linaro.org>
> Sent: Tuesday, July 31, 2018 9:18 PM
> On 07/30/2018 12:12 PM, Aleksandar Markovic wrote:
> > -    isa_mode =3D !!(env->hflags & MIPS_HFLAG_M16);
> > +    isa_mode =3D env->hflags & MIPS_HFLAG_M16 &&
> > +                !(env->insn_flags & ISA_NANOMIPS32);
>=20
> Likewise re nanomips not setting M16.

For this group of patches related to M16 we devised a solution, however, so=
m of the test are failing, and wee need more time to analyze the failures a=
nd the solution. This means that any fix won't be included in v6, or any la=
ter version, until we find and verify a good solution. This is just to give=
 you heads up, so that you don't spend time on reviewing patches that did n=
ot change from the preceding version. Of course, many thanks for all review=
s so far.

Yours,
Aleksandar

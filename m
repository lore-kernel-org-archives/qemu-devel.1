Received: from eggs.gnu.org ([209.51.188.92]:49047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hGr4e-0004L4-Tl
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 16:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hGr4e-0007uX-00
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 16:22:28 -0400
Received: from mail-eopbgr820109.outbound.protection.outlook.com
	([40.107.82.109]:6800
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hGr4d-0007rC-Gb
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 16:22:27 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 17 Apr 2019 20:22:24 +0000
Message-ID: <BN6PR2201MB1251599D75CE44B174BD5116C6250@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1555491867-5922-1-git-send-email-mateja.marjanovic@rt-rk.com>,
	<BN6PR2201MB1251516C13CAE873ADDA73DBC6250@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB1251516C13CAE873ADDA73DBC6250@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] target/mips: Amend tests for MSA binary
 integer operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>

> From: Aleksandar Markovic
> Subject: Re: [PATCH] target/mips: Amend tests for MSA binary integer oper=
ations
>=20
> > From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> > Subject: [PATCH] target/mips: Amend tests for MSA binary integer operat=
ions
> >
> > Amend tests for certain MSA binary integer instructions
> > (for example DIV_S.B) by appending two missing test cases
> > to complete standard battery of 80 test cases for each
> > such instruction. Expected values were pulled from the
> > results of the MIPS64r6 machine that executed those
> > instruction, and QEMU emulation should produce the same
> > results.
> >
> > Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> > ---
>=20
> I'm afraid your patch doesn't apply to the tip of the source tree:

Unfortunately, Mateja, even after resolving patch application conflicts,
the code doesn't build.

For example, wrappers for many MSA instructions are missing, and
there are other problems too.

The patch needs a major amending and refactoring, which I will do
tomorrow, or in next few days, so that you can focus on your other
remaining tasks (for example, explaining "active_fpu" role from
another series, and big endian host MSA test failures).

The good thing is that we will eventually expand test coverage.

Thanks,
Aleksandar=

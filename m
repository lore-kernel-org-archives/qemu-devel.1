Received: from eggs.gnu.org ([208.118.235.92]:37003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1gcVvh-0002Y7-JV
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 08:42:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1gcVvc-0007ps-KW
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 08:42:28 -0500
Received: from mail-bl2nam02on071a.outbound.protection.outlook.com
	([2a01:111:f400:fe46::71a]:30722
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
	id 1gcVvV-0007dK-Jw
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 08:42:20 -0500
From: Aleksandar Rikalo <arikalo@wavecomp.com>
Date: Thu, 27 Dec 2018 13:42:09 +0000
Message-ID: <DM5PR22MB165896446E5EF7E9CCA4BFD1D2B60@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1545822388-10911-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1545822388-10911-13-git-send-email-aleksandar.markovic@rt-rk.com>,
	<BN6PR2201MB1251A5B244430F8689B751E1C6B60@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB1251A5B244430F8689B751E1C6B60@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 12/20] disas: nanoMIPS: Clean up
 handling of 16-bit logic instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>

> From: Aleksandar Markovic
> Sent: Thursday, December 27, 2018 2:18 PM
> To: Aleksandar Markovic; qemu-devel@nongnu.org; Aleksandar Rikalo
> Cc: aurelien@aurel32.net; Stefan Markovic
> Subject: Re: [PATCH v5 12/20] disas: nanoMIPS: Clean up handling of 16-bi=
t logic instructions
>
> > From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> > Subject: [PATCH v5 12/20] disas: nanoMIPS: Clean up handling of 16-bit =
logic instructions
>
> > Clean up handling of 16-bit logic nanoMIPS instructions:
>
> ...
> >
> > -    return img::format("AND %s, %s", rs3, rt3);
> > +    return img::format("AND[16] %s, %s", rs3, rt3);
> > }
>
> I wonder if this instruction should be displayed with two or three argume=
nts (by design of this instruction, the
> destination is the same register as one of sources, but would it be more =
clear for end user to see three arguments,
> even if two of them are always the same?)

nanomips-linux-musl-objdump always shows three registers and generic mnemon=
ic AND (without [16]).
On the other hand, inline assembler accepts syntax with two registers or/an=
d instruction format specification.

We should decide whether we should follow objdump or assembler conventions.
In any case, the same rule should be applied consistently across this disas=
sembler.

Thanks,
Aleksandar Rikalo

>
> Aleksandar
>

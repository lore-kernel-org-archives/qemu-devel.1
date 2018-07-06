Received: from eggs.gnu.org ([2001:4830:134:3::10]:49959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fbUGJ-0008MR-B8
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fbUGE-00077F-8e
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:11:15 -0400
Received: from mail-bn3nam01on071a.outbound.protection.outlook.com
	([2a01:111:f400:fe41::71a]:45037
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fbUGD-00075x-R1
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:11:10 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 6 Jul 2018 17:11:04 +0000
Message-ID: <BN7PR08MB4868C97BD24DBF4A18874A5DC6470@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1530877732-26557-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1530877732-26557-3-git-send-email-aleksandar.markovic@rt-rk.com>
	<BN7PR08MB4868AC9B85699C8293579F63C6470@BN7PR08MB4868.namprd08.prod.outlook.com>,
	<e2782023-f98c-c425-1897-07595f5ba1fb@amsat.org>
In-Reply-To: <e2782023-f98c-c425-1897-07595f5ba1fb@amsat.org>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/8] target/mips: Workaround for
 checkpatch.pl hanging on msa_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> I'm not sure it's worth having this but you are the maintainer so your
> choice :)

If someone in future peruses an older version of this file (let's say, whil=
e working on an older version of QEMU), and comes across this problem with =
checkpatch.pl, by checking the full history of the file, they would be able=
 to see what the problem is. Without this patch, they wouldn't.

> What is unclear to me is, while changing this, why only fix
> the suffix and not also the prefix? That is:
>
>            uint<space>## BITS ##<space>_t S =3D _S, T =3D _T;

It wouldn't be clear what characters caused the problem (or triggered the b=
ug, if you wish).

Regards,
Aleksandar

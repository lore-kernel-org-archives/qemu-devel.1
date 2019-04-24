Received: from eggs.gnu.org ([209.51.188.92]:47300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hJFiF-0008HY-7c
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hJFfu-0000Tu-Ht
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:02:51 -0400
Received: from mail-eopbgr820139.outbound.protection.outlook.com
	([40.107.82.139]:37120
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hJFfu-0000T5-6g
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:02:50 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 24 Apr 2019 11:02:43 +0000
Message-ID: <BN6PR2201MB125177C4249FB6094A09E7BCC63C0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1556040926-23931-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1556040926-23931-5-git-send-email-aleksandar.markovic@rt-rk.com>,
	<8303cc43-6bc4-6225-e632-e02629ef74ff@redhat.com>
In-Reply-To: <8303cc43-6bc4-6225-e632-e02629ef74ff@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 4/4] linux-user: Sanitize interp_info and,
 for mips only, init field fp_abi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "lvivier@redhat.com" <lvivier@redhat.com>, "thuth@redhat.com" <thuth@redhat.com>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "daniel.santos@pobox.com" <daniel.santos@pobox.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>

> From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Subject: Re: [Qemu-devel] [PATCH 4/4] linux-user: Sanitize interp_info an=
d, for mips only, init field fp_abi
>
> Hi Aleksandar,
>=20
> On 4/23/19 7:35 PM, Aleksandar Markovic wrote:
> > From: Daniel Santos <daniel.santos@pobox.com>
> >
> > Sanitize interp_info structure in load_elf_binary() and, for mips only,
> > init its field fp_abi. This fixes appearances of "Unexpected FPU mode"
> > message in some MIPS use cases.
> >
>=20
> Please add:
>=20
> Fixes: https://bugs.launchpad.net/qemu/+bug/1825002
>=20

Will do, Philippe. Thanks a bunch!

Aleksandar

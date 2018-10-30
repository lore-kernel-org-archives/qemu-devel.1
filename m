Received: from eggs.gnu.org ([2001:4830:134:3::10]:50673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gHXqw-0002y4-Kw
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gHXqr-0003yW-Ee
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:30:54 -0400
Received: from mail-eopbgr810092.outbound.protection.outlook.com
	([40.107.81.92]:11578
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gHXqn-0003oE-Pw
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:30:49 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 30 Oct 2018 17:30:40 +0000
Message-ID: <BN6PR2201MB12513C67816C9FEDCB2AB09BC6CC0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1540914249-3392-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540914249-3392-6-git-send-email-aleksandar.markovic@rt-rk.com>,
	<bd184613-b6c5-57c8-6c7d-bea5feb283eb@redhat.com>
In-Reply-To: <bd184613-b6c5-57c8-6c7d-bea5feb283eb@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 5/5] target/mips: Enable only tested
 modes for R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>

> Do you mind adding those one line comment when applying this series?
>=20
> > +#if defined(CONFIG_USER_ONLY)
>=20
>    #if defined(CONFIG_USER_ONLY) /* System mode not implemented */
>=20
> > +#if !defined(TARGET_MIPS64)
>=20
>    #if !defined(TARGET_MIPS64) /* Only O32 user-mode ABI is supported */

I do think this is a very good idea, but it was too late - I was already we=
ll into preparing pull request when I read this.

Thanks,
Aleksandar=

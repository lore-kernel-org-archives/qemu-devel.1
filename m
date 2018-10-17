Received: from eggs.gnu.org ([2001:4830:134:3::10]:37063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gCkdK-00050q-Hy
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gCkdE-0008Mn-PK
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:09:02 -0400
Received: from mail-sn1nam02on0119.outbound.protection.outlook.com
	([104.47.36.119]:61520
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gCkdE-0008Kx-IY
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:08:56 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 17 Oct 2018 12:08:53 +0000
Message-ID: <BN6PR2201MB1251FC9D28455D8F6EB5E721C6FF0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20180930214744.27580-1-f4bug@amsat.org>,
	<20180930214744.27580-3-f4bug@amsat.org>
In-Reply-To: <20180930214744.27580-3-f4bug@amsat.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 2/4] target/mips: Remove definitions
 that are only used once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Philippe Mathieu-Daud=E9 <philippe.mathieu.daude@gmail.com> on beha=
lf of Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Subject: [PATCH v3 2/4] target/mips: Remove definitions that are only use=
d once
>
> There is no gain in adding cpu definition which is used only once.
> Use the chip specific flags directly in place.
> This also clears the 'MIPS CPU defines' namespace.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---

Being used only once is not a sufficient reason for deleting a preprocessor=
 constant. The constants in this case are just fine as they are.

Thanks,
Aleksandar=

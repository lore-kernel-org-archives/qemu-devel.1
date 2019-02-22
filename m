Received: from eggs.gnu.org ([209.51.188.92]:40721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gxCRv-0001bq-St
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gxCRt-0001Kz-Ls
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:09:15 -0500
Received: from mail-eopbgr720091.outbound.protection.outlook.com
	([40.107.72.91]:50134
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gxCRt-0001Gm-8i
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:09:13 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 22 Feb 2019 15:09:09 +0000
Message-ID: <BN6PR2201MB1251CE53F93F35FFA399FABEC67F0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190218121322.DAB0474569F@zero.eik.bme.hu>
In-Reply-To: <20190218121322.DAB0474569F@zero.eik.bme.hu>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] mips_fulong2e: Add on-board graphics
 chip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Huacai Chen <zltjiangshi@gmail.com>, "philmd@redhat.com" <philmd@redhat.com>

> From: BALATON Zoltan <balaton@eik.bme.hu>
> Subject: [PATCH v2] mips_fulong2e: Add on-board graphics chip
>=20
> Add (partial) emulation of the on-board GPU of the machine. This
> allows the PMON2000 firmware to run and should also work with Linux
> console but probably not with X yet.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Based-on: 20190218030257.624A7745694@zero.eik.bme.hu
> ---
> hw/mips/mips_fulong2e.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>=20

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Zoltan, perhaps you ought to create a mini series consisting of the patch

https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg02471.html

and this patch.

I would like to apply this patch independently to MIPS queue, but I can't,
because of interdependencies og the two patches.

I would feel comfortable with both patches going through graphics pull
request.

Thanks again for all efforts!

Aleksandar=

Received: from eggs.gnu.org ([209.51.188.92]:36213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1h1tNu-000380-1l
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:48:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1h1tNt-0005ET-Di
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:48:30 -0500
Received: from mail-eopbgr690134.outbound.protection.outlook.com
	([40.107.69.134]:45134
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1h1tNt-0005Dd-2Z
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:48:29 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 7 Mar 2019 13:48:26 +0000
Message-ID: <BN6PR2201MB125115C44ECE81BE1E1C9576C64C0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190305162829.20079-1-philmd@redhat.com>
	<20190305162829.20079-2-philmd@redhat.com>,
	<87pnr3upsq.fsf@dusky.pond.sub.org>
In-Reply-To: <87pnr3upsq.fsf@dusky.pond.sub.org>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/5] hw/mips/malta: Fix the
 DEBUG_BOARD_INIT code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?Windows-1252?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [Qemu-devel] [PATCH 1/5] hw/mips/malta: Fix the DEBUG_BOARD_=
INIT code
>=20
> Philippe Mathieu-Daud=E9 <philmd@redhat.com> writes:
>=20
> > Commit fa1d36df746 missed to convert this ifdef'ed out code.
> > Introduce the pflash_blk variable.
> >=20
> > This fixes:
> >=20
> >    hw/mips/mips_malta.c:1273:16: error: implicit declaration of functio=
n =91blk_name=92; did you mean =91basename=92? [-Werror=3Dimplicit-function=
-declaration]
> >                 blk_name(dinfo->bdrv), fl_sectors);
> >                 ^~~~~~~~
> >   hw/mips/mips_malta.c:1273:16: error: nested extern declaration of =91=
blk_name=92 [-Werror=3Dnested-externs]
> >   hw/mips/mips_malta.c:1273:30: error: =91DriveInfo=92 {aka =91struct D=
riveInfo=92} has no member named =91bdrv=92
> >                 blk_name(dinfo->bdrv), fl_sectors);
> >                                 ^~
> >=20
> > Fixes: fa1d36df746
> > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
> Question for the maintainers: Aurelien, Aleksandar, fix the
> DEBUG_BOARD_INIT code or drop it?  It looks rather stale...

Markus,

My vote is: drop it.

And, Markus, yes, if you agree with any patch from this series, please let =
them all go though your pull request.

Regards,
Aleksandar

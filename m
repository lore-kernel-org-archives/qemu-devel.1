Received: from eggs.gnu.org ([209.51.188.92]:57359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1n6i-0006H8-JI
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:06:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1n6h-0005lF-Sy
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:06:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h1n6h-0005l2-MM
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:06:19 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190305162829.20079-1-philmd@redhat.com>
	<20190305162829.20079-2-philmd@redhat.com>
Date: Thu, 07 Mar 2019 08:06:13 +0100
In-Reply-To: <20190305162829.20079-2-philmd@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 5 Mar 2019 17:28:25
	+0100")
Message-ID: <87pnr3upsq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Commit fa1d36df746 missed to convert this ifdef'ed out code.
> Introduce the pflash_blk variable.
>
> This fixes:
>
>   hw/mips/mips_malta.c:1273:16: error: implicit declaration of function =
=E2=80=98blk_name=E2=80=99; did you mean =E2=80=98basename=E2=80=99? [-Werr=
or=3Dimplicit-function-declaration]
>                 blk_name(dinfo->bdrv), fl_sectors);
>                 ^~~~~~~~
>   hw/mips/mips_malta.c:1273:16: error: nested extern declaration of =E2=
=80=98blk_name=E2=80=99 [-Werror=3Dnested-externs]
>   hw/mips/mips_malta.c:1273:30: error: =E2=80=98DriveInfo=E2=80=99 {aka =
=E2=80=98struct DriveInfo=E2=80=99} has no member named =E2=80=98bdrv=E2=80=
=99
>                 blk_name(dinfo->bdrv), fl_sectors);
>                                 ^~
>
> Fixes: fa1d36df746
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Question for the maintainers: Aurelien, Aleksandar, fix the
DEBUG_BOARD_INIT code or drop it?  It looks rather stale...

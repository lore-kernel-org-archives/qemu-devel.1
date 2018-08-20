Received: from eggs.gnu.org ([2001:4830:134:3::10]:36790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1frhTF-0003IM-RB
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1frhTB-000520-Sv
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:31:37 -0400
Received: from mail-bl2nam02on0120.outbound.protection.outlook.com
	([104.47.38.120]:58688
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1frhTB-00051k-NS
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:31:33 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 20 Aug 2018 10:31:32 +0000
Message-ID: <BN7PR08MB48682E86A0D88FD7BC311173C6320@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180802155147.1863-1-peter.maydell@linaro.org>,
	<CAFEAcA_ziFp5sFaSMtTeAWWYgiVLfHM_XyLvMCh6JTM9-voA-Q@mail.gmail.com>
In-Reply-To: <CAFEAcA_ziFp5sFaSMtTeAWWYgiVLfHM_XyLvMCh6JTM9-voA-Q@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/2] mips: convert devices away from
 old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, =?iso-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>, "patches@linaro.org" <patches@linaro.org>

> From: Peter Maydell <peter.maydell@linaro.org>
> Sent: Monday, August 20, 2018 11:50 AM
> Subject: Re: [Qemu-devel] [PATCH 0/2] mips: convert devices away from old=
_mmio
>=20
> On 2 August 2018 at 16:51, Peter Maydell <peter.maydell@linaro.org> wrote=
:
> > These patches convert a couple of devices used only by MIPS
> > boards from using the old_mmio MemoryRegionOps accessor functions.
> >
> >  * vga-isa-mm: used by the MIPS 'jazz' boards "magnum" and "pica61"
> >  * bonito pci controller: used by the MIPS "fulong2e" board
> >
> > Tested only with "make check".
> >
> > thanks
> > -- PMM
> >
> > Peter Maydell (2):
> >   hw/display/vga-isa-mm: Convert away from old_mmio
> >   hw/pci-host/bonito: Move away from old_mmio accessors
>=20
> Ping -- other than a minor tweak to a commit message this
> patchset has been reviewed. MIPS folks, could you take this
> via your mips tree ?
>=20
> thanks
> -- PMM

Certainly, we'll include these patches in the next MIPS queue.

Thanks,
Aleksandar=

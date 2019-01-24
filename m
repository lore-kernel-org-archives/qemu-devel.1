Received: from eggs.gnu.org ([209.51.188.92]:36279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gmhAM-0003Nb-3p
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gmhAK-0002RN-5f
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:43:41 -0500
Received: from mail-eopbgr770093.outbound.protection.outlook.com
	([40.107.77.93]:36192
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gmhAI-0002NW-CS
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:43:40 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 24 Jan 2019 15:43:33 +0000
Message-ID: <BN6PR2201MB1251E84161BB31CCFED9BA05C69A0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1543412590-29716-1-git-send-email-stefan.markovic@rt-rk.com>,
	<1543412590-29716-2-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1543412590-29716-2-git-send-email-stefan.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-doc: Add nanoMIPS ISA information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "huth@tuxfamily.org" <huth@tuxfamily.org>, "hpoussin@reactos.org" <hpoussin@reactos.org>, Paul Burton <pburton@wavecomp.com>, "jhogan@kernel.org" <jhogan@kernel.org>

> From: Stefan Markovic <stefan.markovic@rt-rk.com>
> Sent: Wednesday, November 28, 2018 2:43 PM
> To: qemu-devel@nongnu.org
> Cc: Aleksandar Markovic; Stefan Markovic; Petar Jovanovic; peter.maydell@=
linaro.org; huth@tuxfamily.org; > hpoussin@reactos.org; Paul Burton; jhogan=
@kernel.org
> Subject: [PATCH 1/2] qemu-doc: Add nanoMIPS ISA information
>=20
> From: Stefan Markovic <smarkovic@wavecomp.com>
>=20
> Add nanoMIPS information in qemu-doc.texi with example of usage
> included.
>=20
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  qemu-doc.texi | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20

The text itself seems fine to me. If the problem with debug runs is
fixed:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index f7ad1df..6ef593d 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -1994,6 +1994,10 @@ Set the emulated machine type. The default is sun4=
u.
>  @section MIPS System emulator
>  @cindex system emulation (MIPS)
>=20
> +@menu
> +* nanoMIPS System emulator ::
> +@end menu
> +
>  Four executables cover simulation of 32 and 64-bit MIPS systems in
>  both endian options, @file{qemu-system-mips}, @file{qemu-system-mipsel}
>  @file{qemu-system-mips64} and @file{qemu-system-mips64el}.
> @@ -2085,6 +2089,31 @@ SCSI controller
>  G364 framebuffer
>  @end itemize
>=20
> +@node nanoMIPS System emulator
> +@subsection nanoMIPS System emulator
> +@cindex system emulation (nanoMIPS)
> +
> +Executable @file{qemu-system-mipsel} also covers simulation of
> +32-bit nanoMIPS system in little endian mode:
> +
> +@itemize @minus
> +@item
> +nanoMIPS I7200 CPU
> +@end itemize
> +
> +Example of @file{qemu-system-mipsel} usage for nanoMIPS is shown below:
> +
> +Download @code{<disk_image_file>} from @url{https://mipsdistros.mips.com=
/LinuxDistro/nanomips/buildroot/index.html}.
> +
> +Download @code{<kernel_image_file>} from @url{https://mipsdistros.mips.c=
om/LinuxDistro/nanomips/kernels/> v4.15.18-432-gb2eb9a8b07a1-20180627102142=
/index.html}.
> +
> +Start system emulation of Malta board with nanoMIPS I7200 CPU:
> +@example
> +qemu-system-mipsel -cpu I7200 -kernel @code{<kernel_image_file>} \
> +    -M malta -serial stdio -m @code{<memory_size>} -hda @code{<disk_imag=
e_file>} \
> +    -append "mem=3D256m@@0x0 rw console=3DttyS0 vga=3Dcirrus vesa=3D0x11=
1 root=3D/dev/sda"
> +@end example
> +
>=20
>  @node ARM System emulator
>  @section ARM System emulator
> --
> 1.9.1

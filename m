Received: from eggs.gnu.org ([209.51.188.92]:41091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stappers@stappers.nl>) id 1guWuT-0005Uq-Iv
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 01:23:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stappers@stappers.nl>) id 1guWuR-00010u-8g
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 01:23:41 -0500
Received: from gpm.stappers.nl ([2001:981:6c6a:1::49]:40143)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stappers@stappers.nl>) id 1guWuQ-0000C4-RC
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 01:23:39 -0500
Date: Fri, 15 Feb 2019 07:23:18 +0100
From: Geert Stappers <stappers@stappers.nl>
Message-ID: <20190215062318.yjzevnuc3iybcaxv@gpm.stappers.nl>
References: <20190214155714.8779-1-alex.bennee@linaro.org>
	<bbefd980-c740-cb8f-a648-a6f51772d63d@redhat.com>
	<8736oqhu6s.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <8736oqhu6s.fsf@zen.linaroharston>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/block: report when pflash backing file
 isn't aligned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Laszlo Ersek <lersek@redhat.com>, pkg-qemu-devel@lists.alioth.debian.org, qemu-devel@nongnu.org, ard.biesheuvel@linaro.org

On Thu, Feb 14, 2019 at 10:38:35PM +0000, Alex Benn=E9e wrote:
> Laszlo Ersek <lersek@redhat.com> writes:
> > On 02/14/19 16:57, Alex Benn=E9e wrote:
> >> +    /*
> >> +     * Validate the backing store is the right size for pflash
> >> +     * devices. It has to be padded to a multiple of the flash bloc=
k
> >> +     * size.
> >> +     */
> >> +    if (pfl->blk) {
> >> +        uint64_t backing_len =3D blk_getlength(pfl->blk);
> >> +        if (device_len !=3D backing_len) {
> >> +            error_setg(errp, "backing file wrong size "
> >> +                       "(%" PRId64 " !=3D %" PRId64")", backing_len=
, device_len);
> >> +            return;
> >> +        }
> >> +    }
> >>
> >>      memory_region_init_rom_device(
> >>          &pfl->mem, OBJECT(dev),
> >>
>=20
> > - from a user POV, I find it more useful if the error message also sh=
ows
> >   which quantity is which, not just two inequal numbers.
>=20
> How about:
>=20
>   "backing file size (%) not enough for whole device (%)"
>=20
> ?
>=20

from a user POV, I find it more useful if the error messsage
resembles the actual test in the source. Above is test   !=3D

How about

   "backing file size (%) not equal to whole device size (%)"

?




Groeten
Geert Stappers
--=20
Leven en laten leven

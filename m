Received: from eggs.gnu.org ([2001:4830:134:3::10]:43403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZESr-0006mR-33
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:18:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZESn-0003MJ-VQ
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:18:05 -0500
Date: Thu, 2 Feb 2017 10:17:58 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170202101758.GC22164@stefanha-x1.localdomain>
References: <1485800032-24404-1-git-send-email-hch@lst.de>
	<1485800032-24404-2-git-send-email-hch@lst.de>
	<20170201164050.GD12283@stefanha-x1.localdomain>
	<af5d7115-1b30-41aa-f3e5-0c4e4271d52c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline
In-Reply-To: <af5d7115-1b30-41aa-f3e5-0c4e4271d52c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] nvme: implement the DSM command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, keith.busch@intel.com, qemu-devel@nongnu.org, qemu-block@nongnu.org


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 01, 2017 at 12:29:22PM -0800, Paolo Bonzini wrote:
> On 01/02/2017 08:40, Stefan Hajnoczi wrote:
> >> +        goto out_free_range;
> >> +    }
> >> +
> >> +    if (dma_buf_write((uint8_t *)range, sizeof(range), &qsg)) {
> >=20
> > Did you mean sizeof(*range) * nr?
>=20
> Did you also mean dma_buf_read (you want to read from device to range)?

uint64_t dma_buf_write(uint8_t *ptr, int32_t len, QEMUSGList *sg)
{
    return dma_buf_rw(ptr, len, sg, DMA_DIRECTION_TO_DEVICE);
}

DMA_DIRECTION_TO_DEVICE seems correct.

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkwdWAAoJEJykq7OBq3PI76MH/00GNgtmgzrDkeUgGZEyMNGb
IdTLifFAhqZBA2ocT4aNoF67BFzJsKwpcdXivNyysPt68IbtdJGmmGoz8Zjsm7CJ
5I9gEzfE1B86+9BXvznmjmbHe893Q0gTse6DfEXATMjL4EyWSKH8XabfBtZbzdDI
HPciSgkspr4T18XyxCmV/effe4trEsW6lJrRwCAMxK0I7suqZ1CO4dM+7tpMZAbo
T32xNIGLgrfck3oS3XybG0X7usubbOT7ruPpHsoMNI67kW9ji5IEDECTaussnsJM
SmzjJZPLhtdfgWzEWOkKFUKU0Kjz+kN+pxXOP+V2v031s4ZR7LcJKYFujIMe7Gw=
=28sl
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--

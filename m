Received: from eggs.gnu.org ([2001:4830:134:3::10]:39331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eOLMA-0001pC-Cp
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 05:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eOLM6-0008Gp-G6
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 05:30:42 -0500
Date: Mon, 11 Dec 2017 10:30:25 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171211103025.GD13593@stefanha-x1.localdomain>
References: <cover.1512589016.git.mark.kanda@oracle.com>
	<cover.1512748083.git.mark.kanda@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline
In-Reply-To: <cover.1512748083.git.mark.kanda@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] virtio-blk: miscellaneous changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Kanda <mark.kanda@oracle.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, konrad.wilk@oracle.com, martin.petersen@oracle.com, ameya.more@oracle.com, karl.heubaum@oracle.com


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2017 at 09:57:25AM -0600, Mark Kanda wrote:
> v2: add check for maximum queue size [Stefan]
>=20
> This series is for two minor virtio-blk changes. The first patch
> makes the virtio-blk queue size user configurable. The second patch
> rejects logical block size > physical block configurations (similar
> to a recent change in virtio-scsi).
>=20
> Mark Kanda (2):
>   virtio-blk: make queue size configurable
>   virtio-blk: reject configs with logical block size > physical block
>     size
>=20
>  hw/block/virtio-blk.c          | 17 ++++++++++++++++-
>  include/hw/virtio/virtio-blk.h |  1 +
>  2 files changed, 17 insertions(+), 1 deletion(-)

Hi Mark,
Please resend as a top level email thread so the continuous integration
and patch management tools will detect your patch series.

=46rom https://wiki.qemu.org/Contribute/SubmitAPatch:

  "Send each new revision as a new top-level thread, rather than burying
  it in-reply-to an earlier revision, as many reviewers are not looking
  inside deep threads for new patches."

Thanks,
Stefan

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaLl5BAAoJEJykq7OBq3PI3LMH/RdGzAfr/MEDYVGjAQ89/x7I
2sK9HVT4VGWkr+S9KBbvFv8qml3aKjV93/iEwYdYRLL7s9caI2oFHW9hBNODfE1d
8muOqUIHpTKQNBaPJ9FgsZ3RJDOpgD9RiCSRGa/qKq6Jl2sE18SvwTthD1JYxP0F
sGylImyOsoi5HVwWvH+F/itTpDc9SCKwnT2qiMazekulbaifEmvSzlD0FFKCJsIm
c0jQnYOnksDWs0K9OAmAIfXzHXB5VMwW5QA+neBkJg92C+2j9owxQ+FW9vWaOsWg
v32w379rc+x0+HGHR6aDDKwwOWjU7mejuUSsw54ob+2j8gwyUYV926YX0A+exT8=
=fN1A
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--

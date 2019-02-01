Received: from eggs.gnu.org ([209.51.188.92]:38398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpW5t-0002qN-Kw
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpW5s-0004pK-Kp
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:30:45 -0500
Date: Fri, 1 Feb 2019 11:30:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190201103008.GC5730@localhost.localdomain>
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-9-kwolf@redhat.com>
	<5c615324-9f4d-9a7d-b659-84185574a750@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <5c615324-9f4d-9a7d-b659-84185574a750@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 08/11] qcow2: Add basic data-file
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 31.01.2019 um 19:44 hat Eric Blake geschrieben:
> On 1/31/19 11:55 AM, Kevin Wolf wrote:
> > This adds a .bdrv_open option to specify the external data file node.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qapi/block-core.json |  3 ++-
> >  block/qcow2.h        |  4 +++-
> >  block/qcow2.c        | 25 +++++++++++++++++++++++--
> >  3 files changed, 28 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 7f6b4b3ddd..fc46396079 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -2928,7 +2928,8 @@
> >              '*l2-cache-entry-size': 'int',
> >              '*refcount-cache-size': 'int',
> >              '*cache-clean-interval': 'int',
> > -            '*encrypt': 'BlockdevQcow2Encryption' } }
> > +            '*encrypt': 'BlockdevQcow2Encryption',
> > +            '*data-file': 'BlockdevRef' } }
>=20
> Missing docs and a '(since 4.0)' tag. Then again, it's still RFC, so
> that's understandable for this draft.

Yes, as mentioned in the cover letter.

Kevin

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcVB+wAAoJEH8JsnLIjy/WR2EQAK/vmKGdDCUWzqSlDaPl220f
JWaqJTFXKq81J2keBrRffzVhcdyO42SyC6AbKyXDfqw7nMVL6Lr5YQSGTQO19h11
mphSOFhSRlFsrLFQMASeTnbxlmzln/7Ni8Dz6K7Dx0/I4z8sI6h0bcQrM7FJHo5l
SxmWsfFg88C9W2jZGVsAOL6801OWg+Y2SIY/KD1mcrmUps5Ugg+t9h361fHzU2xm
r14n6on3GU2RhhctF1c3knVBykBdq0tGrw8sYI16H02Fm6ueM009Wkln2VmnqixQ
0fYt8MWytnrqdzRdxGL0W1UJUL59kVON/51X5sZ5tOniDGnrfa8XU+w+LHspyrjc
O7++SDt2XIjc/itjjKjC7oM31H9L9vnbFZQtlkWcihX5ihBpk7o8BEf0JV07rSEH
xA0BkEHnBx5Favyb7ZcVaWNgFpeQYDXHmLrv5vSzzEZsx+pjoO3HEhiJ7QDPkw6p
MUa6rvei8DEfnO3m1y7lCiDk1668N0sz1V/d4QbJPccW42YzKer3C+kwYMR9yaW/
IjyT9QYYt154Pw48/Wb4fr9EbwWU/534ZbZYQdS6j8TNLnF0TJh6DtsfeL30XgNu
jFZsPwB4bY0ca4j7RD0ArxiF3/yQwX23zxpTeMvIMtpJutXMetHft7wp0C8ZHkgE
6UroFzcwy5xIChY/N3xh
=O/qq
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--

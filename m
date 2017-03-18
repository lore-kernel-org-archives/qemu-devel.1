Received: from eggs.gnu.org ([2001:4830:134:3::10]:46781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cp4bi-0006Rp-2j
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 23:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cp4bh-00019c-9m
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 23:00:42 -0400
References: <20170317104541.28979-1-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b6725a55-9279-6385-6720-f40d9f52863e@redhat.com>
Date: Sat, 18 Mar 2017 04:00:30 +0100
MIME-Version: 1.0
In-Reply-To: <20170317104541.28979-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nscdVPX1l9KKQot4VECRi1GhQoT4fXvKv"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] qemu-img: improve qemu-img getopt
 error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nscdVPX1l9KKQot4VECRi1GhQoT4fXvKv
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <b6725a55-9279-6385-6720-f40d9f52863e@redhat.com>
Subject: Re: [PATCH v2 0/3] qemu-img: improve qemu-img getopt error messages
References: <20170317104541.28979-1-stefanha@redhat.com>
In-Reply-To: <20170317104541.28979-1-stefanha@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 17.03.2017 11:45, Stefan Hajnoczi wrote:
> v2:
>  * Print short help to avoid obscuring error messages [Max]
>=20
> This series improves getopt error messages.  Unrecognized global option=
s were
> skipped rather than causing qemu-img to exit as expected.  Also avoid p=
rinting
> the full help text because it obscures the actual error message.
>=20
> Stefan Hajnoczi (3):
>   qemu-img: show help for invalid global options
>   qemu-img: fix switch indentation in img_amend()
>   qemu-img: print short help on getopt failure
>=20
>  qemu-img.c | 196 ++++++++++++++++++++++++++++++++++++++++++-----------=
--------
>  1 file changed, 137 insertions(+), 59 deletions(-)

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

(Assuming that patches 2 and 3 will be fine even for rc2...)

Max


--nscdVPX1l9KKQot4VECRi1GhQoT4fXvKv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljMos4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AHbQH/09chubB7xuT2+CYszyVppjafJF0IN2l
8HmY7lSfnh69X85ONMBKCj+jYO4zi14tuCDEx3KStpT6uhyz9CiINmZDwQiPGiNd
6rMt2xtDSkO/zPDMJ3omeTKFHi65GiNbjG8YaHbIMnd7EH2FPfxQseqHGU+R2KRL
EFoUUq5EpPyEs2EGPhK6lXFBlYQMQmgfoIle8MbcBMYecgQqa/Xd4Yl8rGJ94mZO
yZkZDhOlys8YVJGtu8KrZBRNvRXlIA4TbsTjWNFFkmWKHSv89X5EUcBgQrkvsH2g
vStOEFlxmun+2/fMDvTa97maKiRIDuSZyX3LtOu0mz9OVhDaLaHr46Y=
=LZq9
-----END PGP SIGNATURE-----

--nscdVPX1l9KKQot4VECRi1GhQoT4fXvKv--

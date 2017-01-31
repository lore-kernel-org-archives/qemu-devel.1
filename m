Received: from eggs.gnu.org ([2001:4830:134:3::10]:58318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYc1k-0000JX-0j
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 12:15:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYc1g-0002Nl-04
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 12:15:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cYc1f-0002Ng-Q9
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 12:15:27 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C69C2C05AA42
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 17:15:27 +0000 (UTC)
Date: Tue, 31 Jan 2017 17:15:24 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131171524.GB25011@stefanha-x1.localdomain>
References: <20170126171613.1399-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <20170126171613.1399-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] trace: clean up trace-events files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2017 at 05:16:11PM +0000, Stefan Hajnoczi wrote:
> I noticed that some trace-events files are out of date.  This series fixe=
s them.
>=20
> Stefan Hajnoczi (2):
>   qapi: add missing trace_visit_type_enum() call
>   trace: clean up trace-events files
>=20
>  qapi/qapi-visit-core.c  | 1 +
>  block/trace-events      | 2 --
>  hw/block/trace-events   | 1 -
>  hw/display/trace-events | 1 -
>  hw/i386/trace-events    | 1 -
>  hw/input/trace-events   | 2 --
>  hw/intc/trace-events    | 1 -
>  hw/net/trace-events     | 8 --------
>  hw/usb/trace-events     | 1 -
>  hw/vfio/trace-events    | 2 +-
>  migration/trace-events  | 3 ---
>  qapi/trace-events       | 2 +-
>  trace-events            | 1 -
>  13 files changed, 3 insertions(+), 23 deletions(-)
>=20
> --=20
> 2.9.3
>=20

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkMYsAAoJEJykq7OBq3PIzy4H/irxHWQkXJKjwy2FOGRMHNHx
1qyzQD6cAIjExeju90MaBdtcTYdqkLnhx3UIUg7QRUlhdGRihrBOBP3PU9pBq5Yg
jMDmrXhdyjsz1I1jcnINshgp10dprm8eWoqwDZAXz0FiYfQurw9jr90BHz/l1v9W
oAD6dvbNCILfDrzm5S67bppFAyu9KhXBAy6PF4nmnT5zLyi/epPBGE3rCtioW9Z9
tX44SZMUL0BiQyHLerqva1l3cbyG5C9xAH0fpPqmwEdCVVgKcx1LhoikdJNBomAf
mi+pGV+YjOHqNP4io2FK3IULVe3ZcFr8Bq8bDRuwfXkfNMeOWQZTLMJxKghq92Q=
=vPUN
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--

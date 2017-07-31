Received: from eggs.gnu.org ([2001:4830:134:3::10]:33706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dc6wL-0001by-I6
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dc6wG-0002jP-Es
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:24:41 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dc6wG-0002jA-96
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:24:36 -0400
Received: by mail-wm0-x244.google.com with SMTP id r77so21705505wmd.2
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 02:24:36 -0700 (PDT)
Date: Mon, 31 Jul 2017 10:24:32 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170731092432.GC11830@stefanha-x1.localdomain>
References: <20170729131159.24949-1-vsementsov@virtuozzo.com>
	<20170729131159.24949-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline
In-Reply-To: <20170729131159.24949-3-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] trace-events: fix code style: %# ->
 0x%
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, peter.maydell@linaro.org, berrange@redhat.com


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 29, 2017 at 04:11:57PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> In trace format '#' flag of printf is forbidden. Fix it to '0x%'.
>=20
> This patch is created by the following:
>=20
> check that we have a problem
> > find . -name trace-events | xargs grep '%#' | wc -l
> 56
>=20
> check that there are no cases with additional printf flags
> > find . -name trace-events | xargs grep '%[-+ 0]+#' | wc -l
> 0
>=20
> check that there are no wrong usage of '#' and '0x' together
> > find . -name trace-events | xargs grep '0x%#' | wc -l
> 0
>=20
> fix the problem
> > find . -name trace-events | xargs sed -i 's/%#/0x%/g'
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  audio/trace-events       |  4 ++--
>  block/trace-events       |  6 +++---
>  hw/display/trace-events  |  2 +-
>  hw/i386/xen/trace-events | 22 +++++++++++-----------
>  hw/input/trace-events    |  2 +-
>  hw/intc/trace-events     | 20 ++++++++++----------
>  hw/net/trace-events      | 18 +++++++++---------
>  hw/pci/trace-events      |  4 ++--
>  hw/scsi/trace-events     |  6 +++---
>  hw/xen/trace-events      |  8 ++++----
>  trace-events             | 20 ++++++++++----------
>  11 files changed, 56 insertions(+), 56 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZfvdQAAoJEJykq7OBq3PIRvQIAK4dOvHWF2r7w+AdzkOwAy77
eE7LV6+9MDPisc80SU87BAyNhGzVbWyPoH3Kre464kK6AOwQFKk5sH8imh3xd1Qm
aNN7iRj0wiBM4JABwH5j3AQ5RQv82m4DotqHAPSMELWCTNIM8tTUOhlVQ+ExvBcO
6u/Csvs1qIRZgHtZcocQ6QQI4r0eZDXbL0bP7edV4uBwYfmgEsOvkhvdYgQcKB5s
IO9m/ln1rDNIFkUfM1VQxMFhxC82qwBKR+bXldqI/ORSF3qjE7OMcr4eb6kZbyOt
izi5VP290hdVSjBAvn30hKfUxSAB3I3Pjw/uFPOu888c28gdqQ7yYNzE1CelxMg=
=lXQq
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--

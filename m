Received: from eggs.gnu.org ([2001:4830:134:3::10]:58922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWNrj-0002UD-C1
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:44:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWNrf-0005be-Af
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:43:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWNrf-0005bQ-4W
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:43:55 -0500
Date: Wed, 25 Jan 2017 13:43:52 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170125134352.GL10664@stefanha-x1.localdomain>
References: <20170124110151.937-1-berrange@redhat.com>
	<20170124110151.937-5-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6CXocAQn8Xbegyxo"
Content-Disposition: inline
In-Reply-To: <20170124110151.937-5-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/8] trace: move hw/i386/xen events to
 correct subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>


--6CXocAQn8Xbegyxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 11:01:47AM +0000, Daniel P. Berrange wrote:
> The trace-events for a given source file should generally
> always live in the same directory as the source file.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  Makefile.objs            | 1 +
>  hw/i386/trace-events     | 7 -------
>  hw/i386/xen/trace-events | 6 ++++++
>  3 files changed, 7 insertions(+), 7 deletions(-)
>  create mode 100644 hw/i386/xen/trace-events

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6CXocAQn8Xbegyxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYiKuYAAoJEJykq7OBq3PIJ3gIAMkVlRztyt0NN+q4+JLgIv/d
Q6avokRq45nbZuv1P4kh1NFW2gUxHOANRpYunQIZofYPNzyC7hiAnzOc3XOmOIeA
OCNtcW2qiHSKvs3+TN35ZDpdiruRfX5915GE9c7wCVl9ykA58jFKSIXne/feFRg4
TULlO+BGNYh7OjbOo7La6R6f+LGrGl8zQEFAQ2U5Yur66txrTzAeRyO4ebLLEfQB
khzd4eTSzaxI4zUEIrzqE6CVLl75dKr3h6kTu1YtJ7rCXMxSCcomoEU81lGxgg1N
ferabOt6W/BwaUsIrGOWIt5xQ+SJywLUTIApqbp/aVTKgV/9JmDexZPEttdfiQY=
=11zR
-----END PGP SIGNATURE-----

--6CXocAQn8Xbegyxo--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAgDD-0008Oy-Dd
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 13:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAgDC-00062M-PR
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 13:56:59 -0400
References: <20171103143902.18039-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <77890479-0388-7990-d542-f50dbbe9a9f2@redhat.com>
Date: Fri, 3 Nov 2017 12:56:47 -0500
MIME-Version: 1.0
In-Reply-To: <20171103143902.18039-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ibthir2MMrNl362hge8eVR0SVjbeVr3Uw"
Subject: Re: [Qemu-devel] [PATCH] qcow2: don't permit changing encryption
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ibthir2MMrNl362hge8eVR0SVjbeVr3Uw
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <77890479-0388-7990-d542-f50dbbe9a9f2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: don't permit changing encryption
 parameters
References: <20171103143902.18039-1-berrange@redhat.com>
In-Reply-To: <20171103143902.18039-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/03/2017 09:39 AM, Daniel P. Berrange wrote:
> Currently if trying to change encryption parameters on a qcow2 image, q=
emu-img
> will abort. We already explicitly check for attempt to change encrypt.f=
ormat
> but missed other parameters like encrypt.key-secret. Rather than list e=
ach
> parameter, just blacklist changing of all parameters with a 'encrypt.' =
prefix.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/qcow2.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Ibthir2MMrNl362hge8eVR0SVjbeVr3Uw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln8rd8ACgkQp6FrSiUn
Q2rx1Qf/Wi0jVZi63LbTXU7vnTC43rWiw9IYlWEsaT3jGSnK2lWBXJYtNpz3yora
56zDsO70SfGt+HEtU0bApA6LaAx9lidOadyDZSnRF1yQvrHWTjUCTJs2BQ3Erefx
6wUubCuxb3CIsi05kdyxGWiJsNEaP5f1In3kzkERT389tfGpjDgwYj0Mos4Egb7E
tYN5noR50prrx5ElxAcwXbq6nbkNB3t+ho4c4gACHfDj8ohPXqmEzFuqDRtWrhOp
jlTRMnlEKpJbOrIYi6xdADi7/W1P6lSqUwklkARHa1lklb6jmFVJl6cRUCFijdb6
aswJ/fjdeHsAw39u2Z8KWGXLFb3yFg==
=+QOE
-----END PGP SIGNATURE-----

--Ibthir2MMrNl362hge8eVR0SVjbeVr3Uw--

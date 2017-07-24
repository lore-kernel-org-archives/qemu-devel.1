Received: from eggs.gnu.org ([2001:4830:134:3::10]:52211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZiEw-000872-T1
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZiEs-0001e1-Ka
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:37:58 -0400
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-4-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <acb16999-952f-bd1e-254b-befe65a259d3@redhat.com>
Date: Mon, 24 Jul 2017 13:37:49 -0500
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-4-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6PIAcAXlOh7KRIppsrAfDWxHbQ72xmbI4"
Subject: Re: [Qemu-devel] [PATCH for 2.10 03/35] thunk: check nb_fields is
 valid before continuing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6PIAcAXlOh7KRIppsrAfDWxHbQ72xmbI4
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Message-ID: <acb16999-952f-bd1e-254b-befe65a259d3@redhat.com>
Subject: Re: [PATCH for 2.10 03/35] thunk: check nb_fields is valid before
 continuing
References: <20170724182751.18261-1-f4bug@amsat.org>
 <20170724182751.18261-4-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/24/2017 01:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> thunk.c:91:32: warning: Call to 'malloc' has an allocation size of 0 by=
tes
>         se->field_offsets[i] =3D malloc(nb_fields * sizeof(int));
>                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  thunk.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Better would be fixing the code to use g_new0, and the corresponding free=
=2E

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6PIAcAXlOh7KRIppsrAfDWxHbQ72xmbI4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll2Pn0ACgkQp6FrSiUn
Q2oBowf9EUZN9joBagpJ4DWIdKpv3Z2FlBjJNLnrwvb/0MvwHl4e54kf7pXW3NuZ
5RqkfT33aV8P5f/jcFgOE8USCkLMtNoZNb9TX8/ly7GVZ3mx2u2N9k23xGw8zjvi
eo7+tTInKYTA5s/rvnMioBoFHNYoFh4kMXOKJIbaS8yq+kfFo44awuu+P8olm88U
w6sbrrXtfp3+I0L1ODVd/x832ziW4sBZZg7ei2RAS+BRZqWnd6Ol7FX34ZRkVNt+
hHDWkV7Q3bcjMnpRhhhelrR6LeHHDXWcmSp3reRTn6Qem4bbqNhWCTrXRyGauU/2
EOPmTjqGPfmSzu/fkph5DNf58GFz3A==
=qYLB
-----END PGP SIGNATURE-----

--6PIAcAXlOh7KRIppsrAfDWxHbQ72xmbI4--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB5Qz-0005Td-3O
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB5Qy-0006u0-4Q
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:25:09 -0400
References: <20180424152515.25664-1-kwolf@redhat.com>
	<20180424152515.25664-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <57898c52-25f0-5bab-b4da-bb451a5c505c@redhat.com>
Date: Tue, 24 Apr 2018 16:24:54 -0500
MIME-Version: 1.0
In-Reply-To: <20180424152515.25664-3-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fT2Xh4vjoOzSAqYmWqic5a0Nz6rFbeCbo"
Subject: Re: [Qemu-devel] [RFC PATCH 02/33] blockjob: Move RateLimit to
 BlockJob
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fT2Xh4vjoOzSAqYmWqic5a0Nz6rFbeCbo
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <57898c52-25f0-5bab-b4da-bb451a5c505c@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 02/33] blockjob: Move RateLimit to
 BlockJob
References: <20180424152515.25664-1-kwolf@redhat.com>
 <20180424152515.25664-3-kwolf@redhat.com>
In-Reply-To: <20180424152515.25664-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2018 10:24 AM, Kevin Wolf wrote:
> Every block job has a RateLimit, and they all do the exact same thing
> with it, so it should be common infrastructure. Move the struct field
> for a start.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fT2Xh4vjoOzSAqYmWqic5a0Nz6rFbeCbo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrfoKYACgkQp6FrSiUn
Q2o4rQgArb0faTtmXQkNju6bv2hqkXtc831zfeUwMipEo8DWxq7HQtPituq+o1Nv
G+uZsGBh25TC9N7F5uo91oJ7yqR09zGRk9EEshdwxlhFhGsjQNj4+1gdQKFO5Y91
Hc/Eoz3G+5BbH2pLTJWoYpDyTdD7YQTa0tIw5jAaWx0/U0YF/84wqhWGyN3s1Jt/
4EcO/GvcxpHFIoZglFeoWYHxAEzsI2f42sGkrBfOJzxIbw7jbtDWywYiAcg11XR+
+YRmMVOO5570mZE05rYEel5WSja8RTgI8uyU23Ab5PTJPDggB4oeZ2+noa/g/8Di
Azme7344428hj39qzK3krm6kHAVB6Q==
=MyX6
-----END PGP SIGNATURE-----

--fT2Xh4vjoOzSAqYmWqic5a0Nz6rFbeCbo--

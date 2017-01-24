Received: from eggs.gnu.org ([2001:4830:134:3::10]:58410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cW6IT-0002Ud-CT
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:58:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cW6IQ-0001yp-Rn
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:58:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cW6IQ-0001yc-LQ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:58:22 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9959E3A76B5
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 18:58:22 +0000 (UTC)
References: <20170124095332.23955-1-berrange@redhat.com>
	<20170124095332.23955-8-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a9b972bd-e569-51e7-95eb-7a233cdd1c6c@redhat.com>
Date: Tue, 24 Jan 2017 12:58:20 -0600
MIME-Version: 1.0
In-Reply-To: <20170124095332.23955-8-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fV7RT1ItBI9fWg8g05RQJ5pjjG5LHEHBv"
Subject: Re: [Qemu-devel] [PATCH v2 7/8] util: add iterators for QemuOpts
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fV7RT1ItBI9fWg8g05RQJ5pjjG5LHEHBv
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <a9b972bd-e569-51e7-95eb-7a233cdd1c6c@redhat.com>
Subject: Re: [PATCH v2 7/8] util: add iterators for QemuOpts values
References: <20170124095332.23955-1-berrange@redhat.com>
 <20170124095332.23955-8-berrange@redhat.com>
In-Reply-To: <20170124095332.23955-8-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/24/2017 03:53 AM, Daniel P. Berrange wrote:
> To iterate over all QemuOpts currently requires using a callback
> function which is inconvenient for control flow. Add support for
> using iterator functions more directly
>=20
>   QemuOptsIter iter;
>   QemuOpt *opt;
>=20
>   qemu_opts_iter_init(&iter, opts, "repeated-key");
>   while ((opt =3D qemu_opts_iter_next(&iter)) !=3D NULL) {
>       ....do something...
>   }
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  include/qemu/option.h |  9 +++++++++
>  util/qemu-option.c    | 19 +++++++++++++++++++
>  2 files changed, 28 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--fV7RT1ItBI9fWg8g05RQJ5pjjG5LHEHBv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYh6PMAAoJEKeha0olJ0NqPqgIAJfUIS0HpeAhi678WD698QR8
z22NbqgbXsrXwYSCcwsKN29CvilLovHWx+jzvl/wa+3m47yylPpoY+/dG8uDCyGm
BSzPqWK3D1fHUP3/05RWBRbmArQbyNi2DatiHEgRqmKHkPpt/1D7gZRzl+Z0VczM
srlev9LX85N/2vfJUneE1I+zgRjTsRq/014PYCktxsrwnDGAHn5ijKWsoF6xO0F/
ZZ5340qo7A8EnICHeEzXukLXqXC7SPwoodPwP4f3/EiCO8CIKPlAHAwGt8e7Do0p
+cyi81DYYl5dHoL6U4wkfUL6yVSaizcUe4KRVzMV16lcxcsD93LMXbiMlA6/wXY=
=Er9D
-----END PGP SIGNATURE-----

--fV7RT1ItBI9fWg8g05RQJ5pjjG5LHEHBv--

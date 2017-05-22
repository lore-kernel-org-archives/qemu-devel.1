Received: from eggs.gnu.org ([2001:4830:134:3::10]:39167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCoKU-0005Ui-QU
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCoKR-0002xB-Um
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:29:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCoKR-0002wz-Os
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:28:59 -0400
References: <149520531371.9327.383828886525307842.stgit@bahia>
From: Eric Blake <eblake@redhat.com>
Message-ID: <826e8431-8998-4c83-4ca5-980cbe4631bf@redhat.com>
Date: Mon, 22 May 2017 09:28:57 -0500
MIME-Version: 1.0
In-Reply-To: <149520531371.9327.383828886525307842.stgit@bahia>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QGg7SiMdWIqNRNPfF24VlueTdSWkt0OQO"
Subject: Re: [Qemu-devel] [PATCH 0/2] get rid of qemu_utimens()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QGg7SiMdWIqNRNPfF24VlueTdSWkt0OQO
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Message-ID: <826e8431-8998-4c83-4ca5-980cbe4631bf@redhat.com>
Subject: Re: [PATCH 0/2] get rid of qemu_utimens()
References: <149520531371.9327.383828886525307842.stgit@bahia>
In-Reply-To: <149520531371.9327.383828886525307842.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/19/2017 09:50 AM, Greg Kurz wrote:
> It is currently only used by 9pfs and virtfs-proxy-helper. This series =
convert
> them to utimensat() and futimens().
>=20
> --
> Greg
>=20
> ---
>=20
> Greg Kurz (2):
>       9pfs: assume utimensat() and futimens() are present
>       util: drop old utimensat() compat code

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QGg7SiMdWIqNRNPfF24VlueTdSWkt0OQO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIvWpAAoJEKeha0olJ0NqR1AH/jms01gGSr9puXbWn9ykSzfQ
IN4iiTlsDNDtpMir3h51BFAJoaQmXl9R842YnOcuXylFmBQFd+75nrpGPSGfgTXg
5WR88ZAeWd7CcKpCi2Ps+gxk/DR1Yuf3vdvtu+xYMA6CokrUn54tQmTLwIwNhvmu
P82QzCAwcHZPJ+he8/2AWmqXQWs0LaWI3FPs+UK2v3KPjM7NU7gbTVKo4Jd1HAU1
WKvOkvkMD33guc9Mqz+/YZ9MYIYy+2bNhZLIBJ2o9u5E3JDaEpIc2qLZ1VHyV3wB
M5325cEa1BC9jOZnoW1h4lxsAO3elBdWfhTHbrR4NQSfrbq+ytB4JT7kIMSAhyg=
=uPYU
-----END PGP SIGNATURE-----

--QGg7SiMdWIqNRNPfF24VlueTdSWkt0OQO--

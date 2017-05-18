Received: from eggs.gnu.org ([2001:4830:134:3::10]:55316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBM7v-0003x8-OP
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBM7s-00064Z-Gu
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:10:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dBM7s-00064A-8p
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:10:00 -0400
References: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170512133144eucas1p25b4275feb4126a21415242c5085382fd@eucas1p2.samsung.com>
	<1494595886-30912-3-git-send-email-a.perevalov@samsung.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d5047c00-9000-aebe-6b59-75e9d5398db6@redhat.com>
Date: Thu, 18 May 2017 09:09:49 -0500
MIME-Version: 1.0
In-Reply-To: <1494595886-30912-3-git-send-email-a.perevalov@samsung.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0jW4lsdHKlMnBn09S8V1NIx4cV72JhEEP"
Subject: Re: [Qemu-devel] [PATCH V5 2/9] migration: pass ptr to
 MigrationIncomingState into migration ufd_version_check &
 postcopy_ram_supported_by_host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org
Cc: i.maximets@samsung.com, dgilbert@redhat.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0jW4lsdHKlMnBn09S8V1NIx4cV72JhEEP
From: Eric Blake <eblake@redhat.com>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org
Cc: i.maximets@samsung.com, dgilbert@redhat.com, peterx@redhat.com
Message-ID: <d5047c00-9000-aebe-6b59-75e9d5398db6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V5 2/9] migration: pass ptr to
 MigrationIncomingState into migration ufd_version_check &
 postcopy_ram_supported_by_host
References: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
 <CGME20170512133144eucas1p25b4275feb4126a21415242c5085382fd@eucas1p2.samsung.com>
 <1494595886-30912-3-git-send-email-a.perevalov@samsung.com>
In-Reply-To: <1494595886-30912-3-git-send-email-a.perevalov@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/12/2017 08:31 AM, Alexey Perevalov wrote:

Long subject line. Try to keep things in the subject around 60
characters or less, in part so that 'git shortlog --oneline -30' still
fits in an 80-column screen.  Maybe:

migration: Refactor use of MigrationIncomingState pointer

> That tiny refactoring is necessary to be able to set
> UFFD_FEATURE_THREAD_ID while requesting features, and then
> to create downtime context in case when kernel supports it.
>=20
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0jW4lsdHKlMnBn09S8V1NIx4cV72JhEEP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHastAAoJEKeha0olJ0Nqg38H+gKcHP8xgxcnl7iiaoyinDBH
4mWQqHmFOruxNnQ3y3IkCltkGhq+kghxDF7wfioIp6BjmPDhngQe/cZfVOWvChxl
dJ3hC9RjkiaCQirWZ/Cxd+q0KkHJSlnzbRCXHRXQAtfBnmW9CCRudts5k6H80dS1
2Uryo08ANQMHhViXFaDjhqAjwW/ETe5HYjJ9oEzd8W+rg7U6rIwizB1NXWSQSjxv
8//5+7d2AiW080OE51zAUh2N3ccJ1nj2i2c6aiY0Q83l/4Hs2H01yDXnaknk6oYs
3qBFe73LkvRGzEdcp7yI+eETw2kEVAseEU7d3fnCCo+Ll2EwketVBUmp84zUJ1M=
=K7Es
-----END PGP SIGNATURE-----

--0jW4lsdHKlMnBn09S8V1NIx4cV72JhEEP--

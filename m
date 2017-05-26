Received: from eggs.gnu.org ([2001:4830:134:3::10]:36958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEMEd-0005LU-I7
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEMEZ-000080-NT
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:53:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dEMEZ-00007i-Du
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:53:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 513BA368E5
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 20:53:18 +0000 (UTC)
References: <20170526202316.22736-1-ehabkost@redhat.com>
	<20170526202316.22736-4-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <70d35d8d-48ce-d9f6-a624-832f9692bf07@redhat.com>
Date: Fri, 26 May 2017 15:53:17 -0500
MIME-Version: 1.0
In-Reply-To: <20170526202316.22736-4-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7gcouTOs1Ub2vTRJ8S4XNHTsOax8kidDw"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qmp: Include parent type on
 'qom-list-types' output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7gcouTOs1Ub2vTRJ8S4XNHTsOax8kidDw
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Message-ID: <70d35d8d-48ce-d9f6-a624-832f9692bf07@redhat.com>
Subject: Re: [PATCH v2 3/3] qmp: Include parent type on 'qom-list-types'
 output
References: <20170526202316.22736-1-ehabkost@redhat.com>
 <20170526202316.22736-4-ehabkost@redhat.com>
In-Reply-To: <20170526202316.22736-4-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/26/2017 03:23 PM, Eduardo Habkost wrote:
> Include name of parent type of each type on 'qom-list-types' output.
>=20
> Without this, there's no way to figure out the parents of a given type
> without making additional 'qom-list-types' queries.
>=20
> In addition to the test case for the new feature, update the
> abstract-interface test case to use the new field and avoid the
> "qom-list-types implements=3Dobject" trick.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7gcouTOs1Ub2vTRJ8S4XNHTsOax8kidDw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZKJW9AAoJEKeha0olJ0Nq4ooIAJ6r4ruNNrxgEuGJqeAjYvLh
1AobHOiJD4mqiA1Cbyy4ZaU4Rv8G9m/rjivpHWg0DiswJzWMmOpMzpJD2VyuN7Vl
G7z387QDVuZLA3xairNIBl4eMB3iRHNqmvImUexAufgumKgohMqvKQSvyXfmP+yV
5TecxVYSO9DNtuR68Se17kYHycK9h7uKUIT7h0zJ4en6yupx8mvLIECEtCQcB129
E670ReR6MnUeCqgNe3rQOnZTm4E+WOnX39ricy7yv6aMdd46JjebdpOCE9wzvLFn
0MkTvsraVPK6nT9cE2hgcbKaCDNHry5vo+d3aO3opgqNmnmy+Blt8YL1JGp24T8=
=LMJP
-----END PGP SIGNATURE-----

--7gcouTOs1Ub2vTRJ8S4XNHTsOax8kidDw--

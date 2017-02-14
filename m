Received: from eggs.gnu.org ([2001:4830:134:3::10]:33142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdlYu-0004To-P1
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 17:27:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdlYr-0000Jw-Lp
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 17:27:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cdlYr-0000Jd-GK
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 17:27:01 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA528C04B954
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 22:27:01 +0000 (UTC)
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-11-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <044d28d8-c920-d2a7-f435-cb1790010cfc@redhat.com>
Date: Tue, 14 Feb 2017 16:26:59 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-11-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="M7hKIrrwOO8w42icXDgcwUu3n5TVoJrLt"
Subject: Re: [Qemu-devel] [PATCH 10/24] tests/test-cutils: Add missing
 qemu_strtosz()... endptr checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M7hKIrrwOO8w42icXDgcwUu3n5TVoJrLt
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <044d28d8-c920-d2a7-f435-cb1790010cfc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/24] tests/test-cutils: Add missing
 qemu_strtosz()... endptr checks
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-11-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:25 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-cutils.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--M7hKIrrwOO8w42icXDgcwUu3n5TVoJrLt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYo4QzAAoJEKeha0olJ0NqYIgH/1oz9pmTJ8CnmSHGXP6xaNFP
XCq5d+f1uYCLGFxr+fz2KxbrkIAaly117AVAANQUPfEh58j4zwmUAbghMyc/chih
ymKnOyDXrwD5aRIhvyTRyx8HQ67rjbIVHNfqD6x4wripvUaGYcFWzfhRZ09LeLzO
F7j3RG+3/XvkQ/FwUzyXoxVn9Wwn258Vqn3Yq1Wpmx+iGkdXRxFcHYTxfGVP4DGq
7/kB5VCJvvcr9lWsaG7K5JIoOD5JyF/8reJzCrdMyYHPmeaNt5UeLRDp5dle38H1
UAr8ESt69OW6NJG4NyXYOeJS12qzLj3BlyCkn3ELRVbOvkkRq0dHOmfW0UfSTjQ=
=95gT
-----END PGP SIGNATURE-----

--M7hKIrrwOO8w42icXDgcwUu3n5TVoJrLt--

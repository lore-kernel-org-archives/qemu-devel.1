Received: from eggs.gnu.org ([2001:4830:134:3::10]:49193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgGNn-00037n-2c
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:45:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgGNm-00085h-3I
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:45:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgGNl-00085T-TJ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:45:54 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1060C054C59
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 19:45:53 +0000 (UTC)
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
	<1487363905-9480-14-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <76daae87-caf1-1a8e-37a4-b60890b93bb8@redhat.com>
Date: Tue, 21 Feb 2017 13:45:51 -0600
MIME-Version: 1.0
In-Reply-To: <1487363905-9480-14-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="R59OOqG2l66LsG2jCKuF0HJw2UKxu7DQT"
Subject: Re: [Qemu-devel] [PATCH 13/14] monitor: Clean up
 handle_hmp_command() a bit
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
--R59OOqG2l66LsG2jCKuF0HJw2UKxu7DQT
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <76daae87-caf1-1a8e-37a4-b60890b93bb8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/14] monitor: Clean up handle_hmp_command()
 a bit
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
 <1487363905-9480-14-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-14-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 02:38 PM, Markus Armbruster wrote:
> Leave checking qobject_type(req) to qmp_check_input_obj().  Rework
> handling of json_parser_parse_err() failing without setting an error.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  monitor.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--R59OOqG2l66LsG2jCKuF0HJw2UKxu7DQT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrJjvAAoJEKeha0olJ0Nq7ukIAKm9DkJDgUIeOT3e8u+IAOKR
8pVbEjEeDUIvYHZLvncNPLmAd93OMODFiTg7qPfCBJ1mTG1uqq1DvVJGDRfq+XpJ
/xHYE0rWDpfCfXLnl4CpgSUx68j05nb8i8m1xJ8b4kZ3qskvOVB2DbyF5cTlimAm
cBynF6HfoHrigck9iyJ9nBmJQUgsczdsYp/CIXOZHyUNqypv3vdHZGSRrPFrdgUU
0i1MxDIxtFSlpsRJyydDlqTudP0qAKiTmzwACwhLigfFmsoOwWcmu7iL/A1pGRLS
NIC30JIq5J6ZXZcFVxBCgKp2ZS6uxc+xfFMRvBzK2sqjwg5J3YXtCmjeeyXC2CY=
=FTKn
-----END PGP SIGNATURE-----

--R59OOqG2l66LsG2jCKuF0HJw2UKxu7DQT--

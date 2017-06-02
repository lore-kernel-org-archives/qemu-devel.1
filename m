Received: from eggs.gnu.org ([2001:4830:134:3::10]:39781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGmgr-0001k0-3O
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGmgn-0007JH-Vk
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:32:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dGmgn-0007I0-Mp
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:32:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A86F07F6AC
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 13:32:28 +0000 (UTC)
References: <20170601214056.30387-1-quintela@redhat.com>
	<20170601214056.30387-2-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c4d3ba90-9369-4eb6-7a54-f794238275b7@redhat.com>
Date: Fri, 2 Jun 2017 08:32:25 -0500
MIME-Version: 1.0
In-Reply-To: <20170601214056.30387-2-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vm0XGseiCvEceGIw7B6n71QOEqSFBUGEd"
Subject: Re: [Qemu-devel] [PATCH 1/4] ram: Unfold get_xbzrle_cache_stats()
 into populate_ram_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vm0XGseiCvEceGIw7B6n71QOEqSFBUGEd
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Message-ID: <c4d3ba90-9369-4eb6-7a54-f794238275b7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] ram: Unfold get_xbzrle_cache_stats()
 into populate_ram_info()
References: <20170601214056.30387-1-quintela@redhat.com>
 <20170601214056.30387-2-quintela@redhat.com>
In-Reply-To: <20170601214056.30387-2-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2017 04:40 PM, Juan Quintela wrote:
> They were called consequtiveley always.

s/consequtiveley/consecutively/

>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vm0XGseiCvEceGIw7B6n71QOEqSFBUGEd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMWjpAAoJEKeha0olJ0NqotoH/1Tz4cUS81/dP2bTWR6XRM3B
xNU8sbk38CujH8EePa2y1kqlsO3zCWaDQnhvxCExUBDYKwjJAckHPiZZQ8ngfgNF
XtVMWM3f8xNezPyxrktc/QbeHEsJq7RN8e0Ls9htkowhVPJ6frPCV4rbbCM/qWXJ
yh6bIuDz9653WhM55e/S6PzZobF4McqzNg+vXDch6bhjlAMfmP+TyrIZcX98SvJB
x4s8l6S7HxwsGgFb8Oe7scc6whEg7vC/IPyU/2Fok6XbD+1frE4VhJZPAw7s1jw3
fJV2I4Pvvobu4/mPOCByqUgsnEcxYAB4h4wilLsqnbUHB2HbG1/v64pV+tOnjzY=
=QO88
-----END PGP SIGNATURE-----

--vm0XGseiCvEceGIw7B6n71QOEqSFBUGEd--

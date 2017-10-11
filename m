Received: from eggs.gnu.org ([2001:4830:134:3::10]:47188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2GbK-0007Em-PG
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2GbC-00059W-PS
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:59:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e2GbC-000592-FY
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:58:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EAEC7EAA1
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 12:58:57 +0000 (UTC)
References: <20171011100959.29326-1-berrange@redhat.com>
	<20171011100959.29326-6-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0ac09575-93ab-5117-1433-d0a39e8773a1@redhat.com>
Date: Wed, 11 Oct 2017 07:58:55 -0500
MIME-Version: 1.0
In-Reply-To: <20171011100959.29326-6-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3JqNOR2OLmSPNSs2fluRtiWh89HASeVvB"
Subject: Re: [Qemu-devel] [PATCH v2 5/7] io: get rid of bounce buffering in
 websock write path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3JqNOR2OLmSPNSs2fluRtiWh89HASeVvB
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <0ac09575-93ab-5117-1433-d0a39e8773a1@redhat.com>
Subject: Re: [PATCH v2 5/7] io: get rid of bounce buffering in websock write
 path
References: <20171011100959.29326-1-berrange@redhat.com>
 <20171011100959.29326-6-berrange@redhat.com>
In-Reply-To: <20171011100959.29326-6-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/11/2017 05:09 AM, Daniel P. Berrange wrote:
> Currently most outbound I/O on the websock channel gets copied into the=

> rawoutput buffer, and then immediately copied again into the encoutput
> buffer, with a header prepended. Now that qio_channel_websock_encode
> accepts a struct iovec, we can trivially remove this bounce buffering
> and write directly to encoutput.
>=20
> In doing so, we also now correctly validate the encoutput size against
> the QIO_CHANNEL_WEBSOCK_MAX_BUFFER limit.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  include/io/channel-websock.h |  1 -
>  io/channel-websock.c         | 64 +++++++++++++++++++-----------------=
--------
>  2 files changed, 28 insertions(+), 37 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3JqNOR2OLmSPNSs2fluRtiWh89HASeVvB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlneFY8ACgkQp6FrSiUn
Q2pcWQf/Tgir1CPYd3Vmus7KUlVH/QIhfAYNSk7h6ZBkaChY8kx3VF+GzJduTeog
4HxgAL/NKiFxo6Ydlg8zGRhTnIXmWtVbhDdJVSgd+P24aa4wLoQ+6Z1TYOIbTB1U
HFR6l5cT/pMxj3zE768sbYfrYauVZbNdoH/TCNkKhtS83R5nddkxsY+wC32Ft4cg
/f4MomWoc+3794SAkqw0UbaCO/smxdsLOeheg6XmDU4/UQuC0ZjFhC9phDtgzkDS
fuLvGFOQzzpjdYwYsfC+2lLyCq9OHGpkTsRUSyhpZvFOEf36DGtIY1bDowTVBmzt
JwiNtFeeHaVFZJh0waaBWhqDDvBHAA==
=H5Vp
-----END PGP SIGNATURE-----

--3JqNOR2OLmSPNSs2fluRtiWh89HASeVvB--

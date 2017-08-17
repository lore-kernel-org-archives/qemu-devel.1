Received: from eggs.gnu.org ([2001:4830:134:3::10]:43767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diIg9-0003mk-Sf
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diIg5-00013E-8N
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:09:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1diIg5-00012z-2Z
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:09:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E3D2C0587F8
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 11:09:28 +0000 (UTC)
References: <20170817104216.29150-1-dgilbert@redhat.com>
	<20170817104216.29150-2-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <707ce050-c1eb-658f-fc78-62b3597f22bd@redhat.com>
Date: Thu, 17 Aug 2017 06:09:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170817104216.29150-2-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VRsMUp6KdV8g2jVxaQUc586mAPCjQkRVQ"
Subject: Re: [Qemu-devel] [PATCH 1/2] hmp: Missing handle_errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VRsMUp6KdV8g2jVxaQUc586mAPCjQkRVQ
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com
Message-ID: <707ce050-c1eb-658f-fc78-62b3597f22bd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] hmp: Missing handle_errors
References: <20170817104216.29150-1-dgilbert@redhat.com>
 <20170817104216.29150-2-dgilbert@redhat.com>
In-Reply-To: <20170817104216.29150-2-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/17/2017 05:42 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> hmp_info_memdev && hmp_info_memory_devices were missing
> hmp_handle_error calls.  Add them.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hmp.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VRsMUp6KdV8g2jVxaQUc586mAPCjQkRVQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmVeWcACgkQp6FrSiUn
Q2o2fAgAjERBpV6ZtN8lfQtwJGCYvPMGV2dGwkQFmaT1crAPYVSwdjbCuQH/yc7E
n2ltAjvKYVIS33OEEchrDTZYq+XW3Fj0xVHYq6uxjhZlc7OZ1R2L7CeoKdNH4vqu
Vn3xJ93LMGD/VSo9c56WAu/OwfLwwWx+CVG9LenWEOeNMDoPoDKOan9IYPOxeC76
Th0P0vycGRA7CMAqRpJBbXWn060UBz6cGR1pTctRFyhxvK3moQobD67M+/vOGSMg
/Xj/jtrTugc1vne38dD1y2YT95fev/pakL05DmWD8P3GahSqi1qfNLf9UwPIveLL
KH04Hhyo7mzEmaSE4hwrfYfEJbYf8A==
=Zxro
-----END PGP SIGNATURE-----

--VRsMUp6KdV8g2jVxaQUc586mAPCjQkRVQ--

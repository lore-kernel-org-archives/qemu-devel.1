Received: from eggs.gnu.org ([2001:4830:134:3::10]:40775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8WEu-0007af-KU
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8WEs-0005pn-0o
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:26:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41586 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f8WEr-0005p9-OX
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:26:01 -0400
References: <1523340193-9024-1-git-send-email-yulei.zhang@intel.com>
	<a4bfe3d3-d9a0-565e-800c-c4493e328d87@nvidia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <72966c87-f9fe-71d3-8261-7ea315eede47@redhat.com>
Date: Tue, 17 Apr 2018 14:25:50 -0500
MIME-Version: 1.0
In-Reply-To: <a4bfe3d3-d9a0-565e-800c-c4493e328d87@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dGBRFZmCRnEEQQCOL0XOVj6TzH05wYeCb"
Subject: Re: [Qemu-devel] [RFC PATCH V4 3/4] vfio: Add SaveVMHanlders for
 VFIO device to support live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirti Wankhede <kwankhede@nvidia.com>, Yulei Zhang <yulei.zhang@intel.com>, qemu-devel@nongnu.org
Cc: kevin.tian@intel.com, quintela@redhat.com, joonas.lahtinen@linux.intel.com, dgilbert@redhat.com, zhenyuw@linux.intel.com, alex.williamson@redhat.com, zhi.a.wang@intel.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dGBRFZmCRnEEQQCOL0XOVj6TzH05wYeCb
From: Eric Blake <eblake@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>, Yulei Zhang
 <yulei.zhang@intel.com>, qemu-devel@nongnu.org
Cc: kevin.tian@intel.com, quintela@redhat.com,
 joonas.lahtinen@linux.intel.com, dgilbert@redhat.com,
 zhenyuw@linux.intel.com, alex.williamson@redhat.com, zhi.a.wang@intel.com
Message-ID: <72966c87-f9fe-71d3-8261-7ea315eede47@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH V4 3/4] vfio: Add SaveVMHanlders for VFIO
 device to support live migration
References: <1523340193-9024-1-git-send-email-yulei.zhang@intel.com>
 <a4bfe3d3-d9a0-565e-800c-c4493e328d87@nvidia.com>
In-Reply-To: <a4bfe3d3-d9a0-565e-800c-c4493e328d87@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/16/2018 09:44 AM, Kirti Wankhede wrote:
>=20
>=20
> On 4/10/2018 11:33 AM, Yulei Zhang wrote:
>> Instead of using vm state description, add SaveVMHandlers for VFIO
>> device to support live migration.

In the subject line: s/Hanlders/Handlers/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--dGBRFZmCRnEEQQCOL0XOVj6TzH05wYeCb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrWSj4ACgkQp6FrSiUn
Q2pnyQgAo1AHY7tF+oVFLvlaUOdwhfPIb+XFgHyCa+Pm5dkw0kL4voSU3evvgKv6
4nHs3HOJlQmM/Khz4YNByveDFt/2zgS8XWFyj0aGrLE/A763EWIwj5bhIfrRn+9G
SEdhxfoq3f6A4Ta75BkGYf6dJ5veujT27JeztJwVBJs1sVTIvC3jiAu7yemUTVYu
JsRLWuzEZVjqG3RExGp5YG51X6azyP/rBQ3weamuXoDKML7PkK+siEd6oHpRrokB
M1eaKy6DDyZbadrcV4lC1tmR3jcj/2xx6HgsbAKvL9YogkIP2JQw/m1ZNGdSoT9X
IwevVi7flah3olS+jjL2H9zzqELVpQ==
=9fRq
-----END PGP SIGNATURE-----

--dGBRFZmCRnEEQQCOL0XOVj6TzH05wYeCb--

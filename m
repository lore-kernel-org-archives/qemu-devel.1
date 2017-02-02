Received: from eggs.gnu.org ([2001:4830:134:3::10]:43712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cZIxl-0000wc-1v
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:06:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cZIxh-0003M1-Ri
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:06:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cZIxh-0003Ll-J6
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:06:13 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF8C580465
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 15:06:13 +0000 (UTC)
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-7-git-send-email-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <03f9756e-971f-3b30-36d6-4b65d859479e@redhat.com>
Date: Thu, 2 Feb 2017 09:06:11 -0600
MIME-Version: 1.0
In-Reply-To: <1485207141-1941-7-git-send-email-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uLoP48vlvJnXlFx5svdCfhMGiVlgpUmGN"
Subject: Re: [Qemu-devel] [PATCH 06/17] migration: Create x-multifd-threads
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uLoP48vlvJnXlFx5svdCfhMGiVlgpUmGN
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com
Message-ID: <03f9756e-971f-3b30-36d6-4b65d859479e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/17] migration: Create x-multifd-threads
 parameter
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
 <1485207141-1941-7-git-send-email-quintela@redhat.com>
In-Reply-To: <1485207141-1941-7-git-send-email-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/23/2017 03:32 PM, Juan Quintela wrote:
> Indicates the number of threads that we would create.  By default we
> create 2 threads.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---

> +++ b/qapi-schema.json
> @@ -981,13 +981,17 @@
>  # @x-checkpoint-delay: The delay time (in ms) between two COLO checkpo=
ints in
>  #          periodic mode. (Since 2.8)
>  #
> +# @x-multifd-threads: Number of threads used to migrate data in parall=
el
> +#                     The default value is 2 (since 2.9)


> +#
> +# @x-multifd-threads: Number of threads used to migrate data in parall=
el
> +#                     The default value is 1 (since 2.9)

So which is it? I understand why you document it twice (one for setting
the value, and one for listing the current setting), but not why you
have two different defaults.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--uLoP48vlvJnXlFx5svdCfhMGiVlgpUmGN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYk0rjAAoJEKeha0olJ0NqmTIH/3u9d/M5U3sJv8hyPlCj8u8R
YSC7e78ONkcvVR/TMy4dfLhWd5cxWxW7nGDtSFV3uZDNJ9yQP/GCy5MX141CmnX5
GvLW7zIsDYdZB7/UFcLAydIxX2FNlk3E8cLZCrZOrKYScReBDaHqmdqi1d/SJkhi
HXMpzl+H+b9cz1/fjfVOMYPVQqlgntItm3Y6eeHiOG1kByJqkgFYoUGKVYq9z9cr
JXo75y9R/m/Q0xHe7eB3XXUVl14782blMPu6suYdt4c+fL5dh0FY3ClbJfOw+6kM
KomI/tkJmj2WnX8S/YeD2fo/jEx4QV1bj1QwZdpIwVABghjRHMn1YkcTmlq0Qa0=
=alD2
-----END PGP SIGNATURE-----

--uLoP48vlvJnXlFx5svdCfhMGiVlgpUmGN--

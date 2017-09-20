Received: from eggs.gnu.org ([2001:4830:134:3::10]:51514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dufXj-00061M-Gm
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dufXe-0007Iy-Vf
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:59:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dufXe-0007Ip-NJ
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:59:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B16997EAA4
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 13:59:53 +0000 (UTC)
References: <20170920104639.2335-1-quintela@redhat.com>
	<20170920104639.2335-8-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <52df88ba-6844-3569-2913-fa692a2ca6d6@redhat.com>
Date: Wed, 20 Sep 2017 08:59:49 -0500
MIME-Version: 1.0
In-Reply-To: <20170920104639.2335-8-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C0Bu3ttJOg0TL2HbRQfmt1VePGtRbGnFW"
Subject: Re: [Qemu-devel] [PULL 07/16] migration: Create
 x-multifd-page-count parameter
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
--C0Bu3ttJOg0TL2HbRQfmt1VePGtRbGnFW
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Message-ID: <52df88ba-6844-3569-2913-fa692a2ca6d6@redhat.com>
Subject: Re: [Qemu-devel] [PULL 07/16] migration: Create x-multifd-page-count
 parameter
References: <20170920104639.2335-1-quintela@redhat.com>
 <20170920104639.2335-8-quintela@redhat.com>
In-Reply-To: <20170920104639.2335-8-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/20/2017 05:46 AM, Juan Quintela wrote:
> Indicates how many pages we are going to send in each batch to a multif=
d
> thread.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>=20

> +++ b/qapi/migration.json
> @@ -471,6 +471,9 @@
>  #                     number of sockets used for migration.  The
>  #                     default value is 2 (since 2.11)
>  #
> +# @x-multifd-page-count: Number of pages sent together to a thread
> +#                        The default value is 16 (since 2.11)

You're missing a '.' between sentences; it's more obvious when you no
longer have a newline between them when things are rendered to other
documentation formats.

Can be fixed as a followup.

> @@ -539,6 +542,9 @@
>  #                     number of sockets used for migration.  The
>  #                     default value is 2 (since 2.11)
>  #
> +# @x-multifd-page-count: Number of pages sent together to a thread
> +#                        The default value is 16 (since 2.11)
> +#

Multiple instances of it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--C0Bu3ttJOg0TL2HbRQfmt1VePGtRbGnFW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnCdFUACgkQp6FrSiUn
Q2qZEAf/dn+/EcHpV38FxBmy1yasbw7aXsOFr5BsPNbTbjp1ZiLF8jdEGDYRu3I5
W8a0Z+X62MjpkRs0AwlWIlU7gHh3smZK6Tipy7r0x5L/64GLtpwBv5hny5I+sTPe
yscQLUS6Bc4FU44K9ZACujeR7lEQU4Ll2Y5E1H85fuzBozx41M4FWsLsQSD2oKKe
O3vKElu9Lv/zTu4E6PyxTfv5HZOdeoeLDzZJmI1SykYsvnkXbN9f/HnQ/n2wDc37
y4kn/yUvEdeifKtvN6UQM8362vcQ0X5uLrXSoQIqyoND1FG7ROiXuEeZWMWOfUnV
/rzkZlp4uIQ3pcPAIT7iwRAqfO9erQ==
=0ome
-----END PGP SIGNATURE-----

--C0Bu3ttJOg0TL2HbRQfmt1VePGtRbGnFW--

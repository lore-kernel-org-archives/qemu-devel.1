Received: from eggs.gnu.org ([2001:4830:134:3::10]:44383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diIi6-0005LY-25
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diIi5-0002EA-6z
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:11:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1diIi4-0002Di-U4
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:11:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3DC791FFF
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 11:11:31 +0000 (UTC)
References: <20170817104216.29150-1-dgilbert@redhat.com>
	<20170817104216.29150-3-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9f6101f4-2e29-22e5-162c-9c944773f705@redhat.com>
Date: Thu, 17 Aug 2017 06:11:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170817104216.29150-3-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NODWsOFbqut7WxciMLg7rxQUQS4aaVj8F"
Subject: Re: [Qemu-devel] [PATCH 2/2] hmp: Fix unknown command for subtable
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
--NODWsOFbqut7WxciMLg7rxQUQS4aaVj8F
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com
Message-ID: <9f6101f4-2e29-22e5-162c-9c944773f705@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] hmp: Fix unknown command for subtable
References: <20170817104216.29150-1-dgilbert@redhat.com>
 <20170817104216.29150-3-dgilbert@redhat.com>
In-Reply-To: <20170817104216.29150-3-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/17/2017 05:42 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> (qemu) info foo
> unknown command: 'foo'
>=20
> fix this to:
> (qemu) info foo
> unknown command: 'info foo'
>=20
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  monitor.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NODWsOFbqut7WxciMLg7rxQUQS4aaVj8F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmVeeIACgkQp6FrSiUn
Q2oX2Af/STRnnrvDrRL7iRexIhePBOR+OKaUkPbb4xrwun1WfoLt8tV7jc6TQHct
jAynbpK7jSa5OvoDjCP/M+W+a15FT20+gpzJ5RX+Z1YS6LPtIXl9BkHaa+KHV/p/
hiulR+9GELNx6Xx54B/EkAhgI/tsoJzFDA7A7o2hL101jZAWMNM/JfyFeHrCc/Yk
2jVaIrwpu4Fv9QPZ7i01v0QXDebGM6rp1JjQVmK2+ZkUnD6kHPUYt1KpEOuP1XwY
RNaFMetJ33gyJXLTf8g2/lB1iVI/e2tWlAi5GceCZvRVSVuW/lnLtRdFFkpRysLh
+HSPUlgwW0lTVvyocyUU6bRRUDD4PA==
=NWit
-----END PGP SIGNATURE-----

--NODWsOFbqut7WxciMLg7rxQUQS4aaVj8F--

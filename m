Received: from eggs.gnu.org ([209.51.188.92]:39246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGqLK-0005ZH-BE
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGqLJ-0005Nx-DG
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:35:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hGqLJ-0005N9-14
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:35:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1490A307D911
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 19:35:36 +0000 (UTC)
References: <20190417191805.28198-1-armbru@redhat.com>
	<20190417191805.28198-16-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <73b3a105-a554-484b-1ba2-4107f3538584@redhat.com>
Date: Wed, 17 Apr 2019 14:35:34 -0500
MIME-Version: 1.0
In-Reply-To: <20190417191805.28198-16-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7unKqfeGMIQO9jEknX3r23rRzgTueCC4q"
Subject: Re: [Qemu-devel] [PATCH v2 15/17] monitor: Clean up how
 monitor_disas() funnels output to monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7unKqfeGMIQO9jEknX3r23rRzgTueCC4q
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com
Message-ID: <73b3a105-a554-484b-1ba2-4107f3538584@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 15/17] monitor: Clean up how
 monitor_disas() funnels output to monitor
References: <20190417191805.28198-1-armbru@redhat.com>
 <20190417191805.28198-16-armbru@redhat.com>
In-Reply-To: <20190417191805.28198-16-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/17/19 2:18 PM, Markus Armbruster wrote:
> INIT_DISASSEMBLE_INFO() takes an fprintf()-like callback and a FILE *
> to pass to it.  monitor_disas() passes monitor_fprintf() and the
> current monitor cast to FILE *.  monitor_fprintf() casts it right
> back, and is otherwise identical to monitor_printf().  The
> type-pinning is ugly.

For consistency with other patches in the series, s/pinning/punning/

>=20
> Pass qemu_fprintf() and NULL instead.
>=20
> monitor_fprintf() is now unused; delete it.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--7unKqfeGMIQO9jEknX3r23rRzgTueCC4q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly3gAYACgkQp6FrSiUn
Q2r2Lwf/SJ0zcD/33e0qzmZqqvD3MqfKmraV32ptXreIxx1qj3tyFr3pTT6saPVK
0v8XGvgYBwHmkgxQ6tRkRtJV5qnnRlJDpjJAucaY8WHIfUg305/rW1dq8HbnLhK4
w4qPUuQtf6SvG7B7wwKuTVkikqd8IQsW+MSLIrKWh+nfCnZwsY8gxhGfcJS5VBd4
uQMwp031r6YGGgwtqwxlj1fxDJCHA9scgwxQLxNiBURQjce6nKurgA5EIt0632xL
GwPjas5MXo6TLsj0B1c2xuLC6c+hsQE7sp+7YEM6Sd4ZDqR++U3KWnfjelhs6vmp
k6437N50i4nJi1SJuzuVEshqUhIWSg==
=snMn
-----END PGP SIGNATURE-----

--7unKqfeGMIQO9jEknX3r23rRzgTueCC4q--

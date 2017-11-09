Received: from eggs.gnu.org ([2001:4830:134:3::10]:40858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCvKK-00072A-Ay
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 17:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCvKG-000648-0E
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 17:29:36 -0500
References: <20171109203025.27493-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9d251a1d-b6de-7cc2-6efc-a2a17618985b@redhat.com>
Date: Thu, 9 Nov 2017 23:29:14 +0100
MIME-Version: 1.0
In-Reply-To: <20171109203025.27493-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aPq22nWQcm5uP6WPSRaKbc6AvWdAf48WW"
Subject: Re: [Qemu-devel] [PATCH v2 0/5] iotests: Make some tests less flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aPq22nWQcm5uP6WPSRaKbc6AvWdAf48WW
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>
Message-ID: <9d251a1d-b6de-7cc2-6efc-a2a17618985b@redhat.com>
Subject: Re: [PATCH v2 0/5] iotests: Make some tests less flaky
References: <20171109203025.27493-1-mreitz@redhat.com>
In-Reply-To: <20171109203025.27493-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-09 21:30, Max Reitz wrote:
> There are a couple of tests that fail (on my machine) from time to
> time (and by that I mean that recently I've rarely ever had a test run
> with both 083 and 136 working on first try).
> This series should fix most (at least the issues I am aware of).

Fixed the commit message in patch 4 as suggested by Eric and applied to
my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--aPq22nWQcm5uP6WPSRaKbc6AvWdAf48WW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloE1rsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ACZkIAJYDuQ1Y63zaNwU7uFCb7Du/iuWgIZmT
YW182/Lx7rbC131G7YzSrouDcX2jJ4Dwhtegxsfw1FAcrnIJDPWseLCjzkZ6y/Mg
gB8j0RmPi9GUcykhxBiZ/4sjG6Ia507t2MGhwkvWjxtZ29Pqi1GhWKrI/uJOhqEF
5Ka4jVet8NPi0wZF6vkgS3XtecSUI+e1ZDKohYO0RQDlKXy0PR+x3NFvoUTB3R2P
OTL10EvzNKDKvxExrrk7GkoaF1+vD3X338K9M8P49vGOcyJQxbqcJnR9FXP0zoWy
bCRNkhQBWQTqT8vTbzx/IUGl3NwIMLLvfdhy6MX/xgwNh50UZYmvHac=
=P19A
-----END PGP SIGNATURE-----

--aPq22nWQcm5uP6WPSRaKbc6AvWdAf48WW--

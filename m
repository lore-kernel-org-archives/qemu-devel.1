Received: from eggs.gnu.org ([2001:4830:134:3::10]:44684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdJdN-0004JU-O7
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:37:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdJdM-0000Kp-R8
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:37:49 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cdJdM-0000KS-L6
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:37:48 -0500
Received: by mail-wm0-x242.google.com with SMTP id r18so20480898wmd.3
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 08:37:48 -0800 (PST)
Date: Mon, 13 Feb 2017 16:37:45 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170213163745.GQ10361@stefanha-x1.localdomain>
References: <3163c16d6ab4257f7be9ad44fe9cc0ce8c359e5a.1486718555.git.phrdina@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/YnR2r17TIEndSCI"
Content-Disposition: inline
In-Reply-To: <3163c16d6ab4257f7be9ad44fe9cc0ce8c359e5a.1486718555.git.phrdina@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] monitor: add poll-* properties into
 query-iothreads result
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Hrdina <phrdina@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, armbru@redhat.com


--/YnR2r17TIEndSCI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2017 at 10:41:17AM +0100, Pavel Hrdina wrote:
> IOthreads were recently extended by new properties that can
> enable/disable and configure aio polling.  This will also allow
> other tools that uses QEMU to probe for existence of those new
> properties via query-qmp-schema.
>=20
> Signed-off-by: Pavel Hrdina <phrdina@redhat.com>
> ---
>=20
> The other possible way would be to introduce object-list-properties
> which I think would be good in general for the same reason why
> device-list-properties exists.
>=20
>  hmp.c            |  9 +++++++--
>  iothread.c       |  3 +++
>  qapi-schema.json | 15 ++++++++++++++-
>  3 files changed, 24 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/YnR2r17TIEndSCI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYoeDZAAoJEJykq7OBq3PIlb0H/0qSTk4TQ/TlSD8OghEhYI6z
h3dXLYx0F8ziLCN4PwqRyWJBtBKu9bDdZVmkSC3R7vtiEbUeZspVxzwFEyPH1xJg
47HMn8EdoeXBttQv055mkS202Dmh42LGZtz4BBJVCo+OJ4U2wNUDZybbTbX/fRuh
iKgTomLUEfsRfj7qLI05v25SVTr3ECQs1IWcP65St2B4RG6QD/aKIRiu/I2A0KZ2
PT4PlER+IyhOyFuptTaT505Zbk78+fNefRCpHcv0ac7IFaT2YrJ2b8rAnHnmzTmo
sX5lncc2Ffr76siSJOmD3PKhGx5aKKyKE3sZE8k+0fpJKuABtWBlnxCG7PrVmNc=
=gc2Q
-----END PGP SIGNATURE-----

--/YnR2r17TIEndSCI--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cIzSY-00047S-Lq
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 10:02:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cIzST-0003vP-7B
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 10:02:38 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cIzST-0003v8-1a
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 10:02:33 -0500
Received: by mail-wm0-x241.google.com with SMTP id m203so19070919wma.3
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 07:02:32 -0800 (PST)
Date: Mon, 19 Dec 2016 15:02:30 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161219150230.GA20757@stefanha-x1.localdomain>
References: <1482137486-9843-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <1482137486-9843-1-git-send-email-douly.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 0/4] block/qapi: refactor and
 optimize the qmp_query_blockstats()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: stefanha@redhat.com, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, eblake@redhat.com, famz@redhat.com, danpb@redhat.com, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, qemu-devel@nongnu.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2016 at 04:51:22PM +0800, Dou Liyang wrote:
> These patches aim to refactor the qmp_query_blockstats() and
> improve the performance by reducing the running time of it.
>=20
> qmp_query_blockstats() is used to monitor the blockstats, it
> querys all the graph_bdrv_states or monitor_block_backends.
>=20
> There are the two jobs:
>=20
> 1 For the performance:
>=20
> 1.1 the time it takes(ns) in each time:
> the disk numbers     | 10    | 500
> -------------------------------------
> before these patches | 19429 | 667722=20
> after these patches  | 17516 | 557044
>=20
> 1.2 the I/O performance is degraded(%) during the monitor:
>=20
> the disk numbers     | 10    | 500
> -------------------------------------
> before these patches | 1.3   | 14.2
> after these patches  | 0.8   | 9.1

Do you know what is consuming the remaining 9.1%?

I'm surprised to see such a high performance impact caused by a QMP
command.

Please post your QEMU command-line.

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYV/aGAAoJEJykq7OBq3PIvqcIAKM8gPmMGCWzu3WRBszavK6k
g4Vwt1HEuheEHOcK8baPpW1MRrSW/H3mbGZ+Fj3alapT7k6fXISXgufQlzrA7+eo
tg5vbwGcruGAOiP9EpRR1K2QtoUsFVZ17tWy+nZV/1+CS89+eBP5FsPl/AXqn7IF
QsuGE2gTVdjw0d808tC/5U84963gfcFhIaSo6gWSL/jKH47R5E+LmJSdJMPhcuVE
wxmuJZ7Lf5mNfOx2Yx34KrKPNQ9n1QI6H88RRVouyIl6WDGNyIArhRsvtm0fxArs
jp6TUQWUGoJthlOkcLZC2nbPH2LOsqnZSs0A/tZ1u0ml3xNy58afZgXuAJtZmY4=
=UT45
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZbd6-00034P-R7
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZbd3-0005kx-Ne
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:34:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dZbd3-0005ke-I4
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:34:25 -0400
Date: Mon, 24 Jul 2017 12:34:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170724113422.GC2784@stefanha-x1.localdomain>
References: <20170721143149.43721-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline
In-Reply-To: <20170721143149.43721-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] improve tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, armbru@redhat.com, den@openvz.org


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 05:31:47PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Current trace system have a drawback: parameters of trace functions
> are calculated even if corresponding tracepoint is disabled. Also, it
> looks like trace function are not actually inlined by compiler (at
> least for me).
>=20
> Here is a fix proposal: move from function call to macros. Patch 02
> is an example, of how to reduce extra calculations with help of
> patch 01.
>=20
> Vladimir Sementsov-Ogievskiy (2):
>   trace: do not calculate arguments for disabled trace-points
>   monitor: improve tracing in handle_qmp_command

Please use the TRACE_FOO_ENABLED macro instead of putting computation
inside the trace event arguments.  This makes the code cleaner and
easier to read.

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZdds+AAoJEJykq7OBq3PIh8gH/AzKhv4CzHXDt29Yn/EyNVBD
3PdvLH3s82v0+SMPmVsU/lN2B60MoZPLEA8dqstNNk45w8EG5PC4mTdZBLG3Z7AY
hluHgvSW/6JyXEC2tP29H0ymWqCyoe3q/lFyO13GDCaIxCBpibO/gArgvdhzYdJM
/KZ6CNjNv3w6S5IJzeayWscsm1pVwFx25DmHgh7WrvRVGw5EwJFomndhil/PvsOz
lGW4K2O4qepQm5r9Ex7XOCpNXlr8NOMay4C6s7UyE9rifLULs/wYmKdt384zozol
lwidfCWMhf9MPUtlV0y+fkYV7EtrfWS58SKeQiNGucqWI7zapgrmdv3ADLG6lh4=
=h632
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIDxA-0001Nr-AW
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIDx9-0002fn-Lx
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:51:20 -0400
Date: Tue, 6 Jun 2017 14:51:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170606125109.GE5448@noname.redhat.com>
References: <20170605190824.25184-1-eblake@redhat.com>
	<20170605190824.25184-2-eblake@redhat.com>
	<dbe7598c-77bb-eb1c-ba0c-59ebb600ae57@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <dbe7598c-77bb-eb1c-ba0c-59ebb600ae57@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/4] qemu-io: Don't die on second open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 05.06.2017 um 21:58 hat Eric Blake geschrieben:
> Also, I'm seeing a segfault on 68 that exists on current master:
>=20
> 068 1s ... - output mismatch (see 068.out.bad)
> --- /home/eblake/qemu/tests/qemu-iotests/068.out	2017-06-01
> 17:01:25.113094957 -0500
> +++ 068.out.bad	2017-06-05 14:55:54.140835402 -0500
> @@ -6,6 +6,8 @@
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm 0
>  (qemu) quit
> +./common.config: line 107: 13333 Segmentation fault      (core dumped)
> ( if [ -n "${QEMU_NEED_PID}" ]; then
> +    echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid";
> +fi; exec "$QEMU_PROG" $QEMU_OPTIONS "$@" )
>  QEMU X.Y.Z monitor - type 'help' for more information
> -(qemu) quit
> -*** done
> +(qemu) *** done

This should be fixed with "qemu/migration: fix the migration bug found
by qemu-iotests case 068".

Kevin

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZNqU9AAoJEH8JsnLIjy/W3NkP/3SXQJdm2JOXsc90pFeUnLxD
Wxv3VhWrkwwsogHUbB/voLwsOyUwSyawvknsz++u5G2Xe8AylS/dgshyObBKd9Wp
JTnPnNzYQtnlevYq1s2rZ8XFBBGBhCvXG+3/+zSivKINxGerwcOKxB+weTa1p+Op
hdbfbLDP85BXlUIiH+hSsJDeD63OLO0JWCu1drtgK1LQSL+7Zw83o6Cri6HLwt97
KZeibf5zV0ejbaYaz1QBcbJr3Aho5xqFuSN75wecA5AnLY9yuMdHJbtXTiaD81OM
IJnCgvroqnwdYgocQjb9Dwfvta4e+NPSK1mkRdv8sjTDri+wGSnCJHhUdZ3gYbMp
TfEvjGp4tX30wDJaSw9APxiO//Fm5kiYGJG9VxaLdJRPmoaJlL53w9fDjbbOkN4e
yEEfOOmxBq7iLEEVOrl2O/mujToivaKn5QLieFsa55dtk6KJX/iq8CFaAz5Fclb2
2FQkPAuJKZcQ9GfAT9E+6fipc1ESD44n9yjkur/5qAoNdeFtbY9LYEF801gsBVSe
yg/WYvOmW5OxBNKK6JHf78JNnjo4/J63DD5f8rZRfqKr1T4+2BGIWtnb5fcFkaYS
oly1qicfcfQB+dHcV84yj09wXP+zKCqQw6oBW8UZfwIlsTXWYGP+bmkbnVeflVjT
EkflimKZZqNYqKMFhE+I
=4Sif
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--

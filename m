Received: from eggs.gnu.org ([2001:4830:134:3::10]:43414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duL4C-0003fK-KR
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duL46-0002g8-Vv
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:08:08 -0400
References: <20170919155025.4098-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9d3ff80c-5ae8-0fc3-6912-75c0f16f56d2@redhat.com>
Date: Tue, 19 Sep 2017 11:07:53 -0500
MIME-Version: 1.0
In-Reply-To: <20170919155025.4098-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mDa74bLpTDTXFxlqq9elipH3QFfTgmxvi"
Subject: Re: [Qemu-devel] [PATCH] throttle-groups: update
 tg->any_timer_armed[] on detach
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Manos Pitsidianakis <el13635@mail.ntua.gr>, Max Reitz <mreitz@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mDa74bLpTDTXFxlqq9elipH3QFfTgmxvi
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Manos Pitsidianakis <el13635@mail.ntua.gr>,
 Max Reitz <mreitz@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Message-ID: <9d3ff80c-5ae8-0fc3-6912-75c0f16f56d2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] throttle-groups: update
 tg->any_timer_armed[] on detach
References: <20170919155025.4098-1-stefanha@redhat.com>
In-Reply-To: <20170919155025.4098-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2017 10:50 AM, Stefan Hajnoczi wrote:
> Clear tg->any_timer_armed[] when throttling timers are destroy during

s/destroy/destroyed/

> AioContext attach/detach.  Failure to do so causes throttling to hang
> because we believe the timer is already scheduled!
>=20
> The following was broken at least since QEMU 2.10.0 with -drive
> iops=3D100:
>=20
>   $ dd if=3D/dev/zero of=3D/dev/vdb oflag=3Ddirect count=3D1000
>   (qemu) stop
>   (qemu) cont
>   ...I/O is stuck...
>=20
> Reported-by: Yongxue Hong <yhong@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/throttle-groups.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

CC: qemu-stable@nongnu.org

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mDa74bLpTDTXFxlqq9elipH3QFfTgmxvi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnBQNkACgkQp6FrSiUn
Q2rZ1wf+JVexPJ4od827HtWNVPXJr7gtXTv6mS9Fnxj51cTqV2Mnw/v9lZHl9iVb
W4UFUg1HkxwUQ1uDIOphxqkbQqaRi1/ryk4HndhWyBnO+ErDUGhfcxiQc5nImreJ
2nelfPYC3SBMSmcV3N2Z+1Q1MWd31TMa1oWF5EZvnhMm7xWKRYUYEn8caZwtt4uA
GPCH1bpB0jHD4nDMdJccQuB5B8xxY+QxYEBsWKo8beeqKjb70bbTxCYWdlMf6Oz9
/aYTGKemqBnBA1t7IkVs0+fEiV88Iem1PAnrV6DxR6gaARBMvO0Sl5YiTJ2sNsEE
10XN+Mz2aORWzNKpCWQTde5ZT/JNPA==
=suHX
-----END PGP SIGNATURE-----

--mDa74bLpTDTXFxlqq9elipH3QFfTgmxvi--

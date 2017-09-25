Received: from eggs.gnu.org ([2001:4830:134:3::10]:41197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwVSL-0004Lj-0b
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwVSK-0005SD-2f
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:38:01 -0400
References: <20170925135735.25076-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1d5203b2-dfb5-8eb0-4ff7-9ec2749e4317@redhat.com>
Date: Mon, 25 Sep 2017 10:37:44 -0500
MIME-Version: 1.0
In-Reply-To: <20170925135735.25076-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WS5AcqoFoReLeHMjmskF9FdD7V09444BU"
Subject: Re: [Qemu-devel] [PATCH v3] throttle-groups: cancel timers on
 restart
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Manos Pitsidianakis <el13635@mail.ntua.gr>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WS5AcqoFoReLeHMjmskF9FdD7V09444BU
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Manos Pitsidianakis <el13635@mail.ntua.gr>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <1d5203b2-dfb5-8eb0-4ff7-9ec2749e4317@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] throttle-groups: cancel timers on restart
References: <20170925135735.25076-1-stefanha@redhat.com>
In-Reply-To: <20170925135735.25076-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/25/2017 08:57 AM, Stefan Hajnoczi wrote:
> Throttling group members are restarted on config change and by
> bdrv_drained_begin().  Pending timers should be cancelled before
> restarting the queue, otherwise requests see that tg->any_timer_armed[]=

> is already set and do not schedule a timer.
>=20
> For example, a hang occurs at least since QEMU 2.10.0 with -drive
> iops=3D100 because no further timers will be scheduled:
>=20
>   (guest)$ dd if=3D/dev/zero of=3D/dev/vdb oflag=3Ddirect count=3D1000
>   (qemu) stop
>   (qemu) cont
>   ...I/O is stuck...
>=20
> This can be fixed by calling throttle_group_detach_aio_context() from a=

> bdrv_drained_begin/end() region.  This way timers are quiesced properly=
,
> requests are drained, and other throttle group members are scheduled, i=
f
> necessary.
>=20
> Reported-by: Yongxue Hong <yhong@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WS5AcqoFoReLeHMjmskF9FdD7V09444BU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnJIsoACgkQp6FrSiUn
Q2qbpQgAgMM41xk+IBjMAFoB/rMAniWhk4jMF74yBZ+AB2znkf3a9s/p+/UovccQ
J7ZTb3Xa2gKJldkUC+BUb7fFr0xJB6LlCRWHYwl3JmMqjo/AkDRcfuOzhqFDtKqy
MLwW2wl9/HppgnpzbxyUm5foudTdWzQ3Mw1ygluC6hN0tg5Hsc4r18fZplPIs85K
AkeFt89YnvLuBKgs5iaAZmfnEIVc5Os/vde70ypHc2GZlw5PHUl/6vfLWtugT6nW
J+lhpB+dydgyds0s8jlwMypwNCzIftf12bOJHwwQ/uCYSGf0dFKfP6sJ1fGkFf+r
eshENmt85rgliCkX6fptFq0UKC6TGQ==
=KgI2
-----END PGP SIGNATURE-----

--WS5AcqoFoReLeHMjmskF9FdD7V09444BU--

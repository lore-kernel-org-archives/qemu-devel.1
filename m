Received: from eggs.gnu.org ([2001:4830:134:3::10]:53730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fpEf9-0003E3-KV
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fpEf8-0001J2-Uh
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:21:43 -0400
References: <20180813022006.7216-1-mreitz@redhat.com>
	<20180813022006.7216-10-mreitz@redhat.com>
	<400a8b57-a930-2eee-a4a0-bf5a0733db1a@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <813769bd-7249-d831-b8c5-0050f9546cf4@redhat.com>
Date: Mon, 13 Aug 2018 17:21:35 +0200
MIME-Version: 1.0
In-Reply-To: <400a8b57-a930-2eee-a4a0-bf5a0733db1a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1Tka9iUVxPNpbsVaG25yW3ZT4W6C8uijj"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 09/17] mirror: Lock AioContext
 in mirror_co_perform()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1Tka9iUVxPNpbsVaG25yW3ZT4W6C8uijj
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <813769bd-7249-d831-b8c5-0050f9546cf4@redhat.com>
Subject: Re: [Qemu-block] [PATCH 09/17] mirror: Lock AioContext in
 mirror_co_perform()
References: <20180813022006.7216-1-mreitz@redhat.com>
 <20180813022006.7216-10-mreitz@redhat.com>
 <400a8b57-a930-2eee-a4a0-bf5a0733db1a@redhat.com>
In-Reply-To: <400a8b57-a930-2eee-a4a0-bf5a0733db1a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-13 16:43, Paolo Bonzini wrote:
> On 13/08/2018 04:19, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> Locking AioContext should not be needed anywhere here.  mirror_run is
> called via aio_co_enter or aio_co_wake, so the lock is actually already=

> taken every time you call aio_context_acquire.
>=20
> It was needed only because AIO callbacks do *not* take the lock, but
> it's not needed anymore since the conversion to coroutines.

Uh, nice.  Thanks for letting me know! :-)

I'll drop the locks in v2.

Max


--1Tka9iUVxPNpbsVaG25yW3ZT4W6C8uijj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltxof8ACgkQ9AfbAGHV
z0B1vAf8CxG8FhnBj5jfSyFD36c2BPP5wxnNjEyLnLbHeATkfbwxvTTQkDKhIWKN
eym1KzADEOmqdhxMPrA2K6bo1faXrfvMpQSj+vf0DzGsTxG6mVxOc0gNGzN+Dgwi
iMrk7/xYFFaWerUsKIAzWGxyDaOu6+ZAlylqKIGlgBQ4YVhnBdtAd7xtqgpzpl3S
tcfz/kObt1+tXp36qG+9L0/NWvGM1enk7r6jELSORF22iK7CV6U6AZjQjVqgP7BX
W+Sg1BGvMkOXGu11wenvJFaG6HtCNSwICmdR82q8s6NjKqaQPEv9KXrftj4+JjkN
cwNEUOLFZoTGmR+elhRAqbm6C+nfRg==
=XH2v
-----END PGP SIGNATURE-----

--1Tka9iUVxPNpbsVaG25yW3ZT4W6C8uijj--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgG87-0004RW-VZ
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 16:02:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgG86-0004IK-Pc
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 16:02:00 -0400
References: <20170811023759.26390-1-eblake@redhat.com>
	<20170811023759.26390-2-eblake@redhat.com>
	<29dc6e29-7bbc-2c81-22cc-61db4e8ac609@virtuozzo.com>
	<7d6be617-6907-5213-941b-38fe5d3f0fee@redhat.com>
	<c82b8803-c935-783c-9ff5-6c228d5a1138@virtuozzo.com>
	<325cc2fd-277a-d0d2-53d9-8f46418a6a36@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d48ab0e7-6ccf-8823-dab9-c5350f95b239@redhat.com>
Date: Fri, 11 Aug 2017 15:01:44 -0500
MIME-Version: 1.0
In-Reply-To: <325cc2fd-277a-d0d2-53d9-8f46418a6a36@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pFkvMXOa4NOc8HBd1gVKqfkDhKtoHMbbc"
Subject: Re: [Qemu-devel] [PATCH 1/2] nbd: Drop connection if broken server
 is detected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pFkvMXOa4NOc8HBd1gVKqfkDhKtoHMbbc
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <d48ab0e7-6ccf-8823-dab9-c5350f95b239@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] nbd: Drop connection if broken server is
 detected
References: <20170811023759.26390-1-eblake@redhat.com>
 <20170811023759.26390-2-eblake@redhat.com>
 <29dc6e29-7bbc-2c81-22cc-61db4e8ac609@virtuozzo.com>
 <7d6be617-6907-5213-941b-38fe5d3f0fee@redhat.com>
 <c82b8803-c935-783c-9ff5-6c228d5a1138@virtuozzo.com>
 <325cc2fd-277a-d0d2-53d9-8f46418a6a36@redhat.com>
In-Reply-To: <325cc2fd-277a-d0d2-53d9-8f46418a6a36@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/11/2017 02:41 PM, Eric Blake wrote:
>> Hmm, was it correct even before your patch? Is it safe to enter a coro=
utine
>> (which we've scheduled by nbd_recv_coroutines_enter_all()), which is
>> actually
>> yielded inside nbd_rwv (not our yield in nbd_co_receive_reply)?
>=20
> I'm honestly not sure how to answer the question. In my testing, I was
> unable to catch a coroutine yielding inside of nbd_rwv();

Single stepping through nbd_rwv(), I see that I/O is performed by
sendmsg(), which either gets the message sent or, because of nonblocking
mode, fails with EAGAIN, which gets turned into QIO_CHANNEL_ERR_BLOCK
and indeed a call to qemu_channel_yield() within nbd_rwv() - but it's
timing sensitive, so I still haven't been able to provoke this scenario
using gdb.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pFkvMXOa4NOc8HBd1gVKqfkDhKtoHMbbc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmODSgACgkQp6FrSiUn
Q2r4xAf/VAtxpstmvzQZGfb6Q7wfveuVo7CV2r+c0RQ1d8Qxelt+pUhfcDRmxNlb
QPlD9JEUheLx2h4mIPmd6Y1zuXOwXxxPQifu9TNSdKyjSFFREJ1tUW4f7Wg+z9Je
urzeqwbuOHyDDT7vYGi6U77Vm12TggQfalJ9huDrWuM1gMrHzIe0gOfx03eWLVcg
CPhy0SP8va/c4gEYGrh5cuMezK7qBIDJgV7WlJeP0LCyi9xp5PNGBV99zoivthuF
yXiE0dRk8xSSkWp21inhrr0C5T3M3zEqK44PlfrHT+frtTS7jZg6zAwXEmD0C6as
3cMjukv40Opl+NUZuKSMOB4XL6uOXw==
=Vynw
-----END PGP SIGNATURE-----

--pFkvMXOa4NOc8HBd1gVKqfkDhKtoHMbbc--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkXPP-00075L-7S
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkXPO-00086d-8s
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:17:31 -0400
References: <20170815150907.21495-1-eblake@redhat.com>
	<20170815150907.21495-8-eblake@redhat.com>
	<aca0bbb8-0893-c02a-c3cb-b85fa431437b@virtuozzo.com>
	<7e7d839d-7ae7-9b92-7830-d568eb8f1be2@virtuozzo.com>
	<a206b659-b7b7-912a-bbb3-e9b5edee8635@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ee37fd0d-453e-4854-e67e-7a4f50ea1505@redhat.com>
Date: Wed, 23 Aug 2017 10:17:17 -0500
MIME-Version: 1.0
In-Reply-To: <a206b659-b7b7-912a-bbb3-e9b5edee8635@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CTJAQAjG7quIFAKcJ6ecjGTVMtJ4CH4T3"
Subject: Re: [Qemu-devel] nbd-client: Fix regression when server sends
 garbage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CTJAQAjG7quIFAKcJ6ecjGTVMtJ4CH4T3
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <ee37fd0d-453e-4854-e67e-7a4f50ea1505@redhat.com>
Subject: Re: [Qemu-devel] nbd-client: Fix regression when server sends garbage
References: <20170815150907.21495-1-eblake@redhat.com>
 <20170815150907.21495-8-eblake@redhat.com>
 <aca0bbb8-0893-c02a-c3cb-b85fa431437b@virtuozzo.com>
 <7e7d839d-7ae7-9b92-7830-d568eb8f1be2@virtuozzo.com>
 <a206b659-b7b7-912a-bbb3-e9b5edee8635@virtuozzo.com>
In-Reply-To: <a206b659-b7b7-912a-bbb3-e9b5edee8635@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/23/2017 10:09 AM, Vladimir Sementsov-Ogievskiy wrote:
> ping
>=20

We're still trying to round up last-minute patches for a 2.10-rc4 pull
request.


>>>> @@ -107,6 +107,9 @@ static coroutine_fn void
>>>> nbd_read_reply_entry(void *opaque)
>>>>           qemu_coroutine_yield();
>>>>       }
>>>>
>>>> +    if (ret < 0) {
>>>> +        s->quit =3D true;
>>>
>>> but on wrong handle ret is 0:
>>
>> s/0/positive/
>>
>>>

Is your issue fixed by Stefan's patch?

https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04027.html

In fact, he listed a reproduction formula in his earlier attempt at it,
that demonstrates that we still had a hang possible with just what made
it into -rc3
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg03853.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CTJAQAjG7quIFAKcJ6ecjGTVMtJ4CH4T3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmdnH0ACgkQp6FrSiUn
Q2okaAgAluFUxoZU+cO5xABxNYk3DNnKClSDnSdCL/Ikt7mhDrbCWL2NS8w/yceh
bKmqffyBVQFbWQb/M97Wga7f7MeEhB9Izp6nB/03c/fXezNRVKDwFbinp8KAQjg3
eulbzGYIN5kfgZAHqj0zRqvbk6JuN8avfcQw6l5Ci8assi4Vnj5VnxiyhwfEM0tb
4hF7pfV5TCiRSk0Fzrzs1IJabFH/QIYBNuxVdr5I+cJYZZNA3Lr4yDqiCAHASlGz
uU9GLV6UgIitbLO8crxY+ROBtAqIrgUj4Uu2JuVSak3+mAL5JGIinQoemG8YOjdy
BwIVdhydpPRR9u/G/8wRBlNKVvKiag==
=O7b/
-----END PGP SIGNATURE-----

--CTJAQAjG7quIFAKcJ6ecjGTVMtJ4CH4T3--

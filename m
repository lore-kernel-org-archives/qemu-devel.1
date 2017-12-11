Received: from eggs.gnu.org ([2001:4830:134:3::10]:45312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eOOV0-0008Jw-QP
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:52:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eOOUw-000326-O9
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:52:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eOOUw-00031G-FO
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:51:58 -0500
References: <20171208105553.12249-1-pbonzini@redhat.com>
	<20171208105553.12249-3-pbonzini@redhat.com>
	<20171208153010.GD8998@stefanha-x1.localdomain>
	<43a3e41a-f6b2-dc43-f84d-53fa7efd0716@redhat.com>
	<20171211101620.GB13593@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e01b6be6-62b4-2123-ba30-09ca27fd5048@redhat.com>
Date: Mon, 11 Dec 2017 07:51:43 -0600
MIME-Version: 1.0
In-Reply-To: <20171211101620.GB13593@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bJq380NkKrIdq0xmovLDXJxB0K2rp4SOD"
Subject: Re: [Qemu-devel] [PATCH 2/5] lock-guard: add scoped lock
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bJq380NkKrIdq0xmovLDXJxB0K2rp4SOD
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <e01b6be6-62b4-2123-ba30-09ca27fd5048@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] lock-guard: add scoped lock
 implementation
References: <20171208105553.12249-1-pbonzini@redhat.com>
 <20171208105553.12249-3-pbonzini@redhat.com>
 <20171208153010.GD8998@stefanha-x1.localdomain>
 <43a3e41a-f6b2-dc43-f84d-53fa7efd0716@redhat.com>
 <20171211101620.GB13593@stefanha-x1.localdomain>
In-Reply-To: <20171211101620.GB13593@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/11/2017 04:16 AM, Stefan Hajnoczi wrote:

>>> I don't understand the need for the qemu_lock_guard_is_taken(&name)
>>> condition, why not do the following?
>>>
>>>   for (QEMU_LOCK_GUARD(type, name, lock);
>>>        ;
>>>        qemu_lock_guard_unlock(&name))
>>
>> Because that would be an infinite loop. :)
>=20
> Sorry, I mean for (...; false; ...).  Is there any reason to do
> qemu_lock_guard_is_taken(&name)?

You need the loop to execute at least once ;)

But I proposed an alternative that doesn't need is_taken, by:

for (bool name##done =3D false, QEMU_LOCK_GUARD(type, name, lock);
     ! name##done; name##done =3D true)

if we still like the form that declares a for-loop scope.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bJq380NkKrIdq0xmovLDXJxB0K2rp4SOD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloujW8ACgkQp6FrSiUn
Q2rlqgf/YEbw1A3ZlMhUT0WsPaUZUstc3dp1aN6IU/Vm+AOuciorkwwrsZITuxEn
AIQdSlWfvD5DMw0MzTKsP8AyBUtNntP+NJB5FcvF8+oqvtKgT99AY0tIkF5vi9pQ
3nY0QXydueCiQd3koOuQZeobPut69cHV+KjjUgA6MnlI/82IlJ0FOIApXAomSmi0
vWK5jjcaYH88Z1F4w2QwpIqq8LL5BXa3JbZZcbfvtV9SEI0xVC23AkZ//1Zh5cCw
ysZvpbOCT7K88SKo53A5vLhe+Pmr1S+KiveegkBZmGNodEDJ85vJEiiQesg6UQpS
UwKAoCxatYHZr3DsTzTkH7vXMMavYg==
=KzFp
-----END PGP SIGNATURE-----

--bJq380NkKrIdq0xmovLDXJxB0K2rp4SOD--

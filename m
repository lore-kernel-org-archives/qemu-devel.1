Received: from eggs.gnu.org ([2001:4830:134:3::10]:39362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnPuf-0005R0-Fd
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnPuc-0007xG-9E
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:21:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnPuc-0007ww-0J
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:21:22 -0400
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
	<20170311132256.22951-5-marcandre.lureau@redhat.com>
	<84148275-6410-68f7-4da0-345b635c42f3@redhat.com>
	<87h92xk5p7.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7da78125-495b-4a2b-6383-d0ae22ba282b@redhat.com>
Date: Mon, 13 Mar 2017 08:21:19 -0500
MIME-Version: 1.0
In-Reply-To: <87h92xk5p7.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3hx5AXaKTPPPbXJc6HoljfIm91B9qt3ms"
Subject: Re: [Qemu-devel] [PATCH 04/21] qobject: add quint type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, anderson@redhat.com, mdroth@linux.vnet.ibm.com, lersek@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3hx5AXaKTPPPbXJc6HoljfIm91B9qt3ms
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com, anderson@redhat.com,
 mdroth@linux.vnet.ibm.com, lersek@redhat.com
Message-ID: <7da78125-495b-4a2b-6383-d0ae22ba282b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/21] qobject: add quint type
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
 <20170311132256.22951-5-marcandre.lureau@redhat.com>
 <84148275-6410-68f7-4da0-345b635c42f3@redhat.com>
 <87h92xk5p7.fsf@dusky.pond.sub.org>
In-Reply-To: <87h92xk5p7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 02:15 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 03/11/2017 07:22 AM, Marc-Andr=C3=A9 Lureau wrote:
>>> The type is not used at all yet. Add some tests to exercice it.
>>
>> s/exercice/exercise/
>>
>> I wonder if we need this patch at all.
>>
>> I've been thinking about a possible alternative representation, such
>> that a single QInt type can cover _both_ signed and unsigned types, by=

>> having QInt track a sign bit bool in addition to a uint64_t value.
>>

> You say you've been thinking about extending QInt's range to cover
> uint64_t.  I've been thinking even more radically: replace both QInt an=
d
> QFloat by QNumber.  This is how JSON *actually* works.
>=20
> The new QNumber type provides constructors from double, int64_t and
> uint64_t.  It also provides conversion functions to double, int64_t and=

> uint64_t.  The latter two can fail.

Interesting - I like it, as it takes my idea and goes one step further.
You'd want to track 64 bits of precision rather than just 53, when the
input was integral, but the idea seems to have some merit (we have some
special case in the testsuite for what happens in alternates with
various combinations of 'number' vs. 'int' that may need tweaking when
they are no longer distinguishable as QInt vs QFloat, but that's not too
onerous).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--3hx5AXaKTPPPbXJc6HoljfIm91B9qt3ms
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYxpzPAAoJEKeha0olJ0Nqt6YH/Al9mx+2ew/p+pDAe9ua4cIn
A6b+K+T3gyaoiIiQHvqGq3IjrPs214wv4O95kZxxM71j4FPQIz5bs0i55M96FCm8
lSv3YN4lZ9C7AUEVJMSmZ5Ug0cv6SiRvRmlSw7anPC1W3lVAdwMp2bYp1jTL83lq
CH+myVjBZHO7mgC5xHrgVn9ApZlj5iDo/0v6EOOWKrQl+UqNQG2+agyxtOqs2sAN
34ZH9iHOv+BcgkW7fZ1n+A8YAVa85w+U9O95xhTWafHyMyb/cJbtp7fni9WnY3Mp
2jOZpjWuwzPwerYxW/7/gehRHm083nEFqK7LxYHIR1SCebslp4cOlX4H8O0NYE8=
=VG+x
-----END PGP SIGNATURE-----

--3hx5AXaKTPPPbXJc6HoljfIm91B9qt3ms--

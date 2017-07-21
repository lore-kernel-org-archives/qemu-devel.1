Received: from eggs.gnu.org ([2001:4830:134:3::10]:49352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYdNJ-0003DY-G6
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 15:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYdNG-00048Y-B3
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 15:14:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYdNG-00046f-0n
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 15:14:06 -0400
References: <20170718170819.28494-1-anton.ivanov@cambridgegreys.com>
	<20170718170819.28494-3-anton.ivanov@cambridgegreys.com>
	<03702920-f5b1-6579-0c59-a0d46274a6d9@redhat.com>
	<7c19329b-f3dc-1f54-9fac-8ecf43123a8b@cambridgegreys.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <33fada87-93c3-2914-68d9-86092856b37f@redhat.com>
Date: Fri, 21 Jul 2017 14:14:02 -0500
MIME-Version: 1.0
In-Reply-To: <7c19329b-f3dc-1f54-9fac-8ecf43123a8b@cambridgegreys.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hWoFtiNRBGPAGMHTmVQU5nfhJaKo785l1"
Subject: Re: [Qemu-devel] [PATCH 2/3] Unified Datagram Socket Transport -
 GRE support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hWoFtiNRBGPAGMHTmVQU5nfhJaKo785l1
From: Eric Blake <eblake@redhat.com>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com
Message-ID: <33fada87-93c3-2914-68d9-86092856b37f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] Unified Datagram Socket Transport - GRE
 support
References: <20170718170819.28494-1-anton.ivanov@cambridgegreys.com>
 <20170718170819.28494-3-anton.ivanov@cambridgegreys.com>
 <03702920-f5b1-6579-0c59-a0d46274a6d9@redhat.com>
 <7c19329b-f3dc-1f54-9fac-8ecf43123a8b@cambridgegreys.com>
In-Reply-To: <7c19329b-f3dc-1f54-9fac-8ecf43123a8b@cambridgegreys.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/19/2017 12:32 PM, Anton Ivanov wrote:
>=20
>=20
> On 19/07/17 15:40, Eric Blake wrote:
>> On 07/18/2017 12:08 PM, anton.ivanov@cambridgegreys.com wrote:
>>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>>
>>> This adds GRETAP support to the unified socket driver.
>>>

>>> +#
>>> +# @ipv6: force the use of ipv6
>> This doesn't quite match what we do with other sockets (where we have
>> both ipv4 and ipv6 booleans to allow IPv4-only, IPv6-only, or both).  =
Is
>> this something where we can reuse InetSocketAddress instead of inventi=
ng
>> yet another way of doing things?
>>
>> Then again, it does match what NetdevL2TPv3Options did :(
>=20
> I just reviewed this again.
>=20
> I do not think  we can today. This is the declaration:
>=20
> ##
> { 'struct': 'InetSocketAddressBase',
>   'data': {
>     'host': 'str',
>     'port': 'str' } }
>=20
> ##
>=20
> If I read this right port is mandatory, correct?

Okay, so it sounds like reusing InetSocket directly may not be possible.
 But there's still the interface question of whether we want dual 'ipv4'
and 'ipv6' switches to allow finer-grain control over which (or both)
families to be used.

>=20
> We may be able to do it if the port portion if InetSocketAddress become=
s
> optional. There is no such thing as port for the protocols which use th=
e
> raw families.

We can always create a new QAPI type that expresses only the fields we
need; I don't think InetSocketAddress should be changed to have an
optional port just for your code additions.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hWoFtiNRBGPAGMHTmVQU5nfhJaKo785l1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllyUnoACgkQp6FrSiUn
Q2q5YQgAoiWebJ0U+Lia8YBU7LslhzobUpoND+9m51WIhvwfWL7ioN2uQ7N5LbKk
Q0zZwCB6DEchOKFbyrBJ0QsSB6j5vaSc/zzCC44VqzUrB0sXMHrajOsgAAb0Aikl
ZDJVTHL3HhwRnf6yP8kYEWDYrbJcR0+WDy/FKCQ8VMyahDuI+gK1S5TC6Qotr9+b
V+KWVCZpkvSJPbNv1+Kq2sq4cjdzdqSvTS54UQOEgquv1cpGJIVgRkUr1CJ+tyLj
08cSbbuLefge4JfRnncXsQ/A3Q+P/oRMd4g6IayMQhF6O3oXsjnc2T8z25AIg2CQ
d7rDIpEnFX52M3jqn7TIP0Ye0mpyyw==
=3AI0
-----END PGP SIGNATURE-----

--hWoFtiNRBGPAGMHTmVQU5nfhJaKo785l1--

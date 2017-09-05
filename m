Received: from eggs.gnu.org ([2001:4830:134:3::10]:53940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpJrV-0007IY-IU
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpJrQ-0007yU-RO
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:50:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpJrQ-0007y4-I9
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:50:12 -0400
References: <20170818222313.13391-1-eblake@redhat.com>
	<1c41ef09-3e34-63ba-fc85-5aac46a5c355@linux.vnet.ibm.com>
	<ebea7edf-6f5b-9096-552c-079bfcad71a4@redhat.com>
	<87d17lqu85.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f40a5fc9-a140-041f-1c3c-d97036dab898@redhat.com>
Date: Tue, 5 Sep 2017 14:50:05 -0500
MIME-Version: 1.0
In-Reply-To: <87d17lqu85.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8dbrHvNhWIKSB8qDpn1sMb6F3QAbu4EgJ"
Subject: Re: [Qemu-devel] [RFC PATCH] osdep.h: Prohibit disabling assert()
 in supported builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, f4bug@amsat.org, "Michael S. Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8dbrHvNhWIKSB8qDpn1sMb6F3QAbu4EgJ
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, f4bug@amsat.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <f40a5fc9-a140-041f-1c3c-d97036dab898@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] osdep.h: Prohibit disabling assert() in
 supported builds
References: <20170818222313.13391-1-eblake@redhat.com>
 <1c41ef09-3e34-63ba-fc85-5aac46a5c355@linux.vnet.ibm.com>
 <ebea7edf-6f5b-9096-552c-079bfcad71a4@redhat.com>
 <87d17lqu85.fsf@dusky.pond.sub.org>
In-Reply-To: <87d17lqu85.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 02:51 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 08/22/2017 06:19 AM, Halil Pasic wrote:
>>
>>> OTOH I do think this is to some degree institutionalizing a bad pract=
ice
>>> (you say we do not want to do that, but IMHO refusing to build with
>>> NDEBUG makes only sense if we want to alter the semantic of assert so=

>>> that once bad becomes acceptable). I can live with that, but I'm not
>>> happy about it. Have we considered rolling our own construct which is=

>>> designed to exhibit the properties we desire?
>>

>>
>> I'd prefer that if we are going to introduce our own construct that
>> always evaluates side effects, and only has a compile-time switch on
>> whether to abort() or (foolishly) plow on, that we name it something
>> without 'assert' in the name, so that reviewers don't have to be
>> confused about remembering which variant evaluates side effects.  Mayb=
e:
>>
>> q_verify(cond)
>>

>=20
> I vote for frying bigger fish.
>=20
> I also vote for using standard C when standard C is servicable.

So if it were up to me alone, the answer is:

I'm NOT going to add any new construct (whether spelled q_verify() or
otherwise), and will merely document in the commit message that we
discussed this as an alternative (so someone who wants to disable #error
can get a git history of what went into the decision).

Also, it sounds like we want to keep it #error, not #warn.

But if anyone else has strong opinions before we promote this from RFC
to actual patch, I'm still interested in your arguments.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8dbrHvNhWIKSB8qDpn1sMb6F3QAbu4EgJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmu/+0ACgkQp6FrSiUn
Q2r6KQf8D2acxGujelbaS/K7E/IL3CYsacN5AkSeDDDEnb3nlQO49IIVTCQpbBLz
EjGrcOhqrlUAbbHgaNcjjdWsc9VvP0B9FWbEccLDZIjgTScVDUgLF9Spzk5HsyNi
ZqpLGwzVuGYZfuZnW6QtZq6zuWxHbmfO4I9FSIBudM+LoOXw7Qzq2tOfH8zyoYM4
u2S32w9do4ZjXjkwBReQSG6CdfyyYK3oE7LuUp8alYRd5cvy5gKlcBDURTk8Ur1l
EpPw9x9/n74euDsoJ9qhGPvBBBWTqCUszCUDqAmLYS8MKJiQt1UfxndraWxeIoXQ
gbZsDWhfY8Jgp2MCExDIiS0AlkoRNw==
=02wz
-----END PGP SIGNATURE-----

--8dbrHvNhWIKSB8qDpn1sMb6F3QAbu4EgJ--

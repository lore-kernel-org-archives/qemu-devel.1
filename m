Received: from eggs.gnu.org ([2001:4830:134:3::10]:45219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpSrb-0002Rm-ED
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 01:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpSrX-0004cY-G7
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 01:26:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dpSrX-0004Zn-7Z
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 01:26:55 -0400
References: <20170818222313.13391-1-eblake@redhat.com>
	<1c41ef09-3e34-63ba-fc85-5aac46a5c355@linux.vnet.ibm.com>
	<ebea7edf-6f5b-9096-552c-079bfcad71a4@redhat.com>
	<87d17lqu85.fsf@dusky.pond.sub.org>
	<f40a5fc9-a140-041f-1c3c-d97036dab898@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f14f7069-6557-8633-d7c4-3caee567f905@redhat.com>
Date: Wed, 6 Sep 2017 07:26:42 +0200
MIME-Version: 1.0
In-Reply-To: <f40a5fc9-a140-041f-1c3c-d97036dab898@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="9lpbn3O6Uv4xuciCheM5JLlfGRAjSct1p"
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
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9lpbn3O6Uv4xuciCheM5JLlfGRAjSct1p
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.09.2017 21:50, Eric Blake wrote:
> On 08/24/2017 02:51 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> On 08/22/2017 06:19 AM, Halil Pasic wrote:
[...]
>>> I'd prefer that if we are going to introduce our own construct that
>>> always evaluates side effects, and only has a compile-time switch on
>>> whether to abort() or (foolishly) plow on, that we name it something
>>> without 'assert' in the name, so that reviewers don't have to be
>>> confused about remembering which variant evaluates side effects.  May=
be:
>>>
>>> q_verify(cond)
>>
>> I vote for frying bigger fish.
>>
>> I also vote for using standard C when standard C is servicable.
>=20
> So if it were up to me alone, the answer is:
>=20
> I'm NOT going to add any new construct (whether spelled q_verify() or
> otherwise), and will merely document in the commit message that we
> discussed this as an alternative (so someone who wants to disable #erro=
r
> can get a git history of what went into the decision).
>=20
> Also, it sounds like we want to keep it #error, not #warn.
>=20
> But if anyone else has strong opinions before we promote this from RFC
> to actual patch, I'm still interested in your arguments.

You asked for opinions, so here's mine: I agree with you, please do
*not* add a new QEMU-specific construct here. assert() should be a
well-known C construct that every programmer should have understood. You
also need it for other projects. If you haven't understood that it's a
macro and has side-effects, you should learn it (e.g. during patch
review), not avoid it, otherwise you'll run into problems in another
project that is using it again.

But IMHO we should still try to get rid of wrong usage of assert() in
the QEMU sources. So maybe we could allow building with NDEBUG one day
for the brave people who need the extra percent of additional speed. But
as long as we're not there, I think this patch is a good thing to avoid
wrong expectations.

 Thomas


--9lpbn3O6Uv4xuciCheM5JLlfGRAjSct1p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZr4cXAAoJEC7Z13T+cC21ycAP/272nzKz7rwObfKQA38sKe1z
p6jPjKum6zT50ULIdxhlXY4qQUVnFc+WVRRc/3VE3M0TgE0mEaCUXBrD8NdBtQaG
oLNP4eoUM9RRRxuamsLo8yMMb/gBiKH8JenCJvUPfOyNC2W6Jzj3um5o0arOt+u2
6x5Wa8o6AN3WrSGWN/Nv/Hhf5TbHA5wPw2wS7EwVFligdgG8cnurQy1aM48vqurL
w16ji5pqEwZkDLdZl8UpaSi4K5yf8AD9e/6tv04EdLo4ikNAtQPpchNzxzLDoBus
AYvrXrLVQTrfM+GNmT/YIW7hkZJA1l+WBt4LB7H0g8ex5OFKTG8JeLhnGF46n2us
vnBJJzsKOaL0wAuBe2UfihmrJkFKS8gn9ULBNwmwDe1Rgm3f+HAKdGXU+/PTawWd
LeeeZ3jsnwmP8HSlE2gJxf+xhqUDNKyco8NzXz/SN/NbW3rJWIuF/AaRNtFYxkuP
2qgmgMEHwexQm1RN1fyVRnxrjv6HGLB7YNd812BneJ3P3Rjxg6ik1xGupRDQ/lCG
fekL0gfcFP3jeel6Kr2E5TSfQTXPfr89/T73tUnh0kLRDtPQcc2XIsQSCZa82clF
zohxjyoGwdKVGtuIbFvxrSjinF9YfInIoEqDxynxQUMFUQf+gD+Tz7n32J2NnIgd
OOVopFDvRNqrtpl0Vg8H
=M1wN
-----END PGP SIGNATURE-----

--9lpbn3O6Uv4xuciCheM5JLlfGRAjSct1p--

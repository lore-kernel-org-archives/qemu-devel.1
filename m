Received: from eggs.gnu.org ([2001:4830:134:3::10]:55097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpYd2-0007s0-W4
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpYcz-0001FC-Ri
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:36:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36475
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dpYcz-0001Ew-KH
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:36:17 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v86BYCKR097003
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 07:36:16 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ctc054q8w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 07:36:15 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 12:36:13 +0100
References: <20170818222313.13391-1-eblake@redhat.com>
	<1c41ef09-3e34-63ba-fc85-5aac46a5c355@linux.vnet.ibm.com>
	<ebea7edf-6f5b-9096-552c-079bfcad71a4@redhat.com>
	<87d17lqu85.fsf@dusky.pond.sub.org>
	<f40a5fc9-a140-041f-1c3c-d97036dab898@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 13:35:52 +0200
MIME-Version: 1.0
In-Reply-To: <f40a5fc9-a140-041f-1c3c-d97036dab898@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="jISxd9c6xMgl54r36VUBPK20TJmuV9udW"
Message-Id: <b0403fd9-b02b-1ee7-9b12-0408eb055acb@linux.vnet.ibm.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jISxd9c6xMgl54r36VUBPK20TJmuV9udW
From: Halil Pasic <pasic@linux.vnet.ibm.com>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-devel@nongnu.org, f4bug@amsat.org
Message-ID: <b0403fd9-b02b-1ee7-9b12-0408eb055acb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH] osdep.h: Prohibit disabling assert() in
 supported builds
References: <20170818222313.13391-1-eblake@redhat.com>
 <1c41ef09-3e34-63ba-fc85-5aac46a5c355@linux.vnet.ibm.com>
 <ebea7edf-6f5b-9096-552c-079bfcad71a4@redhat.com>
 <87d17lqu85.fsf@dusky.pond.sub.org>
 <f40a5fc9-a140-041f-1c3c-d97036dab898@redhat.com>
In-Reply-To: <f40a5fc9-a140-041f-1c3c-d97036dab898@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/05/2017 09:50 PM, Eric Blake wrote:
> On 08/24/2017 02:51 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> On 08/22/2017 06:19 AM, Halil Pasic wrote:
>>>
>>>> OTOH I do think this is to some degree institutionalizing a bad prac=
tice
>>>> (you say we do not want to do that, but IMHO refusing to build with
>>>> NDEBUG makes only sense if we want to alter the semantic of assert s=
o
>>>> that once bad becomes acceptable). I can live with that, but I'm not=

>>>> happy about it. Have we considered rolling our own construct which i=
s
>>>> designed to exhibit the properties we desire?
>>>
>=20
>>>
>>> I'd prefer that if we are going to introduce our own construct that
>>> always evaluates side effects, and only has a compile-time switch on
>>> whether to abort() or (foolishly) plow on, that we name it something
>>> without 'assert' in the name, so that reviewers don't have to be
>>> confused about remembering which variant evaluates side effects.  May=
be:
>>>
>>> q_verify(cond)
>>>
>=20
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
>=20

I'm fine with this outcome: it is a minimal solution to a real problem.
My initiative was a kind of bike-shedding: any devel with enough exposure=

to  qemu to matter  will learn soon enough that the assert macro is
special in this project.

Regards,
Halil


--jISxd9c6xMgl54r36VUBPK20TJmuV9udW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAEBAgAGBQJZr92pAAoJEA0vhuyXGx0APjEQALHcxffpcNm0R+w27+YoRFF3
7v89piOESI5ZfqCEpFlxCTspdrFr2je7lU46rkDmfsRfQaof6NkEeb3DqPlL0ypl
dVaNGbEpZh33/DDr57kcoP8sm8FBZ5oTdWfTFgZWwrTJOzUhH37LmLIIGZ66ZdhI
0uGRIAOkopVF61BLy4Ah+D+pLr1IkJ1XXvlqNVMeR0zHDvavJ/efoye0bUNT3R6M
nj+uqGjesSoVereuHDoNN6trpNffGXpPbb7W52H8LtXL1ZBOj5VoMsH9z4cmVgtQ
FlkYTfSrP1xLyCDgTS0+jenXR9eGtv2FSx0DTerFlMO+XO3/rxpPsXmWv2iu0J+2
PJ7bsGBNElKahKUqYjk4MCoEA3av9zcpozviUfqFhKT+tNkRN6ZCNYCysXWq9+WW
D/49UfogrUQYqW0V7szhvNm71FjS4bnBRV5QvFffABPOctENIApChhRBx/mYNVtv
2KFDY3dWLMbo/Zxc2qOb9ClQtnaoe12ra9PCr4xsFnYbMagJl5P5wsaW7YL1xfc1
NBWlr/1hxbf/41Xm82Vb/b4W22rt1N12pmJqYKvGJwUSic57wSacfUsWnFtR+D0o
kcH825kvNNU/E+kCGmjvdFQWemwup3VaupGzMo58McGMvWPSQBiQSbeOAJkvvKEO
PN72qYPyYy/DCEiwiyLL
=IkWA
-----END PGP SIGNATURE-----

--jISxd9c6xMgl54r36VUBPK20TJmuV9udW--

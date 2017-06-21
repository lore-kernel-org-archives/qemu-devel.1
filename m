Received: from eggs.gnu.org ([2001:4830:134:3::10]:43375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNdqU-0004SK-GQ
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 07:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNdqT-0001oJ-H9
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 07:30:50 -0400
References: <20170619150002.3033-1-stefanha@redhat.com>
	<117743be-2351-7fe0-c777-c630bb850447@redhat.com>
	<20170621082434.GA16183@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <150fc149-94cf-6e25-3ca1-9f083fd5ad1d@redhat.com>
Date: Wed, 21 Jun 2017 13:30:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170621082434.GA16183@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="adxlXaGqcPmSHLXpEbH1eXrjjnbX9RsJ5"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: don't shadow opts variable in
 img_dd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Reda Sallahi <fullmanet@gmail.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--adxlXaGqcPmSHLXpEbH1eXrjjnbX9RsJ5
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Reda Sallahi <fullmanet@gmail.com>, qemu-block@nongnu.org
Message-ID: <150fc149-94cf-6e25-3ca1-9f083fd5ad1d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: don't shadow opts variable in
 img_dd()
References: <20170619150002.3033-1-stefanha@redhat.com>
 <117743be-2351-7fe0-c777-c630bb850447@redhat.com>
 <20170621082434.GA16183@stefanha-x1.localdomain>
In-Reply-To: <20170621082434.GA16183@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2017-06-21 10:24, Stefan Hajnoczi wrote:
> On Mon, Jun 19, 2017 at 05:18:18PM +0200, Max Reitz wrote:
>> On 2017-06-19 17:00, Stefan Hajnoczi wrote:
>>> It's confusing when two different variables have the same name in one=

>>> function.
>>>
>>> Cc: Reda Sallahi <fullmanet@gmail.com>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>>  qemu-img.c | 9 +++------
>>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/qemu-img.c b/qemu-img.c
>>> index 0ad698d..c285c2f 100644
>>> --- a/qemu-img.c
>>> +++ b/qemu-img.c
>>> @@ -4249,15 +4249,12 @@ static int img_dd(int argc, char **argv)
>>>          case 'U':
>>>              force_share =3D true;
>>>              break;
>>> -        case OPTION_OBJECT: {
>>> -            QemuOpts *opts;
>>> -            opts =3D qemu_opts_parse_noisily(&qemu_object_opts,
>>> -                                           optarg, true);
>>> -            if (!opts) {
>>> +        case OPTION_OBJECT:
>>> +            if (!qemu_opts_parse_noisily(&qemu_object_opts, optarg, =
true)) {
>>>                  ret =3D -1;
>>>                  goto out;
>>>              }
>>> -        }   break;
>>> +            break;
>>>          case OPTION_IMAGE_OPTS:
>>>              image_opts =3D true;
>>>              break;
>>
>> Hm, I basically reverted such a style in commit
>> 3258b91141090b05edcaab8f1d1dd355ca91b49a. I find it confusing to use t=
he
>> same variable for two different things.
>=20
> I don't follow how the commit you posted is related to this patch.  Did=

> you read the patch too quickly and think it uses the outer opts
> variable?

Pleading guilty: Yes, I did. I just saw you dropped the inner variable
and thus thought you were using the outer ones to resolve shadowing.

> This patch doesn't use a variable at all - there is no need for one.

Good, then! :-)

Sorry, and thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--adxlXaGqcPmSHLXpEbH1eXrjjnbX9RsJ5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZSljbEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQIPh
CACim3YEyMRy9EehHakYqQMzv+azBN1jpXVJFCrg0SWxmbIryRKTxPwBniC3q5wA
jnxTJ08i39VyCex+AZ3vB1TVOXrPnCtQxW9DtlBrEsk9urSQIPTtZNN0w1NJ7X1d
fm8xe0jsk/r+JKbGZkmazzeu+/mAD2WS0hJPlB1cnVAiZ3THJ39rESAG0RvMFBj8
R4THjUnlE9jwozI50bDN85oNUD/ktOQAZLKNU0/4H0opZYNT7FMhoZEMr2iH772/
3AvOpdMOgp+GjjI0GxM4iEX7rpNq9iyGUUeUx01Gge5sAnPo38ysh65neLZqdo5n
cLdpaaDjLD4/ixP7uplsi3ic
=2zpQ
-----END PGP SIGNATURE-----

--adxlXaGqcPmSHLXpEbH1eXrjjnbX9RsJ5--

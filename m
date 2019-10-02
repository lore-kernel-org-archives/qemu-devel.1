Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBF2C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445122133F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445122133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFdHI-0003QR-DQ
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 07:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFdGB-0002U9-HS
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFdG9-00033W-Cr
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:57:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50450)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFdG3-00030d-L5; Wed, 02 Oct 2019 07:57:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 786C13084242;
 Wed,  2 Oct 2019 11:57:26 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76A1C5C22C;
 Wed,  2 Oct 2019 11:57:22 +0000 (UTC)
Subject: Re: [PATCH v5 1/5] iotests: remove 'linux' from default supported
 platforms
To: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
References: <20190917234549.22910-1-jsnow@redhat.com>
 <20190917234549.22910-2-jsnow@redhat.com>
 <a252472e-842a-8401-2743-e4ed948b066b@redhat.com>
 <450a1f52-9589-cb98-88cb-1d3fcd5f506a@redhat.com>
 <778487c5-566e-d133-6395-d3908db66adc@redhat.com>
 <62cf912a-8ee9-d023-84c2-1ad6ea94e3b8@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <16eef993-c16e-3fd7-c60d-6d3c7bfb5148@redhat.com>
Date: Wed, 2 Oct 2019 13:57:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <62cf912a-8ee9-d023-84c2-1ad6ea94e3b8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PdPbAbbEzrrfztt6TAVNNRnJQQXFfjqlU"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 02 Oct 2019 11:57:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PdPbAbbEzrrfztt6TAVNNRnJQQXFfjqlU
Content-Type: multipart/mixed; boundary="OOqjwLymJ9ooyFwkTXqgDbI0gpMLFXMSm"

--OOqjwLymJ9ooyFwkTXqgDbI0gpMLFXMSm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.10.19 06:46, Thomas Huth wrote:
> On 01/10/2019 20.44, Max Reitz wrote:
> [...]
>> As I have said, the conceptual problem is that the iotests now run as
>> part of make check.  As such, allowing auto tests to run on non-Linux
>> platforms may introduce build failures that I cannot do anything about=
=2E
>=20
> Well, simply run "make vm-build-openbsd", "make vm-build-freebsd", ...
> if something fails there, it likely should not be in the auto group.

Then we come to Windows and macOS.

What I=E2=80=99ve proposed to John on IRC was to simply skip the iotests =
in make
check for non-Linux systems.

>> And those are very much new failures.
>>
>>> I think that I have demonstrated sufficiently that it's not correct t=
o
>>> prohibit python tests from running on other platforms wholesale, so I=
'd
>>> prefer we don't do that anymore.
>>
>> You have not.
>>
>> The actual argument to convince me is =E2=80=9CThis does not affect an=
y tests in
>> the auto group, so it will not introduce build failures at this time=E2=
=80=9D.
>=20
> I've applied the patch here and it works fine with FreeBSD and macOS:
>=20
>  https://cirrus-ci.com/build/5169384718336000
>  https://travis-ci.com/huth/qemu/builds/129968676
>=20
> It also works fine with "make vm-build-openbsd BUILD_TARGET=3Dcheck-blo=
ck"
> ... so I think you don't have to worry here.

Obviously, because as I=E2=80=99ve said it doesn=E2=80=99t affect any tes=
ts in the auto
group.  Yet.

>>> Further, iotests on FreeBSD already weren't 100% green, so I'm not
>>> causing a regression in that sense, either.
>>
>> My problem is twofold:
>>
>> (1) You claim =E2=80=9CSure, there are failures, but let=E2=80=99s jus=
t deal with them=E2=80=9D
>> and then you do not deal with them.  Seems wrong to me.
>>
>> I=E2=80=99m fine with the argument =E2=80=9CSorry, royal =E2=80=98we=E2=
=80=99.  But it just doesn=E2=80=99t help
>> anyone to hide the errors.  If someone=E2=80=99s on BSD and wants to r=
un the
>> iotests, let them.=E2=80=9D
>>
>> That sounds good to me.
>>
>> (2) Maybe someone adds a Python test in the future that is in auto and=

>> that does not specify Linux as the only supported platform.  Then I se=
nd
>> a pull request and it breaks on macOS.  Now what?  Remove it from auto=
?
>>  Blindly put "macOS" in unsupported platforms?
>=20
> I think both solutions are good. If a test does not work on all systems=
,
> it either should not be in the "auto" group, or it needs to be modified=

> to skip testing when running in an unsupported environment.
>=20
>> In any case, it=E2=80=99ll be a problem for no good reason.
>=20
> Really? Is "more test coverage" not a good reason?

It isn=E2=80=99t when the solution is to just reduce the coverage again.

Furthermore, the problem is that we get this additional coverage on
systems that I will not support.

>> More on that in the next chunk.
>>
>>> I'm going to meekly push and ask that we stage this as-is, and when
>>> something bad happens you can remind me that I wanted this and make m=
e
>>> do it.
>>
>> Make you do what?  Deal with the fact that a pull request is rejected
>> because a test fails on macOS?
>>
>> This is precisely the kind of problem I already had with adding the
>> iotests to make check, and I=E2=80=99m already very much not happy abo=
ut it.
>> (In that case it was $DISPLAY not being set on Peter=E2=80=99s test sy=
stem.)
>>
>> I=E2=80=99ll let you make the deduction of =E2=80=9CThe problem isn=E2=
=80=99t allowing the
>> iotests to run on non-Linux platforms, but the fact that they run in
>> make check=E2=80=9D yourself, so that I no longer feel like I=E2=80=99=
m the only one who
>> considers that having been a mistake.
>=20
> Max, I can understand that you are a little bit annoyed that this "make=

> check with iotests" caused some extra hurdles for you. But honestly,
> removing that again would be quite egoistic by you. Try to put yourself=

> into the position of a "normal", non-blocklayer-maintainer QEMU
> developer. For me, iotests were a *constant* source of frustration.
> Often, when I ran them on top of my latest and greatest patches, to
> check whether I caused a regression, the iotests simply failed. Then I
> had to start debugging - did my patches cause the break, or is "master"=

> broken, too? In almost all cases, there was an issue in the master
> branch already, either because they were failing on s390x, or because I=

> was using ext4 instead of xfs, or because I was using an older distro
> than you, etc... . So while the iotests likely worked fine for the
> limited set of systems that you, Kevin and the other hard-core block
> layer developers are using, it's constantly broken for everybody else
> who is not using the very same setup as you. The only way of *not*
> getting upset about the iotests was to simply completely *ignore* them.=

> Is it that what you want?

It usually worked fine for me because it=E2=80=99s rather rare that non-b=
lock
patches broke the iotests.

I have to admit I actually didn=E2=80=99t think of other people wanting t=
o run
the iotests; but to be honest, your mail doesn=E2=80=99t sound like you w=
ant to
run the iotests either.  It rather sounds like you have to because
otherwise I might complain.

(The reason I didn=E2=80=99t think of it is because non-block patches rar=
ely
break them, so I wouldn=E2=80=99t run the iotests if I were a non-block
maintainer.  Sorry.)


Part of my problem is precisely with the fact that different systems are
different and that the iotests are not as deterministic as we=E2=80=99d w=
ant
them to be.  Realistically, I don=E2=80=99t think they=E2=80=99ll ever be=
=2E  I know they
haven=E2=80=99t been for six years even though it=E2=80=99s been kind of =
a goal, but it
hasn=E2=80=99t worked out so far.  (I don=E2=80=99t think it=E2=80=99s po=
ssible to write iotests
in a way that they are provably deterministic.)

So now you run the tests on your machine, they pass, you send a pull
request.  On Peter=E2=80=99s test machines, they pass, too, so the reques=
t is
merged.  But then on someone else=E2=80=99s machine, they don=E2=80=99t, =
so they get a
make check failure, which is just one step below build failure.  (Or
maybe it just turns up later on the test machines, because it=E2=80=99s f=
lakey.
 Like in the case of 130 a week ago, which I CC=E2=80=99d you on.)

And then it=E2=80=99s my problem even though there=E2=80=99s most likely =
no real problem
there.  (And I can=E2=80=99t reproduce it, because, well, I have a differ=
ent setup.)


Maybe my main problem is that I feel like now I have to deal with all of
the fallout, even though adding the iotests to make check wasn=E2=80=99t =
my idea
and neither me nor Kevin ever consented.  (I don=E2=80=99t know whether K=
evin
consented implicitly, but I don=E2=80=99t see his name in bdd95e47844f2d8=
b.)

You can=E2=80=99t just give me more responsibility without my consent and=
 then
call me egoistic for not liking it.

> Or maybe let me phrase it differently: Do you consider the iotests as
> something that is more or less "private" to the hard-core block layer
> developers, and it's ok if others completely ignore them and break them=

> by accident (and you also don't expect the normal developers to fix the=

> iotests afterwards)?

Well, that=E2=80=99s how it=E2=80=99s always worked, and that didn=E2=80=99=
t frustrate me.

Also, to give you a bit more perspective on why the situation has just
worsed for me, it=E2=80=99s because I run many more tests than what we ha=
ve in
auto for qcow2.  I=E2=80=99ve rarely had a problem with that very limited=
 set of
tests, but with others.  Mostly NBD, actually.

(I run qcow2, qcow2 -o compat=3D0.10, qcow2 -o refcount_bits=3D1, nbd, ra=
w,
luks, qcow, qed, cloop, parallels, bochs, vdi, vhdx, vmdk, vpc; only
x64, but at least both -m64 and -m32.)

First, a disclaimer.  I=E2=80=99m aware that I may be very wrong about th=
e
following, because I will not see make check failures on other people=E2=80=
=99s
systems that they fix themselves.  But the thing is, you haven=E2=80=99t =
told me
about any such failures on your system so far, so I=E2=80=99m just going =
to give
you my perspective here.

Honestly, it looks to me like you don=E2=80=99t even want to run the iote=
sts.  I
interpret most of what you=E2=80=99ve written as:

- I don=E2=80=99t want to not run the iotests, because then people will h=
it me
  for making them fail.

- But they fail all the time, so I always need a baseline for what is
  expected to sometimes fail and what isn=E2=80=99t.  That=E2=80=99s very=
 annoying.
  Let=E2=80=99s introduce a baseline in the form of auto/qcow2, and then =
let
  everyone verify that it works.

So to me it looks like we=E2=80=99ve just added all tests that never fail=
 to
auto.  But if they never fail, then it=E2=80=99s like we haven=E2=80=99t =
run the tests
at all.  (As I=E2=80=99ve said, you need to tell me whether they do fail,=

because I don=E2=80=99t see them fail[1].)

So honestly (I know this is unfair, but it=E2=80=99s my honest POV) it lo=
oks to
me like the current situation is just an excuse for everyone to be able
to claim they run the iotests.  When actually, they don=E2=80=99t, becaus=
e they
run only a small well-defined set that doesn=E2=80=99t catch much anyway.=
  (What
they do catch is stuff that doesn=E2=80=99t help.)

I know you=E2=80=99ll say that we just need to ensure we can add more tes=
ts,
then.  But for one thing, the most important tests are the ones that
take the longest, like 041.  And the other of course is that adding any
more tests to make check just brings me more pain, so I won=E2=80=99t do =
it.

[1] There is the recent case of Kevin=E2=80=99s pull request having been
rejected because his test failed on anything but x64.  I=E2=80=99m torn h=
ere,
because I would have seen that failure on my -m32 build.  So it isn=E2=80=
=99t
like it would have evaded our view for long.

But OTOH, yes, this is a failure that could have annoyed quite some
people for a week; and now it has indeed been caught by make check.

> Then sure, please go ahead and remove the iotests
> from "make check" again. Maybe I just understood the idea of having
> common tests in the repository wrong (or maybe the iotests should be
> moved to a separate repository instead, so that the normal QEMU
> developers do not get in touch with them anymore?) ... Otherwise, I
> think it was the right step to add them "make check" so that everybody
> now *has* to run at least a basic set of the iotests now before they ca=
n
> their patches merged.

=46rom what I read you yourself argued that that doesn=E2=80=99t mean muc=
h,
though, because everyone has different setups on their machine.

> PS: Sorry, if my mail sounded a little bit harsh... but I really had
> quite some frustration with the iotests in the past already.

Me too, that=E2=80=99s the point.


Overall, I think my main problem is that I feel like you=E2=80=99re leavi=
ng me
alone here.  It=E2=80=99s unfair to just add the iotests to make check wi=
thout
my consent, then let me deal with the problems, and then call me
egoistic when I complain.

You have to decide: Either let me deal with the problems, but then I
have every right to be egoistic about it =E2=80=93 or you help me deal wi=
th them.

Max


--OOqjwLymJ9ooyFwkTXqgDbI0gpMLFXMSm--

--PdPbAbbEzrrfztt6TAVNNRnJQQXFfjqlU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2UkKAACgkQ9AfbAGHV
z0AtGAf/QrVdzeVuj0r+9YijEBJyBXo5PHlH2AaOYRP7H1p+kddAQQldBIrO1f56
SjlkpFuvFng0tQy5VyWCakOLFVKOrM9UO0YMyY2sAr7FlAoDWzNRwRJgvTdwXG+m
rJrLAS79uly5sRy4YhXFEb+7s2bl2NmvZkJNrcjFGLbgi+ZVG8haWNbm/uwEOvHb
zwD42Nhryy1bfC41RO22QYok1IC2zl+dOYmBDXbJYZTI4qof1tbdWTOjUcameaoP
qfhn4kKs0P/ZwcMaFWvSTAX7mCeHNAizJW1CQ6IMKPcQVDVesGDFv/0makJ2Abby
bTq6kKjUDRZXpb/qbEM9HqrMrAAXIg==
=gAID
-----END PGP SIGNATURE-----

--PdPbAbbEzrrfztt6TAVNNRnJQQXFfjqlU--


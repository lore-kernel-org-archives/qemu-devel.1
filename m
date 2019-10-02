Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07C6C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 13:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B1421783
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 13:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B1421783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFeoa-00013s-GL
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 09:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFenr-0000aG-0c
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 09:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFenp-00043P-Bp
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 09:36:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43302)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFenj-0003ya-1C; Wed, 02 Oct 2019 09:36:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B4B983003073;
 Wed,  2 Oct 2019 13:36:17 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D5F761001B11;
 Wed,  2 Oct 2019 13:36:12 +0000 (UTC)
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
 <16eef993-c16e-3fd7-c60d-6d3c7bfb5148@redhat.com>
 <30b22415-a46a-6810-4f9f-d108084cd7bb@redhat.com>
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
Message-ID: <e62074a1-3f59-acb6-0cf1-6056b387e9cc@redhat.com>
Date: Wed, 2 Oct 2019 15:36:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <30b22415-a46a-6810-4f9f-d108084cd7bb@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nagovlCt1fjBuaikWu2xr2jHOmdWa28Os"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 02 Oct 2019 13:36:17 +0000 (UTC)
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
--nagovlCt1fjBuaikWu2xr2jHOmdWa28Os
Content-Type: multipart/mixed; boundary="Xl57g6QtlLxwbxInuaYzXUU5ChOW6BWsG"

--Xl57g6QtlLxwbxInuaYzXUU5ChOW6BWsG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.10.19 15:11, Thomas Huth wrote:
> On 02/10/2019 13.57, Max Reitz wrote:
>> On 02.10.19 06:46, Thomas Huth wrote:
>>> [...]
>>> Max, I can understand that you are a little bit annoyed that this "ma=
ke
>>> check with iotests" caused some extra hurdles for you. But honestly,
>>> removing that again would be quite egoistic by you. Try to put yourse=
lf
>>> into the position of a "normal", non-blocklayer-maintainer QEMU
>>> developer. For me, iotests were a *constant* source of frustration.
>>> Often, when I ran them on top of my latest and greatest patches, to
>>> check whether I caused a regression, the iotests simply failed. Then =
I
>>> had to start debugging - did my patches cause the break, or is "maste=
r"
>>> broken, too? In almost all cases, there was an issue in the master
>>> branch already, either because they were failing on s390x, or because=
 I
>>> was using ext4 instead of xfs, or because I was using an older distro=

>>> than you, etc... . So while the iotests likely worked fine for the
>>> limited set of systems that you, Kevin and the other hard-core block
>>> layer developers are using, it's constantly broken for everybody else=

>>> who is not using the very same setup as you. The only way of *not*
>>> getting upset about the iotests was to simply completely *ignore* the=
m.
>>> Is it that what you want?
>>
>> It usually worked fine for me because it=E2=80=99s rather rare that no=
n-block
>> patches broke the iotests.
>>
>> I have to admit I actually didn=E2=80=99t think of other people wantin=
g to run
>> the iotests; but to be honest, your mail doesn=E2=80=99t sound like yo=
u want to
>> run the iotests either.
>=20
> I *want* to run them. Occasionally - when I have new patches that might=

> affect anything related to the block layer. But then I don't want to be=

> in the situation where I first have to debug multiple other problems
> with the iotests first that are not related to my new patches.

OK.

>> (The reason I didn=E2=80=99t think of it is because non-block patches =
rarely
>> break them, so I wouldn=E2=80=99t run the iotests if I were a non-bloc=
k
>> maintainer.  Sorry.)
>=20
> Well, "rarely" is relative. They've been broken *completely* two times
> in the 4.1 development time frame, and IIRC at least once in the 4.0
> time frame.

Hm, OK.  So my memory is just shot.

> [...]
>> Maybe my main problem is that I feel like now I have to deal with all =
of
>> the fallout, even though adding the iotests to make check wasn=E2=80=99=
t my idea
>> and neither me nor Kevin ever consented.  (I don=E2=80=99t know whethe=
r Kevin
>> consented implicitly, but I don=E2=80=99t see his name in bdd95e47844f=
2d8b.)
>>
>> You can=E2=80=99t just give me more responsibility without my consent =
and then
>> call me egoistic for not liking it.
>=20
> Ok, sorry for that. I guess one part of my frustration was also that th=
e
> patches to enable the iotests during "make check" have been on the list=

> for weeks - or rather months - and I never ever got much feedback from
> you or Kevin on them.
I think that=E2=80=99s for two reasons:

(1) The time line in the block layer is unfortunately apparently
different from what you=E2=80=99re used to.  Or, rather, fortunately for =
you.
It isn=E2=80=99t too rare for me to have patches up for a year or more.

(2) We=E2=80=99ve had discussions on this before and the result was alway=
s the
same.  Yes, we=E2=80=99d like to run the iotests as part of make check, b=
ut we
can=E2=80=99t imagine it would work right now (where =E2=80=9Cright now=E2=
=80=9D is whenever we
have the discussion).

So as for me, I felt bad about plainly saying =E2=80=9Cno=E2=80=9D.  But =
I cannot say
=E2=80=9Cyes=E2=80=9D either.  You=E2=80=99re right that I should=E2=80=99=
ve said something.  There are
more words than =E2=80=9Cyes=E2=80=9D and =E2=80=9Cno=E2=80=9D.  Sorry ag=
ain.

I can imagine I had hoped Kevin would speak up (and thus take
responsibility) or you=E2=80=99d become so annoyed with our silence that =
you=E2=80=99d
angrily reach out to us and I=E2=80=99d have to do something.  (Which is =
a
horrible attitude, I realize that.)
I do remember that I didn=E2=80=99t expect that you=E2=80=99d just find s=
omeone else to
merge the patch.  That took me by surprise.

> If you told me right in the beginning about your
> concerns, we would not be at this point now. Also partly my bad, I
> guess, since I could have reached out to you on IRC to discuss it, but
> at that point in time, I rather thought that you just don't really care=
=2E
> Thus it's good to have some conversation now, helps a lot to understand=

> the different expectations. Maybe we can also have a discussion about
> this at KVM forum, I think it's easier to clarify some points of view
> verbally there instead of using mails.

Well, I won=E2=80=99t be at KVM Forum, unfortunately.

>>> Or maybe let me phrase it differently: Do you consider the iotests as=

>>> something that is more or less "private" to the hard-core block layer=

>>> developers, and it's ok if others completely ignore them and break th=
em
>>> by accident (and you also don't expect the normal developers to fix t=
he
>>> iotests afterwards)?
>>
>> Well, that=E2=80=99s how it=E2=80=99s always worked, and that didn=E2=80=
=99t frustrate me.
>=20
> Ok ... you're the maintainer, so if that's really the way you prefer, I=

> can send a patch to remove the iotests from "make check" again.
>=20
>> Honestly, it looks to me like you don=E2=80=99t even want to run the i=
otests.  I
>> interpret most of what you=E2=80=99ve written as:
>>
>> - I don=E2=80=99t want to not run the iotests, because then people wil=
l hit me
>>   for making them fail.
>>
>> - But they fail all the time, so I always need a baseline for what is
>>   expected to sometimes fail and what isn=E2=80=99t.  That=E2=80=99s v=
ery annoying.
>>   Let=E2=80=99s introduce a baseline in the form of auto/qcow2, and th=
en let
>>   everyone verify that it works.
>>
>> So to me it looks like we=E2=80=99ve just added all tests that never f=
ail to
>> auto.  But if they never fail, then it=E2=80=99s like we haven=E2=80=99=
t run the tests
>> at all.
>=20
> I disagree. First, the complete iotest failures that have been merged
> during the 4.1 development time frame to the master branch would have
> been prevented, I think, so it's certainly not that "they never fail".
>=20
> Second, yes, the basic idea was to start with a small set of tests in
> the auto group which was already working, and then to increase that set=

> over time, once other tests run more stable, too. But you know the
> iotests better than me, if you think that most of them can hardly
> brought into the right shape, then this was likely just wishful thinkin=
g
> by me.

I know that one never knows which test turns out to be unstable next.

>> You have to decide: Either let me deal with the problems, but then I
>> have every right to be egoistic about it =E2=80=93 or you help me deal=
 with them.
>=20
> Since I'm not assigned to the block layer, I could only help
> occasionally, so that's likely not enough for solving your frustration.=

> Thus I'll send a patch to remove the iotests from "make check" again.

OK.  Maybe someone else will step up once they see the patch.

Or can we have some middle ground?  Something that runs on some CI
systems (and notifies me and others) but won=E2=80=99t result in pull req=
uests
being rejected or cause make check failures?

Max


--Xl57g6QtlLxwbxInuaYzXUU5ChOW6BWsG--

--nagovlCt1fjBuaikWu2xr2jHOmdWa28Os
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2Up8sACgkQ9AfbAGHV
z0AJswgApf5EYsOnkpGBD8+Jj0sBDLJ0yaa4hDEe0aImt6m4SnZoYfNyh76uFjwo
jOASrTeC+OKgw6T17LrEnpMET17sJh5wkwct3eSHeouT4b5xWwQ2FGKRvwU/juP3
z5LA80F9J/4bgnuEYLSTTAHD1Yn6Zj5ERswTna4ZOMS+9Oqea/y9uZTAi5NLuEyZ
UM0epy8WSPb90HcTuCIYckNJG+p+aZN/xNOh24/4jpL7ljmJjA5RDBmcwQ0qMNTn
gmTVCXxZePvU/PI8Vq/8FbJ4MlqJ+9igmsrFeShbvx+xyWfNgi5InJPp2PUYUpJA
gyt3ym3C6UCD2ogSpsW9rfYOtEtpXQ==
=tR8g
-----END PGP SIGNATURE-----

--nagovlCt1fjBuaikWu2xr2jHOmdWa28Os--


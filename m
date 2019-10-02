Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC7DC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB72C20815
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB72C20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFikI-0007mB-14
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFiiz-0006fX-G1
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 13:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFiiy-000698-4k
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 13:47:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFiiu-00066r-6u; Wed, 02 Oct 2019 13:47:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 48CE78980EA;
 Wed,  2 Oct 2019 17:47:34 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9634B5D9D6;
 Wed,  2 Oct 2019 17:47:30 +0000 (UTC)
Subject: Re: [PATCH v5 1/5] iotests: remove 'linux' from default supported
 platforms
To: Kevin Wolf <kwolf@redhat.com>
References: <20190917234549.22910-1-jsnow@redhat.com>
 <20190917234549.22910-2-jsnow@redhat.com>
 <a252472e-842a-8401-2743-e4ed948b066b@redhat.com>
 <450a1f52-9589-cb98-88cb-1d3fcd5f506a@redhat.com>
 <778487c5-566e-d133-6395-d3908db66adc@redhat.com>
 <62cf912a-8ee9-d023-84c2-1ad6ea94e3b8@redhat.com>
 <16eef993-c16e-3fd7-c60d-6d3c7bfb5148@redhat.com>
 <20191002164438.GD5819@localhost.localdomain>
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
Message-ID: <a7f532cc-68cb-175e-6c8f-930401221ef9@redhat.com>
Date: Wed, 2 Oct 2019 19:47:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191002164438.GD5819@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4SAkzyN5kCnJiNEZZXSN0fWhmqMXROIRM"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Wed, 02 Oct 2019 17:47:34 +0000 (UTC)
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
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4SAkzyN5kCnJiNEZZXSN0fWhmqMXROIRM
Content-Type: multipart/mixed; boundary="XdGbjSEXcOHJfYIJZlShwBvfxzaq7rPcP"

--XdGbjSEXcOHJfYIJZlShwBvfxzaq7rPcP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.10.19 18:44, Kevin Wolf wrote:
> Not sure where in this thread to reply, but since my name is mentioned
> in this mail, it might at least be not the worst one.
>=20
> Am 02.10.2019 um 13:57 hat Max Reitz geschrieben:
>> On 02.10.19 06:46, Thomas Huth wrote:
>>> On 01/10/2019 20.44, Max Reitz wrote:
>>> [...]
>>>> As I have said, the conceptual problem is that the iotests now run a=
s
>>>> part of make check.  As such, allowing auto tests to run on non-Linu=
x
>>>> platforms may introduce build failures that I cannot do anything abo=
ut.
>>>
>>> Well, simply run "make vm-build-openbsd", "make vm-build-freebsd", ..=
=2E
>>> if something fails there, it likely should not be in the auto group.
>>
>> Then we come to Windows and macOS.
>>
>> What I=E2=80=99ve proposed to John on IRC was to simply skip the iotes=
ts in make
>> check for non-Linux systems.
>=20
> I think this really makes sense. Or at least have a blacklist of OSes
> that we can't support iotests on, which would contain at least Windows
> and OS X. Windows because I'm pretty sure that it doesn't work anyway,
> and OS X because if something fails there, we have no way to reproduce.=

> The occasional build failures on OS X that must be fixed by blindly
> guessing what could work without any way to test the fix are already ba=
d
> enough.
>=20
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
>=20
> I disagree. It happened all the time that someone else broke the iotest=
s
> in master and we needed to fix it up.

OK.

(In my experience, it=E2=80=99s still mostly block patches, only that the=
y tend
to go through non-block trees.)

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
> I think I may have implicitly consented by helping Alex with the change=
s
> to 'check' that made its output fit better in 'make check'.
>=20
> Basically, my stance is that I share your dislike for the effects on me=

> personally (also, I can't run 'make check' any more before a pull
> request without testing half of the iotests twice because I still need =
a
> full iotests run), but I also think that having iotests in 'make check'=

> is really the right thing for the project despite the inconvenience it
> means for me.

Then I expect you to NACK Thomas=E2=80=99s patch, and I take it to mean t=
hat I
can rely on you to handle basically all make check iotests failures that
are not caused by my own pull requests.

Works for me.

>> I know you=E2=80=99ll say that we just need to ensure we can add more =
tests,
>> then.  But for one thing, the most important tests are the ones that
>> take the longest, like 041.  And the other of course is that adding an=
y
>> more tests to make check just brings me more pain, so I won=E2=80=99t =
do it.
>=20
> That's something that can be fixed by tweaking the auto group.
>=20
> Can we run tests in 'auto' that require the system emulator? If so,
> let's add 030 040 041 to the default set. They take long, but they are
> among the most valuable tests we have. If this makes the tests take too=

> much time, let's remove some less important ones instead.
>=20
>> [1] There is the recent case of Kevin=E2=80=99s pull request having be=
en
>> rejected because his test failed on anything but x64.  I=E2=80=99m tor=
n here,
>> because I would have seen that failure on my -m32 build.  So it isn=E2=
=80=99t
>> like it would have evaded our view for long.
>=20
> I messed up, so this pull request was rightly stopped. I consider this
> one a feature, not a bug.

Sure, that was a good thing.  I just wonder whether that instance is
enough to justify the pain.

Max


--XdGbjSEXcOHJfYIJZlShwBvfxzaq7rPcP--

--4SAkzyN5kCnJiNEZZXSN0fWhmqMXROIRM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2U4rEACgkQ9AfbAGHV
z0A/fgf8DHaS7k+KP8B8jjI9JcroFZOadkXJ8rl/ROIlHtuPuflBRll5jKwvjcoO
pAyJeLcgzLbGuFbIDyr/GMsX38eHJFanfHigXJLVjAN6dGQ2KxQgaY21/0nsutEp
C/sLHRL6pKGwLKtZRu9p0xDgCZs3onquaqMhockdFvWO6N1I+Lp0RDAvx2zTJ72f
ufim1/HnmCZCtTWAj64qUYmASO4P9pRdN8znnNtw+a4Vcvvi2fz0O6hoq2ALtwWh
33iD6IFTQPCdXnVxuk0jGmv7TaJqfi4rDu2oLvEq07PLZ2BdTisU07vEUXdCGmna
iiY0vRl7wMa3Jca5HYuyLm58EsGQ0A==
=m2gV
-----END PGP SIGNATURE-----

--4SAkzyN5kCnJiNEZZXSN0fWhmqMXROIRM--


Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB137ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B833205F4
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B833205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHSWK-0008Cb-Ou
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 08:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iHSVf-0007gx-6B
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iHSVd-0002uz-Gr
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:53:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38820)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iHSVZ-0002to-FS; Mon, 07 Oct 2019 08:53:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 60F9F302C09F;
 Mon,  7 Oct 2019 12:53:00 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75C0A5D9CD;
 Mon,  7 Oct 2019 12:52:56 +0000 (UTC)
Subject: Re: [PATCH v5 1/5] iotests: remove 'linux' from default supported
 platforms
To: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20190917234549.22910-1-jsnow@redhat.com>
 <20190917234549.22910-2-jsnow@redhat.com>
 <a252472e-842a-8401-2743-e4ed948b066b@redhat.com>
 <450a1f52-9589-cb98-88cb-1d3fcd5f506a@redhat.com>
 <778487c5-566e-d133-6395-d3908db66adc@redhat.com>
 <62cf912a-8ee9-d023-84c2-1ad6ea94e3b8@redhat.com>
 <16eef993-c16e-3fd7-c60d-6d3c7bfb5148@redhat.com>
 <20191002164438.GD5819@localhost.localdomain>
 <a7f532cc-68cb-175e-6c8f-930401221ef9@redhat.com>
 <20191004101952.GC5491@linux.fritz.box>
 <d194e22c-7125-e558-0a80-131a28a87419@redhat.com>
 <e7d5cc8a-7a61-70a2-7efc-8f1af8e7a41f@redhat.com>
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
Message-ID: <8a6b9c09-70f2-e2cc-4c65-33375396d319@redhat.com>
Date: Mon, 7 Oct 2019 14:52:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <e7d5cc8a-7a61-70a2-7efc-8f1af8e7a41f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7tsn5E14og9eC7W4Lhm4H4P9D14jttjwi"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 07 Oct 2019 12:53:00 +0000 (UTC)
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7tsn5E14og9eC7W4Lhm4H4P9D14jttjwi
Content-Type: multipart/mixed; boundary="STcIKsg4HkZyLfQIgg8LOy5HoYROEt8hb"

--STcIKsg4HkZyLfQIgg8LOy5HoYROEt8hb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.10.19 14:16, Thomas Huth wrote:
> On 04/10/2019 14.44, Max Reitz wrote:
>> On 04.10.19 12:19, Kevin Wolf wrote:
>>> Am 02.10.2019 um 19:47 hat Max Reitz geschrieben:
>>>> On 02.10.19 18:44, Kevin Wolf wrote:
>>>>> Am 02.10.2019 um 13:57 hat Max Reitz geschrieben:
>>>>>> It usually worked fine for me because it=E2=80=99s rather rare tha=
t non-block
>>>>>> patches broke the iotests.
>>>>>
>>>>> I disagree. It happened all the time that someone else broke the io=
tests
>>>>> in master and we needed to fix it up.
>>>>
>>>> OK.
>>>>
>>>> (In my experience, it=E2=80=99s still mostly block patches, only tha=
t they tend
>>>> to go through non-block trees.)
>>>
>>> Fair enough, it's usually code that touches block code. I assumed "bl=
ock
>>> patches" to mean patches that go through one of the block trees and f=
or
>>> which iotests are run before sending a pull request.
>>>
>>> In the end, I don't care what code these patches touched. I do an
>>> innocent git pull, and when I finally see that it's master that break=
s
>>> iotests and not my patches on top of it, I'm annoyed.
>>
>> Hm.  Part of my point was that this still happens all the time.
>>
>> Which is why I=E2=80=99d prefer more tests to run in CI than a handful=
 of not
>> very useful ones in make check.
>=20
> Ok, so let's try to add some more useful test to the "auto" group. Kevi=
n
> mentioned 030, 040 and 041, and I think it should be ok to enable them
> (IIRC the only issue was that they run a little bit longer, but if they=

> are very useful, we should include them anyway).

I agree on those.  (Maybe not 040, but definitely 030 and 041.)

Maybe one of the issues was the =E2=80=9Cpath too long=E2=80=9D thing for=
 Unix sockets?

> Do you have any other tests in mind which could be very useful?

I=E2=80=99d like a test for iothreads, it doesn=E2=80=99t look like there=
 currently is
one in auto.  (The problem of course is that they have a higher chance
of being flaky, but I think they also have a higher probability of
breaking because of non-block stuff.)

127 and 256 look promising to me.


Also, I don=E2=80=99t see any migration tests in auto (156 doesn=E2=80=99=
t really count).

The ones that looks interesting here are 091, 181 (but I seem to
remember that 181 is flaky under load, I should investigate that), 183,
and 203 (which also tests iothreads).


Those are the two area that I spontaneously think of when considering
what is more likely to be broken by non-block patches.  Unfortunately,
those are also the two areas with the tests that tend to be the
flakiest, I guess...

> [...]
>>> So if you merge that revert, when iotests break in master, I take it =
I
>>> can rely on you to fix it up before it impacts my working branch?
>>
>> This is not a game, I=E2=80=99m talking purely from my standpoint:
>> (I talked wrongly, but more on that below)
>>
>> Whenever make check fails, it=E2=80=99s urgent.  Without iotests runni=
ng in make
>> check, we had some time to sort the situation out.  That=E2=80=99s no =
longer the
>> case.
>>
>> That means we need to take care of everything immediately.  And I pure=
ly
>> want help with that.
>=20
> While that sounds noble at a first glance, I think you've maybe got too=

> high expectations at yourself here? I mean, all other maintainers of
> other subsystems with tests have the same "problem" if the tests for
> their subsystem run in "make check".

The difference is that the iotests generally seem much less
deterministic to me than the other tests we have.

> The "normal" behavior that I've
> seen so far (and which I think is the right way to deal with it):
>=20
> 1) If a pull request gets rejected due to a "make check" failure, simpl=
y
> drop the offending patches from the pull request, send a v2 pull req
> without them, and tell the author of the offending patches to fix the
> problem (unless the fix is completely trivial and could immediately be
> applied to the v2 pull req). You really don't have to fix each and ever=
y
> issue on your own as a maintainer and can redirect this to the patch
> authors again.
>=20
> 2) If a test fails occasionally during "make check" (due to race
> conditions or whatever), it gets disabled from "make check" if it can't=

> be fixed easily (e.g. in the qtests it gets moved to the "SPEED=3Dslow"=

> category, or in iotests it would get removed from the "auto" group).

Well, we=E2=80=99ll see how it goes.  I suppose in practice it won=E2=80=99=
t be too big
of a problem to just temporarily remove tests from auto if the issue
isn=E2=80=99t clear immediately but the test does seem important.  (I don=
=E2=80=99t
think there=E2=80=99s too much danger of forgetting them.)

>>> Yes, making iotests stable on CI probably involves some pain, especia=
lly
>>> initially. However, if we don't fix them upstream, they'll end up on =
our
>>> desk again downstream because people run tests neither on your nor on=
 my
>>> laptop.
>>>
>>> I think we might actually save time by fixing them once and for all,
>>> even if they are problems in the test cases and not in QEMU, and maki=
ng
>>> new test cases portable from the start, instead of getting individual=

>>> reports one at a time and having to look at the same test cases again=

>>> and again.
>>
>> You should really know I=E2=80=99m all for that and that I=E2=80=99ve =
done my share of
>> work there.
>>
>> But from my perspective we=E2=80=99ve said and tried that for six year=
s and we
>> aren=E2=80=99t there still.  So to me =E2=80=9CWe should just fix it=E2=
=80=9D of course sounds
>> correct, but I also don=E2=80=99t believe it=E2=80=99ll happen any tim=
e soon.  Mostly
>> because we generally don=E2=80=99t know what to fix before it breaks, =
but also
>> because that=E2=80=99s exactly what we=E2=80=99ve tried to do for at l=
east six years.
>=20
> Well, I guess we won't ever get there if we don't try.

That was my point, that we have tried.  It isn=E2=80=99t like we=E2=80=99=
ve failed, it=E2=80=99s
just that it looks like a never-ending mission to me.

And it isn=E2=80=99t like I=E2=80=99m not working on improving the situat=
ion, even when
I=E2=80=99m saying that I don=E2=80=99t think it=E2=80=99ll ever be perfe=
ctly deterministic.

> And the hurdles
> will rather get higher over the years since more and more tests are
> added ...
>=20
>> OTOH, keeping the iotests in make check means we have to act on failur=
e
>> reports immediately.  For example, someone=E2=84=A2 needs to investiga=
te the 130
>> failure Peter has reported.  I=E2=80=99ve just replied =E2=80=9CI don=E2=
=80=99t know=E2=80=9D, CC=E2=80=99d
>> Thomas, and waited whether anyone else would do anything.  Nobody did,=

>> and that can=E2=80=99t work.  (I also wrote that I wouldn=E2=80=99t ac=
t on it, precisely
>> because I didn=E2=80=99t see the point.  I assumed that if anyone disa=
greed with
>> that statement, they would have said something.)
>>
>> So acting on such reports means pain, too.  I consider it greater than=

>> the previous kind of pain, because I prefer =E2=80=9CThis sucks, I=E2=80=
=99ll have to
>> fix it this week or so=E2=80=9D to =E2=80=9COh crap, I=E2=80=99ll have=
 to investigate now,
>> reproduce it, write an email as soon as possible, and fix it=E2=80=9D.=

>=20
> I think that "I have to investigate now ..." mindset is not the right
> way to handle these kind of issues. If a test is shaky and can not be
> fixed easily, we should simply disable it from the "auto" group again.
> So if you like, I can send a patch to remove 130 from the "auto" group
> (personally, I'd rather wait to see if it fails anytime soon again, or
> if this was maybe rather a one-time issue due to a non-clean test syste=
m
> ...)

Waiting for another failure sounds OK to me.  (OTOH, 130 doesn=E2=80=99t =
seem
like something that needs to be in auto, in case we want to take
something out to save time for more important tests.)

But that reminds me that iotest failures probably should be
automatically signaled to me and Kevin instead of Peter having to write
an email himself.  Would that be possible?

Max


--STcIKsg4HkZyLfQIgg8LOy5HoYROEt8hb--

--7tsn5E14og9eC7W4Lhm4H4P9D14jttjwi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2bNSYACgkQ9AfbAGHV
z0BkxQf/c9sVnIuvULRCsGDAS3aUfeCWqHn1Wyjul39HxL3RypBmy9twVRhAGm/R
H6vJjI4MTf9CDP403kehuF+hPeYKvAh+sFdE40ks0lRwJmyzLYfx4bdjJk+qwdPz
V38fKT2klBq+ttoh44cAVvGUC80wxzBpBYZY2NnJg+H0cRurTYNz6UJRn3P8AVzo
B4vTYbjkpBNUI3RNkg36ud7O18PSDQI60AigyIYY2hQtg4p3NrBuFu420tW+AAiE
ngelM3OnJkDTz3Z+wvbBiU0+Oyr72tHG6EW3VRumrwSQX67csngXyRYl4OvWPVsE
Zpg+kEctNOakHVDSlQyoIb9dXZnMXg==
=MopJ
-----END PGP SIGNATURE-----

--7tsn5E14og9eC7W4Lhm4H4P9D14jttjwi--


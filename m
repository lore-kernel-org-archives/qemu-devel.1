Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2DCC47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDCB720862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCB720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGMxe-0008QR-TT
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 08:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iGMwS-0007qh-OX
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iGMwQ-0004hO-Kp
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:44:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iGMwM-0004Yz-J7; Fri, 04 Oct 2019 08:44:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E5CB92D1CE;
 Fri,  4 Oct 2019 12:44:08 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-31.brq.redhat.com
 [10.40.204.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B05E919C5B;
 Fri,  4 Oct 2019 12:44:04 +0000 (UTC)
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
 <a7f532cc-68cb-175e-6c8f-930401221ef9@redhat.com>
 <20191004101952.GC5491@linux.fritz.box>
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
Message-ID: <d194e22c-7125-e558-0a80-131a28a87419@redhat.com>
Date: Fri, 4 Oct 2019 14:44:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191004101952.GC5491@linux.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4HniRnEymN8DNuz24afMHX6kkS6iNIz9U"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 04 Oct 2019 12:44:08 +0000 (UTC)
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
--4HniRnEymN8DNuz24afMHX6kkS6iNIz9U
Content-Type: multipart/mixed; boundary="VhgnGrFRQ9QJgclaJyUN354vKWLpWi6Au"

--VhgnGrFRQ9QJgclaJyUN354vKWLpWi6Au
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.10.19 12:19, Kevin Wolf wrote:
> Am 02.10.2019 um 19:47 hat Max Reitz geschrieben:
>> On 02.10.19 18:44, Kevin Wolf wrote:
>>> Am 02.10.2019 um 13:57 hat Max Reitz geschrieben:
>>>> It usually worked fine for me because it=E2=80=99s rather rare that =
non-block
>>>> patches broke the iotests.
>>>
>>> I disagree. It happened all the time that someone else broke the iote=
sts
>>> in master and we needed to fix it up.
>>
>> OK.
>>
>> (In my experience, it=E2=80=99s still mostly block patches, only that =
they tend
>> to go through non-block trees.)
>=20
> Fair enough, it's usually code that touches block code. I assumed "bloc=
k
> patches" to mean patches that go through one of the block trees and for=

> which iotests are run before sending a pull request.
>=20
> In the end, I don't care what code these patches touched. I do an
> innocent git pull, and when I finally see that it's master that breaks
> iotests and not my patches on top of it, I'm annoyed.

Hm.  Part of my point was that this still happens all the time.

Which is why I=E2=80=99d prefer more tests to run in CI than a handful of=
 not
very useful ones in make check.

(Of course, running it in a CI won=E2=80=99t prevent iotest failures on y=
our
machine, but in practice neither does the current model.)

>>>> Maybe my main problem is that I feel like now I have to deal with al=
l of
>>>> the fallout, even though adding the iotests to make check wasn=E2=80=
=99t my idea
>>>> and neither me nor Kevin ever consented.  (I don=E2=80=99t know whet=
her Kevin
>>>> consented implicitly, but I don=E2=80=99t see his name in bdd95e4784=
4f2d8b.)
>>>>
>>>> You can=E2=80=99t just give me more responsibility without my consen=
t and then
>>>> call me egoistic for not liking it.
>>>
>>> I think I may have implicitly consented by helping Alex with the chan=
ges
>>> to 'check' that made its output fit better in 'make check'.
>>>
>>> Basically, my stance is that I share your dislike for the effects on =
me
>>> personally (also, I can't run 'make check' any more before a pull
>>> request without testing half of the iotests twice because I still nee=
d a
>>> full iotests run),

-x auto for the qcow2 pass, by the way.

>>> but I also think that having iotests in 'make check'
>>> is really the right thing for the project despite the inconvenience i=
t
>>> means for me.
>>
>> Then I expect you to NACK Thomas=E2=80=99s patch, and I take it to mea=
n that I
>> can rely on you to handle basically all make check iotests failures th=
at
>> are not caused by my own pull requests.
>>
>> Works for me.
>=20
> Ah, we can also play this game the other way round.
>=20
> So if you merge that revert, when iotests break in master, I take it I
> can rely on you to fix it up before it impacts my working branch?

This is not a game, I=E2=80=99m talking purely from my standpoint:
(I talked wrongly, but more on that below)

Whenever make check fails, it=E2=80=99s urgent.  Without iotests running =
in make
check, we had some time to sort the situation out.  That=E2=80=99s no lon=
ger the
case.

That means we need to take care of everything immediately.  And I purely
want help with that.  I just did not have the impression that such help
was there in the past months.
(This impression may or may not have a correlation to reality.)

I thought that was just because nobody really cared about the iotests in
make check.  Now you say you do, so that=E2=80=99s why I said you should =
NACK
the revert and then I know that I can count on your help.


Now where I was wrong: I didn=E2=80=99t say =E2=80=9Cyour help=E2=80=9D b=
ut =E2=80=9Cyou handle it=E2=80=9D.
That was wrong.  I=E2=80=99m sorry.  That would mean I reap all the benef=
its and
you have to pay the price.


What I=E2=80=99m not so sure of is why you didn=E2=80=99t just say that=E2=
=80=99s unfair and
instead reply with an impossible suggestion.  That makes it a bit
difficult for me to find out exactly what you plan to do.

I take your point as =E2=80=9CExactly, this suggestion would be impossibl=
e.
With the tests in make check, the worst that happens is CI breakage and
rejected pull requests, and dealing with those is very much possible.=E2=80=
=9D[1]

As I=E2=80=99ve said, my POV is different, because I find CI breakage, ma=
ke
check breakage, and rejected pull requests to be worse because those are
failures on other people=E2=80=99s machines.  That puts me personally und=
er much
more stress than failures on my own machine.  But it seems that you feel
differently.

[1] Or maybe you wanted to say that you find a rare intermittent failure
that slips into make check less worse than 100 % failure of some test
for everyone who runs the iotests.  I don=E2=80=99t know.
I know that the 100 % failures are annoying but generally easily fixed;
whereas the intermittent ones are the ones that stick and hard to fix.
And those intermittent ones are unlikely to cause pull requests to be
rejected.

>>>> I know you=E2=80=99ll say that we just need to ensure we can add mor=
e tests,
>>>> then.  But for one thing, the most important tests are the ones that=

>>>> take the longest, like 041.  And the other of course is that adding =
any
>>>> more tests to make check just brings me more pain, so I won=E2=80=99=
t do it.
>>>
>>> That's something that can be fixed by tweaking the auto group.
>>>
>>> Can we run tests in 'auto' that require the system emulator? If so,
>>> let's add 030 040 041 to the default set. They take long, but they ar=
e
>>> among the most valuable tests we have. If this makes the tests take t=
oo
>>> much time, let's remove some less important ones instead.
>>>
>>>> [1] There is the recent case of Kevin=E2=80=99s pull request having =
been
>>>> rejected because his test failed on anything but x64.  I=E2=80=99m t=
orn here,
>>>> because I would have seen that failure on my -m32 build.  So it isn=E2=
=80=99t
>>>> like it would have evaded our view for long.
>>>
>>> I messed up, so this pull request was rightly stopped. I consider thi=
s
>>> one a feature, not a bug.
>>
>> Sure, that was a good thing.  I just wonder whether that instance is
>> enough to justify the pain.
>=20
> Yes, making iotests stable on CI probably involves some pain, especiall=
y
> initially. However, if we don't fix them upstream, they'll end up on ou=
r
> desk again downstream because people run tests neither on your nor on m=
y
> laptop.
>=20
> I think we might actually save time by fixing them once and for all,
> even if they are problems in the test cases and not in QEMU, and making=

> new test cases portable from the start, instead of getting individual
> reports one at a time and having to look at the same test cases again
> and again.

You should really know I=E2=80=99m all for that and that I=E2=80=99ve don=
e my share of
work there.

But from my perspective we=E2=80=99ve said and tried that for six years a=
nd we
aren=E2=80=99t there still.  So to me =E2=80=9CWe should just fix it=E2=80=
=9D of course sounds
correct, but I also don=E2=80=99t believe it=E2=80=99ll happen any time s=
oon.  Mostly
because we generally don=E2=80=99t know what to fix before it breaks, but=
 also
because that=E2=80=99s exactly what we=E2=80=99ve tried to do for at leas=
t six years.


So, hm.  I don=E2=80=99t quite know where we=E2=80=99re going.

I still think that I personally would prefer the iotests to not run as
part of make check, but just as CI.

You do have a point that dropping the iotests from make check would
benefit me at your expense.  (Well, it=E2=80=99d be the same result for b=
oth of
us, it just appears that we have different perceptions of pain.)

OTOH, keeping the iotests in make check means we have to act on failure
reports immediately.  For example, someone=E2=84=A2 needs to investigate =
the 130
failure Peter has reported.  I=E2=80=99ve just replied =E2=80=9CI don=E2=80=
=99t know=E2=80=9D, CC=E2=80=99d
Thomas, and waited whether anyone else would do anything.  Nobody did,
and that can=E2=80=99t work.  (I also wrote that I wouldn=E2=80=99t act o=
n it, precisely
because I didn=E2=80=99t see the point.  I assumed that if anyone disagre=
ed with
that statement, they would have said something.)

So acting on such reports means pain, too.  I consider it greater than
the previous kind of pain, because I prefer =E2=80=9CThis sucks, I=E2=80=99=
ll have to
fix it this week or so=E2=80=9D to =E2=80=9COh crap, I=E2=80=99ll have to=
 investigate now,
reproduce it, write an email as soon as possible, and fix it=E2=80=9D.

But at least we=E2=80=99ll all have this pain as long as we share it.  An=
d then
it might not be so bad.

Max


--VhgnGrFRQ9QJgclaJyUN354vKWLpWi6Au--

--4HniRnEymN8DNuz24afMHX6kkS6iNIz9U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2XPpMACgkQ9AfbAGHV
z0DaPQf/WKLqcZwSFlGg0SfA5RXGyyMCQxZih4IxF2L00CqhdF2e9JnTsyoKVGrA
4fuPMCgNhIlImLpM24zd9hLD4Px4Yg6dCUQBlbYFQdHszAsSgkPoi+zyQFCSQ/4M
cq0bJMQFQfvj8Gf1Ls0BJwgf/J4gfcz8xhk9isDUVQnTMslqQ4QTOjDcHvIMK0yT
D3thL+mfu8Yaoybetfo8tuFcpRYfm0cd3uMgJ7Jk8611QxARwk6SCC5sUq1c8SXy
jp7w8N7Ejt4CwS9lZGJvnzfIEAZ+DcQ2ITUKb6iPpVvkYSqzGOyopfIr4bMcr1wD
yNcXJtjTR8HfJB12anrfV8GA9negkg==
=Jdr3
-----END PGP SIGNATURE-----

--4HniRnEymN8DNuz24afMHX6kkS6iNIz9U--


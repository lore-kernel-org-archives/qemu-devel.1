Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6242ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C39920B7C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C39920B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFNAG-0006yG-Bc
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 14:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFN8k-0006IZ-N5
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFN8j-0000s4-Ep
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:44:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFN8e-0000om-H3; Tue, 01 Oct 2019 14:44:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BD15E79705;
 Tue,  1 Oct 2019 18:44:43 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 547403795;
 Tue,  1 Oct 2019 18:44:42 +0000 (UTC)
Subject: Re: [PATCH v5 1/5] iotests: remove 'linux' from default supported
 platforms
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190917234549.22910-1-jsnow@redhat.com>
 <20190917234549.22910-2-jsnow@redhat.com>
 <a252472e-842a-8401-2743-e4ed948b066b@redhat.com>
 <450a1f52-9589-cb98-88cb-1d3fcd5f506a@redhat.com>
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
Message-ID: <778487c5-566e-d133-6395-d3908db66adc@redhat.com>
Date: Tue, 1 Oct 2019 20:44:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <450a1f52-9589-cb98-88cb-1d3fcd5f506a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0XZoN5poPQQpPhV96g1LJJfaGpIOC6Ng1"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 01 Oct 2019 18:44:43 +0000 (UTC)
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
--0XZoN5poPQQpPhV96g1LJJfaGpIOC6Ng1
Content-Type: multipart/mixed; boundary="aY2Z2ExwnvBjLI5hAk51RKIbg4oUGzbMk"

--aY2Z2ExwnvBjLI5hAk51RKIbg4oUGzbMk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.09.19 01:35, John Snow wrote:
>=20
>=20
> On 9/23/19 9:09 AM, Max Reitz wrote:
>> On 18.09.19 01:45, John Snow wrote:
>>> verify_platform will check an explicit whitelist and blacklist instea=
d.
>>> The default will now be assumed to be allowed to run anywhere.
>>>
>>> For tests that do not specify their platforms explicitly, this has th=
e effect of
>>> enabling these tests on non-linux platforms. For tests that always sp=
ecified
>>> linux explicitly, there is no change.
>>>
>>> For Python tests on FreeBSD at least; only seven python tests fail:
>>> 045 147 149 169 194 199 211
>>>
>>> 045 and 149 appear to be misconfigurations,
>>> 147 and 194 are the AF_UNIX path too long error,
>>> 169 and 199 are bitmap migration bugs, and
>>> 211 is a bug that shows up on Linux platforms, too.
>>>
>>> This is at least good evidence that these tests are not Linux-only. I=
f
>>> they aren't suitable for other platforms, they should be disabled on =
a
>>> per-platform basis as appropriate.
>>>
>>> Therefore, let's switch these on and deal with the failures.
>>
>> What exactly do you mean by =E2=80=9Cdeal with the failures=E2=80=9D? =
 Do you have a
>> reference to patches that deal with them, or are you or is someone els=
e
>> working on them...?
>>
>> Apart from that, I am rather hesitant to take a patch through my tree
>> that not only may cause test failures on platforms that I will not or
>> actually cannot run tests on (like MacOS or Windows), but that actuall=
y
>> does introduce new failures as you describe.
>>
>> Well, at least it doesn=E2=80=99t introduce build failures because it =
appears
>> there is no Python test that=E2=80=99s in the auto group, so I suppose=
 =E2=80=9Crather
>> hesitant=E2=80=9D is not an =E2=80=9CI won=E2=80=99t=E2=80=9D.
>>
>=20
> Think of it more like this: The failures were always there, but we hid
> them. I'm not "introducing new failures" as such O:-)

That is incorrect.

As I have said, the conceptual problem is that the iotests now run as
part of make check.  As such, allowing auto tests to run on non-Linux
platforms may introduce build failures that I cannot do anything about.

And those are very much new failures.

> I think that I have demonstrated sufficiently that it's not correct to
> prohibit python tests from running on other platforms wholesale, so I'd=

> prefer we don't do that anymore.

You have not.

The actual argument to convince me is =E2=80=9CThis does not affect any t=
ests in
the auto group, so it will not introduce build failures at this time=E2=80=
=9D.

> Further, iotests on FreeBSD already weren't 100% green, so I'm not
> causing a regression in that sense, either.

My problem is twofold:

(1) You claim =E2=80=9CSure, there are failures, but let=E2=80=99s just d=
eal with them=E2=80=9D
and then you do not deal with them.  Seems wrong to me.

I=E2=80=99m fine with the argument =E2=80=9CSorry, royal =E2=80=98we=E2=80=
=99.  But it just doesn=E2=80=99t help
anyone to hide the errors.  If someone=E2=80=99s on BSD and wants to run =
the
iotests, let them.=E2=80=9D

That sounds good to me.

(2) Maybe someone adds a Python test in the future that is in auto and
that does not specify Linux as the only supported platform.  Then I send
a pull request and it breaks on macOS.  Now what?  Remove it from auto?
 Blindly put "macOS" in unsupported platforms?

In any case, it=E2=80=99ll be a problem for no good reason.

More on that in the next chunk.

> I'm going to meekly push and ask that we stage this as-is, and when
> something bad happens you can remind me that I wanted this and make me
> do it.

Make you do what?  Deal with the fact that a pull request is rejected
because a test fails on macOS?

This is precisely the kind of problem I already had with adding the
iotests to make check, and I=E2=80=99m already very much not happy about =
it.
(In that case it was $DISPLAY not being set on Peter=E2=80=99s test syste=
m.)


I=E2=80=99ll let you make the deduction of =E2=80=9CThe problem isn=E2=80=
=99t allowing the
iotests to run on non-Linux platforms, but the fact that they run in
make check=E2=80=9D yourself, so that I no longer feel like I=E2=80=99m t=
he only one who
considers that having been a mistake.

Max


--aY2Z2ExwnvBjLI5hAk51RKIbg4oUGzbMk--

--0XZoN5poPQQpPhV96g1LJJfaGpIOC6Ng1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2TnpgACgkQ9AfbAGHV
z0AYywf8CDVo6NhUJjbqptFlbVwl8wU7YIdHzG4oWUtNBF+9bFqCMRD7e99UqzFQ
xl4MKywVd798KkkTdXltiD2DWCIPUy27/kKPg9mI2ps6AAiPIkkmj2AWGyhRCBXS
alG/Htj54Nctw+FTc8RTMigJq28D/vIXQoJNmxuVKZIhNZRdtUbDpkhaMOhJ6FnD
V8j5DqD0ncDMnN5etfuQutuWWgJrqbJesQuHT/MCA6j3P77e1U1IgVWAUSSCAHe/
G7ObPwcxdiTqGTnc1b19BSg4zsPNX138AV+MmO7ohcnOJsWI8IEGc9MMSSLUT1jW
oh0TlySG8HX/5n9fCMiAwtI31sxbFg==
=xtvP
-----END PGP SIGNATURE-----

--0XZoN5poPQQpPhV96g1LJJfaGpIOC6Ng1--


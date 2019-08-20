Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B66C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F992339F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F992339F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i09nT-0005MM-7D
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 15:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i09jg-0002tx-Hl
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 15:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i09jd-0005M8-PL
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 15:24:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42182)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i09jY-0005K9-HU; Tue, 20 Aug 2019 15:23:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7DC5F19562B3;
 Tue, 20 Aug 2019 19:23:55 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B76210016F3;
 Tue, 20 Aug 2019 19:23:53 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
References: <20190819075348.4078-1-thuth@redhat.com>
 <5e753b9d-dd21-ce31-7f5c-7bc68c39cd2e@redhat.com>
 <8e0ff9ce-c770-6ff6-3e41-494fef4bd40a@redhat.com>
 <b35ee5a6-e3b1-d134-0a28-bfd45f5c8de4@redhat.com>
 <77f00bba-ce4b-ec6e-e48c-89ea797f3cd3@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
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
Message-ID: <016f26bf-b00b-5456-4db9-7cdf0cf35535@redhat.com>
Date: Tue, 20 Aug 2019 21:23:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <77f00bba-ce4b-ec6e-e48c-89ea797f3cd3@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1bJWVlcDoH6AFfquiTQzXsaskEVL7Ufgx"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Tue, 20 Aug 2019 19:23:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] iotests: Check for enabled drivers before
 testing them
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1bJWVlcDoH6AFfquiTQzXsaskEVL7Ufgx
Content-Type: multipart/mixed; boundary="DvaJnPGoP9TyJMk2ZIa1GQw5Z7UqJV3wq";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <016f26bf-b00b-5456-4db9-7cdf0cf35535@redhat.com>
Subject: Re: [PATCH] iotests: Check for enabled drivers before testing them
References: <20190819075348.4078-1-thuth@redhat.com>
 <5e753b9d-dd21-ce31-7f5c-7bc68c39cd2e@redhat.com>
 <8e0ff9ce-c770-6ff6-3e41-494fef4bd40a@redhat.com>
 <b35ee5a6-e3b1-d134-0a28-bfd45f5c8de4@redhat.com>
 <77f00bba-ce4b-ec6e-e48c-89ea797f3cd3@redhat.com>
In-Reply-To: <77f00bba-ce4b-ec6e-e48c-89ea797f3cd3@redhat.com>

--DvaJnPGoP9TyJMk2ZIa1GQw5Z7UqJV3wq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.08.19 21:19, Thomas Huth wrote:
> On 8/20/19 8:48 PM, Max Reitz wrote:
>> On 20.08.19 18:01, Thomas Huth wrote:
> [...]
>>> Well, we disable blkverify in our downstream RHEL version of QEMU - s=
o
>>> it would be great if the iotests could at least adapt to that missing=

>>> driver.
>>
>> I would like to say that RHEL is not a gold standard
>=20
> Well, let's put it this way: The less changes we have to carry along
> downstream (and thus review each time we rebase the downstream tree),
> the more time we have to work on upstream.

As I said, I=E2=80=99m guilty myself.

>> It feels a bit weird to me to say =E2=80=9Cblkverify is not essential,=
 because
>> RHEL disables it, but null-co is=E2=80=9D =E2=80=93 even though there =
is no reason why
>> anyone would need null-co except for testing either.
>=20
> Ok, fine for me, too, if we also declare "null-co" as optional for the
> iotests - let's make sure that the tests in the "auto" group also work
> without them.

Well, should we or not?  You said there are other tests (outside of the
iotests) that break without null-co.  If so, I don=E2=80=99t think there=E2=
=80=99s any
point in making it optional here.

>>>> Of course, that no longer works as an argument now that we
>>>> unconditionally run some iotests in make check.
>>>>
>>>> But still, the question is how strict you want to be.  If blkdebug
>>>> cannot be assumed to be present, what about null-co?  What about raw=
?
>>>
>>> I tried to disable everything beside qcow2 - but that causes so many
>>> things to fail that it hardly makes sense to try to get that working.=

>>
>> Hm, really?  I just whitelisted qcow2 and file and running the auto
>> group worked rather well (except for the failing tests you address her=
e,
>> and the two others I mentioned).
>=20
> IIRC I tried to run all qcow2 tests when I disabled null-co and saw lot=
s
> of failures ... but anyway, let's just focus on the "auto" tests right
> now, that should be doable.

OK, I didn=E2=80=99t bother running all. :-)

Max


--DvaJnPGoP9TyJMk2ZIa1GQw5Z7UqJV3wq--

--1bJWVlcDoH6AFfquiTQzXsaskEVL7Ufgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1cSMgACgkQ9AfbAGHV
z0CJ/Af/QN0Pl79k8Z4SP2MchJ6jLmiXZ83bGaI7VTLjw0jHPy+nbUnF9BeGNmY9
3oC3/ct2KR07V6/s/QMa50wI21PP6Pp6oDbePgjOXGOP8LyKmXlwuBzlgswALFfU
O/iJJEVk4f4Y8UnTjzAtJMH/GxKgW6OV9o71mPE2dEzUeT0Z0FKFiWVQ0lzNJI6r
dmFb/IZO1stL5gc1BzrK6C3EVQGUx4hlhPXz++4xODGNbM/viDvr0+75hEtShB0z
5ag7I9VuDDMoWVHbgqbSrWwGJOqAh+PU5PmqiW+TkyLB41gG0vdINHmItMZGICMo
uxy3SKv0llXob2USHiKFb1DuaXHrcA==
=YAuP
-----END PGP SIGNATURE-----

--1bJWVlcDoH6AFfquiTQzXsaskEVL7Ufgx--


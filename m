Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606C5C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358652084B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358652084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYL8-0004Gf-BV
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 08:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55680)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlYKL-0003ld-Ep
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlYKK-0002PG-8w
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:37:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42446)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlYKH-0002I0-6i; Thu, 11 Jul 2019 08:37:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B02EB3083392;
 Thu, 11 Jul 2019 12:37:27 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A0925C559;
 Thu, 11 Jul 2019 12:37:23 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190710010556.32365-1-jsnow@redhat.com>
 <20190710010556.32365-9-jsnow@redhat.com>
 <8147a871-906b-2e97-86c1-fd8f32218960@redhat.com>
 <ec327b5f-bb53-61f7-19b6-f723c56ee09a@redhat.com>
 <5ff7f740-f96d-928c-c88b-d3c277a7c944@redhat.com>
 <2f221513-f173-8d9f-a3b2-d790ef6f6f51@redhat.com>
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
Message-ID: <ebe52b87-88ab-76a6-5581-f216c5860454@redhat.com>
Date: Thu, 11 Jul 2019 14:37:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2f221513-f173-8d9f-a3b2-d790ef6f6f51@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HXouJY2haJJwDqLK8slxJaAJkBFQ8uADz"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 11 Jul 2019 12:37:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 8/8] iotests/257: test traditional sync
 modes
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HXouJY2haJJwDqLK8slxJaAJkBFQ8uADz
Content-Type: multipart/mixed; boundary="epZ7S9v8BbhEQFyjLFpAlOoyqqUfktD7T";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <ebe52b87-88ab-76a6-5581-f216c5860454@redhat.com>
Subject: Re: [PATCH 8/8] iotests/257: test traditional sync modes
References: <20190710010556.32365-1-jsnow@redhat.com>
 <20190710010556.32365-9-jsnow@redhat.com>
 <8147a871-906b-2e97-86c1-fd8f32218960@redhat.com>
 <ec327b5f-bb53-61f7-19b6-f723c56ee09a@redhat.com>
 <5ff7f740-f96d-928c-c88b-d3c277a7c944@redhat.com>
 <2f221513-f173-8d9f-a3b2-d790ef6f6f51@redhat.com>
In-Reply-To: <2f221513-f173-8d9f-a3b2-d790ef6f6f51@redhat.com>

--epZ7S9v8BbhEQFyjLFpAlOoyqqUfktD7T
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.07.19 05:21, John Snow wrote:
>=20
> On 7/10/19 4:46 PM, Max Reitz wrote:
>> On 10.07.19 21:00, John Snow wrote:
>>> On 7/10/19 1:14 PM, Max Reitz wrote:
>>>> On 10.07.19 03:05, John Snow wrote:
>>>>
>>>> Hm.  How useful is bitmap support for 'top' then, anyway?  That mean=
s
>>>> that if you want to resume a top backup, you always have to resume i=
t
>>>> like it was a full backup.  Which sounds kind of useless.
>>>>
>>>> Max
>>>>
>>>
>>> Good point!
>>>
>>> I think this can be fixed by doing an initialization pass of the
>>> copy_bitmap when sync=3Dtop to set only the allocated regions in the =
bitmap.
>>>
>>> This means that the write notifier won't copy out regions that are
>>> written to that weren't already in the top layer. I believe this is
>>> actually a bugfix; the data we'd copy out in such cases is actually i=
n
>>> the backing layer and shouldn't be copied with sync=3Dtop.
>>
>> Now that you mention it...  I didn=E2=80=99t realize that.  Yes, you=E2=
=80=99re right.
>>
>>> So this would have two effects:
>>> (1) sync=3Dtop gets a little more judicious about what it copies out =
on
>>> sync=3Dtop, and
>>> (2) the bitmap return value is more meaningful again.
>>>
>=20
> This might be harder than I first thought.
>=20
> initializing the copy_bitmap generally happens before we install the
> write notifier, which means that it occurs before the first yield.
>=20
> However, checking the allocation status can potentially be very slow,
> can't it? I can't just hog the thread while I check.

I was thinking about that myself.  It isn=E2=80=99t that bad, because you=
 aren=E2=80=99t
doing the full block_status dance but just checking allocation status,
which is reasonably quick (it just needs to look at the image format
metadata, it doesn=E2=80=99t go down to the protocol layer).

But it=E2=80=99s probably not so good to halt the monitor for this, yes.

> There are ways to cooperatively process write notifier interrupts and
> continue to check allocated status once we enter the main loop, but the=

> problem there becomes: if we fail early, how can we tell if the backup
> is worth resuming?
>=20
> We might not have reached a convergence point for the copy_bitmap befor=
e
> we failed, and still have a lot of extra bits set.

Is that so bad?

> I suppose at least in the case where we aren't trying to save the
> copy_bitmap and need it to mean something specific, this is a reasonabl=
e
> approach to fixing sync=3DTOP.
>=20
> As far as resume is concerned, I don't think I have good ideas. I could=

> emit an event or something if you're using sync=3Dtop with a bitmap for=

> output, but that feels *so* specialized for a niche(?) command that I
> don't know if it's worth pursuing.
>=20
> (Plus, even then, what do you do if it fails before you see that event?=

> You just have to give up on what we copied out? That seems like a waste=

> and not the point of this exercise.)

Before that event, the bitmap can still be usable, as long as all
=E2=80=9Cunknown=E2=80=9D areas are set to dirty.  Sure, your resumed bac=
kup will then
copy too much data.  But who cares.

So I don=E2=80=99t think you even need an event.

> The only way I can think of at all to get a retry on sync=3Dtop is to t=
ake
> an always policy, and to allow a special invocation with something like=

> mode=3Dbitmap+top:

Yes, that was my first idea, too.  But I didn=E2=80=99t even write about =
it,
because of...

> "Assume we need to copy anything set in the bitmap, unless it's not in
> the top layer, and then skip it."
>=20
> Which seems awful, because it would be a specialty mode for the
> exclusive purpose of re-trying sync=3Dtop backups.

=2E..exactly this.

> Meh.

I don=E2=80=99t think it=E2=80=99s all that bad.

Max


--epZ7S9v8BbhEQFyjLFpAlOoyqqUfktD7T--

--HXouJY2haJJwDqLK8slxJaAJkBFQ8uADz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0nLYEACgkQ9AfbAGHV
z0BGHwgAkcARgtUaNF8Zxk6lvjUunL8E2zaqbK9jHb2xDemCZHDc+Q8GgTNwvU34
sIHLo3FiJIUnC8Gp/sCM6c31wUzMn5My0Tu+THiXZjSEfNBUNq5RGXZV0jyZP38N
GUj41Wxd/bOugqUTxqG0FdMhn1B2SGuWt2jzTrTotqRU8InQYIlJ8LsDDyOTC8zE
XE0bTqzgj3Y/NRgjRHzcTRXqTwTyy7tgjILv1OWeueCAOGk/51LaiPPKHzNXYxFI
UQiUSPIrrWJO5/0n8UX7AoJBNZKeSGzJ9VyFHcIYp0wKVFMR73xKEAOodS7W96fj
+X9Es8HNdPCUovLqx39Z9+Qzqqb7yg==
=p+VG
-----END PGP SIGNATURE-----

--HXouJY2haJJwDqLK8slxJaAJkBFQ8uADz--


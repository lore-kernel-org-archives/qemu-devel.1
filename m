Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13ED6C41514
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 11:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07AE20679
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 11:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07AE20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hub8T-00050Y-8B
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 07:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55219)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hub83-0004Mu-FH
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 07:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hub82-0000A7-62
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 07:26:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55922)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hub7z-000073-6I; Mon, 05 Aug 2019 07:26:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BAF1F300BC7E;
 Mon,  5 Aug 2019 11:26:09 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5706160605;
 Mon,  5 Aug 2019 11:26:04 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190802185830.74648-1-vsementsov@virtuozzo.com>
 <815da22c-e88e-e813-d342-9ad14191d052@redhat.com>
 <c360e5b3-b0cf-bc18-891c-23fe71553652@virtuozzo.com>
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
Message-ID: <ffa94076-5e9c-2e02-e6d0-7e873569de34@redhat.com>
Date: Mon, 5 Aug 2019 13:26:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c360e5b3-b0cf-bc18-891c-23fe71553652@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aJk7vWUGPqMpGNyr3UeC0Mvh7WQeTh9Ik"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 05 Aug 2019 11:26:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] util/hbitmap: fix unaligned reset
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aJk7vWUGPqMpGNyr3UeC0Mvh7WQeTh9Ik
Content-Type: multipart/mixed; boundary="SwNJAI8txZmUf36aRnwLSSrz2og7EPIeP";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jsnow@redhat.com" <jsnow@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <ffa94076-5e9c-2e02-e6d0-7e873569de34@redhat.com>
Subject: Re: [PATCH] util/hbitmap: fix unaligned reset
References: <20190802185830.74648-1-vsementsov@virtuozzo.com>
 <815da22c-e88e-e813-d342-9ad14191d052@redhat.com>
 <c360e5b3-b0cf-bc18-891c-23fe71553652@virtuozzo.com>
In-Reply-To: <c360e5b3-b0cf-bc18-891c-23fe71553652@virtuozzo.com>

--SwNJAI8txZmUf36aRnwLSSrz2og7EPIeP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.08.19 11:45, Vladimir Sementsov-Ogievskiy wrote:
> 03.08.2019 0:19, Max Reitz wrote:
>> On 02.08.19 20:58, Vladimir Sementsov-Ogievskiy wrote:
>>> hbitmap_reset is broken: it rounds up the requested region. It leads =
to
>>> the following bug, which is shown by fixed test:
>>>
>>> assume granularity =3D 2
>>> set(0, 3) # count becomes 4
>>> reset(0, 1) # count becomes 2
>>>
>>> But user of the interface assume that virtual bit 1 should be still
>>> dirty, so hbitmap should report count to be 4!
>>>
>>> In other words, because of granularity, when we set one "virtual" bit=
,
>>> yes, we make all "virtual" bits in same chunk to be dirty. But this
>>> should not be so for reset.
>>>
>>> Fix this, aligning bound correctly.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>
>>> Hi all!
>>>
>>> Hmm, is it a bug or feature? :)
>>> I don't have a test for mirror yet, but I think that sync mirror may =
be broken
>>> because of this, as do_sync_target_write() seems to be using unaligne=
d reset.
>>
>> Crap.
>>
>>
>> Yes, you=E2=80=99re right.  This would fix it, and it wouldn=E2=80=99t=
 fix it in the
>> worst way.
>>
>> But I don=E2=80=99t know whether this patch is the best way forward st=
ill.  I
>> think call hbitmap_reset() with unaligned boundaries generally calls f=
or
>> trouble, as John has laid out.  If mirror=E2=80=99s do_sync_target_wri=
te() is
>> the only offender right now, I=E2=80=99d prefer for hbitmap_reset() to=
 assert
>> that the boundaries are aligned (for 4.2),
>=20
> OK, agree that asserting this is better.
>=20
>   and for
>> do_sync_target_write() to be fixed (for 4.1? :-/).
>>
>> (A practical problem with this patch is that do_sync_target_write() wi=
ll
>> still do the write, but it won=E2=80=99t change anything in the bitmap=
, so the
>> copy operation was effectively useless.)
>>
>> I don=E2=80=99t know how to fix mirror exactly, though.  I have four i=
deas:
>>
>> (A) Quick fix 1: do_sync_target_write() should shrink [offset, offset =
+
>> bytes) such that it is aligned.  This would make it skip writes that
>> don=E2=80=99t fill one whole chunk.
>>
>> +: Simple fix.  Could go into 4.1.
>> -: Makes copy-mode=3Dwrite-blocking equal to copy-mode=3Dbackground un=
less
>>     you set the granularity to like 512. (Still beats just being
>>     completely broken.)
>>
>> (B) Quick fix 2: Setting the request_alignment block limit to the job=E2=
=80=99s
>> granularity when in write-blocking mode.
>>
>> +: Very simple fix.  Could go into 4.1.
>> +: Every write will trigger a RMW cycle, which copies the whole chunk =
to
>>     the target, so write-blocking will do what it=E2=80=99s supposed t=
o do.
>> -: request_alignment forces everything to have the same granularity, s=
o
>>     this slows down reads needlessly.  (But only for write-blocking.)
>>
>> (C) Maybe the right fix 1: Let do_sync_target_write() expand [offset,
>> offset + bytes) such that it is aligned and read head and tail from th=
e
>> source node.  (So it would do the RMW itself.)
>>
>> + Doesn=E2=80=99t slow reads down.
>> + Writes to dirty areas will make them clean =E2=80=93 which is what
>>    write-blocking is for.
>> - Probably more complicated.  Nothing for 4.1.
>=20
> This is how backup works.
>=20
>>
>> (D) Maybe the right fix 2: Split BlockLimits.request_alignment into
>> read_alignment and write_alignment.  Then do (B).
>=20
> Now it's OK, but if we implement bitmap mode for mirror (which is upcom=
ing
> anyway, I think), it will slow down all writes, when we are interested =
only
> in which are touching dirty parts.

Ah, yes.  OK, (C) it is, then.  With what Kevin has said, just taking
this patch for now seems good to me; but I can see a small problem still
(will send in a separate mail).

Max

>> In effect, this is more or less the same as (C), but probably in a
>> simpler way.  Still not simple enough for 4.1, though.
>>
>>
>> So...  I tend to do either (A) or (B) now, and then probably (D) for
>> 4.2?  (And because (D) is an extension to (B), it would make sense to =
do
>> (B) now, unless you=E2=80=99d prefer (A).)
>>
>> Max
>>
>=20
>=20



--SwNJAI8txZmUf36aRnwLSSrz2og7EPIeP--

--aJk7vWUGPqMpGNyr3UeC0Mvh7WQeTh9Ik
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1IEksACgkQ9AfbAGHV
z0A92ggApF59bLf+T+02ZYq7z2CpKuoQPEodDM0TqDeQz8VhugiTRtXYu4GvXhD3
VtfKkjLGjoxRqviVdQwMlym6L1tpTeJ3XVhKbNVXqZ3qGm1i+KNrPfxAtDO9upax
sYwzmzGTVGnfKMcj/sSN/DSztUVYvP2UPp25c7/LSCeyv2+4YuRZRjq0UMmeu1QD
Fzwae6TByFGIO1Nkz/bsdugH87eEJ4pkcb9ynf9iypvBPc/krrMN3KBJQXZ6hY98
EVfc2dZpVUB7DMVn5+lX5r0YuH/BXiszVxj/QOlJ7CM7CIVqn0CaUGvQLkDjiT3o
nj3h27BQQt2w1C1WR9KER+zS8lTM0w==
=9Dd0
-----END PGP SIGNATURE-----

--aJk7vWUGPqMpGNyr3UeC0Mvh7WQeTh9Ik--


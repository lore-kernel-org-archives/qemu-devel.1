Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C6FC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 11:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2770420856
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 11:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2770420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hubQk-0005dg-Aj
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 07:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36278)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hubPN-0004im-4k
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 07:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hubPJ-0004BS-A1
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 07:44:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48140)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hubPF-0004AJ-VI; Mon, 05 Aug 2019 07:44:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1E43289AC0;
 Mon,  5 Aug 2019 11:44:01 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 28CC21001284;
 Mon,  5 Aug 2019 11:43:56 +0000 (UTC)
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
Message-ID: <b6e6adb2-dbe7-a767-bcc8-8c667fef2ab7@redhat.com>
Date: Mon, 5 Aug 2019 13:43:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c360e5b3-b0cf-bc18-891c-23fe71553652@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="h64RoK7CQoBXkr8C979gSMOguqYganoaD"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 05 Aug 2019 11:44:01 +0000 (UTC)
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
--h64RoK7CQoBXkr8C979gSMOguqYganoaD
Content-Type: multipart/mixed; boundary="0kGRLjC43AzRx1qd4M2K6qSHgo8BUkwqh";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jsnow@redhat.com" <jsnow@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <b6e6adb2-dbe7-a767-bcc8-8c667fef2ab7@redhat.com>
Subject: Re: [PATCH] util/hbitmap: fix unaligned reset
References: <20190802185830.74648-1-vsementsov@virtuozzo.com>
 <815da22c-e88e-e813-d342-9ad14191d052@redhat.com>
 <c360e5b3-b0cf-bc18-891c-23fe71553652@virtuozzo.com>
In-Reply-To: <c360e5b3-b0cf-bc18-891c-23fe71553652@virtuozzo.com>

--0kGRLjC43AzRx1qd4M2K6qSHgo8BUkwqh
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

(By the way, now I remember why I was only thinking about reads: We
always have to copy whole chunks to the target anyway, because when a
write comes in, the whole chunk is marked as dirty.  We don=E2=80=99t kno=
w
whether that=E2=80=99s because of this write or not, so we always have to=
 copy
it all.

But I forgot about the source...  Right, we don=E2=80=99t need to align t=
he
write there, just on the target.)

(Max)


--0kGRLjC43AzRx1qd4M2K6qSHgo8BUkwqh--

--h64RoK7CQoBXkr8C979gSMOguqYganoaD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1IFnsACgkQ9AfbAGHV
z0CYqQf+LuGVkoTis3kTVZHIlrc4KcLOF8U/jMBCx8JpStsSbGQKCwupVMJjnsNj
QFFQSx67ycszCEVLOA92EpO4prffglkeud6k6OO7HPKve67NfMyu8hXti9RI4ONf
oYxxDHYUnrC+6nSceIEiET6oA4BE73ytimD/bCbX4rPsy5aSREAh9euf/WeitZdw
vsKe5JnOBWYQjPga23AlbTp4T0AybZp6RSTCuST+EFMRtO6c+kpORczDY6Rq5pRJ
uH+q9bF9ZfR2x/fMKreRXZ77vsgANZdlMexRrA9wF/2PPJJdeDJ7OvNex2wddyxz
eKOE12QzlMeEW/jAZYqw3pLu6a/eEw==
=L8ZT
-----END PGP SIGNATURE-----

--h64RoK7CQoBXkr8C979gSMOguqYganoaD--


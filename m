Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7449CC432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E1D821850
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qjs7shar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1D821850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX2W7-0004Fr-95
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 07:21:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iX2V5-0003k4-PP
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:20:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iX2V4-0002yc-JW
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:20:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48166
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iX2V4-0002yG-FI
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574166053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l+/ZpjkHOgaBVxJjrFArgGHB9R73esGseWsZM3GLmOA=;
 b=Qjs7sharS6gYxTj56nq5lknpEZEMK/rW1EVJ3Db52Jo9+Zs/uUtmuGYO0zs9NVm86X9KUS
 eExIy5YwBtKetHmaoefdfQ2hNDiaqf/gQqCrvU9cX7XCQApR+P0WQSUyN09INTizfOI/J3
 eC25PXHxD664CMaX0Xya04yilWYnzPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-tOqwaL8HMAGtbTPdv8akSw-1; Tue, 19 Nov 2019 07:20:50 -0500
X-MC-Unique: tOqwaL8HMAGtbTPdv8akSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4F79DB62;
 Tue, 19 Nov 2019 12:20:48 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-187.ams2.redhat.com
 [10.36.117.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85D899069;
 Tue, 19 Nov 2019 12:20:43 +0000 (UTC)
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
To: "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
 <09d0bab1-ed7d-4fd7-555d-93075f10d497@redhat.com>
 <6b0811ec-822e-1c4a-1512-d6f3945645d2@openvz.org>
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
Message-ID: <5c894f55-71ec-6ef2-856d-d2f0b859144b@redhat.com>
Date: Tue, 19 Nov 2019 13:20:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <6b0811ec-822e-1c4a-1512-d6f3945645d2@openvz.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EXZnjqxU5y3BztXkvYen1VIAj3baafDdU"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EXZnjqxU5y3BztXkvYen1VIAj3baafDdU
Content-Type: multipart/mixed; boundary="9XxP0WKW8ekFmaw5oWAEqtxl9a91cNIcG"

--9XxP0WKW8ekFmaw5oWAEqtxl9a91cNIcG
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.11.19 13:02, Denis V. Lunev wrote:
> On 11/19/19 1:22 PM, Max Reitz wrote:
>> On 16.11.19 17:34, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi all!
>>>
>>> I wanted to understand, what is the real difference between bdrv_block_=
status_above
>>> and bdrv_is_allocated_above, IMHO bdrv_is_allocated_above should work t=
hrough
>>> bdrv_block_status_above..
>>>
>>> And I found the problem: bdrv_is_allocated_above considers space after =
EOF as
>>> UNALLOCATED for intermediate nodes..
>>>
>>> UNALLOCATED is not about allocation at fs level, but about should we go=
 to backing or
>>> not.. And it seems incorrect for me, as in case of short backing file, =
we'll read
>>> zeroes after EOF, instead of going further by backing chain.
>> Should we, though?  It absolutely makes sense to me to consider post-EOF
>> space as unallocated because, well, it is as unallocated as it gets.
>>
>> So from my POV it would make more sense to fall back to the backing file
>> for post-EOF reads.
>>
>> OTOH, I don=92t know whether changing that behavior would qualify as a
>> possible security issue now, because maybe someone has sensitive
>> information in the tail of some disk and then truncated the overlay so
>> as to hide it?  But honestly, that seems ridiculous and I can=92t imagin=
e
>> people to do that.  (It would work only for the tail, and why not just
>> write zeroes there, which works everywhere?)  So in practice I don=92t
>> believe that to be a problem.
>>
>> Max
>=20
> That seems to be wrong from my POW. Once we get block device truncated,
> it exposed that tail to the guest with all zeroes.
>=20
> Let us assume that we have virtual disk of length L. We create new top
> delta of
> length X (less then L) and new top delta after with length Y (more than L=
),
> like the following:
>=20
> [.........................] Y
> [........] X
> [...................] L
>=20
> Once the guest creates FS=A0 on state Y it relies on the fact that data f=
rom X
> to Y is all zeroes.
>=20
> Any operations with backing chain must keep guest content to be tha same,
> i.e. if we commit from Y to L, virtual disk content should be preserved,
> i.e.
> read as all zero even if there is some data in L from X to L.
>=20
> If we commit from X to Y, the range from X to L should remain all zeroes.
>=20
> This is especially valid for backups, which can not be changed and are
> validated by the software from time to time.
>=20
> Does this makes sense?

All right then.  But then there=92s the case of commit not shrinking the
backing file, so the guest content won=92t be the same if you commit a
short overlay into a longer backing file.

Max


--9XxP0WKW8ekFmaw5oWAEqtxl9a91cNIcG--

--EXZnjqxU5y3BztXkvYen1VIAj3baafDdU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3T3hkACgkQ9AfbAGHV
z0BWRgf/e9DCCZawt7qTKlJX2/OkalTcq1jGbP/xDKLZsPVKMQ3/Dkxdp/phy1Yd
htNxMbnypUQVUnyaTw044+mHsMI3jgzNFtspJ/G5QH0HI7z4CYmOY342r8UXmyiN
SJH7z+Sfd4HRevKqhUpVOcvyiXfWpL9xrQfWTzp9x1C0uw14C1Z1Cn5Ep1zEb9iQ
cpe8jefj7w0xExY0XSMsc70sFkWsjonumm/ny2pFLsYxIjDnWhBMFy/kPB16pUwg
Hf8qIFYWBR3I1ezP7MKFLNlgwZBeQ6OEXZ5sGFmR/okul8kjqBBIMpU7HOVRKR1r
7U3fTCVKc/3equlHuv2ThOmqoB9Dfw==
=zISC
-----END PGP SIGNATURE-----

--EXZnjqxU5y3BztXkvYen1VIAj3baafDdU--



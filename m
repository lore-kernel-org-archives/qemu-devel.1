Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68768C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 12:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF7520679
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 12:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF7520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx9tS-00019g-EM
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 08:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46787)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hx9si-0000fa-8t
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hx9sh-000724-74
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:57:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hx9se-0006zF-Tp; Mon, 12 Aug 2019 08:56:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 39A863066EDC;
 Mon, 12 Aug 2019 12:56:55 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-161.brq.redhat.com
 [10.40.204.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DBE7171C86;
 Mon, 12 Aug 2019 12:56:53 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-10-mreitz@redhat.com>
 <0020733a-cf68-7df0-b92f-68fd498735cd@virtuozzo.com>
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
Message-ID: <36be9f5d-b081-152b-6e11-0d787270005a@redhat.com>
Date: Mon, 12 Aug 2019 14:56:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0020733a-cf68-7df0-b92f-68fd498735cd@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6IfWqsS1FI5ULZogmYFEZDd6Y7bOEYdrG"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 12 Aug 2019 12:56:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 09/42] block: Include filters when
 freezing backing chain
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6IfWqsS1FI5ULZogmYFEZDd6Y7bOEYdrG
Content-Type: multipart/mixed; boundary="VN0WRjBOAvhegKQ91QH7BQ2tzklI4pEZI";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <36be9f5d-b081-152b-6e11-0d787270005a@redhat.com>
Subject: Re: [PATCH v6 09/42] block: Include filters when freezing backing
 chain
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-10-mreitz@redhat.com>
 <0020733a-cf68-7df0-b92f-68fd498735cd@virtuozzo.com>
In-Reply-To: <0020733a-cf68-7df0-b92f-68fd498735cd@virtuozzo.com>

--VN0WRjBOAvhegKQ91QH7BQ2tzklI4pEZI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.08.19 15:32, Vladimir Sementsov-Ogievskiy wrote:
> 09.08.2019 19:13, Max Reitz wrote:
>> In order to make filters work in backing chains, the associated
>> functions must be able to deal with them and freeze all filter links, =
be
>> they COW or R/W filter links.
>>
>> In the process, rename these functions to reflect that they now act on=

>> generalized chains of filter nodes instead of backing chains alone.
>>
>> While at it, add some comments that note which functions require their=

>> caller to ensure that a given child link is not frozen, and how the
>> callers do so.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   include/block/block.h | 10 +++---
>>   block.c               | 81 +++++++++++++++++++++++++----------------=
--
>>   block/commit.c        |  8 ++---
>>   block/mirror.c        |  4 +--
>>   block/stream.c        |  8 ++---
>>   5 files changed, 62 insertions(+), 49 deletions(-)

[...]

>> @@ -2477,10 +2481,6 @@ void bdrv_root_unref_child(BdrvChild *child)
>>       bdrv_unref(child_bs);
>>   }
>>  =20
>> -/**
>> - * Clear all inherits_from pointers from children and grandchildren o=
f
>> - * @root that point to @root, where necessary.
>> - */
>=20
> Hmm, unrelated chunk? Without it:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

I don=E2=80=99t know how that slipped in, sorry...

Once again, thanks for reviewing!

Max


--VN0WRjBOAvhegKQ91QH7BQ2tzklI4pEZI--

--6IfWqsS1FI5ULZogmYFEZDd6Y7bOEYdrG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1RYhMACgkQ9AfbAGHV
z0BWiAf/d+Kf3XtmveoqdqAR52V019h/VYs7N6jFidgO3OEfyzJRa4GRqkycOmRa
+chkW3LrAlmYzFyuEiZmhxv83F7cNYuK3uyqCCW2sxRbj3fnxcCzLsULJhvFnwSw
fXemYOxY+4dyK8I7zFiFglGmyBTgST0F44RvGYiyvQQNokTfRKG6POMuWx9kWFi7
wyrkY6fr90Yo7/pQp/H5UHLv4z9OWiXOevOC97tmI+gQoGui0I4Xf9geBvD1m0zy
7qxFXWE0w1qzauk28j93cHSDPPQLD1xoFisQKnASix8jTWe/TZDS19Mgh52c8Vr9
pU1/qwaA+Mwu26ADy2jEf8R/EkK2pw==
=tMUK
-----END PGP SIGNATURE-----

--6IfWqsS1FI5ULZogmYFEZDd6Y7bOEYdrG--


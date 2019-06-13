Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AB4C31E4B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823952175B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823952175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40728 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbRKH-00006A-AU
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 11:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37611)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbQa2-0004kx-MI
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbQa1-0005ml-IZ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:19:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54452)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbQZy-0005jY-Tx; Thu, 13 Jun 2019 10:19:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F05E330BC56C;
 Thu, 13 Jun 2019 14:19:41 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4627600C0;
 Thu, 13 Jun 2019 14:19:40 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-12-mreitz@redhat.com>
 <7a0fe60a-0d16-5420-0c6a-65cfe01bc933@virtuozzo.com>
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
Message-ID: <187cae6d-c9f1-7adb-aca9-5d0ba977de43@redhat.com>
Date: Thu, 13 Jun 2019 16:19:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7a0fe60a-0d16-5420-0c6a-65cfe01bc933@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6vcGHSR6dj1chBEr0lp1MOYpIYATotnBx"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 13 Jun 2019 14:19:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 11/42] block: Add
 bdrv_supports_compressed_writes()
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
--6vcGHSR6dj1chBEr0lp1MOYpIYATotnBx
Content-Type: multipart/mixed; boundary="2qFuF8NjhXuyUUZY4x3xIlgjJzSR7qwzl";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <187cae6d-c9f1-7adb-aca9-5d0ba977de43@redhat.com>
Subject: Re: [PATCH v5 11/42] block: Add bdrv_supports_compressed_writes()
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-12-mreitz@redhat.com>
 <7a0fe60a-0d16-5420-0c6a-65cfe01bc933@virtuozzo.com>
In-Reply-To: <7a0fe60a-0d16-5420-0c6a-65cfe01bc933@virtuozzo.com>

--2qFuF8NjhXuyUUZY4x3xIlgjJzSR7qwzl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.06.19 15:29, Vladimir Sementsov-Ogievskiy wrote:
> 13.06.2019 1:09, Max Reitz wrote:
>> Filters cannot compress data themselves but they have to implement
>> .bdrv_co_pwritev_compressed() still (or they cannot forward compressed=

>> writes).  Therefore, checking whether
>> bs->drv->bdrv_co_pwritev_compressed is non-NULL is not sufficient to
>> know whether the node can actually handle compressed writes.  This
>> function looks down the filter chain to see whether there is a
>> non-filter that can actually convert the compressed writes into
>> compressed data (and thus normal writes).
>=20
> Why not to use this function in (as I remember only 2-3 cases) when
> we check for bs->drv->bdrv_co_pwritev_compressed? It would be a complet=
e fix
> for described problem.

Well, bdrv_driver_pwritev_compressed() doesn=E2=80=99t really care, it wi=
ll find
out sooner or later anyway (while being passed down the chain).  This is
only really important for the backup job, which will use this function
as of patch 26.  (It isn=E2=80=99t important before 26, because using fil=
ters
with backup generally is a gamble before that patch.)

> (hmm, ok, other new APIs are added separately too, for some reason they=
 don't
> confuse me and this confuses)
>=20
> On the other hand, (the second time I think about it during review), co=
uld
> we handle compression through flags completely?
> We have supported_write_flags feature, which should be used for all the=
se checks..
> And may be, we may drop .bdrv_co_pwritev_compressed at all.

We probably could, yes.  I just felt like this wasn=E2=80=99t the time to=
 do it.
O:-)

> But if you want to keep it as is, it's OK too:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks for reviewing!

Max


--2qFuF8NjhXuyUUZY4x3xIlgjJzSR7qwzl--

--6vcGHSR6dj1chBEr0lp1MOYpIYATotnBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0CW3sACgkQ9AfbAGHV
z0CdAQf/d3CneSCTEjpC2G1vgsc8TCbejhSWKnbjjbEU5KF8wxesDKoj0xDbXA7Z
d4CruHK4bbiMovDNLnQGJmxvRZhG9aOUJuvR6QmAGb+0b8Yu+OzgaFW0JxOyWerQ
sgyEWtGCegsbvznNtCP79rvSNQ8TbMRl3F8gMH9Hz4dCd8XjdxzExLPNKZrsG210
haJw53YGbLAmn+7IAC1s7h38g0Gv5mxN5WVs/3Y1ep9U+ondYJYckGa1JUWkVZUT
Tm3o0OcUbsY5YE2Ukm07ZtZtfnuqNZd5NF5rfRt8rDauWFt+0O4ykt6OFcAsHQXL
go/Ofto4wi2IqHRthkkIXi70fef25g==
=8gWQ
-----END PGP SIGNATURE-----

--6vcGHSR6dj1chBEr0lp1MOYpIYATotnBx--


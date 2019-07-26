Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265DFC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA63A22BEF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA63A22BEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqwNm-0004Qs-Rd
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 05:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55681)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hqwNW-0003pQ-2F
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hqwNS-00052i-Pp
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:19:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49736)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hqwNQ-0004i4-3P; Fri, 26 Jul 2019 05:19:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6559930833A0;
 Fri, 26 Jul 2019 09:18:56 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-164.ams2.redhat.com
 [10.36.116.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A158160C62;
 Fri, 26 Jul 2019 09:18:54 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20190725162704.12622-1-kwolf@redhat.com>
 <20190725162704.12622-2-kwolf@redhat.com>
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
Message-ID: <7af54232-2168-4509-a8e6-5fc712d28cf4@redhat.com>
Date: Fri, 26 Jul 2019 11:18:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725162704.12622-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Bl9HitvGTHy0NjgOJGskD0k6hNWJNxdT8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 26 Jul 2019 09:18:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/4] block: Remove blk_pread_unthrottled()
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
Cc: dplotnikov@virtuozzo.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Bl9HitvGTHy0NjgOJGskD0k6hNWJNxdT8
Content-Type: multipart/mixed; boundary="sk0INQduNfTCFpm9sV98pJhaYQV0XPY2h";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: dplotnikov@virtuozzo.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-devel@nongnu.org
Message-ID: <7af54232-2168-4509-a8e6-5fc712d28cf4@redhat.com>
Subject: Re: [PATCH 1/4] block: Remove blk_pread_unthrottled()
References: <20190725162704.12622-1-kwolf@redhat.com>
 <20190725162704.12622-2-kwolf@redhat.com>
In-Reply-To: <20190725162704.12622-2-kwolf@redhat.com>

--sk0INQduNfTCFpm9sV98pJhaYQV0XPY2h
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.07.19 18:27, Kevin Wolf wrote:
> The functionality offered by blk_pread_unthrottled() goes back to commi=
t
> 498e386c584. Then, we couldn't perform I/O throttling with synchronous
> requests because timers wouldn't be executed in polling loops. So the
> commit automatically disabled I/O throttling as soon as a synchronous
> request was issued.
>=20
> However, for geometry detection during disk initialisation, we always
> used (and still use) synchronous requests even if guest requests use AI=
O
> later. Geometry detection was not wanted to disable I/O throttling, so
> bdrv_pread_unthrottled() was introduced which disabled throttling only
> temporarily.
>=20
> All of this isn't necessary any more because we do run timers in pollin=
g
> loop and even synchronous requests are now using coroutine
> infrastructure internally. For this reason, commit 90c78624f already
> removed the automatic disabling of I/O throttling.
>=20
> It's time to get rid of the workaround for the removed code, and its
> abuse of blk_root_drained_begin()/end(), as well.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/sysemu/block-backend.h |  2 --
>  block/block-backend.c          | 16 ----------------
>  hw/block/hd-geometry.c         |  7 +------
>  3 files changed, 1 insertion(+), 24 deletions(-)

It took me a bit of git blaming to find out more about the history of
timer execution (and finally arrived at
https://lists.nongnu.org/archive/html/qemu-devel/2013-08/msg03060.html),
but now I=E2=80=99m reasonably confident.

Reviewed-by: Max Reitz <mreitz@redhat.com>


--sk0INQduNfTCFpm9sV98pJhaYQV0XPY2h--

--Bl9HitvGTHy0NjgOJGskD0k6hNWJNxdT8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl06xXwACgkQ9AfbAGHV
z0Dy9Af/SXXZLKTOk1AypeK+AFIzr9HnVWaze10bNmO2zUQUMweO/LSPmx+/Dhi2
sbmGCRe2AhcXwZ2VxTQSe9L2uLmt9yiaByXnkJiudtsnpWD/rgkluU059l+jSTta
Vunh52R1/FgtaH6ar3fnZKSw618LpM6YAKjVhFSOXMs7SRerDt+04j+eCKc6aukk
kEK59IS4x5NfCXg614pKpR6JYKNLHFGKyCl3lvb3nyA/UWEDDjEeces7l4t9iHM3
fxFoGFtlp/BMeu71KE86LqsXCSZvkVPMYdLX6H2G1WvXxToLt08fLfF3Ipy8x3q8
Qkg9yRYwMj67myQZpNwsGXVSEQeyhQ==
=j2pV
-----END PGP SIGNATURE-----

--Bl9HitvGTHy0NjgOJGskD0k6hNWJNxdT8--


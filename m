Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73A0CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A215621D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLE/+BUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A215621D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNyp8-0001eN-Ef
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 08:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iNykd-0001a3-GQ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iNykb-0002is-76
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:31:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30609
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iNykV-0002YC-Gq
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572006675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GDb2MaZjbnIVlyvIqk6tWabdPK5Fg/RHZtkhdkdWoPc=;
 b=aLE/+BUYwk8uN0GJxh6NEZYf50hVq/lAqeKg/bYOq4f1fGx3+aAZ8VUHRrThp9ivS9gMbu
 T2KM7cDUMZEelzBRqxGdLphWibDM1kX6TGpNJF14og3/T7/thacWI0d8l/s4T9VonmWT5a
 6SDG2sdXBJloY9crPObII1eDVrkp1LE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-UStGsJNwMs2iS6jklKV9PQ-1; Fri, 25 Oct 2019 08:31:11 -0400
X-MC-Unique: UStGsJNwMs2iS6jklKV9PQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8C13107AD31;
 Fri, 25 Oct 2019 12:31:09 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EEBD560852;
 Fri, 25 Oct 2019 12:31:05 +0000 (UTC)
Subject: Re: [PATCH v3 0/6] block-copy: memory limit
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191022111805.3432-1-vsementsov@virtuozzo.com>
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
Message-ID: <06c576de-91f4-69ab-5962-53f2ba9930e3@redhat.com>
Date: Fri, 25 Oct 2019 14:31:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022111805.3432-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="30f7iAuZFQgV1vNie7qaVAOz0MJtPFXac"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--30f7iAuZFQgV1vNie7qaVAOz0MJtPFXac
Content-Type: multipart/mixed; boundary="Bt8vMLjeHDZdAzyAcRqC6pvkmmk1yq7vO"

--Bt8vMLjeHDZdAzyAcRqC6pvkmmk1yq7vO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.10.19 13:17, Vladimir Sementsov-Ogievskiy wrote:
> I'm going to bring block-status driven, async copying process to
> block-copy, to make it fast. The first step is to limit memory usage of
> backup, here is it.
>=20
> v3:
> 03: add Max's r-b
> 04: fix commit message and include guards, add Max's r-b
> 05-06: add Max's r-b
>=20
> v2: [mostly by Max's comments]
> Now based on master (Thank you Max!)
> 01: add Max's r-b
> 02: add Max's r-b
> 03: - refactor block_copy_do_copy goto/return
>     - add small comment to block_copy_do_copy
> 04: - a lot of renaming and wording fixes
>     - refactor to use "available" instead of "taken"
>     - refactor co_get_from_shres
> 05: rebase on 04 changes
> 06: drop extra things from max_transfer calculation
>=20
> Vladimir Sementsov-Ogievskiy (6):
>   block/block-copy: allocate buffer in block_copy_with_bounce_buffer
>   block/block-copy: limit copy_range_size to 16 MiB
>   block/block-copy: refactor copying
>   util: introduce SharedResource
>   block/block-copy: add memory limit
>   block/block-copy: increase buffered copy request
>=20
>  include/block/block-copy.h        |   5 +-
>  include/qemu/co-shared-resource.h |  71 ++++++++++++
>  block/block-copy.c                | 182 +++++++++++++++---------------
>  util/qemu-co-shared-resource.c    |  76 +++++++++++++
>  block/trace-events                |   6 +-
>  util/Makefile.objs                |   1 +
>  6 files changed, 249 insertions(+), 92 deletions(-)
>  create mode 100644 include/qemu/co-shared-resource.h
>  create mode 100644 util/qemu-co-shared-resource.c

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--Bt8vMLjeHDZdAzyAcRqC6pvkmmk1yq7vO--

--30f7iAuZFQgV1vNie7qaVAOz0MJtPFXac
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2y6wgACgkQ9AfbAGHV
z0Aa9Qf/az8nJfwJ2Z54S/IC5oOOFDTL8FAAuvC9ECvKpcNjjdVA9/ft9guJqOta
NCeZNSCLzUEyJFTfO9Kw44u+uLlbsn84ZwgK+pY9gWhcxLe/Oys6NSpTwJmIdG4m
h67UMlPf84HTy7GyVV5lS00dmM2BsYxj7AQMIZt53rIG8FmCaEkLuxEIpvWpu5HE
4ihh+vNjAPk15GCNIW6aVcvDPoL+vVFWIjrfdJlR0KotFz9kBv+NsnzY/iKTBWQw
89+Hg3e4GohWVJZVxZD6MzOrUMOiuYl01hBM7tz77jPxjr6cYLx+pvYhZA8hx8cC
x8/JPosiTlk+IOGufZbDY67+p/Fv+w==
=ijuO
-----END PGP SIGNATURE-----

--30f7iAuZFQgV1vNie7qaVAOz0MJtPFXac--



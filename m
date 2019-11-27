Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F722C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:20:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2242068E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGL88AY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2242068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZyBX-0007NR-Sj
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 09:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZy8X-00031A-Cj
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:17:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxtQ-00059w-6s
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:02:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41825
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxtP-000592-TV
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574863326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aTH7c9/BszOwjnr+mfHgf7jRYoJ6lHKYaD0I3ogQ0LY=;
 b=jGL88AY6oas4SWCzEetkJRjo6wc+qfhgY2xc5AVkjj+o4o5xUvKkps9cnT43xWBnMedYE9
 iPY7QzL7uH06QmZEOm1A/hR7KiFqQrWx/uDzWuOseJiJrkNXM0ymXpY55zS0Z/s2dImVtf
 ruw7a0I5FWcOdwZZf/LT0qKoXx3BXvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-FfidTBlfM1S67mGcSrmYkg-1; Wed, 27 Nov 2019 09:02:03 -0500
X-MC-Unique: FfidTBlfM1S67mGcSrmYkg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E70D800053;
 Wed, 27 Nov 2019 14:02:01 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-205-186.brq.redhat.com
 [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CA515D9D6;
 Wed, 27 Nov 2019 14:01:59 +0000 (UTC)
Subject: Re: [PATCH v9 1/3] block: introduce compress filter driver
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1574779398-88772-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1574779398-88772-2-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Message-ID: <f3a68aa4-6e53-747a-8765-b92ed6588b08@redhat.com>
Date: Wed, 27 Nov 2019 15:01:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1574779398-88772-2-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="b1nuWaHu8GWIHcWR6LMT0XePtVwhGqICD"
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b1nuWaHu8GWIHcWR6LMT0XePtVwhGqICD
Content-Type: multipart/mixed; boundary="qZZzjCjrSYfFAEZ4zKVCwfKqzWJ5zrpcg"

--qZZzjCjrSYfFAEZ4zKVCwfKqzWJ5zrpcg
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.11.19 15:43, Andrey Shinkevich wrote:
> Allow writing all the data compressed through the filter driver.
> The written data will be aligned by the cluster size.
> Based on the QEMU current implementation, that data can be written to
> unallocated clusters only. May be used for a backup job.
>=20
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  block/Makefile.objs     |   1 +
>  block/filter-compress.c | 190 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  qapi/block-core.json    |  10 ++-
>  3 files changed, 197 insertions(+), 4 deletions(-)
>  create mode 100644 block/filter-compress.c

[...]

> diff --git a/block/filter-compress.c b/block/filter-compress.c
> new file mode 100644
> index 0000000..ef4b12b
> --- /dev/null
> +++ b/block/filter-compress.c

[...]

> +#define PERM_PASSTHROUGH (BLK_PERM_CONSISTENT_READ \
> +                          | BLK_PERM_WRITE \
> +                          | BLK_PERM_RESIZE)
> +#define PERM_UNCHANGED (BLK_PERM_ALL & ~PERM_PASSTHROUGH)
> +
> +static void compress_child_perm(BlockDriverState *bs, BdrvChild *c,
> +                                const BdrvChildRole *role,
> +                                BlockReopenQueue *reopen_queue,
> +                                uint64_t perm, uint64_t shared,
> +                                uint64_t *nperm, uint64_t *nshared)
> +{
> +    *nperm =3D perm & PERM_PASSTHROUGH;
> +    *nshared =3D (shared & PERM_PASSTHROUGH) | PERM_UNCHANGED;
> +
> +    /*
> +     * We must not request write permissions for an inactive node, the c=
hild
> +     * cannot provide it.
> +     */
> +    if (!(bs->open_flags & BDRV_O_INACTIVE)) {
> +        *nperm |=3D BLK_PERM_WRITE_UNCHANGED;
> +    }

The copy-on-read filter has to take the WRITE_UNCHANGED permission
because it will do such writes for every read, but I don=92t think this
driver ever needs to take this permission.  Therefore it should be
enough to use bdrv_filter_default_perms for .bdrv_child_perm.

Max


--qZZzjCjrSYfFAEZ4zKVCwfKqzWJ5zrpcg--

--b1nuWaHu8GWIHcWR6LMT0XePtVwhGqICD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3egdUACgkQ9AfbAGHV
z0DTzgf+IallT2B82UQS1ukWMcKzHQdIhtV/jAfS7dWL3cZGwvBGT9liQZ4kjI1U
Dn350EzCKr6Zz8zyoPuF7oquxE8I/kRMucS+IqB0O+KMae0RqKbcI4mHOlgLnBFU
mlJUw0SNgB7zolYEuDKhT69yrMvz1knU3K90quOgfyL4v1TtIXqXntggBjIqGGY7
AzMz2jkInIPuU7l7i3KZO6DXAqJfpb09qBoZRK04OrqVObhQQKj4XgdYALJx9GQ9
viu8FYxA+d9OMID4dFMB2U2HAmdotMC55VeF+sPUjlqpEBRCy8/szrnCOI846BQw
hXDXTnBbTqWO1SjS5ejq5YnWo+JSag==
=kYJT
-----END PGP SIGNATURE-----

--b1nuWaHu8GWIHcWR6LMT0XePtVwhGqICD--



Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF84C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFEAA20718
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5EJlKdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEAA20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3h1T-00010N-Uy
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 09:05:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j3h0f-0000QK-OA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:04:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j3h0e-0005wu-Qr
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:04:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23176
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j3h0e-0005wY-Ma
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581948268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vsRjvngQz5IIEE+YiCwQAn9ogbPZLOFwhxcubzcboRc=;
 b=F5EJlKdKNs/Q1VehY1GTbMqIymccpKxT1jzY6pcJDplPlJ3ZHuEODi2l3X85mA9sCuItCD
 fSwap5Mec4wx0ybmybWODLO4Nc7ZC/PAFoiIoA9ORkSgYsMgKfaH993SQFQCLAmTlz1PbH
 miIeaQ5/mHwjUluGtFZoe9vHgQc9bag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-LE5zVF6uN3Ku1TqeGzxoNw-1; Mon, 17 Feb 2020 09:04:22 -0500
X-MC-Unique: LE5zVF6uN3Ku1TqeGzxoNw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25CFD85EE6E;
 Mon, 17 Feb 2020 14:04:21 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-191.ams2.redhat.com
 [10.36.117.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 36A738B548;
 Mon, 17 Feb 2020 14:04:18 +0000 (UTC)
Subject: Re: [PATCH v2 7/7] block/block-copy: hide structure definitions
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-8-vsementsov@virtuozzo.com>
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
Message-ID: <ba8f31d5-d04f-2c8f-2afc-4c1ce2f5aa3c@redhat.com>
Date: Mon, 17 Feb 2020 15:04:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191127180840.11937-8-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6uPWstkP3xufWN9OY91BEQ4EQGpMoWXZc"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
--6uPWstkP3xufWN9OY91BEQ4EQGpMoWXZc
Content-Type: multipart/mixed; boundary="eUIBkjLG5lM3vO7m7oVQonWnFzpkFDF13"

--eUIBkjLG5lM3vO7m7oVQonWnFzpkFDF13
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.11.19 19:08, Vladimir Sementsov-Ogievskiy wrote:
> Hide structure definitions and add explicit API instead, to keep an
> eye on the scope of the shared fields.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/block-copy.h | 57 +++------------------------------
>  block/backup-top.c         |  6 ++--
>  block/backup.c             | 27 ++++++++--------
>  block/block-copy.c         | 64 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 86 insertions(+), 68 deletions(-)

[...]

> diff --git a/block/backup.c b/block/backup.c
> index cf62b1a38c..acab0d08da 100644
> --- a/block/backup.c
> +++ b/block/backup.c

[...]

> @@ -458,6 +458,7 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
>      job->sync_bitmap =3D sync_bitmap;
>      job->bitmap_mode =3D bitmap_mode;
>      job->bcs =3D bcs;
> +    job->bcs_bitmap =3D block_copy_dirty_bitmap(bcs);

It seems a bit weird to me to store a pointer to the BCS-owned bitmap
here, because, well, it=E2=80=99s a BCS-owned object, and just calling
block_copy_dirty_bitmap() every time wouldn=E2=80=99t be prohibitively expe=
nsive.

I feel sufficiently bad about this to warrant not giving an R-b, but I
know I shouldn=E2=80=99t withhold an R-b over this, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>

>      job->cluster_size =3D cluster_size;
>      job->len =3D len;


--eUIBkjLG5lM3vO7m7oVQonWnFzpkFDF13--

--6uPWstkP3xufWN9OY91BEQ4EQGpMoWXZc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5KnWEACgkQ9AfbAGHV
z0AZpQf+IT6pP1AKLHrYZu2oS1pHbC1RMjy5FqJtAu/HgY08RSZgNZTiy6FAdjko
yxLIW8qSQDTZVDMwo+tdB51bvv/fD+quSbUz+VVej4LvIHmupn5XRKmZ2HmCq5Z9
cXMOPOnmptY5PYTWR2PJIM56SL0Bkz/5uKAJhGNu120YLgByg3VRSAlTJEHI2y/H
friStujYI6/i3FfUa3iB2SR1PhbUBaJBuk3jsDaib0FQsoLz7HwzypbfPTxBuMDg
5WzOaO5J0ZneBQpscpWXesXVrV4s3xoQI0ih24Q6g6hVlF3e2N9abp8mZ2FGLQbU
iJ6FqQaYB8bXnMGG6St9e1mTt0unSg==
=2Mpb
-----END PGP SIGNATURE-----

--6uPWstkP3xufWN9OY91BEQ4EQGpMoWXZc--



Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFF8C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 11:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB99206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 11:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhvdgVwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB99206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVDIx-0004QQ-Rz
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 06:28:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iVDIA-0003f6-Rq
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 06:28:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iVDI8-0003VY-KM
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 06:28:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20680
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iVDI8-0003VF-Fw
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 06:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573730879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fqsWg0XJmvbvAjw1KdgSmc+UKZnH5QiUxKZD4iyZilM=;
 b=XhvdgVwpYj06pcLeQ6JqOGdH6u2+VG2Ow50t+vtK3p8tsBzvyEV8W3T9xy9k3Kf0ux0eUr
 9MF21U4AdJtWcOYki4RA8C/wWoxNWhqVsP0XcGaWAlOU1u+oFk+YWhRGFtUgTo9ForjFAk
 zFyORUliOnt+DKqCkzjHo8Lls0SK0mA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-vPNp5lj-MQSgDz8HSoz5tA-1; Thu, 14 Nov 2019 06:27:56 -0500
X-MC-Unique: vPNp5lj-MQSgDz8HSoz5tA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC1A6100727E;
 Thu, 14 Nov 2019 11:27:54 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-160.ams2.redhat.com
 [10.36.117.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D78F610E5;
 Thu, 14 Nov 2019 11:27:52 +0000 (UTC)
Subject: Re: [PATCH v7 1/3] block: introduce compress filter driver
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1573670589-229357-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1573670589-229357-2-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Message-ID: <a5dd3514-a804-6c63-2158-0dff9ac37ab3@redhat.com>
Date: Thu, 14 Nov 2019 12:27:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1573670589-229357-2-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R1oWv1csD9ZFFkvOLPtF8tcoH1TnD78P9"
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R1oWv1csD9ZFFkvOLPtF8tcoH1TnD78P9
Content-Type: multipart/mixed; boundary="FnWvMalEsNax4ztEJySoNLqWVHqgTqGqn"

--FnWvMalEsNax4ztEJySoNLqWVHqgTqGqn
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.11.19 19:43, Andrey Shinkevich wrote:
> Allow writing all the data compressed through the filter driver.
> The written data will be aligned by the cluster size.
> Based on the QEMU current implementation, that data can be written to
> unallocated clusters only. May be used for a backup job.
>=20
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  block/Makefile.objs     |   1 +
>  block/filter-compress.c | 201 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  qapi/block-core.json    |  10 ++-
>  3 files changed, 208 insertions(+), 4 deletions(-)
>  create mode 100644 block/filter-compress.c
>=20
> diff --git a/block/Makefile.objs b/block/Makefile.objs
> index e394fe0..330529b 100644
> --- a/block/Makefile.objs
> +++ b/block/Makefile.objs
> @@ -43,6 +43,7 @@ block-obj-y +=3D crypto.o
> =20
>  block-obj-y +=3D aio_task.o
>  block-obj-y +=3D backup-top.o
> +block-obj-y +=3D filter-compress.o
> =20
>  common-obj-y +=3D stream.o
> =20
> diff --git a/block/filter-compress.c b/block/filter-compress.c
> new file mode 100644
> index 0000000..64b1ee5
> --- /dev/null
> +++ b/block/filter-compress.c
> @@ -0,0 +1,201 @@
> +/*
> + * Compress filter block driver
> + *
> + * Copyright (c) 2019 Virtuozzo International GmbH
> + *
> + * Author:
> + *   Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> + *   (based on block/copy-on-read.c by Max Reitz)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) any later version of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "block/block_int.h"
> +#include "qemu/module.h"
> +
> +
> +static int compress_open(BlockDriverState *bs, QDict *options, int flags=
,
> +                         Error **errp)
> +{
> +    bs->backing =3D bdrv_open_child(NULL, options, "file", bs, &child_fi=
le, false,
> +                                  errp);

Please don=92t attach something that the QAPI schema calls =93file=94 as
bs->backing.

Yes, attaching it as bs->file would break backing chains.  That=92s a bug
in the block layer.  I=92ve been working on a fix for a long time.

Please don=92t introduce more weirdness just because we have a bug in the
block layer.

(Note that I=92d strongly oppose calling the child =93backing=94 in the QAP=
I
schema, as this would go against what all other user-creatable filters do.)

Max


--FnWvMalEsNax4ztEJySoNLqWVHqgTqGqn--

--R1oWv1csD9ZFFkvOLPtF8tcoH1TnD78P9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3NOjYACgkQ9AfbAGHV
z0Dhswf/YH273TyAVv85m9ysRZITznv7R/yTlo7jViyr8a7lrOJiamf3Sgx5idbs
yBTrIpqW48LKviw/9T+hVNG1hEx+yMq5BtCmMXCP4yNF1xeLmd/eoDNuX5boEtK7
Lj1pjanHAfIAm9egHPDJOl1MRJEU0V944CYxGfW19D07SwaQrCbnjVXGpCloL6mE
AVmplIXFbxI1UzVjIRK2I+/BzJmoC5DQ/y6clwlSPtfm/YQq9pzwyZnEYD1h99aJ
Qg75IG96Yh1PuwdUv2HTAAHJEY6LofY1eOwtSiVIvR7lI/8pSnXkXwszp8Zn6vAl
pqHR5osM9RfghuSSeCrj/LIj3iUdNw==
=+rw/
-----END PGP SIGNATURE-----

--R1oWv1csD9ZFFkvOLPtF8tcoH1TnD78P9--



Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC5DC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA394206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA394206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE9o2-0000cr-4t
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 07:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kE9nU-00006Q-41
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:22:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30838
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kE9nR-0002ZR-G3
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:22:23 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-1Swi57xtPSKT3krmi2--Fg-1; Fri, 04 Sep 2020 07:22:18 -0400
X-MC-Unique: 1Swi57xtPSKT3krmi2--Fg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 136391DDE7;
 Fri,  4 Sep 2020 11:22:17 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-156.ams2.redhat.com
 [10.36.114.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC7B787D62;
 Fri,  4 Sep 2020 11:22:14 +0000 (UTC)
Subject: Re: [PATCH v8 2/7] copy-on-read: add filter append/drop functions
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1598633579-221780-3-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Message-ID: <9733a257-b864-e8db-7379-f94fbd21045a@redhat.com>
Date: Fri, 4 Sep 2020 13:22:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598633579-221780-3-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="d3KWPfEnmL4ZOb6hkg44jmxdgiL5qpDuL"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d3KWPfEnmL4ZOb6hkg44jmxdgiL5qpDuL
Content-Type: multipart/mixed; boundary="EancMk9ZM2gdvWjkDjAlS0Za1OXJtD9E4"

--EancMk9ZM2gdvWjkDjAlS0Za1OXJtD9E4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.08.20 18:52, Andrey Shinkevich wrote:
> Provide API for the COR-filter insertion/removal.

Hm.  Why?

I see the implementation is just bdrv_open() + bdrv_replace_node(),
which is what I would have expected.  Why can=E2=80=99t the caller just do =
that?

Or maybe it would even make sense to just make it a generic block driver
function, like

BlockDriverState *
bdrv_insert_node(BlockDriverState *bs, const char *node_driver,
                 const char *node_name, QDict *node_options,
                 Error **errp);

?

(Similarly for dropping a node from a chain.)

> Also, drop the filter child permissions for an inactive state when the
> filter node is being removed.

Do we need .active for that?  Shouldn=E2=80=99t it be sufficient to just no=
t
require BLK_PERM_WRITE_UNCHANGED when no permissions are taken on the
node (i.e. perm =3D=3D 0 in cor_child_perm())?

Of course, using an .active field works, too.  But Vladimir wanted a
similar field in the preallocate filter, and there already is in
backup-top.  I feel like there shouldn=E2=80=99t be a need for this.

.bdrv_child_perm() should generally be able to decide what permissions
it needs based on the information it gets.  If every driver needs to
keep track of whether it has any parents and feed that information into
.bdrv_child_perm() as external state, then something feels wrong.

If perm =3D=3D 0 is not sufficient to rule out any parents, we should just
explicitly add a boolean that tells .bdrv_child_perm() whether there are
any parents or not =E2=80=93 shouldn=E2=80=99t be too difficult.

> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/copy-on-read.c | 104 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  block/copy-on-read.h |  35 +++++++++++++++++
>  2 files changed, 139 insertions(+)
>  create mode 100644 block/copy-on-read.h

[...]

>  block_init(bdrv_copy_on_read_init);
> diff --git a/block/copy-on-read.h b/block/copy-on-read.h
> new file mode 100644
> index 0000000..1686e4e
> --- /dev/null
> +++ b/block/copy-on-read.h
> @@ -0,0 +1,35 @@
> +/*
> + * Copy-on-read filter block driver
> + *
> + * The filter driver performs Copy-On-Read (COR) operations
> + *
> + * Copyright (c) 2018-2020 Virtuozzo International GmbH.
> + *
> + * Author:
> + *   Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef COPY_ON_READ_FILTER
> +#define COPY_ON_READ_FILTER

Bit of a weird include guard, seeing that most header files in qemu
(certainly under block/) base their name on their filename.  So this
would be BLOCK_COPY_ON_READ_H (or COPY_ON_READ_H).

(It=E2=80=99s just that COPY_ON_READ_FILTER kind of sounds like a configure=
d
option, i.e. whether the filter is present or not.)

Max

> +
> +#include "block/block_int.h"
> +
> +BlockDriverState *bdrv_cor_filter_append(BlockDriverState *bs,
> +                                         const char *filter_node_name,
> +                                         Error **errp);
> +void bdrv_cor_filter_drop(BlockDriverState *cor_filter_bs);
> +
> +#endif /* COPY_ON_READ_FILTER */
>=20



--EancMk9ZM2gdvWjkDjAlS0Za1OXJtD9E4--

--d3KWPfEnmL4ZOb6hkg44jmxdgiL5qpDuL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9SI2QACgkQ9AfbAGHV
z0BY2Qf/aCfWK4+fhy6LsOttFnUt9ps9DuFGKAACpGpPOtMqLTKsUn9BBsdXgfY7
xeaw7z2IfG3hKVcJZL3qp6qIKqpS8sKHJPN2GxiLensYUFJeKrby16FteFvuAXaO
haUCDSd2oA1qeEYiJH3obXu/iLT5EH1iC4jz5CGOMCQQNVbd7ICYhJvRU+s5LxZG
rQgYSDs3A/KqG7cZOUUViiOYRNxJmLYfGuAKfpwNckNru/Exq9d0cvmqEqjNAxRs
qBv3rn8ljSn7pzSdJWeHDWS+5lMNzNu9gxprdN/ydgu1ew/RDjfH9phcnOdUGIJx
ODJaCyRhyLR8FfPtY5vsC2z1LgAYPg==
=2W9L
-----END PGP SIGNATURE-----

--d3KWPfEnmL4ZOb6hkg44jmxdgiL5qpDuL--



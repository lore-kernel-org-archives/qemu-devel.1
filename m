Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB017C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C50206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCNLX7t3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C50206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnJfW-00012K-Oa
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 06:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jnJeR-0000Xa-SU
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:26:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20768
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jnJeP-0002i4-5b
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592821563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N/s4YO3j05UONHII8zu7zZsNYCcXnN+4hjmy1cFeepc=;
 b=eCNLX7t3Zbi/lhMcdW2+n2CSmRo1s9b5wqVUbwH/97yKorsQ7ygpcqGd0VnxjirveRcikx
 KSpNqx7bOXc3acX4tj4pDeUIkzVmFAq5Qbpp2hEZVOKjfmLmhOkTuNazK4vQtOhnMlIOoi
 lJvpNLM3oeYs2845DI/xpFL/xXHtEFk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-8tDlOyKAMdWeel_1A2GvkA-1; Mon, 22 Jun 2020 06:26:01 -0400
X-MC-Unique: 8tDlOyKAMdWeel_1A2GvkA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49F7D8018AB;
 Mon, 22 Jun 2020 10:26:00 +0000 (UTC)
Received: from localhost (ovpn-115-184.ams2.redhat.com [10.36.115.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A0D47C1FD;
 Mon, 22 Jun 2020 10:25:59 +0000 (UTC)
Date: Mon, 22 Jun 2020 11:25:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Lin Ma <lma@suse.com>
Subject: Re: [PATCH v2 1/3] block: Add bdrv_co_get_lba_status
Message-ID: <20200622102558.GA13543@stefanha-x1.localdomain>
References: <20200617103018.18026-1-lma@suse.com>
 <20200617103018.18026-2-lma@suse.com>
MIME-Version: 1.0
In-Reply-To: <20200617103018.18026-2-lma@suse.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2020 at 06:30:16PM +0800, Lin Ma wrote:
> The get lba status wrapper based on the bdrv_block_status. The following
> patches will add GET LBA STATUS 16 support for scsi emulation layer.
>=20
> Signed-off-by: Lin Ma <lma@suse.com>
> ---
>  block/io.c                | 43 +++++++++++++++++++++++++++++++++++++++
>  include/block/block_int.h |  5 +++++
>  2 files changed, 48 insertions(+)
>=20
> diff --git a/block/io.c b/block/io.c
> index df8f2a98d4..2064016b19 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2208,6 +2208,49 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *=
child, int64_t offset,
>                             BDRV_REQ_ZERO_WRITE | flags);
>  }
> =20
> +int coroutine_fn
> +bdrv_co_get_lba_status(BdrvChild *child, int64_t offset, int64_t bytes,
> +                       uint32_t *num_blocks, uint32_t *is_deallocated)

Missing doc comments.

> +{
> +    BlockDriverState *bs =3D child->bs;

Why does this function take a BdrvChild argument instead of
BlockDriverState? Most I/O functions take BlockDriverState.

> +    int ret =3D 0;
> +    int64_t target_size, count =3D 0;
> +    bool first =3D true;
> +    uint8_t wanted_bit1 =3D 0;
> +
> +    target_size =3D bdrv_getlength(bs);
> +    if (target_size < 0) {
> +        return -EIO;
> +    }
> +
> +    if (offset < 0 || bytes < 0) {
> +        return -EIO;
> +    }
> +
> +    for ( ; offset <=3D target_size - bytes; offset +=3D count) {
> +        ret =3D bdrv_block_status(bs, offset, bytes, &count, NULL, NULL)=
;
> +        if (ret < 0) {
> +            goto out;
> +        }
> +        if (first) {
> +            if (ret & BDRV_BLOCK_ZERO) {
> +                wanted_bit1 =3D BDRV_BLOCK_ZERO >> 1;
> +                *is_deallocated =3D 1;

This is a boolean. Please use bool instead of uint32_t.

Please initialize is_deallocated to false at the beginning of the
function to avoid accidental uninitialized variable accesses in the
caller.

> +            } else {
> +                wanted_bit1 =3D 0;
> +            }
> +            first =3D false;
> +        }
> +        if ((ret & BDRV_BLOCK_ZERO) >> 1 =3D=3D wanted_bit1) {
> +            (*num_blocks)++;

If there is a long span of allocated/deallocated blocks then this
function only increments num_blocks once without counting the number of
blocks. I expected something like num_blocks +=3D pnum / block_size.  What
is the relationship between bytes, count, and blocks in this function?

> +        } else {
> +            break;
> +        }
> +    }
> +out:
> +    return ret;
> +}
> +
>  /*
>   * Flush ALL BDSes regardless of if they are reachable via a BlkBackend =
or not.
>   */
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 791de6a59c..43f90591b9 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -1296,6 +1296,11 @@ int coroutine_fn bdrv_co_block_status_from_backing=
(BlockDriverState *bs,
>                                                     int64_t *pnum,
>                                                     int64_t *map,
>                                                     BlockDriverState **fi=
le);
> +int coroutine_fn bdrv_co_get_lba_status(BdrvChild *child,
> +                                        int64_t offset,
> +                                        int64_t bytes,
> +                                        uint32_t *num_blocks,
> +                                        uint32_t *is_deallocated);

Should this function be in include/block/block.h (the public API) so
that any part of QEMU can call it? It's not an internal API.

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7whzUACgkQnKSrs4Gr
c8gYdAgAudHT7n+s61+IaL9iTnUtDYoeqPgLRMjl1GXwaGt+NGdeUBlUAStKKX+6
4p3Bm9+FmxcC3RUwuRK4XMrFz0nmZrz4k2iRzvivjPWCJMwscJLynkK5r/UEscih
wcEq+SUcERCDNNa7Te4cCLZ2FdtRLvQBW6CcDoY5sqDKy4JQYDdTWfpJcWPVpyEa
d2ZKqg1C/4PEzyu18EsKxXE5lPwq4UWSx4qa1ozlxdp68Ivx52KW6zNsn8H1gjvq
owxsP+mio8cJVfZxu/6mu5mT5hiYqiUAFsShWU5yKLv494Ss1xO89LQUwSYqPFCc
1A0abaDzDOSbrQOUPqD6Yo0pIypE+w==
=tcV6
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--



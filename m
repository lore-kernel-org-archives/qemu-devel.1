Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC34CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 12:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA562089C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 12:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA562089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLRKP-00061b-9C
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 08:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iLRJG-0004d8-9w
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iLRJC-0000IX-SI
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:24:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52370)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iLRJC-0000Hz-Jj
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:24:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A5E5307D986;
 Fri, 18 Oct 2019 12:24:41 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-198.ams2.redhat.com
 [10.36.117.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD88560A35;
 Fri, 18 Oct 2019 12:24:37 +0000 (UTC)
Date: Fri, 18 Oct 2019 14:24:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v7 1/4] block: introducing 'bdrv_co_delete_file' interface
Message-ID: <20191018122436.GD6122@localhost.localdomain>
References: <20190903135708.21624-1-danielhb413@gmail.com>
 <20190903135708.21624-2-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190903135708.21624-2-danielhb413@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 18 Oct 2019 12:24:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.09.2019 um 15:57 hat Daniel Henrique Barboza geschrieben:
> Adding to Block Drivers the capability of being able to clean up
> its created files can be useful in certain situations. For the
> LUKS driver, for instance, a failure in one of its authentication
> steps can leave files in the host that weren't there before.
>=20
> This patch adds the 'bdrv_co_delete_file' interface to block
> drivers and add it to the 'file' driver in file-posix.c.The

Missing space between "file-posix.c.The"

> implementation is given by 'raw_co_delete_file'.
>=20
> Suggested-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  block/file-posix.c        | 28 ++++++++++++++++++++++++++++
>  include/block/block_int.h |  6 ++++++
>  2 files changed, 34 insertions(+)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index fbeb0068db..52756de522 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2390,6 +2390,33 @@ static int coroutine_fn raw_co_create_opts(const=
 char *filename, QemuOpts *opts,
>      return raw_co_create(&options, errp);
>  }
> =20
> +/**
> + * Co-routine function that erases a regular file.
> + */

We don't have function comments for other BdrvDriver callbacks. It may
be appropriate to have a comment when there is something special going
on here that differs from a normal implementation. But this specific
comment is even redundant with the function name, so I think we don't
need it.

> +static int coroutine_fn raw_co_delete_file(BlockDriverState *bs,
> +                                           Error **errp)
> +{
> +    struct stat st;
> +    int ret;
> +
> +    if (!(stat(bs->filename, &st) =3D=3D 0) || !S_ISREG(st.st_mode)) {
> +        ret =3D -ENOENT;
> +        error_setg_errno(errp, -ret, "%s is not a regular file",
> +                         bs->filename);
> +        goto done;

There is no cleanup code, so a direct return -ENOENT would be simpler.

> +    }
> +
> +    ret =3D unlink(bs->filename);
> +    if (ret < 0) {
> +        ret =3D -errno;
> +        error_setg_errno(errp, -ret, "Error when deleting file %s",
> +                         bs->filename);
> +    }
> +
> +done:
> +    return ret;
> +}
> +
>  /*
>   * Find allocation range in @bs around offset @start.
>   * May change underlying file descriptor's file offset.
> @@ -2942,6 +2969,7 @@ BlockDriver bdrv_file =3D {
>      .bdrv_co_block_status =3D raw_co_block_status,
>      .bdrv_co_invalidate_cache =3D raw_co_invalidate_cache,
>      .bdrv_co_pwrite_zeroes =3D raw_co_pwrite_zeroes,
> +    .bdrv_co_delete_file =3D raw_co_delete_file,
> =20
>      .bdrv_co_preadv         =3D raw_co_preadv,
>      .bdrv_co_pwritev        =3D raw_co_pwritev,
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 0422acdf1c..a959ec2d1e 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -314,6 +314,12 @@ struct BlockDriver {
>       */
>      int coroutine_fn (*bdrv_co_flush)(BlockDriverState *bs);
> =20
> +    /*
> +     * Delete a local created file.
> +     */

No reason to restrict this to "local", even if for now file-posix is the
only driver that implements it. This can change later.

The comment fits in a single line.

> +    int coroutine_fn (*bdrv_co_delete_file)(BlockDriverState *bs,
> +                                            Error **errp);
> +

Kevin


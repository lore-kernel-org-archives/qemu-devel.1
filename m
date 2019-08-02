Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F344AC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA15B2087C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA15B2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hta7C-0005kp-3v
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 12:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32938)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hta5k-0002kx-UM
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hta5j-0002Al-BF
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:07:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46950)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hta5j-00029x-3Q
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:07:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ADDF02BE9C;
 Fri,  2 Aug 2019 16:07:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-107.ams2.redhat.com
 [10.36.117.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E68E85D9E2;
 Fri,  2 Aug 2019 16:07:32 +0000 (UTC)
Date: Fri, 2 Aug 2019 18:07:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <20190802160731.GF6379@localhost.localdomain>
References: <20190628194512.21311-1-danielhb413@gmail.com>
 <20190628194512.21311-2-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190628194512.21311-2-danielhb413@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 02 Aug 2019 16:07:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 1/4] block: introducing
 'bdrv_co_delete_file' interface
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
Cc: jsnow@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.06.2019 um 21:45 hat Daniel Henrique Barboza geschrieben:
> Adding to Block Drivers the capability of being able to clean up
> its created files can be useful in certain situations. For the
> LUKS driver, for instance, a failure in one of its authentication
> steps can leave files in the host that weren't there before.
>=20
> This patch adds the 'bdrv_co_delete_file' interface to block
> drivers and add it to the 'file' driver in file-posix.c. The
> implementation is given by 'raw_co_delete_file'. The helper
> 'bdrv_path_is_regular_file' is being used only in raw_co_delete_file
> at this moment, but it will be used inside LUKS in a later patch.
> Foreseeing this future use, let's put it in block.c and make it
> public.
>=20
> Suggested-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  block.c                   | 11 +++++++++++
>  block/file-posix.c        | 28 ++++++++++++++++++++++++++++
>  include/block/block.h     |  1 +
>  include/block/block_int.h |  6 ++++++
>  4 files changed, 46 insertions(+)
>=20
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -309,6 +309,12 @@ struct BlockDriver {
>       */
>      int coroutine_fn (*bdrv_co_flush)(BlockDriverState *bs);
> =20
> +    /*
> +     * Delete a local created file.
> +     */
> +    int coroutine_fn (*bdrv_co_delete_file)(const char *filename,
> +                                            Error **errp);

I wonder if it wouldn't make more sense to pass a BlockDriverState
instead of a filename. In the create options we usually have a BDS
around, so it should be possible to use.

The only case where it wouldn't work is if creating the image file
worked, but bdrv_open() fails. I think this is unlikely, and it's even
more unlikely that unlinking such a file would then work, so I wouldn't
see it as a problem.

The reason why I'm suggesting this is that we've spent a lot of time in
the past years to change open and create to an interface that doesn't
use only filenames, because filenames cover only part of the possibe
block devices.

So I'm kind of hesitant to add a new interface that can only use
filenames, while we know that filenames just don't quite cut it in the
general case - especially if using a BDS, which already has all the
information needed, is possible as an alternative.

>      /*
>       * Flushes all data that was already written to the OS all the way=
 down to
>       * the disk (for example file-posix.c calls fsync()).
> --=20
> 2.20.1
>=20
> diff --git a/block.c b/block.c
> index c139540f2b..6e2b0f528d 100644
> --- a/block.c
> +++ b/block.c
> @@ -621,6 +621,17 @@ int get_tmp_filename(char *filename, int size)
>  #endif
>  }
> =20
> +/**
> + * Helper that checks if a given string represents a regular
> + * local file.
> + */
> +bool bdrv_path_is_regular_file(const char *path)
> +{
> +    struct stat st;
> +
> +    return (stat(path, &st) =3D=3D 0) && S_ISREG(st.st_mode);
> +}
> +
>  /*
>   * Detect host devices. By convention, /dev/cdrom[N] is always
>   * recognized as a host CDROM.

This hunk isn't generic, it belong in file-posix.c

Kevin


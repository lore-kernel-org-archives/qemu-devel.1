Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC44C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3693A22210
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kbd0qtqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3693A22210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT4YJ-0002Ou-4y
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 10:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kT4WV-0001bs-Ox
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 10:46:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57579)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kT4WR-0001JY-Na
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 10:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602773186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1CrKcYMlXGdS8unutP6RVch3537Z4VtAdLBQRDgtV1c=;
 b=Kbd0qtqefZD40LXexbn3DGDmYAurTQTKSHNwuEaQp5xMcYYqASmGdkbE+4/OMllnija8WE
 IU9iumqwbLPDS5Ppa29Btv8d9BacuTDi5w5TFCCqwHBbPpSur3ulDuGvK+MBcKCS4q7492
 r6tz8vmk5B61r4IGQNpMIdR1lrVCuXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-8pnC-9S_OyOX3hH3kGAKzw-1; Thu, 15 Oct 2020 10:46:23 -0400
X-MC-Unique: 8pnC-9S_OyOX3hH3kGAKzw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EED5F87952A;
 Thu, 15 Oct 2020 14:46:21 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5920476642;
 Thu, 15 Oct 2020 14:46:16 +0000 (UTC)
Subject: Re: [PATCH v2 02/20] fuse: Allow exporting BDSs via FUSE
To: Kevin Wolf <kwolf@redhat.com>
References: <20200922104932.46384-1-mreitz@redhat.com>
 <20200922104932.46384-3-mreitz@redhat.com>
 <20201015085703.GB4610@merkur.fritz.box>
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
Message-ID: <2db9dbfe-137a-4cdc-08ab-aaa1aed26423@redhat.com>
Date: Thu, 15 Oct 2020 16:46:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201015085703.GB4610@merkur.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cPK7DYyCh5Gyo1nNiQruznzpVTaE4o3Tp"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cPK7DYyCh5Gyo1nNiQruznzpVTaE4o3Tp
Content-Type: multipart/mixed; boundary="OhHfQFOO1hKbM8ZT0AcMNFZGHVTKUDjz8"

--OhHfQFOO1hKbM8ZT0AcMNFZGHVTKUDjz8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.10.20 10:57, Kevin Wolf wrote:
> Am 22.09.2020 um 12:49 hat Max Reitz geschrieben:
>> block-export-add type=3Dfuse allows mounting block graph nodes via FUSE =
on
>> some existing regular file.  That file should then appears like a raw
>> disk image, and accesses to it result in accesses to the exported BDS.
>>
>> Right now, we only implement the necessary block export functions to set
>> it up and shut it down.  We do not implement any access functions, so
>> accessing the mount point only results in errors.  This will be
>> addressed by a followup patch.
>>
>> We keep a hash table of exported mount points, because we want to be
>> able to detect when users try to use a mount point twice.  This is
>> because we invoke stat() to check whether the given mount point is a
>> regular file, but if that file is served by ourselves (because it is
>> already used as a mount point), then this stat() would have to be served
>> by ourselves, too, which is impossible to do while we (as the caller)
>> are waiting for it to settle.  Therefore, keep track of mount point
>> paths to at least catch the most obvious instances of that problem.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  qapi/block-export.json   |  24 +++-
>>  include/block/fuse.h     |  30 +++++
>>  block.c                  |   1 +
>>  block/export/export.c    |   4 +
>>  block/export/fuse.c      | 253 +++++++++++++++++++++++++++++++++++++++
>>  block/export/meson.build |   1 +
>>  6 files changed, 311 insertions(+), 2 deletions(-)
>>  create mode 100644 include/block/fuse.h
>>  create mode 100644 block/export/fuse.c
>>
>> diff --git a/qapi/block-export.json b/qapi/block-export.json
>> index 0c045dfe7b..cb5bd54cbf 100644
>> --- a/qapi/block-export.json
>> +++ b/qapi/block-export.json
>> @@ -174,6 +174,21 @@
>>  ##
>>  { 'command': 'nbd-server-stop' }
>> =20
>> +##
>> +# @BlockExportOptionsFuse:
>> +#
>> +# Options for exporting a block graph node on some (file) mountpoint
>> +# as a raw image.
>> +#
>> +# @mountpoint: Path on which to export the block device via FUSE.
>> +#              This must point to an existing regular file.
>> +#
>> +# Since: 5.2
>> +##
>> +{ 'struct': 'BlockExportOptionsFuse',
>> +  'data': { 'mountpoint': 'str' },
>> +  'if': 'defined(CONFIG_FUSE)' }
>> +
>>  ##
>>  # @BlockExportType:
>>  #
>> @@ -181,10 +196,13 @@
>>  #
>>  # @nbd: NBD export
>>  #
>> +# @fuse: Fuse export (since: 5.2)
>=20
> s/Fuse/FUSE/?

Tomato, TOMATO.

Sure. :)

>> +#
>>  # Since: 4.2
>>  ##
>>  { 'enum': 'BlockExportType',
>> -  'data': [ 'nbd' ] }
>> +  'data': [ 'nbd',
>> +            { 'name': 'fuse', 'if': 'defined(CONFIG_FUSE)' } ] }
>> =20
>>  ##
>>  # @BlockExportOptions:
>> @@ -213,7 +231,9 @@
>>              '*writethrough': 'bool' },
>>    'discriminator': 'type',
>>    'data': {
>> -      'nbd': 'BlockExportOptionsNbd'
>> +      'nbd': 'BlockExportOptionsNbd',
>> +      'fuse': { 'type': 'BlockExportOptionsFuse',
>> +                'if': 'defined(CONFIG_FUSE)' }
>>     } }
>> =20
>>  ##
>> diff --git a/include/block/fuse.h b/include/block/fuse.h
>> new file mode 100644
>> index 0000000000..ffa91fe364
>> --- /dev/null
>> +++ b/include/block/fuse.h
>> @@ -0,0 +1,30 @@
>> +/*
>> + * Present a block device as a raw image through FUSE
>> + *
>> + * Copyright (c) 2020 Max Reitz <mreitz@redhat.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; under version 2 or later of the Licens=
e.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef BLOCK_FUSE_H
>> +#define BLOCK_FUSE_H
>> +
>> +#ifdef CONFIG_FUSE
>> +
>> +#include "block/export.h"
>> +
>> +extern const BlockExportDriver blk_exp_fuse;
>> +
>> +#endif /* CONFIG_FUSE */
>> +
>> +#endif
>> diff --git a/block.c b/block.c
>> index acde53f92a..7bf45f6ede 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -26,6 +26,7 @@
>>  #include "block/trace.h"
>>  #include "block/block_int.h"
>>  #include "block/blockjob.h"
>> +#include "block/fuse.h"
>>  #include "block/nbd.h"
>>  #include "block/qdict.h"
>>  #include "qemu/error-report.h"
>> diff --git a/block/export/export.c b/block/export/export.c
>> index 64d39a6934..ba866d6ba7 100644
>> --- a/block/export/export.c
>> +++ b/block/export/export.c
>> @@ -16,6 +16,7 @@
>>  #include "block/block.h"
>>  #include "sysemu/block-backend.h"
>>  #include "block/export.h"
>> +#include "block/fuse.h"
>>  #include "block/nbd.h"
>>  #include "qapi/error.h"
>>  #include "qapi/qapi-commands-block-export.h"
>> @@ -24,6 +25,9 @@
>> =20
>>  static const BlockExportDriver *blk_exp_drivers[] =3D {
>>      &blk_exp_nbd,
>> +#ifdef CONFIG_FUSE
>> +    &blk_exp_fuse,
>> +#endif
>>  };
>> =20
>>  /* Only accessed from the main thread */
>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>> new file mode 100644
>> index 0000000000..75f11d2514
>> --- /dev/null
>> +++ b/block/export/fuse.c
>> @@ -0,0 +1,253 @@
>> +/*
>> + * Present a block device as a raw image through FUSE
>> + *
>> + * Copyright (c) 2020 Max Reitz <mreitz@redhat.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; under version 2 or later of the Licens=
e.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#define FUSE_USE_VERSION 31
>> +
>> +#include "qemu/osdep.h"
>> +#include "block/aio.h"
>> +#include "block/block.h"
>> +#include "block/export.h"
>> +#include "block/fuse.h"
>> +#include "block/qapi.h"
>> +#include "qapi/error.h"
>> +#include "qapi/qapi-commands-block.h"
>> +#include "sysemu/block-backend.h"
>> +
>> +#include <fuse.h>
>> +#include <fuse_lowlevel.h>
>> +
>> +
>> +typedef struct FuseExport {
>> +    BlockExport common;
>> +
>> +    struct fuse_session *fuse_session;
>> +    struct fuse_buf fuse_buf;
>> +    bool mounted, fd_handler_set_up;
>> +
>> +    char *mountpoint;
>> +    bool writable;
>> +} FuseExport;
>> +
>> +static GHashTable *exports;
>> +static const struct fuse_lowlevel_ops fuse_ops;
>> +
>> +static void fuse_export_shutdown(BlockExport *exp);
>> +static void fuse_export_delete(BlockExport *exp);
>> +
>> +static void init_fuse(void);
>> +static int setup_fuse_export(FuseExport *exp, const char *mountpoint,
>> +                             Error **errp);
>> +static void read_from_fuse_export(void *opaque);
>> +
>> +static bool is_regular_file(const char *path, Error **errp);
>> +
>> +
>> +static int fuse_export_create(BlockExport *blk_exp,
>> +                              BlockExportOptions *blk_exp_args,
>> +                              Error **errp)
>> +{
>> +    FuseExport *exp =3D container_of(blk_exp, FuseExport, common);
>> +    BlockExportOptionsFuse *args =3D &blk_exp_args->u.fuse;
>> +    int ret;
>> +
>> +    assert(blk_exp_args->type =3D=3D BLOCK_EXPORT_TYPE_FUSE);
>> +
>> +    init_fuse();
>> +
>> +    /*
>> +     * It is important to do this check before calling is_regular_file(=
) --
>> +     * that function will do a stat(), which we would have to handle if=
 we
>> +     * already exported something on @mountpoint.  But we cannot, becau=
se
>> +     * we are currently caught up here.
>> +     * (Note that ideally we would want to resolve relative paths here,
>> +     * but bdrv_make_absolute_filename() might do the wrong thing for
>> +     * paths that contain colons, and realpath() would resolve symlinks=
,
>> +     * which we do not want: The mount point is not going to be the
>> +     * symlink's destination, but the link itself.)
>> +     * So this will not catch all potential clashes, but hopefully at
>> +     * least the most common one of specifying exactly the same path
>> +     * string twice.
>> +     */
>> +    if (g_hash_table_contains(exports, args->mountpoint)) {
>> +        error_setg(errp, "There already is a FUSE export on '%s'",
>> +                   args->mountpoint);
>> +        ret =3D -EEXIST;
>> +        goto fail;
>> +    }
>=20
> I guess the proper solution would be to make block export creation
> asynchronous so that we can actually serve that request in the
> background.
>=20
> Something for another day...
>=20
>> +
>> +    if (!is_regular_file(args->mountpoint, errp)) {
>> +        ret =3D -EINVAL;
>> +        goto fail;
>> +    }
>> +
>> +    exp->mountpoint =3D g_strdup(args->mountpoint);
>> +    exp->writable =3D blk_exp_args->writable;
>> +
>> +    ret =3D setup_fuse_export(exp, args->mountpoint, errp);
>> +    if (ret < 0) {
>> +        goto fail;
>> +    }
>> +
>> +    g_hash_table_insert(exports, g_strdup(args->mountpoint), NULL);
>> +    return 0;
>> +
>> +fail:
>> +    fuse_export_shutdown(blk_exp);
>> +    fuse_export_delete(blk_exp);
>=20
> Why fuse_export_shutdown()? The only thing to possibly undo at
> this point is allocating exp->mountpoint, which is freed in
> fuse_export_delete().

I just realized it=E2=80=99s not only a question of style, but even technic=
ally
wrong to do so.  fuse_export_shutdown() drops the mount point path from
the @exports hash table, which shouldn=E2=80=99t be done if we got here fro=
m the
g_hash_table_contains() condition.

That could be fixed by introducing a new label that won=E2=80=99t execute
fuse_export_shutdown(), but we can also just let setup_fuse_export()
call that.

> Or can setup_fuse_export() fail without cleaning up? I hope not.
>=20
>> +    return ret;
>> +}
>> +
>> +/**
>> + * Ensure that the global FUSE context is set up.
>> + */
>> +static void init_fuse(void)
>> +{
>> +    if (exports) {
>> +        return;
>> +    }
>> +
>> +    exports =3D g_hash_table_new_full(g_str_hash, g_str_equal, g_free, =
NULL);
>> +}
>> +
>> +/**
>> + * Create exp->fuse_session and mount it.
>> + */
>> +static int setup_fuse_export(FuseExport *exp, const char *mountpoint,
>> +                             Error **errp)
>> +{
>> +    const char *fuse_argv[2];
>> +    struct fuse_args fuse_args;
>> +    int ret;
>> +
>> +    fuse_argv[0] =3D ""; /* Dummy program name */
>> +    fuse_argv[1] =3D NULL;
>> +    fuse_args =3D (struct fuse_args)FUSE_ARGS_INIT(1, (char **)fuse_arg=
v);
>> +
>> +    exp->fuse_session =3D fuse_session_new(&fuse_args, &fuse_ops,
>> +                                         sizeof(fuse_ops), exp);
>> +    if (!exp->fuse_session) {
>> +        error_setg(errp, "Failed to set up FUSE session");
>> +        return -EIO;
>> +    }
>> +
>> +    ret =3D fuse_session_mount(exp->fuse_session, mountpoint);
>> +    if (ret < 0) {
>> +        error_setg(errp, "Failed to mount FUSE session to export");
>> +        return -EIO;
>=20
> Oh, it can. :-(
>=20
> I think it would be better to call fuse_export_shutdown() here so that
> the function doesn't change the state when it returns failure.

I suppose then this function (setup_fuse_export()) should also add the
mount point name from the @exports hash table, so it makes sense to drop
it via fuse_export_shutdown().

But then yeah, why not.  Makes sense.

>> +    }
>> +    exp->mounted =3D true;
>> +
>> +    aio_set_fd_handler(exp->common.ctx,
>> +                       fuse_session_fd(exp->fuse_session), true,
>> +                       read_from_fuse_export, NULL, NULL, exp);
>> +    exp->fd_handler_set_up =3D true;
>> +
>> +    return 0;
>> +}
>> +
>> +/**
>> + * Callback to be invoked when the FUSE session FD can be read from.
>> + * (This is basically the FUSE event loop.)
>> + */
>> +static void read_from_fuse_export(void *opaque)
>> +{
>> +    FuseExport *exp =3D opaque;
>> +    int ret;
>> +
>> +    blk_exp_ref(&exp->common);
>> +
>> +    ret =3D fuse_session_receive_buf(exp->fuse_session, &exp->fuse_buf)=
;
>=20
> The fuse_session_loop() implementation seems to imply that we should
> retry on EINTR.

OK.  I see you=E2=80=99re digging into libfuse already. :)

>> +    if (ret < 0) {
>> +        goto out;
>> +    }
>> +
>> +    fuse_session_process_buf(exp->fuse_session, &exp->fuse_buf);
>> +
>> +out:
>> +    blk_exp_unref(&exp->common);
>> +}
>> +
>> +static void fuse_export_shutdown(BlockExport *blk_exp)
>> +{
>> +    FuseExport *exp =3D container_of(blk_exp, FuseExport, common);
>> +
>> +    if (exp->fuse_session) {
>> +        fuse_session_exit(exp->fuse_session);
>> +
>> +        if (exp->mounted) {
>> +            fuse_session_unmount(exp->fuse_session);
>> +            exp->mounted =3D false;
>> +        }
>> +
>> +        if (exp->fd_handler_set_up) {
>> +            aio_set_fd_handler(exp->common.ctx,
>> +                               fuse_session_fd(exp->fuse_session), true=
,
>> +                               NULL, NULL, NULL, NULL);
>> +            exp->fd_handler_set_up =3D false;
>> +        }
>> +
>> +        fuse_session_destroy(exp->fuse_session);
>> +        exp->fuse_session =3D NULL;
>=20
> What happens if a request is still in flight?
>=20
> Oh, can't happen because the driver is fully synchronous after this
> series. Fair enough, making it asynchronous can come on top of it.

(I had multiple approaches of handling parallel requests, but none made
a substantial performance difference, which is why I left the driver in
the most simple form for this first proposal.)

> However, I think we should move fuse_session_unmount() and
> fuse_session_destroy() to .delete instead of .shutdown to avoid setting
> up a trap for whoever introduces async requests to the FUSE export.

Yes, makes sense.

>> +    }
>> +
>> +    if (exp->mountpoint) {
>> +        g_hash_table_remove(exports, exp->mountpoint);
>> +    }
>> +}
>> +
>> +static void fuse_export_delete(BlockExport *blk_exp)
>> +{
>> +    FuseExport *exp =3D container_of(blk_exp, FuseExport, common);
>> +
>> +    free(exp->fuse_buf.mem);
>> +    g_free(exp->mountpoint);
>> +}
>> +
>> +/**
>> + * Check whether @path points to a regular file.  If not, put an
>> + * appropriate message into *errp.
>> + */
>> +static bool is_regular_file(const char *path, Error **errp)
>> +{
>> +    struct stat statbuf;
>> +    int ret;
>> +
>> +    ret =3D stat(path, &statbuf);
>> +    if (ret < 0) {
>> +        error_setg_errno(errp, errno, "Failed to stat '%s'", path);
>> +        return false;
>> +    }
>> +
>> +    if (!S_ISREG(statbuf.st_mode)) {
>> +        error_setg(errp, "'%s' is not a regular file", path);
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>=20
> This is obviously racy (TOCTOU), but if I understand correctly, we use
> it only to provide a nicer error message than if fuse_session_mount()
> fails, so this is fine.

It=E2=80=99s a check provided for convenience, yes.  More important is perh=
aps
that users might provide a directory instead of a file as the mount
point, which wouldn=E2=80=99t work.  (You=E2=80=99ll just get errors back. =
 Which isn=E2=80=99t
a catastrophe, it=E2=80=99s just nice to tell users early and explicitly th=
at
that won=E2=80=99t work.)

Max


--OhHfQFOO1hKbM8ZT0AcMNFZGHVTKUDjz8--

--cPK7DYyCh5Gyo1nNiQruznzpVTaE4o3Tp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+IYLYACgkQ9AfbAGHV
z0ATuAf/fBnEXbkZ8cJr/AHg84oqsgSfc7nh3OqY1Sdgv+ar0DjhJe79mXSH+6AV
kYtXkiUr7Fy70ElolhtSPVTyBxkOFTIuPJ3seLBYMDiTpG8ZW6jgKBnMvOChG7m+
smDf5dRw/CXAe2ILyBIx6ijh1gdtBJfrZPC16CVV2x2Nst8dMbFymb3jsx4BgQzN
Oo5chfojHt/O5cIxm1LBbKg8tfjbGIpTu9lyv1gTA+NC45uvS1WfqjBO5altvVy2
MqF1oeEwXXqPR2SVeE0PEsuJEE/63AIZiltMkx/AEJ6Y1/efP5pFVkunzcSRiES/
7f0reMJ/CMhyQi0IMxgv3FvE0X32iw==
=rsqq
-----END PGP SIGNATURE-----

--cPK7DYyCh5Gyo1nNiQruznzpVTaE4o3Tp--



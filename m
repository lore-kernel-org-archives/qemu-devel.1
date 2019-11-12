Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36FCC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 09:40:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9E420650
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 09:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1Iezslw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9E420650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUSet-0007ZG-Sa
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 04:40:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iUSe2-0006NE-BF
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iUSe0-0007yR-9M
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:39:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33900
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iUSdz-0007y8-VX
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:39:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573551567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LM/+iaXxJ6sy6RVvMX055G/edcyt+JOeVXrhbN5Be4M=;
 b=L1IezslwyiLmnQJAKTZaMmkrAuyGXKBGCov9SL7peMZV7SUGkSBa2wUhEMHVHiNGPFKyrC
 hJQqmR4W6FDTOiwHLpAn+Ac5ercci2gbDdiq2D73ZN51XX18j8TGTVsUQgO9kGt7lNeqEU
 UxL4Xc2YoumXcJke6fOq+OEaiZ+SoTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-xskc6DZqO-aD49nX8DHtDg-1; Tue, 12 Nov 2019 04:39:23 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C31A4DC20;
 Tue, 12 Nov 2019 09:39:22 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-43.ams2.redhat.com [10.36.117.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DACFD100EBCC;
 Tue, 12 Nov 2019 09:39:13 +0000 (UTC)
Date: Tue, 12 Nov 2019 10:39:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Subject: Re: [PATCH v6 1/3] block: introduce compress filter driver
Message-ID: <20191112093912.GC5364@linux.fritz.box>
References: <1573488277-794975-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1573488277-794975-2-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <1573488277-794975-2-git-send-email-andrey.shinkevich@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: xskc6DZqO-aD49nX8DHtDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: vsementsov@virtuozzo.com, qemu-block@nongnu.org, armbru@redhat.com,
 qemu-devel@nongnu.org, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.11.2019 um 17:04 hat Andrey Shinkevich geschrieben:
> Allow writing all the data compressed through the filter driver.
> The written data will be aligned by the cluster size.
> Based on the QEMU current implementation, that data can be written to
> unallocated clusters only. May be used for a backup job.
>=20
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

> +static BlockDriver bdrv_compress =3D {
> +    .format_name                        =3D "compress",
> +
> +    .bdrv_open                          =3D zip_open,
> +    .bdrv_child_perm                    =3D zip_child_perm,

Why do you call the functions zip_* when the driver is called compress?
I think zip would be a driver for zip archives, which we don't use here.

> +    .bdrv_getlength                     =3D zip_getlength,
> +    .bdrv_co_truncate                   =3D zip_co_truncate,
> +
> +    .bdrv_co_preadv                     =3D zip_co_preadv,
> +    .bdrv_co_preadv_part                =3D zip_co_preadv_part,
> +    .bdrv_co_pwritev                    =3D zip_co_pwritev,
> +    .bdrv_co_pwritev_part               =3D zip_co_pwritev_part,

If you implement .bdrv_co_preadv/pwritev_part, isn't the implementation
of .bdrv_co_preadv/pwritev (without _part) dead code?

> +    .bdrv_co_pwrite_zeroes              =3D zip_co_pwrite_zeroes,
> +    .bdrv_co_pdiscard                   =3D zip_co_pdiscard,
> +    .bdrv_refresh_limits                =3D zip_refresh_limits,
> +
> +    .bdrv_eject                         =3D zip_eject,
> +    .bdrv_lock_medium                   =3D zip_lock_medium,
> +
> +    .bdrv_co_block_status               =3D bdrv_co_block_status_from_ba=
cking,

Why not use bs->file? (Well, apart from the still not merged filter
series by Max...)

> +    .bdrv_recurse_is_first_non_filter   =3D zip_recurse_is_first_non_fil=
ter,
> +
> +    .has_variable_length                =3D true,
> +    .is_filter                          =3D true,
> +};

Kevin



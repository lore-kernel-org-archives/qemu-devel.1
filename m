Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE41C2BA83
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E49520726
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFTlsXlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E49520726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3bRs-0007na-QW
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 03:08:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ndevos@redhat.com>) id 1j3bRG-0007IS-HJ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:07:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ndevos@redhat.com>) id 1j3bRE-0005NN-Ks
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:07:33 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46317
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ndevos@redhat.com>) id 1j3bRE-0005MW-FT
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:07:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581926851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jaonyWJZxhgRMRnCzX1UAbvzZ8RaIogi23Du3ZJ7WPc=;
 b=KFTlsXlqfnyBtj7TXFhHG2enetSgnKOr/Ct8qai8Jl+gnUhcIj71Ju2JunEVbWsuy1E4pF
 HG8xLFNcvtQXg9cMVppeicKlxAHyWbQKz9xQJP0HoSGHEesWu8VaJ2cbAz0YvM03wqonLs
 4YwvtV+LgMtNhZaJqUue/0nChqfSJOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-VJfwyQEaMh2Dd-5YsE-qLQ-1; Mon, 17 Feb 2020 03:06:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B1A0800D5B;
 Mon, 17 Feb 2020 08:06:16 +0000 (UTC)
Received: from localhost (unknown [10.36.118.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C10CA5C28D;
 Mon, 17 Feb 2020 08:06:15 +0000 (UTC)
Date: Mon, 17 Feb 2020 09:06:14 +0100
From: Niels de Vos <ndevos@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [GEDI] [PATCH 07/17] gluster: Drop useless has_zero_init callback
Message-ID: <20200217080614.GG239686@ndevos-x270.lan.nixpanic.net>
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-8-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200131174436.2961874-8-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: VJfwyQEaMh2Dd-5YsE-qLQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:GLUSTER" <integration@gluster.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, david.edmondson@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 31, 2020 at 11:44:26AM -0600, Eric Blake wrote:
> block.c already defaults to 0 if we don't provide a callback; there's
> no need to write a callback that always fails.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Niels de Vos <ndevos@redhat.com>

> ---
>  block/gluster.c | 14 --------------
>  1 file changed, 14 deletions(-)
>=20
> diff --git a/block/gluster.c b/block/gluster.c
> index 4fa4a77a4777..9d952c70981b 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -1357,12 +1357,6 @@ static int64_t qemu_gluster_allocated_file_size(Bl=
ockDriverState *bs)
>      }
>  }
>=20
> -static int qemu_gluster_has_zero_init(BlockDriverState *bs)
> -{
> -    /* GlusterFS volume could be backed by a block device */
> -    return 0;
> -}
> -
>  /*
>   * Find allocation range in @bs around offset @start.
>   * May change underlying file descriptor's file offset.
> @@ -1567,8 +1561,6 @@ static BlockDriver bdrv_gluster =3D {
>      .bdrv_co_readv                =3D qemu_gluster_co_readv,
>      .bdrv_co_writev               =3D qemu_gluster_co_writev,
>      .bdrv_co_flush_to_disk        =3D qemu_gluster_co_flush_to_disk,
> -    .bdrv_has_zero_init           =3D qemu_gluster_has_zero_init,
> -    .bdrv_has_zero_init_truncate  =3D qemu_gluster_has_zero_init,
>  #ifdef CONFIG_GLUSTERFS_DISCARD
>      .bdrv_co_pdiscard             =3D qemu_gluster_co_pdiscard,
>  #endif
> @@ -1599,8 +1591,6 @@ static BlockDriver bdrv_gluster_tcp =3D {
>      .bdrv_co_readv                =3D qemu_gluster_co_readv,
>      .bdrv_co_writev               =3D qemu_gluster_co_writev,
>      .bdrv_co_flush_to_disk        =3D qemu_gluster_co_flush_to_disk,
> -    .bdrv_has_zero_init           =3D qemu_gluster_has_zero_init,
> -    .bdrv_has_zero_init_truncate  =3D qemu_gluster_has_zero_init,
>  #ifdef CONFIG_GLUSTERFS_DISCARD
>      .bdrv_co_pdiscard             =3D qemu_gluster_co_pdiscard,
>  #endif
> @@ -1631,8 +1621,6 @@ static BlockDriver bdrv_gluster_unix =3D {
>      .bdrv_co_readv                =3D qemu_gluster_co_readv,
>      .bdrv_co_writev               =3D qemu_gluster_co_writev,
>      .bdrv_co_flush_to_disk        =3D qemu_gluster_co_flush_to_disk,
> -    .bdrv_has_zero_init           =3D qemu_gluster_has_zero_init,
> -    .bdrv_has_zero_init_truncate  =3D qemu_gluster_has_zero_init,
>  #ifdef CONFIG_GLUSTERFS_DISCARD
>      .bdrv_co_pdiscard             =3D qemu_gluster_co_pdiscard,
>  #endif
> @@ -1669,8 +1657,6 @@ static BlockDriver bdrv_gluster_rdma =3D {
>      .bdrv_co_readv                =3D qemu_gluster_co_readv,
>      .bdrv_co_writev               =3D qemu_gluster_co_writev,
>      .bdrv_co_flush_to_disk        =3D qemu_gluster_co_flush_to_disk,
> -    .bdrv_has_zero_init           =3D qemu_gluster_has_zero_init,
> -    .bdrv_has_zero_init_truncate  =3D qemu_gluster_has_zero_init,
>  #ifdef CONFIG_GLUSTERFS_DISCARD
>      .bdrv_co_pdiscard             =3D qemu_gluster_co_pdiscard,
>  #endif
> --=20
> 2.24.1
>=20
> _______________________________________________
> integration mailing list
> integration@gluster.org
> https://lists.gluster.org/mailman/listinfo/integration
>=20



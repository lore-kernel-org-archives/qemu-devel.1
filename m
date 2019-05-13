Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A886CC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FAA92070D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAA92070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55451 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ9Cq-0005Jr-NJ
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 07:33:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hQ98X-00024e-IQ
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hQ98V-0001LM-V0
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:28:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hQ98U-0001KV-Pz
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:28:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id f8so5178751wrt.1
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 04:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=C5scM0EhoZDBCl9zdBg/6udl8HCkO0WkzT79qKgiwEA=;
	b=cI8+QVALwIIcnlgFeb+VVRiqa55DXPosQwDWnHSV19fH99owZHmbf/OSrZO3pQW8mC
	yVjitVIIEwcs1zx7Rf+5p/SA46IEqf5qahGd6e2xRJkOtZUqBTWWWnc2pP5gCHEEoteh
	hEeLuqAVAhJkBQxO5cGPFvD3agaVae4azgAC/mvJNlRnKHbSKb2ExjtDXqNJwzt7c4FW
	F4tdx4IGZ2l0v+1MazrKt11OodtAr8RuO/I8DsFQt2qpJrOpTRlIygo1gNxWHpR3zUYO
	t6fv3A0MULnYafb9yCiO3gVWtZa6xza9x5C0JV+rhBnWplJ2L2Y5FtbAaqwQSIUpzU+G
	/wCw==
X-Gm-Message-State: APjAAAXFASrZtZE3/ohVSENpX6vz8x6S3YiGr5hvvVpahHj1R7MCBiA+
	44P77WQMmgqi6U3F3Rk4QKntUw==
X-Google-Smtp-Source: APXvYqyTo/1hvKfgqph0pEadVfPd7PMUvbTVEWJbFsoEnyMSDkAJ/JXiNNvZGVDPCaYjoImFoWYVgg==
X-Received: by 2002:a5d:4b0b:: with SMTP id v11mr16576170wrq.317.1557746929410;
	Mon, 13 May 2019 04:28:49 -0700 (PDT)
Received: from steredhat (host151-251-static.12-87-b.business.telecomitalia.it.
	[87.12.251.151])
	by smtp.gmail.com with ESMTPSA id g6sm9154645wro.29.2019.05.13.04.28.48
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 13 May 2019 04:28:48 -0700 (PDT)
Date: Mon, 13 May 2019 13:28:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Message-ID: <20190513112846.ggnhopjwbopfexum@steredhat>
References: <20190510162254.8152-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510162254.8152-1-berto@igalia.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] qcow2: Define and use
 QCOW2_COMPRESSED_SECTOR_SIZE
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patch LGTM, just a comment below.

On Fri, May 10, 2019 at 07:22:54PM +0300, Alberto Garcia wrote:
> When an L2 table entry points to a compressed cluster the space used
> by the data is specified in 512-byte sectors. This size is independent
> from BDRV_SECTOR_SIZE and is specific to the qcow2 file format.
> 
> The QCOW2_COMPRESSED_SECTOR_SIZE constant defined in this patch makes
> this explicit.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c  |  5 +++--
>  block/qcow2-refcount.c | 25 ++++++++++++++-----------
>  block/qcow2.c          |  3 ++-
>  block/qcow2.h          |  4 ++++
>  4 files changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 974a4e8656..b36f4aa84a 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -796,8 +796,9 @@ int qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
>          return cluster_offset;
>      }
>  
> -    nb_csectors = ((cluster_offset + compressed_size - 1) >> 9) -
> -                  (cluster_offset >> 9);
> +    nb_csectors =
> +        (cluster_offset + compressed_size - 1) / QCOW2_COMPRESSED_SECTOR_SIZE -
> +        (cluster_offset / QCOW2_COMPRESSED_SECTOR_SIZE);
>  
>      cluster_offset |= QCOW_OFLAG_COMPRESSED |
>                        ((uint64_t)nb_csectors << s->csize_shift);
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index fa7ac1f7cb..780bd49a00 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -1172,12 +1172,11 @@ void qcow2_free_any_clusters(BlockDriverState *bs, uint64_t l2_entry,
>      switch (ctype) {
>      case QCOW2_CLUSTER_COMPRESSED:
>          {
> -            int nb_csectors;
> -            nb_csectors = ((l2_entry >> s->csize_shift) &
> -                           s->csize_mask) + 1;
> -            qcow2_free_clusters(bs,
> -                (l2_entry & s->cluster_offset_mask) & ~511,
> -                nb_csectors * 512, type);
> +            int64_t offset = (l2_entry & s->cluster_offset_mask)
> +                & QCOW2_COMPRESSED_SECTOR_MASK;
> +            int size = QCOW2_COMPRESSED_SECTOR_SIZE *
> +                (((l2_entry >> s->csize_shift) & s->csize_mask) + 1);

What about using int64_t type for the 'size' variable?
(because the qcow2_free_clusters() 'size' parameter is int64_t)

> +            qcow2_free_clusters(bs, offset, size, type);
>          }
>          break;
>      case QCOW2_CLUSTER_NORMAL:
> @@ -1317,9 +1316,12 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
>                          nb_csectors = ((entry >> s->csize_shift) &
>                                         s->csize_mask) + 1;
>                          if (addend != 0) {
> +                            uint64_t coffset = (entry & s->cluster_offset_mask)
> +                                & QCOW2_COMPRESSED_SECTOR_MASK;
>                              ret = update_refcount(
> -                                bs, (entry & s->cluster_offset_mask) & ~511,
> -                                nb_csectors * 512, abs(addend), addend < 0,
> +                                bs, coffset,
> +                                nb_csectors * QCOW2_COMPRESSED_SECTOR_SIZE,
> +                                abs(addend), addend < 0,
>                                  QCOW2_DISCARD_SNAPSHOT);
>                              if (ret < 0) {
>                                  goto fail;
> @@ -1635,9 +1637,10 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
>              nb_csectors = ((l2_entry >> s->csize_shift) &
>                             s->csize_mask) + 1;
>              l2_entry &= s->cluster_offset_mask;
> -            ret = qcow2_inc_refcounts_imrt(bs, res,
> -                                           refcount_table, refcount_table_size,
> -                                           l2_entry & ~511, nb_csectors * 512);
> +            ret = qcow2_inc_refcounts_imrt(
> +                bs, res, refcount_table, refcount_table_size,
> +                l2_entry & QCOW2_COMPRESSED_SECTOR_MASK,
> +                nb_csectors * QCOW2_COMPRESSED_SECTOR_SIZE);
>              if (ret < 0) {
>                  goto fail;
>              }
> diff --git a/block/qcow2.c b/block/qcow2.c
> index a520d116ef..80679a84d2 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -4188,7 +4188,8 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
>  
>      coffset = file_cluster_offset & s->cluster_offset_mask;
>      nb_csectors = ((file_cluster_offset >> s->csize_shift) & s->csize_mask) + 1;
> -    csize = nb_csectors * 512 - (coffset & 511);
> +    csize = nb_csectors * QCOW2_COMPRESSED_SECTOR_SIZE -
> +        (coffset & ~QCOW2_COMPRESSED_SECTOR_MASK);
>  
>      buf = g_try_malloc(csize);
>      if (!buf) {
> diff --git a/block/qcow2.h b/block/qcow2.h
> index fdee297f33..7e796877d6 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -74,6 +74,10 @@
>  #define MIN_CLUSTER_BITS 9
>  #define MAX_CLUSTER_BITS 21
>  
> +/* Defined in the qcow2 spec (compressed cluster descriptor) */
> +#define QCOW2_COMPRESSED_SECTOR_SIZE 512U
> +#define QCOW2_COMPRESSED_SECTOR_MASK (~(QCOW2_COMPRESSED_SECTOR_SIZE - 1))
> +
>  /* Must be at least 2 to cover COW */
>  #define MIN_L2_CACHE_SIZE 2 /* cache entries */
>  


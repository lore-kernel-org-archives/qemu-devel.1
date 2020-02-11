Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF49C3B186
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFDBF2086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdlpxVrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDBF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Xmr-0004D8-R9
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j1Xm8-0003Tj-TP
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j1Xm7-0004s0-NU
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:48:36 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35201
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j1Xm6-0004qz-KJ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581436114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4oIzaT1cOEqoZ+upxTTVZbTLXWPV1CZB4Vo9fFDfrc=;
 b=OdlpxVrUrvxDc7i2uW3mj6Ym/8lZCY9UXr2svs29/K0gNjmLor2NKYYKI3vIBfzeaX2p/w
 i2OyzHAAfCt66BWIWN/Zyd0MPiVIWDw9xA0ZwvocUivTJN0hvtX9KqbC9nX5kUtHlcJzB5
 cMDt+x9iEnOSZN2o/VQVlCinS18u0s0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-mAj8V2QKPruXsKVh4wBEvg-1; Tue, 11 Feb 2020 10:48:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53E1B1B18BC1;
 Tue, 11 Feb 2020 15:48:29 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D26BA5C1B2;
 Tue, 11 Feb 2020 15:48:28 +0000 (UTC)
Subject: Re: [PATCH v2 29/33] block: Make bdrv_filter_default_perms() static
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-30-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6015c40e-2506-7088-22a3-c54bb694580f@redhat.com>
Date: Tue, 11 Feb 2020 09:48:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204170848.614480-30-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: mAj8V2QKPruXsKVh4wBEvg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 11:08 AM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c                   | 12 ++++++------
>   include/block/block_int.h | 10 ----------
>   2 files changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 747a2973f5..091e9cc16a 100644
> --- a/block.c
> +++ b/block.c
> @@ -2194,12 +2194,12 @@ int bdrv_child_refresh_perms(BlockDriverState *bs, BdrvChild *c, Error **errp)
>       return bdrv_child_try_set_perm(c, perms, shared, errp);
>   }
>   
> -void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
> -                               const BdrvChildClass *child_class,
> -                               BdrvChildRole role,
> -                               BlockReopenQueue *reopen_queue,
> -                               uint64_t perm, uint64_t shared,
> -                               uint64_t *nperm, uint64_t *nshared)
> +static void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
> +                                      const BdrvChildClass *child_class,
> +                                      BdrvChildRole role,
> +                                      BlockReopenQueue *reopen_queue,
> +                                      uint64_t perm, uint64_t shared,
> +                                      uint64_t *nperm, uint64_t *nshared)
>   {

Hmm - no comment here...

>       *nperm = perm & DEFAULT_PERM_PASSTHROUGH;
>       *nshared = (shared & DEFAULT_PERM_PASSTHROUGH) | DEFAULT_PERM_UNCHANGED;
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 7b51866678..5e3f512ae8 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -1254,16 +1254,6 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
>    */
>   int bdrv_child_refresh_perms(BlockDriverState *bs, BdrvChild *c, Error **errp);
>   
> -/* Default implementation for BlockDriver.bdrv_child_perm() that can be used by
> - * block filters: Forward CONSISTENT_READ, WRITE, WRITE_UNCHANGED and RESIZE to
> - * all children */
> -void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,

...and you lost the comment here.  It's still a useful comment, so move 
it to the .c (and wing it to keep syntax check happy).  With that,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org



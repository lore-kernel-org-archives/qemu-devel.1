Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C0FC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FDE8207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjtTCJEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDE8207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k93zn-0002wW-Kb
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k93yx-0001zy-12
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:09:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52267
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k93yv-00084Y-9d
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598004548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZ0VqA2qrMPgknKbs6SCPHecscI908hdFc+I02sU6jY=;
 b=RjtTCJEajF7jdTiQ4Dhq3G5n/VVjoDh8mVuDdJgeqtVisqvkZDf2eX80ij9cOmXM8D75c8
 RgmXs7lsHHbut8xgxxpGqYPp1o3HK1Lq3XQBq3A7BDWeBcnSrGb2GDIZ1RPfeh8xpkMhHJ
 x79I3S9Pm6JxStz6TlVSBFRnnOWrwKU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-1Ksi6XYWNU2CamvBxoasNw-1; Fri, 21 Aug 2020 06:09:06 -0400
X-MC-Unique: 1Ksi6XYWNU2CamvBxoasNw-1
Received: by mail-wm1-f72.google.com with SMTP id k12so613635wmj.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 03:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=UpqRrEyhfs6Z3wYjZ1/8FGrZEvS1FPHKK2L98xjDf6E=;
 b=hf8FBm2UHhZpJHeb7Km9124b0/S+1KPjKH0wyU1ZSm3X6RfjYeVkILMa7nBvtdemcV
 tRmIaBbI/9ybMGMXREZwuME74CVzT6gztv2X7ZTcVMmnSw6e3B53hEgA7XmT/6AMchct
 Yx5AVS/TPOJsQBIkNUAKRYfQZ/UmSiyjXE1LZjb8S4SFoYseErgeR4Qp5MuJIQdslkJ5
 5rgMZrtS+bIGna+16a6WZ3Gzp3LHTEksoL7cHS+/Fw6E56fYLThvWB5mzPmG0rQlDGMX
 sIAO2DOO9j7ct47FIvdUD1EagM/xIJT42UOvbP8I6hcV5MGzPFoD/e5wlwPVWtogtzrX
 jl6w==
X-Gm-Message-State: AOAM530lOTVeyPAxnEp1Na0WMaPOuZxc/VSkmjOps24D0ZPlo9sJNaRe
 iwHJyFI0LdJ8r/Dj2QHFsioWqfhtEkd9rih3dG820o4zgfP3oB9q0X35sr/J3dm7JcZDKer4EIZ
 CAK9H/xd8ZetKnfo=
X-Received: by 2002:a1c:5413:: with SMTP id i19mr3025266wmb.139.1598004545642; 
 Fri, 21 Aug 2020 03:09:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4NEcQaLAnc0vSiiz863jioqYl3GEi3DY5oCEjY1RRPU+vKPjGvcX+g1I/4yhlOCly2VMreQ==
X-Received: by 2002:a1c:5413:: with SMTP id i19mr3025238wmb.139.1598004545355; 
 Fri, 21 Aug 2020 03:09:05 -0700 (PDT)
Received: from steredhat (host-79-33-191-244.retail.telecomitalia.it.
 [79.33.191.244])
 by smtp.gmail.com with ESMTPSA id f6sm5039430wme.32.2020.08.21.03.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 03:09:04 -0700 (PDT)
Date: Fri, 21 Aug 2020 12:08:53 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 10/15] block/nvme: Replace qemu_try_blockalign(bs) by
 qemu_try_memalign(pg_sz)
Message-ID: <20200821100853.cup7kfivx4x7khi6@steredhat>
References: <20200820165901.1139109-1-philmd@redhat.com>
 <20200820165901.1139109-11-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200820165901.1139109-11-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:55:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 20, 2020 at 06:58:56PM +0200, Philippe Mathieu-Daudé wrote:
> qemu_try_blockalign() is a generic API that call back to the
> block driver to return its page alignment. As we call from
> within the very same driver, we already know to page alignment
> stored in our state. Remove indirections and use the value from
> BDRVNVMeState.
> This change is required to later remove the BlockDriverState
> argument, to make nvme_init_queue() per hardware, and not per
> block driver.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  block/nvme.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> 
> diff --git a/block/nvme.c b/block/nvme.c
> index ac6bb52043d..f180078e781 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -174,7 +174,7 @@ static void nvme_init_queue(BlockDriverState *bs, NVMeQueue *q,
>  
>      bytes = ROUND_UP(nentries * entry_bytes, s->page_size);
>      q->head = q->tail = 0;
> -    q->queue = qemu_try_blockalign(bs, bytes);
> +    q->queue = qemu_try_memalign(s->page_size, bytes);
>      if (!q->queue) {
>          error_setg(errp, "Cannot allocate queue");
>          return;
> @@ -223,7 +223,7 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
>      if (!q) {
>          return NULL;
>      }
> -    q->prp_list_pages = qemu_try_blockalign(bs,
> +    q->prp_list_pages = qemu_try_memalign(s->page_size,
>                                            s->page_size * NVME_QUEUE_SIZE);
>      if (!q->prp_list_pages) {
>          goto fail;
> @@ -522,7 +522,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>          .cdw10 = cpu_to_le32(0x1),
>      };
>  
> -    id = qemu_try_blockalign(bs, sizeof(*id));
> +    id = qemu_try_memalign(s->page_size, sizeof(*id));
>      if (!id) {
>          error_setg(errp, "Cannot allocate buffer for identify response");
>          goto out;
> @@ -1141,7 +1141,7 @@ static int nvme_co_prw(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
>          return nvme_co_prw_aligned(bs, offset, bytes, qiov, is_write, flags);
>      }
>      trace_nvme_prw_buffered(s, offset, bytes, qiov->niov, is_write);
> -    buf = qemu_try_blockalign(bs, bytes);
> +    buf = qemu_try_memalign(s->page_size, bytes);
>  
>      if (!buf) {
>          return -ENOMEM;
> @@ -1285,7 +1285,7 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
>  
>      assert(s->nr_queues > 1);
>  
> -    buf = qemu_try_blockalign(bs, s->page_size);
> +    buf = qemu_try_memalign(s->page_size, s->page_size);
>      if (!buf) {
>          return -ENOMEM;
>      }
> -- 
> 2.26.2
> 
> 



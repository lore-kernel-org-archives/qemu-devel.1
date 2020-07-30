Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A289C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:20:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66EDE2075F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxFhHoTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EDE2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k15fX-00039v-MQ
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 06:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k15ek-0002er-ET; Thu, 30 Jul 2020 06:19:22 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k15ei-0004Bz-NL; Thu, 30 Jul 2020 06:19:22 -0400
Received: by mail-ot1-x342.google.com with SMTP id v6so8914981ota.13;
 Thu, 30 Jul 2020 03:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VXl1xLlHugazKOiI+mlFXaRQAQifSHJowRp9v1FNkQg=;
 b=JxFhHoTTgdr/tnqVazfTCRqJ4WxLfUOFRN5uNCoMdfMGIlY7cVtjpJ1W9BUnZFYiyZ
 fCbWRAabX8Cn32cr2ogplPPGzshJYx5SZVRQyUJSMBH5jOalDqjI0/V1jT689YY7d+Un
 gBDBcJcSUxeckovHXZKTGRF5B8biPtcRdKv7i+ZdniW5rNgogpTU+aeI34zx066zcrL4
 M3jUDZexr3kyuhZTvr4h42eZYpQJBuvqTr8dBDM3lz4ZKotpzN1KVAZV0VcNwDjTo8iv
 tKM0eww9BNSBpMP7damzLzCr5gjtA9R7ig442oekfiXuNOFapbbzIYAwIRbaGF0s4rRs
 EJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VXl1xLlHugazKOiI+mlFXaRQAQifSHJowRp9v1FNkQg=;
 b=EH+iFsN7eqb/kk86GBkLRV8n/6rZQqfwjF6WwUvmFZZPvfMNeTP5fuDtgra8eSvvMw
 opz8J9WsW5fDXw+N6B5+ZmK9qpmUub75kvDu7E/dZIWPVwcmAmUyZIM0x39oYDaVEVCS
 NPb6nyQqUo1olu3t+gIw3rIsl7dY6FuKMdY/zdb0tiW+nOgatd/1XNRZZu75thUOVADN
 QQCOZVq1Y855xcbDmtqBOmZUbjs3WPSJj07i7oicgF0Iphhz6lDgSINxwIXFl5NHYH1M
 sjGDdD7u0qqFmZ10XhQgcyee1V2iCmjQ0jSecySeVx1h726c+NtFE5Ush14T8esaaUZl
 zKrQ==
X-Gm-Message-State: AOAM533WVNHZUlZZ6G460ciIvQLTRROIxLkMuy4bHCP3wM3U2gB4eTtJ
 /gzcdiiz+9rjyZNkLDmEiWNmqSN0TtgpPFIG434=
X-Google-Smtp-Source: ABdhPJyHQZvxAPWscoJJdEw4v0JZEbzeJjneOPqd39VxABRReR9DDxhVw/tYnuk2zm8kp6DgpIxnEpedUfGaPvCcqTw=
X-Received: by 2002:a9d:7d04:: with SMTP id v4mr1628746otn.319.1596104358351; 
 Thu, 30 Jul 2020 03:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200729220638.344477-1-its@irrelevant.dk>
 <20200729220638.344477-9-its@irrelevant.dk>
In-Reply-To: <20200729220638.344477-9-its@irrelevant.dk>
From: Minwoo Im <minwoo.im.dev@gmail.com>
Date: Thu, 30 Jul 2020 19:19:07 +0900
Message-ID: <CAA7jztf4iYBhcwRJM7AEZ9L-dxL3GW9gc0T-7SerDDXQmpn2bA@mail.gmail.com>
Subject: Re: [PATCH v2 08/16] hw/block/nvme: add request mapping helper
To: Klaus Jensen <its@irrelevant.dk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Keith Busch <kbusch@kernel.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 30, 2020 at 7:06 AM Klaus Jensen <its@irrelevant.dk> wrote:
>
> From: Klaus Jensen <k.jensen@samsung.com>
>
> Introduce the nvme_map helper to remove some noise in the main nvme_rw
> function.
>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/block/nvme.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 952afbb05175..198a26890e0c 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -415,6 +415,15 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
>      return status;
>  }
>
> +static uint16_t nvme_map_dptr(NvmeCtrl *n, NvmeCmd *cmd, size_t len,
> +                         NvmeRequest *req)
> +{
> +    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> +    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
> +
> +    return nvme_map_prp(&req->qsg, &req->iov, prp1, prp2, len, n);
> +}

Let's do something for MPTR laster also when we are right in front of that.

Looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

> +
>  static void nvme_post_cqes(void *opaque)
>  {
>      NvmeCQueue *cq = opaque;
> @@ -602,8 +611,6 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
>      uint32_t nlb  = le32_to_cpu(rw->nlb) + 1;
>      uint64_t slba = le64_to_cpu(rw->slba);
> -    uint64_t prp1 = le64_to_cpu(rw->dptr.prp1);
> -    uint64_t prp2 = le64_to_cpu(rw->dptr.prp2);
>
>      uint8_t lba_index  = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
>      uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
> @@ -620,7 +627,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>          return NVME_LBA_RANGE | NVME_DNR;
>      }
>
> -    if (nvme_map_prp(&req->qsg, &req->iov, prp1, prp2, data_size, n)) {
> +    if (nvme_map_dptr(n, cmd, data_size, req)) {
>          block_acct_invalid(blk_get_stats(n->conf.blk), acct);
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> --
> 2.27.0
>


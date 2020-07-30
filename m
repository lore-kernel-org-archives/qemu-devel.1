Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036D6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34172075F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZhliE1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34172075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k15qr-0000Uq-2c
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 06:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k15pg-0007qM-RU; Thu, 30 Jul 2020 06:30:40 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k15pf-0005l8-20; Thu, 30 Jul 2020 06:30:40 -0400
Received: by mail-pl1-x641.google.com with SMTP id p1so13677043pls.4;
 Thu, 30 Jul 2020 03:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YUXbOG0t/rSjnAlVqL981IQeaYkPyNK8CXym73EY+AA=;
 b=GZhliE1AOJAVy+1DUvy5TQWA/uRctg7eIgOQs1azJCILYMAACcx7XXmI/f7jpr+D5o
 440ko2nHIjDPxL5lWfE1MotGddtddH2yrcx10HeRZB31N5PCZmdwdjIceRdPO0GCB07j
 hduWLg9rvh/ttB+VKM8vokmeoO1eM07YFGxPKmqlv2XYL9QK8u8LVoABXI5UqrERLD2M
 L/w+gwtOqQbP+gkqyYn4hLeaZPXdkx7ZqL1iMi5ksJZrYcnbEumKlkKnilk16dqRP9Ys
 PJRhVIx7xZCnxPHOXzRLwU4vJfNvNrqhqNnYTilGh/HZGo823sZV0DNSYVMgRZHVw0ML
 rzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YUXbOG0t/rSjnAlVqL981IQeaYkPyNK8CXym73EY+AA=;
 b=Fg/lGEiuFmAufxpnvTN4G9clZmQX5xFUfdkbcKnfdutFCeOID8AYFNRgV6pyzESkmt
 Snfgj8iJPy/IUohF8y/sxR47SCMyGSyir/vz20NRKRaZAp167XpCRWaKVJ/25mR/Lc5W
 U7aZ4sL+FVddpBtbdx09EFJeWxyY/5EjIEvHm9FN54tS9EsO+TnMJLD5iv6/i1StraxE
 Zf6kCf3mrE3peTawtkmR/J1QMjuRRXbACjmkj00Qttbia7m1QsMNoRZe5GrUMu3TvG66
 UpDXC1FEmi8D5aTrI1r4sgvXo+w9PvKiFDul7d/GLJ2Scd62Sju2KItNHxO+ZWKvEHLW
 LuXg==
X-Gm-Message-State: AOAM532X+ZJPYSB1Iua43vUGIO24cWfAyoLslfZKRvEqmconkboceaVy
 uFR8NWa7rDXfLXDFDgvV5oc=
X-Google-Smtp-Source: ABdhPJxq1jB/OKANB2wTCbSg2+q8yBs3wYR9F34mGJKoPs7TGLbjWHSeAUqNciRw1idWEPPsNLCnMQ==
X-Received: by 2002:a63:338c:: with SMTP id
 z134mr33296793pgz.245.1596105037309; 
 Thu, 30 Jul 2020 03:30:37 -0700 (PDT)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id b13sm5424609pjl.7.2020.07.30.03.30.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 30 Jul 2020 03:30:36 -0700 (PDT)
Date: Thu, 30 Jul 2020 19:30:33 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v2 16/16] hw/block/nvme: remove explicit qsg/iov parameters
Message-ID: <20200730103033.2nhvoaequkwhaals@localhost.localdomain>
References: <20200729220638.344477-1-its@irrelevant.dk>
 <20200729220638.344477-17-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200729220638.344477-17-its@irrelevant.dk>
User-Agent: NeoMutt/20171215
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pl1-x641.google.com
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

On 20-07-30 00:06:38, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Since nvme_map_prp always operate on the request-scoped qsg/iovs, just
> pass a single pointer to the NvmeRequest instead of two for each of the
> qsg and iov.
> 
> Suggested-by: Minwoo Im <minwoo.im.dev@gmail.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 55b1a68ced8c..aea8a8b6946c 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -284,8 +284,8 @@ static uint16_t nvme_map_addr(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
>      return NVME_SUCCESS;
>  }
>  
> -static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
> -                             uint64_t prp2, uint32_t len, NvmeCtrl *n)
> +static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
> +                             uint32_t len, NvmeRequest *req)
>  {
>      hwaddr trans_len = n->page_size - (prp1 % n->page_size);
>      trans_len = MIN(len, trans_len);
> @@ -293,6 +293,9 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>      uint16_t status;
>      bool prp_list_in_cmb = false;
>  
> +    QEMUSGList *qsg = &req->qsg;
> +    QEMUIOVector *iov = &req->iov;
> +
>      trace_pci_nvme_map_prp(trans_len, len, prp1, prp2, num_prps);
>  
>      if (unlikely(!prp1)) {
> @@ -386,7 +389,7 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
>  {
>      uint16_t status = NVME_SUCCESS;
>  
> -    status = nvme_map_prp(&req->qsg, &req->iov, prp1, prp2, len, n);
> +    status = nvme_map_prp(n, prp1, prp2, len, req);
>      if (status) {
>          return status;
>      }
> @@ -431,7 +434,7 @@ static uint16_t nvme_map_dptr(NvmeCtrl *n, size_t len, NvmeRequest *req)
>      uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
>      uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
>  
> -    return nvme_map_prp(&req->qsg, &req->iov, prp1, prp2, len, n);
> +    return nvme_map_prp(n, prp1, prp2, len, req);
>  }
>  
>  static void nvme_post_cqes(void *opaque)


This looks better to have qsg and iov in the NvmeRequest.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>


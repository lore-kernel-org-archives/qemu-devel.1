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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD059C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A26D20809
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1VrR5ZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A26D20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k15e9-00026U-OW
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 06:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k15dL-0001f8-Fy; Thu, 30 Jul 2020 06:17:55 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k15dJ-00045L-QJ; Thu, 30 Jul 2020 06:17:55 -0400
Received: by mail-ot1-x344.google.com with SMTP id l27so12533174oti.3;
 Thu, 30 Jul 2020 03:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8DA231LHPV2cyZhGDI+dMcu++nRZMljgdpqOCyU5Cvg=;
 b=o1VrR5ZDX7tuj8Q6VtZdm6hhIq9Q2KpuMGtrhKHKtiUePurT1m2VPngGR3TX34l3Kk
 lLwFvq6A3tC7SUoCXj04NwmACH1kP54+BD8PpnS10ljInozPNK/Vvpvt531nhiggO4EL
 7ui0CtCBoCSjc2ejwWzZhwzqVjVQ/89UxpXqngL1ztlo9M2NHQij1LW1msA5UG9OC8FY
 uMqaqtq64GHN69aGUjaHq1g4yiBvFZ7oycuxjsCrB/bZ4Ec193hyM5v9fsgvnJm6LhqQ
 kVYn6twDjwcj8RnPAsVJTgekPcc2xC12+fo6aP8NH9h5z+t5kbNox+R/IUhCFATLD+Ja
 x9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8DA231LHPV2cyZhGDI+dMcu++nRZMljgdpqOCyU5Cvg=;
 b=D/3vtwhNHiXjzXLCePg7xCfxFe7zqmzU8sqNx0A5Nd6mxwNyoQVfHpta1ddnDkfOY5
 URh7w8wZYVcFnpe3YFlXn+r455AnUbQvtzmP6AsO0Trf34vaJDXaZzBkHdhSmFVBhpci
 34ea4L1Y+3+qdJJAXceNE3ejCRInr8kXY7DG94n+kKZWZaPjeS8Rvp7vTPiH7gOJOwVe
 V/v0w0noNnDobS0QhNKgR3/jxYJsWHnyZuUKJfBxFsSD+KDuS9Hl/WCzHYVutLFu0xWp
 l0o21HdFz+AbukYxliEaQXPskehYwZy0h/OQi5a24rBd7B6rGKOzeYR6aamcyJf0rhna
 6Nfg==
X-Gm-Message-State: AOAM532WEQiAlMHziD+7d5I1QS2iov3KZoLBquzCffYxYPA4DC6hwVW/
 f4TVIXGpTkqu7dVMSvpwYK8rzyd5dLPhjcyLaSQ=
X-Google-Smtp-Source: ABdhPJw+1RP/camM0PxGPpoXW/8EToR3xOJB1ef9uC1pFhZIjZ0nXTLgDCCL0iePhILQnUYPtXORySr1jnI8ayeiK/o=
X-Received: by 2002:a9d:7d04:: with SMTP id v4mr1625228otn.319.1596104272335; 
 Thu, 30 Jul 2020 03:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200729220638.344477-1-its@irrelevant.dk>
 <20200729220638.344477-8-its@irrelevant.dk>
In-Reply-To: <20200729220638.344477-8-its@irrelevant.dk>
From: Minwoo Im <minwoo.im.dev@gmail.com>
Date: Thu, 30 Jul 2020 19:17:41 +0900
Message-ID: <CAA7jztdvr5=vUPioq_iPXoV_0Ch-kOFRC8OxvQDPe0qEQiNjxQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] hw/block/nvme: add tracing to nvme_map_prp
To: Klaus Jensen <its@irrelevant.dk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-ot1-x344.google.com
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
> Add tracing to nvme_map_prp.
>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c       | 2 ++
>  hw/block/trace-events | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 571635ebe9f9..952afbb05175 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -274,6 +274,8 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>      int num_prps = (len >> n->page_bits) + 1;
>      uint16_t status;
>
> +    trace_pci_nvme_map_prp(trans_len, len, prp1, prp2, num_prps);

Hmm.. Okay with this.  But once QEMUSGList and QEMUIOVector instances are coming
into the NvmeRequest, we just can pass the NvmeRequest instance here
and print the cid as well
later :)

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

Thanks!

> +
>      if (unlikely(!prp1)) {
>          trace_pci_nvme_err_invalid_prp();
>          return NVME_INVALID_FIELD | NVME_DNR;
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index f3b2d004e078..f20c59a4b542 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -35,6 +35,7 @@ pci_nvme_irq_masked(void) "IRQ is masked"
>  pci_nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2=0x%"PRIx64""
>  pci_nvme_map_addr(uint64_t addr, uint64_t len) "addr 0x%"PRIx64" len %"PRIu64""
>  pci_nvme_map_addr_cmb(uint64_t addr, uint64_t len) "addr 0x%"PRIx64" len %"PRIu64""
> +pci_nvme_map_prp(uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2, int num_prps) "trans_len %"PRIu64" len %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64" num_prps %d"
>  pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
>  pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8""
>  pci_nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
> --
> 2.27.0
>


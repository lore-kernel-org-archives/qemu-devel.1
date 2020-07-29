Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8EBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7BBC20809
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5rGsgi9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BBC20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0nsR-0006gx-1a
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 11:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0nrj-00064x-5F; Wed, 29 Jul 2020 11:19:35 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0nrg-0002Lj-Ri; Wed, 29 Jul 2020 11:19:34 -0400
Received: by mail-pl1-x643.google.com with SMTP id w17so11918215ply.11;
 Wed, 29 Jul 2020 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YPLq7f51aYrxWOwWTXxu/X7RYcNAE4nLTx8FeJxk9qs=;
 b=S5rGsgi9OtxIlyka0zBv89M4aFkDW3KfvYmnVSzoUPRR9yBrBZx6sQcpTbhOWHXmBy
 7IHCHtEOMP7Hept7QGoGQCV2T+k/iRKCOLxK8moRUlQbnKu2yqERlJ76jrRvkuW21rpg
 qkNG5ceg7kNO1H3pOuCbzHHQn2qcBxZRxpGN+c9bj5kkxAiW9xV9rpL4ezzi1zDjgyb0
 giwWQmQ0aI6QHi9So9oqSo6cWWzOx+hVf+KIVf6YMBw8IRyG9vjcfxbKezwKZtJJYEVP
 YGkN4JB1h7G0gJAduQN/pQ21L1zS12VL2tE5OtugU6jc292kX+N5jep6mwTxBTdlgQYo
 pezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YPLq7f51aYrxWOwWTXxu/X7RYcNAE4nLTx8FeJxk9qs=;
 b=fheFv/qf1F+GTKj0PgL12kjW1IV+ucu62bhxLFInWZeB0vgnBiFneYn+dKYw7x5N2q
 XLQKGSgxgL9B/v3R6RJmz7iYA8VIH0nD1aI93ULFIu+taeoUvgSYtg37pgvsqfKGJKg4
 88ntvAJxOC8nMXu9JOtpaTm7l93hyyUbFW3J8ZJUnitCvyyaQ4jmT4mGLA3ha5ets3TW
 Ik4n24CeS4cfvI5CAuqUYE+FBKCCCBVW3aLHTGHWCM3z8A/vniH/YNukZuOpo+1koUF5
 7GyQ0no6lHlQfvLmhx9jKY/W1aqVKLAyfD/j4t1Y72vulil8x/dFoOUMfYTq803/YzUP
 qYBw==
X-Gm-Message-State: AOAM532qXEh6p+ow8bZJfrR6m8CjP2gI71KCPtkTR++X8RN4wzGa7mxc
 dmkJhcnRYcdw/xmpMK5Pnf0=
X-Google-Smtp-Source: ABdhPJz0zSLBz5MJsT/OiRpamKvycZIVAY7xIgZybNKqdEUF6oAnMQCix+rD0xDqwNjWGZwnQHDheg==
X-Received: by 2002:a17:902:8d87:: with SMTP id
 v7mr22293781plo.151.1596035970722; 
 Wed, 29 Jul 2020 08:19:30 -0700 (PDT)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id g23sm2809618pfo.95.2020.07.29.08.19.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 29 Jul 2020 08:19:30 -0700 (PDT)
Date: Thu, 30 Jul 2020 00:19:28 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 02/16] hw/block/nvme: add mapping helpers
Message-ID: <20200729151807.GA14876@localhost.localdomain>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-3-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720113748.322965-3-its@irrelevant.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pl1-x643.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Klaus,

On 20-07-20 13:37:34, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Add nvme_map_addr, nvme_map_addr_cmb and nvme_addr_to_cmb helpers and
> use them in nvme_map_prp.
> 
> This fixes a bug where in the case of a CMB transfer, the device would
> map to the buffer with a wrong length.
> 
> Fixes: b2b2b67a00574 ("nvme: Add support for Read Data and Write Data in CMBs.")
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

>  static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>                               uint64_t prp2, uint32_t len, NvmeCtrl *n)
>  {
>      hwaddr trans_len = n->page_size - (prp1 % n->page_size);
>      trans_len = MIN(len, trans_len);
>      int num_prps = (len >> n->page_bits) + 1;
> +    uint16_t status;
>  
>      if (unlikely(!prp1)) {
>          trace_pci_nvme_err_invalid_prp();
>          return NVME_INVALID_FIELD | NVME_DNR;
> -    } else if (n->bar.cmbsz && prp1 >= n->ctrl_mem.addr &&
> -               prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size)) {
> -        qsg->nsg = 0;
> +    }
> +
> +    if (nvme_addr_is_cmb(n, prp1)) {
>          qemu_iovec_init(iov, num_prps);
> -        qemu_iovec_add(iov, (void *)&n->cmbuf[prp1 - n->ctrl_mem.addr], trans_len);
>      } else {
>          pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
> -        qemu_sglist_add(qsg, prp1, trans_len);
>      }
> +
> +    status = nvme_map_addr(n, qsg, iov, prp1, trans_len);
> +    if (status) {
> +        goto unmap;
> +    }
> +
>      len -= trans_len;
>      if (len) {
>          if (unlikely(!prp2)) {
>              trace_pci_nvme_err_invalid_prp2_missing();
> +            status = NVME_INVALID_FIELD | NVME_DNR;
>              goto unmap;
>          }
>          if (len > n->page_size) {
> @@ -242,6 +309,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>                  if (i == n->max_prp_ents - 1 && len > n->page_size) {
>                      if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
>                          trace_pci_nvme_err_invalid_prplist_ent(prp_ent);
> +                        status = NVME_INVALID_FIELD | NVME_DNR;
>                          goto unmap;
>                      }
>  
> @@ -255,14 +323,14 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>  
>                  if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
>                      trace_pci_nvme_err_invalid_prplist_ent(prp_ent);
> +                    status = NVME_INVALID_FIELD | NVME_DNR;
>                      goto unmap;
>                  }
>  
>                  trans_len = MIN(len, n->page_size);
> -                if (qsg->nsg){
> -                    qemu_sglist_add(qsg, prp_ent, trans_len);
> -                } else {
> -                    qemu_iovec_add(iov, (void *)&n->cmbuf[prp_ent - n->ctrl_mem.addr], trans_len);
> +                status = nvme_map_addr(n, qsg, iov, prp_ent, trans_len);
> +                if (status) {
> +                    goto unmap;
>                  }
>                  len -= trans_len;
>                  i++;
> @@ -270,20 +338,27 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
>          } else {
>              if (unlikely(prp2 & (n->page_size - 1))) {
>                  trace_pci_nvme_err_invalid_prp2_align(prp2);
> +                status = NVME_INVALID_FIELD | NVME_DNR;
>                  goto unmap;
>              }
> -            if (qsg->nsg) {
> -                qemu_sglist_add(qsg, prp2, len);
> -            } else {
> -                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - n->ctrl_mem.addr], trans_len);
> +            status = nvme_map_addr(n, qsg, iov, prp2, len);
> +            if (status) {
> +                goto unmap;

I like these parts which is much better to read the codes.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

Thanks,


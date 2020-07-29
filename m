Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD23C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594A820FC3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUKpYhgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594A820FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0okr-0008Gl-Mt
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 12:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0okG-0007r2-Sa; Wed, 29 Jul 2020 12:15:56 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:37300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0okD-0002tU-UR; Wed, 29 Jul 2020 12:15:56 -0400
Received: by mail-pj1-x1041.google.com with SMTP id lx9so2260596pjb.2;
 Wed, 29 Jul 2020 09:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=kEtvLLZL7fZ7STnfo6rUqCR23Fa8JvSj1vFvsNk/9iQ=;
 b=aUKpYhgBqvzybn5UG+xTXLpybAsreV7yATiDv4zZ9HXtJvkq8NFepJi7YEKkkk2SC8
 kXE4NU6HIzR2IzASctAhXF4CvsC7YQrZgUQmM6y9oE5uDXjrhDTkcfy4ppjgUmla3Srn
 ofPa0LloBX4Y9mW+d+4finqvyVj1iMrWStncwFPVkI32LupYDbFYNmUgDYXF931qr9Lo
 /FTt3Tir10Gz9rSY7Gj+1QocWyDoeg0NFzA7j2HK+dhf6ucOardv0jLSd0lly6KKBzSb
 8CtNbNNGlMhM6tMjEU+qCLcrYOwEQAjCokxLJk/rFK/d/eKIYW4xSjyFPHrHxi7SnWvA
 +yVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=kEtvLLZL7fZ7STnfo6rUqCR23Fa8JvSj1vFvsNk/9iQ=;
 b=PND456zQ6HAaI69MokojkdqGREZB+39158MBao8E86dM2SCD+E6BlIPhcTkkUgyfbh
 5fL6ks8f65DIrf2jASmTQZH9B0xwcwz0PaeDHWjypAsJ0MjX478TdHdQCo2taJLH39tg
 joSVzZAlAFPztpx9kxGW/8c0e1vAs8Eps9Y4xHT2CBHww6iUmX+Ycjsbdp2nUeIx9uRm
 mRPF6weSozo686qBDHJAJDurJMHiTokJJ9BM4GtVno2S2ugvPbbbB+c2RQh50s6b+5Pd
 fXF0jzkvL7Eqh11QJdv7okx9IaKtRqEf4+GnDcdFCydThYkiXNdlKej/J1Ogw9qjotEU
 uEew==
X-Gm-Message-State: AOAM532fdRvvp/1HFjfgKe0z2irVrGQFCAobZPBlf3Z7Qi7eXqUrrk5K
 rAAi+g9gnJnTsLtDCXcE2p4ojgkjfSs=
X-Google-Smtp-Source: ABdhPJwcu+cLfIg7mQez/6aNpyn+I4KyZzF1W+VlOWNLVtVvlgoVtc8VzBoHTsmtUK0VWAm2f0SrIg==
X-Received: by 2002:a17:90b:f11:: with SMTP id
 br17mr7991447pjb.68.1596039350809; 
 Wed, 29 Jul 2020 09:15:50 -0700 (PDT)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id w82sm2637085pff.7.2020.07.29.09.15.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 29 Jul 2020 09:15:50 -0700 (PDT)
Date: Thu, 30 Jul 2020 01:15:48 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 16/16] hw/block/nvme: use preallocated qsg/iov in
 nvme_dma_prp
Message-ID: <20200729161548.GO14876@localhost.localdomain>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-17-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720113748.322965-17-its@irrelevant.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pj1-x1041.google.com
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

On 20-07-20 13:37:48, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Since clean up of the request qsg/iov is now always done post-use, there
> is no need to use a stack-allocated qsg/iov in nvme_dma_prp.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

> ---
>  hw/block/nvme.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 0b3dceccc89b..b6da5a9f3fc6 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -381,45 +381,39 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
>                               uint64_t prp1, uint64_t prp2, DMADirection dir,
>                               NvmeRequest *req)
>  {
> -    QEMUSGList qsg;
> -    QEMUIOVector iov;
>      uint16_t status = NVME_SUCCESS;
>  
> -    status = nvme_map_prp(n, &qsg, &iov, prp1, prp2, len, req);
> +    status = nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len, req);

After this change, can we make nvme_map_prp() just receive
NvmeRequest *req without &req->qsg, &req->iov by retrieve them from
inside of the nvme_map_prp()?


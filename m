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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFB6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF91920809
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoVuJWDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF91920809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0oem-0001S7-2g
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 12:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0odZ-00006x-LC; Wed, 29 Jul 2020 12:09:01 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:51836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0odX-0001jg-E8; Wed, 29 Jul 2020 12:09:01 -0400
Received: by mail-pj1-x1044.google.com with SMTP id c6so2073834pje.1;
 Wed, 29 Jul 2020 09:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=csSZOmvSSx/QlFiwOlQbEiM0aa69VOcweqdB9TSOImE=;
 b=ZoVuJWDS6BFJSakTe+mzbNqh4gXdS089CI5g/UBm5kfB9mp1MOVHPDNQLUHDu1kMzd
 i52cC0wUbz9ihp29MJw81WdwmWFmr49yzvrqR3krgdHRkOV+i4JBl5JtYp74aSUnxjue
 LOfwshWXvS0xKs3Ab2x+K5W/YdaTbXD/JIruY+L7gky5c5lbv006j4X3oQMYqzF+KDbO
 091Irurw2zCs2Tz0Sqix1YGf1qcJ5N0AyVV0czH7Npv2XVF6sd0OBPfbuXbL3stHMJS4
 sRRlbB5021aOzd1tRbpZzxrNzYmws6usvBl+ErBPx/3jzJKbkRjxj5Yjkolv8GAM4EyC
 0DcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=csSZOmvSSx/QlFiwOlQbEiM0aa69VOcweqdB9TSOImE=;
 b=oVls51Ec9Lgt2nKydVFsbAelKAJ6QWZCpjL6wD3Hurm2zp0x8XYOCL6MKi9WfJ+LVd
 XgDkcKbtTyqwwMFX7JJmVH6yF9y/7xJX0mUWKS9FWPH8Uf35UNokVnDP6ZUBt5Z5rLF4
 qjKD5C8Q3auh+qVaZrsHZMeTouXG6S/zS68NCt/wxtoFFX+xwpXpXOqpTJP6ZhzUvO9N
 izq9o3OhbcWxLrOu66IGAwF2zPwy/jB3pgOrPqM1tilXwKzWeZ6kqK2k9zJ4CP/cSsaI
 WEAgpu6ci+UANfx4wgPWC4g8Jy418mM2DbyPIUhWhBVs7ubobBFMnZzfOwdNzaJJpHBp
 B+8g==
X-Gm-Message-State: AOAM531u5hm0mqAYEPju45pNgXMzS5zuIL0fOu19+eF75UDHwV/aLXd6
 pT4Jfy3aNAdDeP38vPRJLJQ=
X-Google-Smtp-Source: ABdhPJyuiaq+AeLP0RaNQ5EH/FLiUiVMaUkOerWbxn9FxbTp+RiNKL5ihPIi8YGKzAd6MgaFdIlkHA==
X-Received: by 2002:a17:902:968a:: with SMTP id
 n10mr28738425plp.67.1596038937572; 
 Wed, 29 Jul 2020 09:08:57 -0700 (PDT)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id q22sm2852821pgn.91.2020.07.29.09.08.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 29 Jul 2020 09:08:57 -0700 (PDT)
Date: Thu, 30 Jul 2020 01:08:55 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 14/16] hw/block/nvme: consolidate qsg/iov clearing
Message-ID: <20200729160855.GM14876@localhost.localdomain>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-15-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720113748.322965-15-its@irrelevant.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pj1-x1044.google.com
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

On 20-07-20 13:37:46, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Always destroy the request qsg/iov at the end of request use.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 48 +++++++++++++++++-------------------------------
>  1 file changed, 17 insertions(+), 31 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 54cd20f1ce22..b53afdeb3fb6 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -213,6 +213,14 @@ static void nvme_req_clear(NvmeRequest *req)
>  {
>      req->ns = NULL;
>      memset(&req->cqe, 0x0, sizeof(req->cqe));
> +
> +    if (req->qsg.sg) {
> +        qemu_sglist_destroy(&req->qsg);
> +    }
> +
> +    if (req->iov.iov) {
> +        qemu_iovec_destroy(&req->iov);
> +    }

Oh okay.  This looks like update for the previous patch in this series.
And I also agree on starting to make focus on nvme_req_clear() for
wrap-up.

Looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>


Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7319C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D34220857
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fZvlxEeG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D34220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUdN-0005Ao-T1
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joUcO-0004Y3-7R
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:20:52 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joUcL-0000Zu-Rq
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:20:51 -0400
Received: by mail-oi1-x241.google.com with SMTP id a21so5450723oic.8
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Bzt76snm4wLfHzG59xDB4yLCkSvVzZD1EmKyQz6jLA4=;
 b=fZvlxEeG8pVDlXg3MgK2RQYACHlb/LcU0CPXHwBsMrLrqBXjxmqDV2/47XaR8FSeH6
 oNWQjRzjobrqKp6rqIzjgZQUAEtidnvIzdkJlB4ZSFjART6VdYSI4VATpcX48Qm3f3zs
 LqcuWVxpBPJ1D7FAWJ1wBHoGEkn8d2H/OZscUOoxpluD+2P8fcHk9/SQFg9xRxSHRIyn
 RRXM0jhSxY56pUZH8TObN7Tc+SH/tJVlkqM5YazBQICE3O1pYDYYnPF5NOQSOzSxZt3O
 YQOniM1VlAmw1E6QMHKx4xIA5eCU2OkPEDpT6ADnTHP0DeLL+GEkpJim1eUwJjPjtLgX
 iY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Bzt76snm4wLfHzG59xDB4yLCkSvVzZD1EmKyQz6jLA4=;
 b=d90KVbtMn4INAQtYgT51yAM138NKfusDdpAEv3tBRevk7c0jrUicse+0Mrg7Pq/YaW
 QcTz5DQhjJ8HiRHotSHRLC2J6Yzv5zGtL9XDbUZxtK6yuwlLsgzsyOauMax8ETYS/MqJ
 qwWDVJARULNGhzR+ZCiMK5rhZPtCNe3Hhj8ySEriEV2q2nZlz7nCPsnWtuIQ2qBKSdRl
 zJ+9o6tD+CVUwFHnfQFN9mV1paNYyUfFHqzjtKiLsy1Xo8vnKKblpWs12F39KUkmTd7H
 AVJ7Ty8Kgk/tvVvlXqkmnq34i4NEGCn3y6CsAgQpUCNI+XwRFQB6X4k01yGTEiiZznQH
 2BGA==
X-Gm-Message-State: AOAM530fufcrV7FvLHy3tvRapgeySC0217XRqg3lnMyR67tjTa2x7eSz
 V5ASXHeplO6aibJn/dBVFriGv8IhJfZ5WmcjIXBBxQ==
X-Google-Smtp-Source: ABdhPJylBF95hbT36EVaXaaNQwRz0PmPXv3P3dsP93nGb6INZ4ye4EL793ODeoWNSV1DguSDgK2dBM+NVLtYrBOSGG4=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr2927182oia.163.1593102048093; 
 Thu, 25 Jun 2020 09:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200605041733.415188-1-richard.henderson@linaro.org>
 <20200605041733.415188-2-richard.henderson@linaro.org>
In-Reply-To: <20200605041733.415188-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 17:20:37 +0100
Message-ID: <CAFEAcA-qybDD6GWYPFB6tMfTb9Kj+_bCKCxPyDYMZBr8EwbDmQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] tcg: Introduce target-specific page data for
 user-only
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 at 05:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This data can be allocated by page_alloc_target_data() and
> released by page_set_flags(start, end, prot | PAGE_RESET).
>
> This data will be used to hold tag memory for AArch64 MTE.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

> @@ -289,6 +295,8 @@ int walk_memory_regions(void *, walk_memory_regions_fn);
>  int page_get_flags(target_ulong address);
>  void page_set_flags(target_ulong start, target_ulong end, int flags);
>  int page_check_range(target_ulong start, target_ulong len, int flags);
> +void *page_get_target_data(target_ulong address);
> +void *page_alloc_target_data(target_ulong address, size_t size);

Could we have a doc comment for any new function that's got
global scope, please?

>  #endif
>
>  CPUArchState *cpu_copy(CPUArchState *env);

> +void *page_alloc_target_data(target_ulong address, size_t size)
> +{
> +    PageDesc *p = page_find(address >> TARGET_PAGE_BITS);
> +    void *ret = NULL;
> +
> +    if (p) {
> +        ret = p->target_data;
> +        if (!ret && (p->flags & PAGE_VALID)) {
> +            p->target_data = ret = g_malloc0(size);
> +        }
> +    }
> +    return ret;

Can a PageDesc validly have p->target_data != NULL but
p->flags with PAGE_VALID not set ?

It's not clear to me why for a !PAGE_VALID page which
has target_data already we return that pointer but
if it doesn't have any we don't allocate: either
"always allocate" or "always return NULL for non-valid pages"
would seem more self-consistent.

> @@ -787,9 +788,11 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
>          new_addr = -1;
>      } else {
>          new_addr = h2g(host_addr);
> +        /* FIXME: Move page flags and target_data for each page.  */

Is this something we're going to address later in the patchset?

>          prot = page_get_flags(old_addr);
>          page_set_flags(old_addr, old_addr + old_size, 0);
> -        page_set_flags(new_addr, new_addr + new_size, prot | PAGE_VALID);
> +        page_set_flags(new_addr, new_addr + new_size,
> +                       prot | PAGE_VALID | PAGE_RESET);
>      }
>      tb_invalidate_phys_range(new_addr, new_addr + new_size);
>      mmap_unlock();

thanks
-- PMM


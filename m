Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C72EC3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 15:35:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0452D22CE9
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 15:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L9E6bQlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0452D22CE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3ivh-0006K3-U6
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 11:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i3iqr-0004oF-NR
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 11:30:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i3iql-0007h3-Qj
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 11:30:11 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i3iqh-0007Y0-HL
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 11:30:06 -0400
Received: by mail-pl1-x643.google.com with SMTP id bj8so3530089plb.4
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 08:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=l1vrArjGjtuwQab5mDPZX2ho3//9hk2kxvy3b+lZc9I=;
 b=L9E6bQlmseF9ybyOcyEqSkJuKE3FrOhmOPbo9AesY2iGi0fCtXdTaiNQdtixd98peQ
 OwtwU9ZGBgQBMpgL3JD74+8AFeJTqFxuZrLIKhh0p7VUT5FM75Mon0ebcW6pQZAGLKsG
 VbaNs+rs/Ailscx9quFmWdbjM84pfHICp2bmM+0+DbZPbmdPLIY8KAo42/84q6SMAaFM
 ymegpnU1qqXrNTeNFz9JhrMF7Gr606LYF05DQMDDnKAQrW1Ct4gc+/8LrGhC93mmjWVv
 PkPIbUTTy5jp23/e0Z5fx8NVY1ziiFQXFN3rBoHxyPKDdHjnTY6+nH8HEzj3egMbpDgC
 lWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l1vrArjGjtuwQab5mDPZX2ho3//9hk2kxvy3b+lZc9I=;
 b=GvF7Z+gHDmN0Yb2r8faiHeNK77q9bRXwXWgrzISeFAQ+rVsog0f+GwSMuwH9pS+uZA
 esa0SWkITDQg+n7ulOukT5qEyLURjS9k/eelIIyLm4WkigHqMFVKZtSJcVuvY6ndjr7o
 G/bEYrrdinjCmbcixxAYtsuR4bildk1qRThT4MzLPrUNv5pXGRt0NJQSBgMg4zH5d9xa
 alXZi81foy+bxIpd1HNYAz55RVCeZokMMs0FPPu/Z4eMiOfOtCPqwhhygWrGKfRdId1A
 Ys8tSeOA97LKOvi1/EnqXaJR0AiqKOkqJ8LwEbXl0SsE5uthr+8kC4S8tMj2YPmeQuL+
 c0XQ==
X-Gm-Message-State: APjAAAXRxlp3raeUcOVjjnrGJW6PX+lvbqzvJQ0zYlUAhubtEqhCbR24
 /ZlTsBG/aFyL7Jg597aC1L/9Fg==
X-Google-Smtp-Source: APXvYqwQugazstH9Mrb/pmH0b9UEG4YemNe+g8UY68FWigC6sVi+nv7VcwSu73azgGuCmkloDMXGjQ==
X-Received: by 2002:a17:902:860b:: with SMTP id
 f11mr16158527plo.48.1567179002029; 
 Fri, 30 Aug 2019 08:30:02 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id y16sm7104558pfn.173.2019.08.30.08.30.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Aug 2019 08:30:00 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190830100959.26615-1-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4e363e0d-a2f1-7257-9b77-a78f717abb15@linaro.org>
Date: Fri, 30 Aug 2019 08:29:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830100959.26615-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v2 0/2] tcg: Introduce probe_access() and
 return a host pointer
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/30/19 3:09 AM, David Hildenbrand wrote:
> Let's return a host pointer from probe_access() if possible and provide
> probe_access(). s390x will soon make use of probe_access() and use the
> provided host pointer.
> 
> v1 -> v2:
> - Rebased to tcg-next
> - "tcg: Make probe_write() return a pointer to the host page"
> -- Rephrase documentation
> - "tcg: Factor out probe_write() logic into probe_access()"
> -- Don't check the MMU index
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Riku Voipio <riku.voipio@iki.fi>
> 
> David Hildenbrand (2):
>   tcg: Make probe_write() return a pointer to the host page
>   tcg: Factor out probe_write() logic into probe_access()
> 
>  accel/tcg/cputlb.c      | 60 +++++++++++++++++++++++++++++++----------
>  accel/tcg/user-exec.c   | 28 ++++++++++++++-----
>  include/exec/exec-all.h |  9 +++++--
>  3 files changed, 75 insertions(+), 22 deletions(-)
> 

Queued to tcg-next.


r~


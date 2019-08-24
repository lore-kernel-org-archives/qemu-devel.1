Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEEEC3A59E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 19:46:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A754420870
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 19:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qnCTJ5LK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A754420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1c01-0001VO-RO
	for qemu-devel@archiver.kernel.org; Sat, 24 Aug 2019 15:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1bz0-00013n-LS
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 15:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1byz-0006oH-IA
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 15:45:54 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:43746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1byz-0006m8-AQ
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 15:45:53 -0400
Received: by mail-pl1-x629.google.com with SMTP id 4so7657159pld.10
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2019 12:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vSJfmJ1O7jdh1TlvVS8LzuU8TXzleWk5/D56S32K4lE=;
 b=qnCTJ5LKphIf6axs2GjNNvbGqPQOPjoRvIyGmHvASOxHF+WAMI4Aqbuwz0BuYPsoKk
 VEeALoUMFnepxezcqqMhoBk8M1fd7jYx9tdCEbrtbef+AnXz14bUvTaKUEnpbh5pRsbt
 +5O2JeNNJrliptGewgD5IIxUNVgc15TpzkfpP3jZDeeZoMghf6h/jjZOXHdoROplo6pv
 x86VabSjky29WjUDuI5lCzURw0i7g+AJ6McSE80iqQLfiWeeDQhwBoX64Dl4PN0LI/nE
 qdkncSfIFrtZOx9iO6rJ8jTSsJAAdxFIEZ63eHBAZS0qUEhzqXFRm7guswWVB4wo4b2v
 2iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vSJfmJ1O7jdh1TlvVS8LzuU8TXzleWk5/D56S32K4lE=;
 b=tSFgbkEwBSF+5UZ2LnnHkdER4nYpmxDYSggB4/TCAiLRgHMolAFN++8FcUDzjizTo8
 JTMpHFSh5zVthdGeiQfphDsSMrRUg07+KZrwE1zXVhLCjr5GfgsWF9gvyAYv64S5I/9P
 1aY1/jakplWv/PsYFCmfcek5T2A9Ozlv/9U6e6dnWBmFmZ2ZCsFQktHRd8UvEyYo9FYv
 8wdx/kCevjlKemAY+l8D++gcTIHW8tSq3gaVHYJtLtBEFCXcY87bR9pjefNJ7jNn7G+7
 C06G5qQVSFGStvn4qJPz7FTV1bcgysMBkOUwrrXI93bazSzf/QM31cymkEEHDHqQTc74
 XG5A==
X-Gm-Message-State: APjAAAUe8R9qR9s+OF+i2HwuE8sAZADEAWvy1dJdQsWHy7uwZnthHzGi
 Yqjod6zjefSCI/fBXUb+Avtu2Q==
X-Google-Smtp-Source: APXvYqweP+I4ogerss4nS2ecCrZMr9y4FK/J17ty44nv6YIHfBMPlZe0YakqEdhGVK9aQj80STjo8g==
X-Received: by 2002:a17:902:f096:: with SMTP id
 go22mr11590574plb.58.1566675950705; 
 Sat, 24 Aug 2019 12:45:50 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t70sm11034638pjb.2.2019.08.24.12.45.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 24 Aug 2019 12:45:49 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190823100741.9621-1-david@redhat.com>
 <20190823100741.9621-10-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1ef25fb4-08d7-98db-41f9-65b00e288c43@linaro.org>
Date: Sat, 24 Aug 2019 12:45:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823100741.9621-10-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::629
Subject: Re: [Qemu-devel] [PATCH v1 9/9] tcg: Check for watchpoints in
 probe_write()
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
Cc: Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Cornelia Huck <cohuck@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 3:07 AM, David Hildenbrand wrote:
> @@ -1071,8 +1072,23 @@ void probe_write(CPUArchState *env, target_ulong addr, 
>          if (!VICTIM_TLB_HIT(addr_write, addr)) {
>              tlb_fill(env_cpu(env), addr, size, MMU_DATA_STORE,
>                       mmu_idx, retaddr);
> +            /* TLB resize via tlb_fill may have moved the entry. */
> +            entry = tlb_entry(env, mmu_idx, addr);
>          }
>      }
> +
> +    if (!size) {
> +        return;
> +    }
> +    tlb_addr = tlb_addr_write(entry);
> +
> +    /* Watchpoints for this entry only apply if TLB_MMIO was set. */
> +    if (tlb_addr & TLB_MMIO) {
> +        MemTxAttrs attrs = env_tlb(env)->d[mmu_idx].iotlb[index].attrs;

We need to recompute index above as well, since we use it here.
Fixed up and applied to tcg-next.


r~


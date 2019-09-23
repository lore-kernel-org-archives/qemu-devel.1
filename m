Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77789C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 495CF20835
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495CF20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCL23-0005No-8h
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 05:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iCKzr-0003P1-R4
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iCKzq-0003Ei-Lz
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:51:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iCKzq-0003EP-D2
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:51:06 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7BAF73B72D
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 09:51:05 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id j125so6396943wmj.6
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 02:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kvEmVluppOWlY2Q472Ya1xN4mgYueD+ialW/NvCe4Kc=;
 b=lAUL7iPildm93uEQZkDm9t+b4eOVKsYpxqXvb2fiW1BZ/CqGAKmr4pJRc2bcu5bNEO
 pGDmW7D0fIpmbD6uqhcYJtnemGIySoKQ2Sc2TjmvV0Tb8rk4k/G6v0u8p4PZocteKUe1
 w9GsamrKluw/xRqipb9EN69D6qLaz8hOj+IwwojaO5VCMftQP3EsPrMqIjP+TcQENCF4
 kFcrI1Wzl0UckMgVpHcetQ7g2rIr8/eAK6/jbLbGk3rkEnhHMsB2E5Reeiv5iC7XUdBX
 oIGTGmGe9ry/enqG5TvQHU5Nhz8Jh7CLkbhhnzeJ5enUEnEbpHw+/69jPwlLU59nR757
 3e6A==
X-Gm-Message-State: APjAAAUx0Lx5uFdYb5m4cRgnKlgpL+gJsjxmDalOMyAfiZxFR5IwI29r
 cN5OtnQUVMvUeahEFFo2OHoXvvBnaDDHhcAsX54Rok8VZPweuhEJSWWL5dxDHFdEJYcmvVquhL9
 a4Nasloo5wA5/ye8=
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr19996150wrs.191.1569232264171; 
 Mon, 23 Sep 2019 02:51:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzNJRkgrThNDGiYikqI8RD+QEga20FmD3fEN4mvrHQJQqb6MZ6D+ED7X/qIhLQomycL7Omo3w==
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr19996133wrs.191.1569232263855; 
 Mon, 23 Sep 2019 02:51:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id s13sm9520304wmc.28.2019.09.23.02.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 02:51:03 -0700 (PDT)
Subject: Re: [PATCH v3 09/20] cputlb: Replace switches in load/store_helper
 with callback
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190922035458.14879-1-richard.henderson@linaro.org>
 <20190922035458.14879-10-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f67383ec-9dc8-c040-8fd9-fb659b8cd2d4@redhat.com>
Date: Mon, 23 Sep 2019 11:51:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190922035458.14879-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: alex.bennee@linaro.org, stefanha@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/19 05:54, Richard Henderson wrote:
> +/* Wrap the unaligned load helpers to that they have a common signature.  */
> +static inline uint64_t wrap_ldub(const void *haddr)
> +{
> +    return ldub_p(haddr);
> +}
> +
> +static inline uint64_t wrap_lduw_be(const void *haddr)
> +{
> +    return lduw_be_p(haddr);
> +}
> +
> +static inline uint64_t wrap_lduw_le(const void *haddr)
> +{
> +    return lduw_le_p(haddr);
> +}
> +
> +static inline uint64_t wrap_ldul_be(const void *haddr)
> +{
> +    return (uint32_t)ldl_be_p(haddr);
> +}
> +
> +static inline uint64_t wrap_ldul_le(const void *haddr)
> +{
> +    return (uint32_t)ldl_le_p(haddr);
> +}

Any reason to have these five functions (plus five for stores) instead
of a pair

static uint64_t ld_memop(const void *haddr, MemOp op)
{
}

static uint64_t st_memop(void *haddr, MemOp op, uint64_t val)
{
}

that includes the switches?  Everything should be inlined just the same
if you do

        if (unlikely(tlb_addr & TLB_BSWAP)) {
            st_memop(haddr, op ^ MO_BSWAP, val);
        } else {
            st_memop(haddr, op, val);
        }

and the like.

Paolo

>  static inline uint64_t QEMU_ALWAYS_INLINE
>  load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>              uintptr_t retaddr, MemOp op, bool code_read,
> -            FullLoadHelper *full_load)
> +            FullLoadHelper *full_load, LoadHelper *direct)
>  {
>      uintptr_t mmu_idx = get_mmuidx(oi);
>      uintptr_t index = tlb_index(env, mmu_idx, addr);
> @@ -1373,33 +1400,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>  
>   do_aligned_access:
>      haddr = (void *)((uintptr_t)addr + entry->addend);
> -    switch (op) {
> -    case MO_UB:
> -        res = ldub_p(haddr);
> -        break;
> -    case MO_BEUW:
> -        res = lduw_be_p(haddr);
> -        break;
> -    case MO_LEUW:
> -        res = lduw_le_p(haddr);
> -        break;
> -    case MO_BEUL:
> -        res = (uint32_t)ldl_be_p(haddr);
> -        break;
> -    case MO_LEUL:
> -        res = (uint32_t)ldl_le_p(haddr);
> -        break;
> -    case MO_BEQ:
> -        res = ldq_be_p(haddr);
> -        break;
> -    case MO_LEQ:
> -        res = ldq_le_p(haddr);
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> -
> -    return res;
> +    return direct(haddr);



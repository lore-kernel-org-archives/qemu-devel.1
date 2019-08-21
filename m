Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D3CC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5992E22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BUX9hqVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5992E22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UOe-0004dy-7e
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0UN9-0002xA-Sp
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0UN8-0002SH-AR
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:26:11 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43361)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0UN8-0002Qt-0E
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:26:10 -0400
Received: by mail-pg1-x542.google.com with SMTP id k3so1679639pgb.10
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oInbOgNscJRZUfgK1mx7l/CjhhovsgM8ujhMOHOC13g=;
 b=BUX9hqVwt8ZIog+BP00f6XlDKaf6Vwek8XZrmV9+piJXrVHXpkBXX70ir08KKbDypu
 VXGJjy0Bl3TO01KewuxDgTPMGLzLgYURcLS3ONKHDfsyi3ANdEFALPfOvvy8Jxelp7JK
 ACdUgjs0USTjnqXsMIH323aj3qbI7G+Mmx1GDz5hkzJ0HPUxohphjO0RNWg9pY2hYB/Z
 qpzfcNCsRnJQYMYUgdzYRCZLyvUV0MgLteJqx58tq+i2BEqWew+yEncjBP21/tQY9Afa
 GEdJ/s5rKlATRRThk0rnPnqXe+Qw6eCZwpdLOTOVLcb0JsI5Vpk0G0l5eYtmeU4KuDwf
 B5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oInbOgNscJRZUfgK1mx7l/CjhhovsgM8ujhMOHOC13g=;
 b=BojoC17JxURaIeXyVj9i8s1JMKBv7M0F/JIK6Z78b9VizPe7/5WO+aQrJJzXvnI5YQ
 m2nIN2iQ4utDvBjEkPO1I0ieDH0IZY6oUii9ksfGJCCNZ6f57hmcBEPqsWRr1omTHQaG
 4sMAN/v5RB2H5SewZ3kdHXpor18CUuKnqFTtp2AaLaBrYfprQ0Ii/7f6IvQgDc1ss+kq
 hORUYGkRrbaUShRSxkgom8ZMo1ia39uErN21drZ71lzOBRWC/TOCIUGCvZK81hIfkU1Q
 mjsQtQPvIoIYkLX7Ar8+43tk3QjKi04vI+ikD5ibQsgu1M2yNVcJP+tJSHgkM8xig+PU
 VTsw==
X-Gm-Message-State: APjAAAVTyV9qFtyBrskBjK4igmPFeyiX1hzac4kLjih0AIJd4GojLAfP
 Tgw1g+eFL8+sAQMDBCph+8Xw8Q==
X-Google-Smtp-Source: APXvYqxCd2WYJTcEOoN813v80GtEMFLTmy8bHWJTbjge/NJrX+E/Nc6iQnw2RDKBWyxA2vshaRZFxQ==
X-Received: by 2002:a63:6a81:: with SMTP id
 f123mr30566609pgc.348.1566408368723; 
 Wed, 21 Aug 2019 10:26:08 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id c13sm25449749pfi.17.2019.08.21.10.26.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 Aug 2019 10:26:07 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190821092252.26541-1-david@redhat.com>
 <20190821092252.26541-3-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <dc42887a-f991-1fe0-36a7-a7804bc4a939@linaro.org>
Date: Wed, 21 Aug 2019 10:26:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821092252.26541-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v1 2/4] s390x/tcg: Introduce
 probe_read_access()
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/19 2:22 AM, David Hildenbrand wrote:
> +/*
> + * Make sure the read access is permitted and TLB entries are created. In
> + * very rare cases it might happen that the actual accesses might need
> + * new MMU translations. If the page tables were changed in between, we
> + * might still trigger a fault. However, this seems to barely happen, so we
> + * can ignore this for now.
> + */
> +void probe_read_access(CPUS390XState *env, uint64_t addr, uint64_t len,
> +                       uintptr_t ra)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    if (!guest_addr_valid(addr) || !guest_addr_valid(addr + len - 1) ||
> +        page_check_range(addr, len, PAGE_READ) < 0) {
> +        s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
> +    }
> +#else
> +    while (len) {
> +        const uint64_t pagelen = -(addr | -TARGET_PAGE_MASK);
> +        const uint64_t curlen = MIN(pagelen, len);
> +
> +        cpu_ldub_data_ra(env, addr, ra);
> +        addr = wrap_address(env, addr + curlen);
> +        len -= curlen;
> +    }
> +#endif
> +}

I don't think this is really the right approach, precisely because of the
comment above.

I think we should

(1) Modify the generic probe_write to return the host address,
    akin to tlb_vaddr_to_host except it *will* fault.

(2) Create a generic version of probe_write for CONFIG_USER_ONLY,
    much like the one you have done for target/s390x.

(3) Create generic version of probe_read that does the same.

(4) Rewrite fast_memset and fast_memmove to fetch all of the host
    addresses before doing any modifications.  The functions are
    currently written as if len can be very large, handling any
    number of pages.  Except that's not true.  While there are
    several kinds of users apart from MVC, two pages are sufficient
    for all users.

    Well, should be.  We would need to adjust do_mvcl to limit the
    operation to TARGET_PAGE_SIZE (CC=3, cpu-determined number of
    bytes moved without reaching end of first operand).
    Which is probably a good idea anyway.  System mode should not
    spend forever executing one instruction, as it would if you
    pass in a 64-bit length from MVCLE.


Something like

static void fast_memmove_idx(CPUS390XState *env, uint64_t dst,
                             uint64_t src, uint32_t len,
                             int dst_idx, int src_idx,
                             uintptr_t ra)
{
    void *dst1, *dst2, *dst3;
    void *src1, *src2, *src3;
    uint32_t len1, len2, lenr;
    uint64_t dstr, srcr;

    if (unlikely(len == 0)) {
        return;
    }
    assert(len <= TARGET_PAGE_SIZE);

    dst1 = probe_write(env, dst, 1, dst_idx, ra);
    src1 = probe_read(env, src, 1, src_idx, ra);

    if (dst1 == NULL || src1 == NULL) {
        goto io_memmove;
    }

    /* Crop length so that neither SRC+LEN nor DST+LEN crosses a page. */
    len1 = adj_len_to_page(adj_len_to_page(len, src), dst);
    lenr = len - len1;

    if (likely(lenr == 0)) {
        memmove(dst1, src1, len);
        return;
    }

    /* Probe for the second page and range.  */
    dstr = dst + len1;
    srcr = src + len1;
    dst2 = probe_write(env, dstr, 1, dst_idx, ra);
    src2 = probe_read(env, srcr, 1, src_idx, ra);

    len2 = adj_len_to_page(adj_len_to_page(lenr, srcr), dstr);
    lenr -= len2;

    if (likely(lenr == 0)) {
        memmove(dst1, src1, len1);
        if (dst2 != NULL && src2 != NULL) {
            memmove(dst2, src2, len2);
            return;
        }
        dst = dstr;
        src = srcr;
        len = len2;
        goto io_memmove;
    }

    /*
     * There is a chance for a third page and range.  E.g.
     *   dst = 0xaaaff0, src = 0xbbbff8, len = 32
     * len1 = 8, bringing src to its page crossing, then
     * len2 = 8, bringing dst to its page crossing, then
     * lenr = 16, finishing the rest of the operation.
     */
    dstr += len2;
    srcr += len2;
    dst3 = probe_write(env, dstr, 1, dst_idx, ra);
    src3 = probe_read(env, srcr, 1, src_idx, ra);

    memmove(dst1, src1, len1);
    memmove(dst2, src2, len2);
    if (dst3 != NULL && src3 != NULL) {
        memmove(dst3, src3, lenr);
        return;
    }
    dst = dstr;
    src = srcr;
    len = lenr;

 io_memmove:
#ifdef CONFIG_USER_ONLY
    /*
     * There is no I/O space, so probe_{read,write} raise exceptions
     * for unmapped pages and never return NULL.
     */
    g_assert_not_reached();
#else
    TCGMemOpIdx oi_dst = make_memop_idx(MO_UB, dst_idx);
    TCGMemOpIdx oi_src = make_memop_idx(MO_UB, src_idx);
    do {
        uint8_t x = helper_ret_ldub_mmu(env, src, oi_src, ra);
        helper_ret_stb_mmu(env, dest, x, oi_dst, ra);
    } while (--len != 0);
#endif
}

static void fast_memmove(CPUS390XState *env, uint64_t dst, uint64_t src,
                         uint32_t len, uintptr_t ra)
{
    int mmu_idx = cpu_mmu_index(env, false);
    fast_memmove_idx(env, dst, src, len, mmu_idx, mmu_idx, ra);
}


r~


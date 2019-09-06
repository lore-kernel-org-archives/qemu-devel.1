Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B865C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 11:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25FAE206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 11:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gNDAc/jc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FAE206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6C1o-0005Za-3d
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 07:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i6C0y-00054i-NY
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 07:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i6C0x-0004lp-Ae
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 07:02:52 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35961)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i6C0x-0004lK-4K
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 07:02:51 -0400
Received: by mail-ot1-x342.google.com with SMTP id 67so5345105oto.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 04:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sINOstcRJi3OciMAkAkHd+D/StFmDl4pDFL51TZp/Ak=;
 b=gNDAc/jcgxYo21tTA+GQhpvFAWk25OEgrCzL9Q0fmeniaVCVF6dWK9M8+MSHQIVlpv
 MtDpfs1wMp4pzGloT0niiQ1jMDf0amqhaJ6VM1o5nFm3qQ+M+pqVXCjJRF/KvGfik6fR
 kuA6mYI0sGtMIpqM0sq1ndlKjIvqQaU3L/GdHUFmljrlMswbjfGbOwRUpwR+PUd6Z9ea
 shymlKdrOUoLzouuTaa1FVY2AhjsQtReM3NX4jfo/ZWx+5+0fX1HDNl8Jn7qboxaJV2b
 I+woQJq1opzkhw/biwnLizS6HJ5nJuxl/TvsLCfvRO1jS0is6guRw0eX6wMPcx0xkm64
 QcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sINOstcRJi3OciMAkAkHd+D/StFmDl4pDFL51TZp/Ak=;
 b=Eu2h60AMZO+CG9MrCKs16+RCRSuX+3F47VgIiwR558VfYF3NqIlg6hrSy7YT0JyVOL
 edbd0EBNVS2w3VwZK/RJOS9kqAG5sDEfNd6iVluMrQX2KyW18GRT/Ac0HhQCkb4JmwwY
 cpthGWxGmLkXepy5vM9b85cwDCNhpaF33rZutT9cfrCyd8drMjQ3lWaRLc5k1gFFSu9K
 NgGlCIE3ZFYI4IJyZRKU3u6kczDhurMJnFAKMfTaphNcZyOI+96sIYMOSlWbsu+tinBC
 kCnyTjx3veGSLU7WaHiaGjGTLPAhcR33IRqgghqkIsp7vzKMc+RIar9Zfu5/gEXKbBP7
 FWNA==
X-Gm-Message-State: APjAAAV4JsQQJwZsRoYohOHLfGRSmMerF6nnW3WY3YIFkIuVZbPmhST6
 sSpIOxOzkT68834DK02Jfc+8wC0Z8xJuyjceosSvZQ==
X-Google-Smtp-Source: APXvYqyoKZcZtLkxYvyGfOt6OHx3qKpMEnUJWOJBoCO0fxtJ99Y2JBiVUQWWjXlhMBuNw7sw5SDjFshFnB9SgLKhWO4=
X-Received: by 2002:a9d:7504:: with SMTP id r4mr6372091otk.221.1567767770295; 
 Fri, 06 Sep 2019 04:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190903160858.5296-1-richard.henderson@linaro.org>
 <20190903160858.5296-23-richard.henderson@linaro.org>
In-Reply-To: <20190903160858.5296-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2019 12:02:37 +0100
Message-ID: <CAFEAcA9g-nyCPafbjmdL6Ka03rEhH3LyZL2aBPqH7UdR36TihA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 22/36] cputlb: Fold TLB_RECHECK into
 TLB_INVALID_MASK
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Sep 2019 at 17:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We had two different mechanisms to force a recheck of the tlb.
>
> Before TLB_RECHECK was introduced, we had a PAGE_WRITE_INV bit
> that would immediate set TLB_INVALID_MASK, which automatically
> means that a second check of the tlb entry fails.
>
> We can use the same mechanism to handle small pages.
> Conserve TLB_* bits by removing TLB_RECHECK.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

> @@ -1265,27 +1269,6 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>          if ((addr & (size - 1)) != 0) {
>              goto do_unaligned_access;
>          }
> -
> -        if (tlb_addr & TLB_RECHECK) {
> -            /*
> -             * This is a TLB_RECHECK access, where the MMU protection
> -             * covers a smaller range than a target page, and we must
> -             * repeat the MMU check here. This tlb_fill() call might
> -             * longjump out if this access should cause a guest exception.
> -             */
> -            tlb_fill(env_cpu(env), addr, size,
> -                     access_type, mmu_idx, retaddr);
> -            index = tlb_index(env, mmu_idx, addr);
> -            entry = tlb_entry(env, mmu_idx, addr);
> -
> -            tlb_addr = code_read ? entry->addr_code : entry->addr_read;
> -            tlb_addr &= ~TLB_RECHECK;
> -            if (!(tlb_addr & ~TARGET_PAGE_MASK)) {
> -                /* RAM access */
> -                goto do_aligned_access;
> -            }
> -        }
> -
>          return io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
>                          mmu_idx, addr, retaddr, access_type, op);
>      }

In the old version of this code, we do the "tlb fill if TLB_RECHECK
is set", and then we say "now we've done the refill have we actually
got RAM", and we avoid calling io_readx() if that is the case.
This is necessary because io_readx() will misbehave if you try to
call it on RAM (notably if what we have is notdirty-mem then we
need to do the read-from-actual-host-ram because the IO ops backing
notdirty-mem are intended for writes only).

With this patch applied, we seem to have lost the handling for
if the tlb_fill in a TLB_RECHECK case gives us back some real RAM.
(Similarly for store_helper().)

I think this is what's causing Mark Cave-Ayland's Solaris test
case to fail.

More generally, I don't really understand why this merging
is correct -- "TLB needs a recheck" is not the same thing as
"TLB is invalid" and I don't think we can merge the two
bits.

thanks
-- PMM


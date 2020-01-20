Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5E5C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68C422522
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddCbuPSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68C422522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itg7h-0005MD-Kn
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 18:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1itg5v-0003lp-AF
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:04:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1itg5u-0004Wy-0g
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:04:31 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36075)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1itg5t-0004Vn-Q4
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:04:29 -0500
Received: by mail-wr1-x443.google.com with SMTP id z3so1257682wru.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 15:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0S0dy5PZ8tNfVl6Ib7l4QHc4tS/w2cGZqOIiDpRqJcc=;
 b=ddCbuPSZ+3ePNlPFW8Uk8LcSxn0nYw6NMmRVAxVp94/R/KhIIUh5sBG66+TLJtj4Ve
 NXSo+45HfabD84cmE04Y+/JH0r5Hp91uBqOQTyi02Hr2cdOQ+JaSZGxJNSVuLlKaOHPY
 5+2387Z2KGsA+Ap8rYJ+heV9awpNGhXUs3OrjLTlWmnwSJe1rpFRGH/tpvxBcbBZ3rHh
 f2rR+lQwTFqpwnuR0CMvRxSViPW75ee258fSSZGOKHwRtNZmEg0+48hi68wrGaC9hh/H
 faAeZJ7ECI5Zjyu08u5hqWVC2IV4Nfv0LvjmS9XmeMPT2p0FDagK5NELr9EZl692KkcF
 VHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0S0dy5PZ8tNfVl6Ib7l4QHc4tS/w2cGZqOIiDpRqJcc=;
 b=qD2GlvxeFj9ZfO2FgvrMsJn+YXgPEALscgHqps1EN9jZUNtU+Ub1VYA0YxgMzpd9Dg
 zLrxuVbJX678epvdV6eK2HHnVC/5ZR0UQvIAMNGv+cllRABhILc/t6agR6Ugd9+Y44PG
 D7oNKd70EIi8vpdqIkj4wHXAGsadoFYIXOMO504DpKyDGD53FY2al7yAVwTorCDrGvOB
 sTQNQU9xlrwWZz4yXyErafT//GQ3BuC3+YZYYpVNpISa0yKo1SUtXxbO8zxVXE3vO2UC
 0VHwElBToxoeuDc3xeaXN5qstKWuTFycpZB5MG6ZmdavvF+ILf9pr5ZXNswpRYg3nF/u
 5FZA==
X-Gm-Message-State: APjAAAUqMN9d+r1XUM8lxuvUQxIpds8pfAFeQLCL/qXuTDvAeFgWcx/A
 qvZlfXrm1liVPDK7k58W32qiPaA8/RymrT4YwZqT/5Fw
X-Google-Smtp-Source: APXvYqzDp9nDuuXiHNyWY6Q/5BY8nyCMZAdGN7BdaF7y2G9sId5wE5vFRcwMjjNO8cYYHsMFU87nP5FhJPO3dfmcIN4=
X-Received: by 2002:ac2:5310:: with SMTP id c16mr898491lfh.102.1579561452294; 
 Mon, 20 Jan 2020 15:04:12 -0800 (PST)
MIME-Version: 1.0
References: <20200109024907.2730-1-richard.henderson@linaro.org>
In-Reply-To: <20200109024907.2730-1-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Jan 2020 09:03:43 +1000
Message-ID: <CAKmqyKPDWFu9orMOiRW=NS7qu74kU_dovRo1BzSyeb8o=77PiA@mail.gmail.com>
Subject: Re: [PATCH 0/9] cputlb: Various cleanups
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 9, 2020 at 12:49 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> I had a conversation with Alistair Francis at KVM forum about
> being able to represent ASIDs "properly".  This lead to the idea
> that target-specific code might be able to cache TLBs outside of
> the "main" NB_MMU_MODES -- possibly thousands of them.
>
> This goes nowhere near that far.  But it does begin edging toward
> the possibility of having a
>
>     struct CPUTLBSaved {
>         CPUTLBDesc d;
>         CPUTLBDescFast f;
>     };
>
> by moving some of the most basic routines to use CPUTLBDesc and
> CPUTLBDescFast directly instead of always using an mmu_idx.
>
> I'm not sure how much time I'll have to go further along these
> lines, but what I have so far still looks like a cleanup.

Thanks for helping with this!

Unfortunately I haven't had a chance to dig into this myself.

Alistair

>
>
> r~
>
>
> Richard Henderson (9):
>   cputlb: Merge tlb_table_flush_by_mmuidx into
>     tlb_flush_one_mmuidx_locked
>   cputlb: Make tlb_n_entries private to cputlb.c
>   cputlb: Pass CPUTLBDescFast to tlb_n_entries and sizeof_tlb
>   cputlb: Hoist tlb portions in tlb_mmu_resize_locked
>   cputlb: Hoist tlb portions in tlb_flush_one_mmuidx_locked
>   cputlb: Split out tlb_mmu_flush_locked
>   cputlb: Partially merge tlb_dyn_init into tlb_init
>   cputlb: Initialize tlbs as flushed
>   cputlb: Hoist timestamp outside of loops over tlbs
>
>  include/exec/cpu_ldst.h |   5 --
>  accel/tcg/cputlb.c      | 120 +++++++++++++++++++++-------------------
>  2 files changed, 64 insertions(+), 61 deletions(-)
>
> --
> 2.20.1
>
>


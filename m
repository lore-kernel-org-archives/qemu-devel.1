Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33514C04AA6
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F26B120652
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVSsBnJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26B120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33068 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLALo-0001G4-A0
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:46:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLAI4-00070j-Jo
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLAI3-0005EH-HP
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:42:08 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLAI3-00059s-Ak
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:42:07 -0400
Received: by mail-oi1-x243.google.com with SMTP id w197so9021900oia.2
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=TbQQeoVuWlL6uw2HCqjR19lGYYJs6/Qda8ZujnN+WTE=;
	b=sVSsBnJIZdtEkNJqyy8kSb4Nxfk/4XrReh3QV/xtufqirBPjEqSu/B5BAqSWQIiRmT
	7wFWcg5euStqe0d1X8FU5MFpjh+vQSI9MzhY+XkWV4IpOCOBb/iK83qxc0Ug4SFmzHNB
	e6/xIcrGgAFQg+HVNZupGOLKtx1nB2rfxg+hrbYT6r55RBLDQt6cRCdBh5VBCU2TX9va
	KRzo34Kwv3aYK6xOkqxxPZMV9/5X2q0r++8UO9ugTXj4OsbcQvt5mmrGhDWoPpKZL0rX
	xVMIrJB0wPOu1MMbKhUXbMeSsGjVLUuyxBh4apryJ9ZVV2etePuGCLU3uV9s5cyerciX
	+uyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=TbQQeoVuWlL6uw2HCqjR19lGYYJs6/Qda8ZujnN+WTE=;
	b=PYdaX2sZ3i1ZsGPD8WkZLXw/bJ//cz+R4JvAJY0zr4IrEj1VPC7j36VY3mTrt9qZ/E
	HVpnyUEox3nSnTkc+U3doQH7hJQo1w1hrOqx3O5EWlqTszGqD0Ciw191+wTwjaYyf4g3
	+UheUpmjHMX6uREhhquOJN/h4dMmfB6VXk6zww4udbOC3q4RQWU/gPfZehN8YSJ1B208
	c9hdMDmO24IR9C5u/GywvcUpRSgm9RFq8AwmuBnCGJexqjk66ZcaWYrnrVHfBRrktHeA
	aFA/iWD9WjIRE0preo9kCwv5mK2+YhJzqDygwHZw9Zb6vyig7TDI8gpnfrPl9aS0WQYp
	k5zA==
X-Gm-Message-State: APjAAAX4Ad7AdhxSOtH8Bka1KKDnpy//WeVOYm0ZmkYEmqLvLwarW3MT
	hrgXqISsUNA1pHroLA8cvtTurfqsE3zBaPKPmxs6jsFoRd8=
X-Google-Smtp-Source: APXvYqzyTYQjBXy2JLivoUHD3pBz2VE+Vv5rXzaBJUDA5R0z3NeZYxiCZ+6sJ64zIFcRwGhiH++gxV9+j5ghqD0s+OA=
X-Received: by 2002:a05:6808:301:: with SMTP id
	i1mr148150oie.163.1556559720863; 
	Mon, 29 Apr 2019 10:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-27-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:41:49 +0100
Message-ID:
 <CAFEAcA_TJJ7V3apxmGvhoiRk2dxzT77SapcyMuopGwqmeQoosw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH 26/26] tcg: Use tlb_fill probe from
 tlb_vaddr_to_host
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429174149.-nTgC-eIGGYp0jhhbbTa-76gwCLUcsx381AmIHyumKY@z>

On Wed, 3 Apr 2019 at 05:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Most of the existing users would continue around a loop which
> would fault the tlb entry in via a normal load/store.  But for
> SVE we have a true non-faulting case which requires the new
> probing form of tlb_fill.

So am I right in thinking that this fixes a bug where we
previously would mark a load as faulted if the memory happened
not to be in the TLB, whereas now we will correctly pull in the
TLB entry and do the load ?

(Since guest code ought to be handling the "non-first-load
faulted" case by looping round or otherwise arranging to
retry, nothing in practice would have noticed this bug, right?)

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu_ldst.h | 40 ++++--------------------
>  accel/tcg/cputlb.c      | 69 ++++++++++++++++++++++++++++++++++++-----
>  target/arm/sve_helper.c |  6 +---
>  3 files changed, 68 insertions(+), 47 deletions(-)
>
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index d78041d7a0..be8c3f4da2 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -440,43 +440,15 @@ static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
>   * This is the equivalent of the initial fast-path code used by
>   * TCG backends for guest load and store accesses.
>   */

The doc comment which this is the last two lines of needs
updating, I think -- with the changed implementation it's
no longer just the equivalent of the fast-path bit of code,
and it doesn't return NULL on a TLB miss any more.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


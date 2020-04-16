Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53050C2BB85
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 13:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220BE20767
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 13:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QThXN+f4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220BE20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP4bb-0002Th-3E
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 09:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jP4a4-0001S2-Nf
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 09:29:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jP4a3-0007rU-Ga
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 09:29:24 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jP4a3-0007rD-CT
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 09:29:23 -0400
Received: by mail-oi1-x243.google.com with SMTP id t199so13150616oif.7
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 06:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mYIJr/NIUn6tB5qz4UxkwwM9iCHMtjun13/tTPeokBY=;
 b=QThXN+f4PljllfBo/OFU+sui7jszqbYno+ZD+drZ7IgdeEghFZefiNGQpRsg/FIGJW
 7KEe7hR1Q4rfV45xHM39KF0yLQYXsU5edxKBfB+oDytnz7pvepRkuZEXxIQANQGL8EcS
 Zoi+0PUK8RqHgMBKY1+GDN26nsfAc1sZnK1qiREXGw2UQWAaVxvCBYqxGj3bx+es0FJT
 y4DA3M58zdiNwtIRWQvq0VaIGMrFboVfMUX9jUfwqxFqhHrzjdh97cERZvdb5KINukRK
 ki3izOZ8OD3SbG/QCwiy3NZBTjU6+moyPQGHuJNa2r/gXV016iu7fa6cACuXC1M5ZZmD
 1BKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mYIJr/NIUn6tB5qz4UxkwwM9iCHMtjun13/tTPeokBY=;
 b=lZ3tl4cRgXwfZRxgbuo6SMJ06SuNQ72AjBFKPMDUWrLLkRS0snpmOWtw9Sc1CiQ+bq
 /2tCXO0o4va0Lf3K1RjsAtepc+VYfD8ijyhUZaVT2LQKl4vWTwY0ggAaKEoJXN7tp0BV
 NOQROgt+YJ8pHuSzsEaUOifmWQrT7hnbrsotAMnqpPzRqbbz/vxd6YvuyIbtDvxFE1/m
 1Il3d4v2j3pKl85pqTP6TjkkdcnXc34LcYGxX19hwsK3mL4ss3T/IdedkyQyG6XDX+AO
 7z/Bpj7+gH7Dg5SpOrdV2K2HCytu9kqnVV08kt/Ne16VJVL06vqt4sMzxAIkftJrwfTI
 AJYg==
X-Gm-Message-State: AGi0PuaH/a/MWfcsYrkVUTXM6zd9WKf8xE3/CfrQorSemm+pfGBpmOMa
 RDx0JJIMpb73OvQtEd7GlN3AxYakfe2FvyTza13lfQ==
X-Google-Smtp-Source: APiQypIK5XZiZGXEyjrLI7DvIb5WLX8lXUjER7p11mXRCfKhOhsHIqXvHBsJjPfMSsJF7Vl1P0cOjqhYh8cViUoCKUs=
X-Received: by 2002:aca:170e:: with SMTP id j14mr2864832oii.163.1587043762467; 
 Thu, 16 Apr 2020 06:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200311064420.30606-1-richard.henderson@linaro.org>
 <20200311064420.30606-10-richard.henderson@linaro.org>
In-Reply-To: <20200311064420.30606-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2020 14:29:11 +0100
Message-ID: <CAFEAcA9+sx8fpMBtTre2otKFY44pvJMuC7Pu9aEDAO5t7kg4tQ@mail.gmail.com>
Subject: Re: [PATCH 09/16] target/arm: Handle watchpoints in sve_ld1_r
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 at 06:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Handle all of the watchpoints for active elements all at once,
> before we've modified the vector register.  This removes the
> TLB_WATCHPOINT bit from page[].flags, which means that we can
> use the normal fast path via RAM.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> +    if (flags0 & TLB_WATCHPOINT) {
> +        mem_off = info->mem_off_first[0];
> +        reg_off = info->reg_off_first[0];
> +        reg_last = info->reg_off_last[0];
> +
> +        while (reg_off <= reg_last) {
> +            uint64_t pg = vg[reg_off >> 6];
> +            do {
> +                if ((pg >> (reg_off & 63)) & 1) {
> +                    cpu_check_watchpoint(env_cpu(env), addr + mem_off, msize,
> +                                         info->page[0].attrs, wp_access, retaddr);
> +                }
> +                reg_off += esize;
> +                mem_off += msize;
> +            } while (reg_off <= reg_last && (reg_off & 63));
> +        }
> +    }
> +
> +    mem_off = info->mem_off_split;
> +    if (mem_off >= 0) {
> +        cpu_check_watchpoint(env_cpu(env), addr + mem_off, msize,
> +                             info->page[0].attrs, wp_access, retaddr);
> +    }
> +
> +    mem_off = info->mem_off_first[1];
> +    if ((flags1 & TLB_WATCHPOINT) && mem_off >= 0) {
> +        reg_off = info->reg_off_first[1];
> +        reg_last = info->reg_off_last[1];
> +
> +        do {
> +            uint64_t pg = vg[reg_off >> 6];
> +            do {
> +                if ((pg >> (reg_off & 63)) & 1) {
> +                    cpu_check_watchpoint(env_cpu(env), addr + mem_off, msize,
> +                                         info->page[1].attrs, wp_access, retaddr);
> +                }
> +                reg_off += esize;
> +                mem_off += msize;
> +            } while (reg_off & 63);
> +        } while (reg_off <= reg_last);
> +    }

Another pair of almost-but-not-quite-the-same loops.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


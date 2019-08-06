Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A79AC433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 14:24:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A0F2064A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 14:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mXq83VCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A0F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv0Nr-0000Ae-AU
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 10:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41407)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hv0NV-0008DF-ID
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 10:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hv0NU-0006Tx-JA
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 10:23:53 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hv0NU-0006Td-Dj
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 10:23:52 -0400
Received: by mail-ot1-x341.google.com with SMTP id j11so35583972otp.10
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vhzTGlhi6jv9Oo6XkHzFd0lUwPVIfnG8JAzZTNE1GAs=;
 b=mXq83VCjnd/Us8My45O14ji2uD0xq7q2CG3cNKijmg3wT8j7AfHqFRoe7fYY+PN1uw
 tWv08TwpAENXFAnuR+z+eGSIm8HIi6P0cTGtHwPgGt4eKtsJ9RjOMyWBDO1oOVePlkTx
 4+eBnk+q5RSE1wwmEy7563EQLHUIuvBUdZP3cF9j25k3T3CVmebF1JmXU0jKjeYKTlO/
 3hu2XUuFn2737toYNPWVoEkixCOuzHpygELlQxdxjXIRFaO4l28l2NwA99MuNAnR/aHW
 gQvhc5Bmw+6aOHDXnTeQOr89HlI3UBUiH3Ca5RvmUjCuc9Jnt1yadGKwLduhCS5ccpbB
 2YyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vhzTGlhi6jv9Oo6XkHzFd0lUwPVIfnG8JAzZTNE1GAs=;
 b=d7Km4sI2GJOltaR9mqS6edudZLT7KApgMKbv4hvmAyg7/NrE73/7FqiMLNkLrINgzb
 ZVyV6nU6GLISJTPnf32A9/GjW1eSQooW4+56ZjDl8h651j8Nw93+m/VFR7hUeKKsquF0
 lsc4z+ZLlxTbmu5Mwe2vGo0MtxbUGYplEYWkbRcM77a1hup0Z3qqWqfeQfShjDiIpCNX
 KCHUrodns40NAlviISpr9tZ1Tygn7xJPY0/tOfkSf8YWJyBEjqqNBuu/ens1oorK1nnF
 ow9otZf6VquL7omsQ5R6a+pLwj4u5gCz+Dcz4MbxLwlsd4KphviV2HL6ArI7s3sKUjpG
 sJ2Q==
X-Gm-Message-State: APjAAAWonjWj6IxdbZUytz2R21j/8ETySxsBy1Ip+WK1KtZKOF/mk+0J
 b+lciyC319yp3TWKi22DsomoUYFqVg7cIJG+kH3bVg==
X-Google-Smtp-Source: APXvYqzOHXGOKm9alTejJ+wSzna3oSTXclfifNQOZ0ZjP/CU7T9Bd1EjTvbkJKtCw2g4Lpnh/aYwMXy4UkTc26Ihz6o=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr3576138oti.91.1565101431336; 
 Tue, 06 Aug 2019 07:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190729214717.6616-1-pbonzini@redhat.com>
In-Reply-To: <20190729214717.6616-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Aug 2019 15:23:40 +0100
Message-ID: <CAFEAcA-gtfK1AwSFKo9XatJ_E9345Cd9+MS+1uu2WYG0i32sVA@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH untested for-4.2] memory: fix race between
 TCG and accesses to dirty bitmap
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jul 2019 at 22:47, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The race is as follows:
>
>       vCPU thread                  reader thread
>       -----------------------      -----------------------
>       TLB check -> slow path
>         notdirty_mem_write
>           write to RAM
>           set dirty flag
>                                    clear dirty flag
>       TLB check -> fast path
>                                    read memory
>         write to RAM
>
> and the second write is missed by the reader.
>
> Fortunately, in order to fix it, no change is required to the
> vCPU thread.  However, the reader thread must delay the read after
> the vCPU thread has finished the write.  This can be approximated
> conservatively by run_on_cpu, which waits for the end of the current
> translation block.
>
> A similar technique is used by KVM, which has to do a synchronous TLB
> flush after doing a test-and-clear of the dirty-page flags.
>
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         I tested this some time ago, and enough has changed that I don't
>         really trust those old results.  Nevertheless, I am throwing out
>         the patch so that it is not forgotten.

This patch looks almost the same (maybe identical except for the
commit message title?) as the patch "memory: introduce
memory_global_after_dirty_log_sync" which you sent out at almost
the same time as this one. Which patch should we be reviewing?

thanks
-- PMM


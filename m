Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E653C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 14:16:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27AB52070E
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 14:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Orv54Bd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AB52070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwndd-0006tM-Ej
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 10:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwnd2-0006Ra-0w
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 10:15:52 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwnd0-0003f6-8h
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 10:15:51 -0400
Received: by mail-oi1-x241.google.com with SMTP id w17so10534045oie.6
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2020 07:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VAx62HjJPVVsjrnNlN67JFirro7P/EmKUQk+raZs5b4=;
 b=Orv54Bd8MnnkGqJ7toyBtNuZDtUCbYEP6+cvWKnkBNyr3SxlruyzFuLdBIPRmwBpX0
 PYC1kOMh77yjbS3wW8SCxLhlcukPAz7kg+2GlKEA+Uxp8YBkco2rYJZMUWDJAjucUtyg
 4jnmrp054bymIf88hKkyyCQxQCNCsBBXOJVGm1h13cAMrKn5MJtBcDHls+HVQp5RhIss
 2RSmtr9gI8NS5NcMVBAVlbQu4SPZa/NzPFH0OnlkzOJ08aXpNSQ+cKQEe4hIn1CycijA
 v5y64Z1bKR192JlJmXrY17mbrp5aJFOqjQJ/6742OEERemzhwN0wqet7xdO3f2PPhTnF
 7jZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VAx62HjJPVVsjrnNlN67JFirro7P/EmKUQk+raZs5b4=;
 b=ALBTSr1zV4xVQ0H9rcxKszXoOhG1cQrN0Reu5SqapSAiBPfgysmPfd2K6dr+VdJChT
 QV4D03r2XNEwEXPkAT0UUYRqcdH4WgQwrhGvxfmQnYKi8qv4bjK+6Jkl+klreYc0psQR
 6WFqRzoFFURPIyTBt8lOOXibAejuaRQZGv5KuzBtx9Fbg6T0kwaRdwqDBsy+21QKDFl1
 mklBJiIaZTwDCig3gvmrE1rvkIS3vsC3O0CIOScIu/wxqkvyIPQ48X1cPD+nz9yt1lSf
 otxpKwrE0URGibEsFyQWK1T8ggVN7PiO3G9JfSCsWC/E7Mm3yB0YKuWrnPMjZdFrHmk1
 4R5g==
X-Gm-Message-State: AOAM5300ZDkYqmkERjvOTxgqnyXAyp/xFNvooiBWlKAzL68TJJbbaZqj
 w5uCRo+BWoEho62tFSoOZqnSq4Dhge7GRO/EvIdAMg==
X-Google-Smtp-Source: ABdhPJws1jDfKiuybreatpfzdiu69kkAARmQKdatiWC5PLA1xnsBygXgi0lAJGW1lZEj+u9uVVm7KiD5Tgwjr6ELxHw=
X-Received: by 2002:aca:1706:: with SMTP id j6mr10905274oii.146.1595081748846; 
 Sat, 18 Jul 2020 07:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqwtUrSpCqNGEETBijewzvmpno8OAX_PKSShDP_gUQ-3VQ@mail.gmail.com>
In-Reply-To: <CA+XhMqwtUrSpCqNGEETBijewzvmpno8OAX_PKSShDP_gUQ-3VQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Jul 2020 15:15:38 +0100
Message-ID: <CAFEAcA96mh_4EkKz31HgzfPOEQvhta8VTcvMV=An8Us0+x=NfQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] exec: posix_madvise usage on SunOS.
To: David CARLIER <devnexen@gmail.com>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 18 Jul 2020 at 14:21, David CARLIER <devnexen@gmail.com> wrote:
>
> From a9e3cced279ae55a59847ba232f7828bc2479367 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Sat, 18 Jul 2020 13:29:44 +0100
> Subject: [PATCH 2/3] exec: posix_madvise usage on SunOS.
>
> with _XOPEN_SOURCE set, the older mman.h API based on caddr_t handling
> is not accessible thus using posix_madvise here.
>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  exec.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/exec.c b/exec.c
> index 6f381f98e2..0466a75b89 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3964,7 +3964,15 @@ int ram_block_discard_range(RAMBlock *rb,
> uint64_t start, size_t length)
>               * fallocate'd away).
>               */
>  #if defined(CONFIG_MADVISE)
> +#if !defined(CONFIG_SOLARIS)
>              ret =  madvise(host_startaddr, length, MADV_DONTNEED);
> +#else
> +        /*
> +         * mmap and its caddr_t based api is not accessible
> +         * with _XOPEN_SOURCE set on illumos
> +         */
> +            ret =  posix_madvise(host_startaddr, length, POSIX_MADV_DONTNEED);
> +#endif

Hi. I'm not sure this patch will do the right thing, because
I don't think that Solaris's POSIX_MADV_DONTNEED provides
the semantics that this QEMU function says it needs. The
comment at the top of the function says:

 * Unmap pages of memory from start to start+length such that
 * they a) read as 0, b) Trigger whatever fault mechanism
 * the OS provides for postcopy.
 * The pages must be unmapped by the end of the function.

(Aside: the use of 'unmap' in this comment is a bit confusing,
because it clearly doesn't mean 'unmap' if it wants read-as-0.
And the reference to faults on postcopy is incomprehensible
to me: if memory is read-as-0 it isn't going to fault.)

Linux's madvise(MADV_DONTNEED) does guarantee us this
read-as-zero behaviour. (It's a silly API choice that Linux
put this behaviour behind madvise, which is supposed to be
merely advisory, but that's how it is.) The Solaris
posix_madvise() manpage says it is merely advisory and
doesn't affect the behaviour of accesses to the memory.

If posix_madvise() behaviour was OK in this function, the
right way to fix this would be to use qemu_madvise()
instead, which already provides this "if host has
madvise(), use it, otherwise use posix_madvise()" logic.
But I suspect that the direct madvise() here is deliberate.

Side note: not sure the current code is correct for the
BSDs either -- they have madvise() but don't provide
Linux's really-read-as-zero guarantee for MADV_DONTNEED.
So we should probably be doing something else there, and
whatever that something-else is is probably also what
Solaris wants.

We use ram_block_discard_range() only in migration and
in virtio-balloon and virtio-mem; I've cc'd some people
who hopefully understand what the requirements on this
function are and might have a view on what the not-Linux
implementation should look like. (David Gilbert: git
blame says you wrote this code :-))

thanks
-- PMM


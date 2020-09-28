Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB71C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E952076B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PrC+1E8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E952076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtYK-0007hE-RW
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMtL6-00025F-SO
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:37:14 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631]:45165)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMtL4-0005As-AB
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:37:12 -0400
Received: by mail-ej1-x631.google.com with SMTP id i26so8487281ejb.12
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 06:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WDWEmJqWHDjw8+V+vAhf8PHk7EdAZ4cIOjCZBTopxug=;
 b=PrC+1E8JE8pvBoe0UxcAO0tFRrXSsujZdrQC0l9kyDWfgWhxg4BWt9M5kL1zJFeSyj
 ienGPktPucx2XqZNlZDyAeIDFPUtKeabGQ5wvTeGGR04jcdM46q1ykxl2gDy8HWS6CiA
 CZtXcRvOJOeLU95BUEDQ/mkD40JQ8D3tVMU+YY3pPcuJZ1fe2QhsSdnSQnAH4Lz1qOBQ
 B62+wxLS5+QsUBMygHi/aUsHzSHZ1iDqfakGt9w0vr5Xf91zW25AkTW0x/mEWpC3Qt8p
 zC6wlURgnQsb6WpCTNqQAVeH2R0aNtZFLzHy1Uhbbmv79PQb6rKKZQaRtUpuDOjc+Lo/
 20+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WDWEmJqWHDjw8+V+vAhf8PHk7EdAZ4cIOjCZBTopxug=;
 b=Vagx1KqeTzWPjNxlEPOXvJTsq1XfKciK8axYFHRVkK3IbyTRjAfSoQrib6k5NNbzrF
 ZiGm04WL6fND37afNIODUeHaLj0GncGsrPNFJ/Y5QvF8ViM0TXD+JosNViirt2bk9g0O
 Y52SzNLY/zlvUPxZWdd0bjXBA1auHwFz/vSw26nmsIyWtJ31/peHIS8rku75RwaIycao
 5tHGnzXZZtY+mwd791PXPFcQvkOYPPJLiRDEy1UY0/83Jl/4qBpdrTjDviA0HE6TKG/X
 Z/IYHAUTvxC7Yy1w4B5BjS9rzHlXKDeZqV8w/VXQnnYhWatTb9h8zYq7Rj5YKtiH1Xdg
 IMDw==
X-Gm-Message-State: AOAM530tnKI+hn+/o87VVH3SYeiAM5Z/EwxsBrgwSUBDL1TvTqrwUZ3b
 qhtzH6tTAuHOahK1r9K2NDcZygTyXk45ajsYLGAcYA==
X-Google-Smtp-Source: ABdhPJx76bJbG7RUJau20hyPUVtBBpajwwUADggDH7rcfs6gUgnVx4/akeL/vK6v0jLwRQHqaoFQdNaH/dM1WpTGq3w=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr1630032ejb.85.1601300228364; 
 Mon, 28 Sep 2020 06:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200928125859.734287-1-philmd@redhat.com>
 <20200928125859.734287-3-philmd@redhat.com>
In-Reply-To: <20200928125859.734287-3-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2020 14:36:57 +0100
Message-ID: <CAFEAcA9qi+Nyva7c8Pj8NtZ+shXzzkA+WaybZiFGZ0sa3fToig@mail.gmail.com>
Subject: Re: [PATCH 2/3] qemu/atomic: Drop special case for unsupported
 compiler
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Sep 2020 at 14:12, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Since commit efc6c070aca ("configure: Add a test for the
> minimum compiler version") the minimum compiler version
> required for GCC is 4.8, which has the GCC BZ#36793 bug fixed.
>
> We can safely remove the special case introduced in commit
> a281ebc11a6 ("virtio: add missing mb() on notification").

> -/*
> - * We use GCC builtin if it's available, as that can use mfence on
> - * 32-bit as well, e.g. if built with -march=3Dpentium-m. However, on
> - * i386 the spec is buggy, and the implementation followed it until
> - * 4.3 (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D36793).
> - */
> -#if defined(__i386__) || defined(__x86_64__)
> -#if !QEMU_GNUC_PREREQ(4, 4)
> -#if defined __x86_64__
> -#define smp_mb()    ({ asm volatile("mfence" ::: "memory"); (void)0; })
> -#else
> -#define smp_mb()    ({ asm volatile("lock; addl $0,0(%%esp) " ::: "memor=
y"); (void)0; })
> -#endif
> -#endif
> -#endif

You need to be a bit cautious about removing QEMU_GNUC_PREREQ()
checks, because clang advertises itself as GCC 4.2 via the
__GNUC__ and __GNUC_MINOR__ macros that QEMU_GNUC_PREREQ()
tests, and so unless the code has explicitly handled clang
via a different ifdef or feature test clang will be using
the fallback codepath in cases like this. So you also need
to find out whether all our supported versions of clang
are OK with the gcc-4.4-and-up version of this code...
(I think that deleting this set of #ifs means we end up
with the "just use __sync_synchronize()" version of smp_mb()
later on in the header?)

thanks
-- PMM


Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A208C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A522207ED
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ing49XgJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A522207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaiOx-0005Vi-EF
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jaiOC-00046k-0b
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:13:16 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jaiOA-0006NL-7D
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:13:15 -0400
Received: by mail-ot1-x344.google.com with SMTP id w22so8522919otp.5
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Xt6gu4+eaQuMJFPwT8oV6k+iEiCGWPUTkC6kwPqJGp8=;
 b=Ing49XgJjmRpKG+8PpjhHETinpEQfqhJbzvsMEn9umd1V3HgL5tP6PEUtuBvcWB3SI
 +9uA4tPXHT7EnE1vN3ivWU/DZpx7Qk+Rs5r4znx/3DmozXrClPVQrkrcnz9yF2xcJH8J
 nIlp8/Z1ABLwiI290Oxz11zINpBXDK7LF9mYAu5vHY0Xutadp6mO5y2xRvNzxuN2KvhS
 Lo+tmb5EiNEIIl26pFQ/kt7Ys2IbwrxN2nfXwvKH1VuUhCMUznhG6Zo+zMPkKvtwZK1T
 lAC/9cgTSH/zn3civHv+3WOy3zd7xg1pFORtoQ0swX3b4yny1RHkm4/g1Cbe8tNN3dVf
 Kl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Xt6gu4+eaQuMJFPwT8oV6k+iEiCGWPUTkC6kwPqJGp8=;
 b=p9+4AWfdnaOWjbdC1TQ5fgHVHCY1ny6df210qNSO6lsDg19M7SJdGlm/UT3UD5exK2
 nyvmLSdiyWJkscgcnAXS+S2gHvtlTqiw+lw055RBOg1mrmx89wP1JBDowiFGpH4Tkmt+
 GoObCxmbjQ1Kh1ghbGVCIGvkqJhU+h8kaLeOfc8lEbg2Pk8nSMnJ+hu/SClIDpjm8VOO
 Z0bJX6KZwfJCFffMBFC7Q4eQUXjxt4EUp0Knj4+ihsZ6J4RIXWE0GiDZr9MXKYnzt3zr
 vY6RNfN+TKTEoO4blkO5NaZxnjS5aEUZTvWem0wvZKvngue7jy3J4vPXxzsjz8UHEBjP
 tD9g==
X-Gm-Message-State: AOAM5331Q0rkclwXquvSflcomz/6mZFjpYBKxZqvueOxT82CUMS86q4F
 SNlb2b9ptBFLmS6f2wALuT1BmtyjNIcTd0ixAtmfJw==
X-Google-Smtp-Source: ABdhPJzycwB3eF621Wb5qHnjYXqy1Q85+6JHhC9Ug0G4CJd+tHxYjIL1E+HGUeQZzWyHGmF/hPYvS7lg5wMLiNOa94M=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr12261051oth.221.1589818393131;
 Mon, 18 May 2020 09:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200518155308.15851-1-f4bug@amsat.org>
 <20200518155308.15851-2-f4bug@amsat.org>
In-Reply-To: <20200518155308.15851-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2020 17:13:01 +0100
Message-ID: <CAFEAcA8XdUMyQfXWMjr5cqc8+p8k_ECv8WpeOoE_mtDNAJENJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] exec: Let address_space_read/write_cached()
 propagate MemTxResult
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvm-devel <kvm@vger.kernel.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 16:53, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Both address_space_read_cached_slow() and
> address_space_write_cached_slow() return a MemTxResult type.
> Do not discard it, return it to the caller.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/exec/memory.h | 19 +++++++++++--------
>  exec.c                | 16 ++++++++--------
>  2 files changed, 19 insertions(+), 16 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


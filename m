Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DA0C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3EC72082F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VRAKj0YA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EC72082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6eM3-0005lN-TC
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 12:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6eLH-00056l-Tk
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6eLF-0006lo-HB
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:49:59 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6eLE-0006kj-6R
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:49:56 -0500
Received: by mail-ot1-x343.google.com with SMTP id z9so337022oth.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 09:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rr4UCfVHKav4oC6NIKyVwaHkTCmC6VAHr9oIXyxI1JY=;
 b=VRAKj0YAURnyeYjjEC0XlzvILcYMKxtiQ5Rcht+/LtaFUJ8p3JlY7OHOoPLd8944+a
 Mg+aEJDXiEqfjEp0iE7KIhzIiYrkl1fDQM+BVnyXwtlGHNq8M2TgX232zJ6eT7IKVOky
 0emKoIfdf0yR16Rna555XaDBBs1G+yebdKBjTdR2GXv4MChoHBvAwXkS9k1dwYsO2yy7
 lFXitXr5K0elWSRTESJQiUTq0ecGv2SFG05mTBDyEfINviN5VKaaYLWU/BuNLo6WbIFa
 GkjBt0uoBRBrpVYcEr69jB24O1/bGrxDUoA6l7bqOceSwb01WzbGto2HTcXllUvMCail
 Vk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rr4UCfVHKav4oC6NIKyVwaHkTCmC6VAHr9oIXyxI1JY=;
 b=EqJ2Kn3YEnYWrpcLNwgy/yglQwKeqom4ByNtFOVIdWI76+RXTXmDwT0XBluBESK+jK
 dskhNELjJKQN7WZFMQ5tpvmaiwHlsf0OXn1/BFhlvdOmamEKaN1a3BY9/Exrq9Z0Tg3A
 kERfK1nxXGGTDSppcIgt/sfoP48+YpblC8fl7f3h/Yi+654Xy++FfVnxL/EE/tVU2FAf
 9bfDBI4qDlDTRgGoJs3trGTTT3NyMY4n1UyaTI2AEotf9coEQ+z3EV2ht/x0DnEOw+Co
 dJ3jQUTDTX8iyi5U1BSm5ErAY4WG7O6ByWgxY+JnfoRnxW2unxS+PEKkyaBHxsHxKk7i
 en9g==
X-Gm-Message-State: APjAAAUISLZJQmREAj3pPzgBxU+0i1jz//NJiuJs4R+MeChr+AMiBAqK
 Lrc3K8fkpprjRD2rXCUKKdXauuvY7uVuAYcLWRKY9w==
X-Google-Smtp-Source: APXvYqzeEEUZoP8UlGn458wGEvExZET3ySUVVfgjyvG2w3AHmUm9xqZ29vGoyQrvjaqRaIrwkfVhMRc1Qs+0mhmRUr0=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr33647379oto.135.1582652994654; 
 Tue, 25 Feb 2020 09:49:54 -0800 (PST)
MIME-Version: 1.0
References: <20200218190958.745-1-richard.henderson@linaro.org>
 <20200218190958.745-8-richard.henderson@linaro.org>
 <CAFEAcA_QHoRcfv0oLgxNsuEOaRJOoM9sQHqXZEP-tDeJrziVYw@mail.gmail.com>
 <4dbed837-f3a4-2280-8655-6975dd235e4b@linaro.org>
In-Reply-To: <4dbed837-f3a4-2280-8655-6975dd235e4b@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 17:49:43 +0000
Message-ID: <CAFEAcA8+72ZdTFj+b4X0fsNoaWPVR_0icfT8Y_FyUkPYRLJ0hA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] target/arm: Honor the HCR_EL2.TTLB bit
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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

On Tue, 25 Feb 2020 at 17:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/25/20 4:01 AM, Peter Maydell wrote:
> > The set of operations this traps differs when ARMv8.4-TLBI is
> > implemented. It looks like you've applied this access fn to
> > the wider with-v8.4-TLBI set? (eg TLBI_VMALLE1 is only trapped
> > with ARMv8.4-TLBI, not without.)
>
> Um, that's not true.
>
> ARMv8.4-TLBI adds the *OS and R* insns, and extends this bit to apply there.
> But all of the original v8.0 insns are unchanged.

Oh, the spec has confused me by listing the TLBI operations
in a different order in the "with v8.4-TLBI" section (where
it starts with 'TLBI VMALLE1') and in the "otherwise" section
(where it starts with 'TLBI VMALLE1IS' but 'TLBI VMALLE1'
is still in the list, just later on).

thanks
-- PMM


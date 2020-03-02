Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AE0C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5A9214DB
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vN+IrQJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5A9214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jhI-0008Rn-4G
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 06:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8jgd-0007tS-I3
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:56:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8jgc-0002Hy-AP
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:56:39 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46319)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8jgc-0002H9-4B
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:56:38 -0500
Received: by mail-ot1-x341.google.com with SMTP id g96so9350943otb.13
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 03:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8ce+9WLoPMBik9Xb3ltlTP/bQVe5reTWxd+l2Zyo8kU=;
 b=vN+IrQJCoBlMJmb9Hf0/Qg1esShijVnBMC7mwf1mcsK9iX6uOFVNkUbX5ycetlgETY
 5vxnhM8uqdgYAhLp+9OnUtfpk1KSVAviXeatM5Ph2kPydRBquSy/ujmaPaB2HsocCdgl
 X/aIQHB6w0IeuvdUGFWfAYxvoC9F1A+o/8bFHWB6YrFAFD3oKLKZxGPKV62d5LnaFdDd
 qqmigVVU/0QS3FYQ1Enj83kdnBQHmzm/KJQBmcngOtPksvP/B2T6z1xN3gR7HiFbPP6X
 U+p5HrcpRP1Eos0OO1My0JMQomdyBYHYT+VltlSnLRkeA20oC2Fpv+5pKfz6I3WWhR+l
 lefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8ce+9WLoPMBik9Xb3ltlTP/bQVe5reTWxd+l2Zyo8kU=;
 b=ZgItFZqh74tLrSM3GlIgPrLug8xk5C/VS5iQtvvEcoOb9c7PHHDE8s3BdDj7ZcjqTO
 UbB/JW028WcKkp+a/aAz0vR/Yga2YC3LvrUqtZebitpkRTDH43y+gheaVJmy/LFO8T9d
 E6ac9Pl71pSRkN8JDCGhhzArFcj6xFpqxCk6v3vy0XYbW5geqPmqIUX0xX0bhi/wJ3YM
 QxX9x5cGAqXEXqLofPedfINFu1dCF1U3imh32slWmwqE7yN0812AvBHSmARtU7qljqi9
 P+ar+tbVzRdMJLOpULsthWznve+inKXuyflujdIbtttEthAim8kPaXzbqQqpIq7HYa2g
 hu9Q==
X-Gm-Message-State: ANhLgQ0lgt6i/EHMnk2jto7fUw8fVVMkaSlGy/NPved4lLeT2Et9FDD5
 ud+gYOVi6nQguM7QloU53XqbKFnTuCYnZduhySeJSA==
X-Google-Smtp-Source: ADFU+vuDgqlGSj0YdAH7Uxsyje2rG5wl1lhurYTbAS5gsJ3raHoxkkZLje2GmMsfyYdtTcQK0vGnzDhTsgJSDxGmXBI=
X-Received: by 2002:a05:6830:1406:: with SMTP id
 v6mr3714337otp.232.1583150197046; 
 Mon, 02 Mar 2020 03:56:37 -0800 (PST)
MIME-Version: 1.0
References: <20200225031222.15434-1-richard.henderson@linaro.org>
In-Reply-To: <20200225031222.15434-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 11:56:26 +0000
Message-ID: <CAFEAcA8eqWYL+BAPCqPeGHEBRpcio+xM=A56Ou2znB7yKQu5QQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] target/arm: Misc cleanups surrounding TBI
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

On Tue, 25 Feb 2020 at 03:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We have a bug at present wherein we do not supply the memory tag to
> the memory system, so that on fault FAR_ELx does not contain the
> correct value.
>
> For system mode, we already handle ignoring TBI in get_phys_addr_lpae,
> as long as we don't actually drop the tag during translation.
> For user mode, we don't have that option, so for now we must simply
> accept that we'll get the wrong value in the siginfo_t.

Something weird happened to this series: it looks like
the first 2 patches were sent as replies to the cover letter,
but then patches 3-8 were all replies to patch 2:

https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg06699.html

The result is that neither patches nor patchew think they
got the entire series. Could you resend it, please?

thanks
-- PMM


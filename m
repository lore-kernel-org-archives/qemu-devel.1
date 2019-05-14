Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32439C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F058620881
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k3jjeXuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F058620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47648 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQWgo-0001Zq-7n
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 08:37:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQWfO-0000gj-L7
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQWfH-0005fI-7O
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:36:17 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQWfG-0005ec-Su
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:36:15 -0400
Received: by mail-ot1-x343.google.com with SMTP id t24so6321371otl.12
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 05:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=oySKgSnzErgTCPNKJ0w56R7/irJDB/zHyvLpBJTZfYY=;
	b=k3jjeXuwHSFpRQniyM57Hr71mp6ylRITl+7tgFSVXDdn3n8z95sDjJuRj3JRcG5Woy
	GVFoSojjfVZHiMOFZlRX+YF7zWbvskrlugnLRSfG7LqaIiVp3+gEfBO4zBfONBm2v8we
	+TJAZnlqKT2wyj/iP/MsEsHdsFJZqmDiG9xwdTPOra1s1NmtnszoaCMGD4A4WOHK7OO0
	xoZv3xBb4zx944pvyoEKx3rzsqtT2EsL0Cp+TKYa0hTw2rT9b/oENG/lVwlgmoBUhYfs
	X6w3ASX3vMR/6gbcwuMxyOcHYeJ7nhq2CK6LdvsV8+INt/+gfWdjlpRJGDcexDbUK9yP
	HO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=oySKgSnzErgTCPNKJ0w56R7/irJDB/zHyvLpBJTZfYY=;
	b=Ht1gEQiwQbAM/dosmfm2PRHVRgU+8ENDqRRrcZTDGTEOARPRKulpx6LID+L4mRxYJ6
	w6gmlGNNu3vqf0a5VNyGz56+M2vd9EuAohl0FF+kmkBOZSSmqnHQpCWSqjIFsVSaQZ8S
	Q4WUpZB0yTrPjt/fnm+ePKHGdPO/OTdePHKvsKuE2z9JlORwis9f64ZdGPTF/9NTJ/z2
	vn+WF0+W1QLNtWkzyY+L0/2wrCAYhw3Ig1OPtSNSTCdJGoPT2wza9bSQ6an2TMmnvfBB
	N6Seqap5iDrADTuXQ1r38nw2g7DEi/tz90YjxYZcBn2bMDDdx9+LaT8NuOuFEgje6FfQ
	sQOA==
X-Gm-Message-State: APjAAAUq+2SIY+6sbVl53rLuW7Z22XL6pTNG2+02iO0mbyntMahvCKud
	bIW9P9T+3FCV5FytETMexIibfHICkDTId8jwAuoHrw==
X-Google-Smtp-Source: APXvYqyXNlktv3YNKpGuANtfbNNQiJU3HfOauPVK65pnBdDz0CEcRmOzD3ENCFesFBYBTZcnAV7jb393D9kjWulEej8=
X-Received: by 2002:a05:6830:13c4:: with SMTP id
	e4mr4068056otq.171.1557837373934; 
	Tue, 14 May 2019 05:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190510185438.29533-1-richard.henderson@linaro.org>
In-Reply-To: <20190510185438.29533-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 May 2019 13:36:03 +0100
Message-ID: <CAFEAcA-bGyRDeYNdiAkJfNNqSPkbOpGZCNyY94w3dJftzrYPJA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL v2 00/27] tcg: Add CPUClass::tlb_fill
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

On Fri, 10 May 2019 at 19:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes in v2:
>
>   * Fix --disable-tcg compilation for x86 and s390x.
>     I adjusted every target/ that used any CONFIG_TCG in cpu.c.
>     but then afterward I see that only x86 and s390x have had
>     their Makefiles adjusted to make --disable-tcg actually work.
>
>   * Fix Werror for 64-bit on 32-bit.
>
> Only re-posting changed patches.
>
>
> r~
>
>
> The following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0ccae8:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-05-10 14:49:36 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20190510
>
> for you to fetch changes up to 4811e9095c0491bc6f5450e5012c9c4796b9e59d:
>
>   tcg: Use tlb_fill probe from tlb_vaddr_to_host (2019-05-10 11:12:50 -0700)
>
> ----------------------------------------------------------------
> Add CPUClass::tlb_fill.
> Improve tlb_vaddr_to_host for use by ARM SVE no-fault loads.
>

I did a test merge of this and it passed my build tests; I haven't
applied it though pending resolution of Aleksandar's comments.

thanks
-- PMM


Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB137C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B704F206A3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IyU3u/88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B704F206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51702 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOfuB-0000Zu-3d
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 06:03:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOft9-0008W1-BS
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOft8-0006RF-Cr
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:02:55 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hOft8-0006Qu-7f
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:02:54 -0400
Received: by mail-ot1-x344.google.com with SMTP id l17so1770086otq.1
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 03:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=b9vIq08mdzzwoVPIGr77y9MvPTEWiqQRnko3XP0jL2A=;
	b=IyU3u/885WHGdoDZAR885nnLuiYxod5kbjpxg3ZwK7kL/n+Shn7vCZINDXdYiREEFf
	aXMNVKlFqLLYoGmBgZ3c2x8DiOvp+yhsk/52q/XhcDepJEkqX/peveRm/NSNfqcaQRc+
	VV3YQ427GmwSD4gLiuPpTa9RCCzbQXqcK0FfzOIQ+/a0UocUKVK9T6/xFos6OnE4+auB
	nf+QepbXzi6hS5xf6ejtqobemz4sZC0gvm/vjMbRzHg+jsdMbK9jlWsTthEZQs6DAYxL
	gExDJ+7TcbsJiV1mejL7di2ybV6tBlea2FMr5fb+2jNKaWJKKNaTlMq0XCH3GIlxlipT
	qkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=b9vIq08mdzzwoVPIGr77y9MvPTEWiqQRnko3XP0jL2A=;
	b=cwH/v8WUEeg+JiF7Sz+3ZE2l2Dvvn6yodmsORG8XqLX8nIyV98X1AfG8PsU9YyA+z1
	U2iCyXer3tF6as1wYqFpuVM1l+M/9xk0rmaxPXJICKifRcXKPlGGx07uwfoHvoIe4Vzg
	ttJ9A+OhpWdAk2jUYSgK1Dw9daEfiH2iSZwMWBGjuOT5VBFYkrpkoY/LeVgHDJQwF6zN
	OZLuPp3FamK+vvt2/LLm9J997ZuwovO/z+ugf+B7tW2uaWR6us2ZIEHzl3UYCJjPDHNh
	z3ZCMH0hV8s4nzHaCI9jdg/3xQLaVNuKdRcxxb1Anuoie7osfCv44OOyx/B4COf6U/x6
	bVmA==
X-Gm-Message-State: APjAAAW+J6yorsLOCtu/B+0oySmv8Mdb/3Sp2p+Hz/Cs9U4wiARzQiQI
	gngFqI+z6Mu9ke4opFCr19FKqCLbQgLRfuY4QD66uA==
X-Google-Smtp-Source: APXvYqy3lneTTqi7z1aWgQ5Wm5WLtq545tcStVEfA49qHkDLsuAmPuo1iTAFcu4xFqO2J86hIJdYrbPDBPCd9dfH1RY=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr1006508oto.151.1557396173258; 
	Thu, 09 May 2019 03:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190509060246.4031-1-richard.henderson@linaro.org>
	<20190509060246.4031-15-richard.henderson@linaro.org>
In-Reply-To: <20190509060246.4031-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 May 2019 11:02:42 +0100
Message-ID: <CAFEAcA_ptiM8HWcvcu1+3DULec2uoYpLuLorNnPvDzvmhb+oXw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 14/27] target/nios2: Convert to
 CPUClass::tlb_fill
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 May 2019 at 07:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Remove the leftover debugging cpu_dump_state.
>
> Cc: Chris Wulff <crwulff@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Keep user-only and system tlb_fill separate.
> ---

> -int nios2_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
> -                               int rw, int mmu_idx)
> +bool nios2_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                        MMUAccessType access_type, int mmu_idx,
> +                        bool probe, uintptr_t retaddr)
>  {
>      cs->exception_index = 0xaa;
>      /* Page 0x1000 is kuser helper */
>      if (address < 0x1000 || address >= 0x2000) {
>          cpu_dump_state(cs, stderr, 0);
>      }
> -    return 1;
> +    cpu_loop_exit_restore(cs, retaddr);
>  }

Commit message says we delete cpu_dump_state() call but
the code doesn't seem to change it?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


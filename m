Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63E2C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4EC2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KRakDecw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4EC2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45783 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLRWD-0008Tz-A0
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 08:05:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLROj-0002f6-IK
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLROi-0005Gz-If
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:58:09 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLROi-0005Et-C4
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:58:08 -0400
Received: by mail-ot1-x343.google.com with SMTP id t20so11629075otl.5
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 04:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=tk8COTEyjthIF0Jp1cfA+pEDRboxt604+/zaiAyN2ak=;
	b=KRakDecwcBqQ2OkY2KEXO4PdfIihuAJP3bHyFjrr2bESmhkyM1sZ5a3qYlbjS+eKFY
	JbxiXOTdtm69fVkQFpVgtqqqXrDdFhFbkr3Gg15BQlGJIEYILvT7l7+x5UpQRkCnW08D
	OxrbNYalZVg0CL48GfkHkceAOuR4Wzq1A7aDZsbtOF8qIBLH0pTUWg1z6l4iRmkLYkhW
	yZt8fBaidtbDk673NTaiVxZdDVNYo+QwefdSJcHMwWWeSbbgVTb02FvnSa/1CmRt1oFY
	/hPHFxLTzZfp/uel3cJz5KmP++qoTPo3eayBxX2xvPP+/7zAXxRop8I0phwRMXQ5YG2W
	gDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=tk8COTEyjthIF0Jp1cfA+pEDRboxt604+/zaiAyN2ak=;
	b=XjVJ7ki3BDopOI1dkz8JeiacT/MI2WH409CZ9RchrWmmSRT9f12eOrssAqZAiKSJJ7
	oIyOJeksp8qVX7qxji0bCghsIJfY5zw6XXs3pjpZXDe6osi7lRhM+ae1iY82rei2X6UC
	UIi9bLp7cMktbf6VTqERQlCT33GerL05HCEqvOIse2x5ffonI9bKpW8QY9rcTdVvZcJJ
	vj/OVGymTMiocaPrJa2xUpUCbRM55L15//u9WHl7YGz+iqa8dCqo5joIZUZmJc2y0Ngj
	wCDuB+STquE+ApCojeZbY+xtsEWf4Gy2g5DKfpRKsg13R+mFSJD3ns2sk75WPW76s9dm
	JPyA==
X-Gm-Message-State: APjAAAUvu/47Uq0n9V9yQuYw3anKyb/NEL6ta7BwHOgHGNLxsxmcfvTQ
	hU0ku6mmHEn2Gi9YzaDMlL8qbjz6vlZ/ObIGtyV9Ww==
X-Google-Smtp-Source: APXvYqzaBT2MVCZArf8k4THSgl6eKioQcmL30D2EoK47ms45EHbBLYigl4yiyerJfB3yHHjlnT3EzzY6AnHvPXv2Aa4=
X-Received: by 2002:a9d:404:: with SMTP id 4mr39916317otc.352.1556625487129;
	Tue, 30 Apr 2019 04:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-6-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 12:57:56 +0100
Message-ID:
 <CAFEAcA-LJfcTp2BNtug3XM39jTUQSEu3wNrgYmJih6cvPubShg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 05/26] target/cris: Convert to
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430115756.Bed9SQqsw6u4hFpA_L3rE61B8d4nQwf0dsJwVxK4kb8@z>

On Wed, 3 Apr 2019 at 04:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/cris/cpu.h       |  5 +--
>  target/cris/cpu.c       |  5 ++-
>  target/cris/helper.c    | 67 +++++++++++++++++++++++------------------
>  target/cris/op_helper.c | 28 -----------------
>  4 files changed, 42 insertions(+), 63 deletions(-)

> -int cris_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
> -                              int mmu_idx)
> +bool cris_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                       MMUAccessType access_type, int mmu_idx,
> +                       bool probe, uintptr_t retaddr)
>  {
>      CRISCPU *cpu = CRIS_CPU(cs);
>
>      cs->exception_index = 0xaa;
>      cpu->env.pregs[PR_EDA] = address;
> -    cpu_dump_state(cs, stderr, fprintf, 0);
> -    return 1;
> +    cpu_loop_exit_restore(cs, retaddr);

You might mention in the commit message that we removed the
cpu_dump_state().

> +    env->pregs[PR_EDA] = address;
> +    cs->exception_index = EXCP_BUSFAULT;
> +    env->fault_vector = res.bf_vec;
> +    if (retaddr) {
> +        if (cpu_restore_state(cs, retaddr, true)) {
> +            /* Evaluate flags after retranslation. */
> +            helper_top_evaluate_flags(env);

Side note because the old code does the same thing, but it seems
weird that we have to manually recalculate the flags here -- I
would expect cpu_restore_state() to actually restore the state
(presumably by having restore_state_to_opc() do the fixing up
of the flags?).

> +        }
> +    }
> +    cpu_loop_exit(cs);
> +}

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


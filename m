Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91653C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5737C20656
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P0K8S/b9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5737C20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58667 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL7bP-00033x-Jm
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 10:49:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7aW-0002ja-BR
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7aS-0004Jh-8z
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:49:00 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL7aM-0004Hk-6r
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:48:50 -0400
Received: by mail-ot1-x343.google.com with SMTP id w6so8835536otl.7
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=jBtyBLXh6GhrpeiZUU0XgozDWAmGIKvfIjS2FnOV9Zo=;
	b=P0K8S/b99lkLp+D1iYWGTwUYClP0g52M64U9lP/nxY8EirS6u3PPtcS087I4VWxTCU
	am82+9U45uItThCfbCYFNFr6fgjTo1LzeepzLMeF/e1B09dsYZcbSDID0pqFLYlVWmOV
	GOGZH34Z2iRPOOISBNwlOTnJ0tx6gZHNeX5f1ejDOPLAfw5oYgAnM6474Y30T7B67AsY
	E4+cxS2zeCTlicmWHfSFRz6DshpBbCenKAVKYikehlLc8U7z6Eg5WZfD6SQQM9URxWb2
	62XYqC+yB/AQKExeAVO48YijmH3gvKV2KxnR11WXRviG0Tf9JE+YDlhDXVhdHMJlAqO6
	uhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=jBtyBLXh6GhrpeiZUU0XgozDWAmGIKvfIjS2FnOV9Zo=;
	b=MFjQHKb5lazIEESyoz6cOJP3rigmGUnVYAuQEpffGPOAU1KypKFnGBOfOuYeIGxch/
	5ZHrUJY8bpQLOPXQRChWPB6VK3pg4yvXKX5CiaGs6wjcpYanx87jm0RgVIW1uqjkq9r3
	OSZ2icMQmFIZ+qcwqua3xrS78q4Pa5k8s1dMEG8uYWwpwRsvyQ2eBIQs1ncA75HlzePN
	rqnkvg+8GZymfY02jqXZUDXBzBGEalSGa8FW3KnKYjm71eDSwNHL/7nE/jx5n+AXqWhb
	9Vh3MyJD0JrO/8G5gh0U6NvcrUn+hQ0HRjUt7IHf2/5CQ+gjH9E5gl9skS5Qz9+EcPvT
	lS0g==
X-Gm-Message-State: APjAAAUmZ+kn2kV9ysRYsFB+biq/00Ekb+7rNpGxyo2Aq2fWfpUHmkOi
	fK32OdkfnYlPsd128WsWBIZTDDLI3iKglNqDYe8d6w==
X-Google-Smtp-Source: APXvYqxPBRFrLLSQUAiosgCmVc3zHmrq9SwMgZxE+fc3xsL09xhjxaW+9DX5U3MzpeJeTFjvY19SH5T+tEJceAUPYQw=
X-Received: by 2002:a9d:57c4:: with SMTP id q4mr4256857oti.151.1556549326443; 
	Mon, 29 Apr 2019 07:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-33-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-33-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:48:35 +0100
Message-ID:
 <CAFEAcA-uRsaN7zPSWO5Ga8UnYHEbF5MdEKmnbt07N9nDoOXZ8A@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 32/36] cpu: Move icount_decr to
 CPUNegativeOffsetState
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
Message-ID: <20190429144835.VB5k7lu3FttrzR8nEcOrgQon_z3J9V_zNowm1mmJUNY@z>

On Thu, 28 Mar 2019 at 23:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Amusingly, we had already ignored the comment to keep this value at the
> end of CPUState.  This restores the minimum negative offset from TCG_AREG0
> for code generation.
>
> For the couple of uses within qom/cpu.c, add a pointer from the CPUState
> object to the IcountDecr object within CPUNegativeOffsetState.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 45ef41ebb2..032a62672e 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -54,7 +54,7 @@ typedef struct SyncClocks {
>  #define MAX_DELAY_PRINT_RATE 2000000000LL
>  #define MAX_NB_PRINTS 100
>
> -static void align_clocks(SyncClocks *sc, const CPUState *cpu)
> +static void align_clocks(SyncClocks *sc, CPUState *cpu)
>  {
>      int64_t cpu_icount;
>
> @@ -62,7 +62,7 @@ static void align_clocks(SyncClocks *sc, const CPUState *cpu)
>          return;
>      }
>
> -    cpu_icount = cpu->icount_extra + cpu->icount_decr.u16.low;
> +    cpu_icount = cpu->icount_extra + cpu_neg(cpu)->icount_decr.u16.low;
>      sc->diff_clk += cpu_icount_to_ns(sc->last_cpu_icount - cpu_icount);
>      sc->last_cpu_icount = cpu_icount;

Why does this require that we remove the 'const' from the cpu
argument to the function ?


> @@ -1404,7 +1405,7 @@ static void process_icount_data(CPUState *cpu)
>          cpu_update_icount(cpu);
>
>          /* Reset the counters */
> -        cpu->icount_decr.u16.low = 0;
> +        cpu_neg(cpu)->icount_decr.u16.low = 0;
>          cpu->icount_extra = 0;
>          cpu->icount_budget = 0;
>


>  int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
> @@ -265,7 +265,7 @@ static void cpu_common_reset(CPUState *cpu)
>      cpu->mem_io_pc = 0;
>      cpu->mem_io_vaddr = 0;
>      cpu->icount_extra = 0;
> -    atomic_set(&cpu->icount_decr.u32, 0);
> +    atomic_set(&cpu->icount_decr_ptr->u32, 0);
>      cpu->can_do_io = 1;
>      cpu->exception_index = -1;
>      cpu->crash_occurred = false;

What determines when we need to access the icount fields
via icount_decr_ptr versus when we can just directly
access icount_decr ?

thanks
-- PMM


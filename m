Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B1AC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D8920675
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJmpVr+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D8920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58649 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOn3x-0004sI-3S
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:42:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOn2i-000453-Bq
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOn2g-0008V1-TY
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:41:16 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:43473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOn2g-0008R2-LP
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:41:14 -0400
Received: by mail-lf1-x141.google.com with SMTP id u27so2159734lfg.10
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 10:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=ro51JLy0np+viiHkEO8nfpRuXeKBegwQ9LGuJkv+aVs=;
	b=pJmpVr+ZQyAL6b1kJeirDgLhYA8xFN9wuNK3bTltT+XY1RPZxr4xH+NNmRVBw5aJ9s
	eFP3mCWAXk2+9C7yurEN/pOSU1gzuRKCv/zUd/k4mSqAyVXHP9wbWumTJXs7pgu4qdxC
	VPpcefSpADNxNwPO9FCfKCtV8g70ltGfAuC9Bb0TplWS9Pgtk/ffjPtx0i84tm1N5cjx
	16H8M8H6JTgHAMNcvxioxiH+IXz09SPt/g9fBXaKOuKiBtOOLQZvUts/5qjiA4SKVyYM
	Va0ym14YxKG25da0UimIB1ufyXHmTdEl4+4KtWFl2m+ANdSv7Mh/bCrNCWp5mNlPyuMB
	Ihsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=ro51JLy0np+viiHkEO8nfpRuXeKBegwQ9LGuJkv+aVs=;
	b=K02hfzC2JJlpYfAjj2qSBzU6yJ9iG3rrj1woYkIx5FpF160RkC9oW7D2k5BR0OHGRN
	ryJZdub2aiuEsEHY8cIQUBqzIed+NyqC9zqozECd5Olkt9RmuvXosY19zlTGP1XGTbay
	UovLp+UrJLNQ9m1CwAcPIv7bCqCDUARlrj1ME4j5mlbp9UkINa934LQ0eb/ggbborETE
	jWkNviul3cq1PF3SDPuXbRsL9ZuBurQaIOO+tZ/5xvD++LhEM/gG69aPN3b9VjioqcnV
	B3gJlthU32w9zj/UhMSSjksfzEwVzl8Y2A1rWMdFly7eg15ngLs1GMu7foqqVah+Z+ZL
	JZYw==
X-Gm-Message-State: APjAAAWS/F7CZ1jdc/MOUFTXG/t9dOhV4zzn83NO9LVlwpPVCfyDbVgF
	uxv6GwoHLms3LsY6IM1ltPM1QcO6izr7sVbP2WI=
X-Google-Smtp-Source: APXvYqyBG6/J3QhnKVVmiAQMIcNvXw9j8BZUy18xT9A8BC8yZD9gzi3PZR9ovOa5BHyKcFDnQBYgbYg13flnGxJXHzY=
X-Received: by 2002:a19:4a04:: with SMTP id x4mr3157344lfa.124.1557423667705; 
	Thu, 09 May 2019 10:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190509060246.4031-1-richard.henderson@linaro.org>
	<20190509060246.4031-2-richard.henderson@linaro.org>
In-Reply-To: <20190509060246.4031-2-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 10:39:00 -0700
Message-ID: <CAKmqyKPPAHaD48pMxrdGgCUEhgz4g5=5MVVScg4v=GL7eX+_fg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH v2 01/27] tcg: Add CPUClass::tlb_fill
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 8, 2019 at 11:03 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This hook will replace the (user-only mode specific) handle_mmu_fault
> hook, and the (system mode specific) tlb_fill function.
>
> The handle_mmu_fault hook was written as if there was a valid
> way to recover from an mmu fault, and had 3 possible return states.
> In reality, the only valid action is to raise an exception,
> return to the main loop, and deliver the SIGSEGV to the guest.
>
> Note that all of the current implementations of handle_mmu_fault
> for guests which support linux-user do in fact only ever return 1,
> which is the signal to return to the main loop.
>
> Using the hook for system mode requires that all targets be converted,
> so for now the hook is (optionally) used only from user-only mode.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/qom/cpu.h     |  9 +++++++++
>  accel/tcg/user-exec.c | 39 ++++++++++++++-------------------------
>  2 files changed, 23 insertions(+), 25 deletions(-)
>
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 08abcbd3fe..c1f267b4e0 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -118,6 +118,12 @@ struct TranslationBlock;
>   *       will need to do more. If this hook is not implemented then the
>   *       default is to call @set_pc(tb->pc).
>   * @handle_mmu_fault: Callback for handling an MMU fault.
> + * @tlb_fill: Callback for handling a softmmu tlb miss or user-only
> + *       address fault.  For system mode, if the access is valid, call
> + *       tlb_set_page and return true; if the access is invalid, and
> + *       probe is true, return false; otherwise raise an exception and
> + *       do not return.  For user-only mode, always raise an exception
> + *       and do not return.
>   * @get_phys_page_debug: Callback for obtaining a physical address.
>   * @get_phys_page_attrs_debug: Callback for obtaining a physical address=
 and the
>   *       associated memory transaction attributes to use for the access.
> @@ -191,6 +197,9 @@ typedef struct CPUClass {
>      void (*synchronize_from_tb)(CPUState *cpu, struct TranslationBlock *=
tb);
>      int (*handle_mmu_fault)(CPUState *cpu, vaddr address, int size, int =
rw,
>                              int mmu_index);
> +    bool (*tlb_fill)(CPUState *cpu, vaddr address, int size,
> +                     MMUAccessType access_type, int mmu_idx,
> +                     bool probe, uintptr_t retaddr);
>      hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);
>      hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
>                                          MemTxAttrs *attrs);
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 0789984fe6..199f88c826 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -65,6 +65,7 @@ static inline int handle_cpu_signal(uintptr_t pc, sigin=
fo_t *info,
>      CPUClass *cc;
>      int ret;
>      unsigned long address =3D (unsigned long)info->si_addr;
> +    MMUAccessType access_type;
>
>      /* We must handle PC addresses from two different sources:
>       * a call return address and a signal frame address.
> @@ -147,35 +148,23 @@ static inline int handle_cpu_signal(uintptr_t pc, s=
iginfo_t *info,
>         are still valid segv ones */
>      address =3D h2g_nocheck(address);
>
> -    cc =3D CPU_GET_CLASS(cpu);
> -    /* see if it is an MMU fault */
> -    g_assert(cc->handle_mmu_fault);
> -    ret =3D cc->handle_mmu_fault(cpu, address, 0, is_write, MMU_USER_IDX=
);
> -
> -    if (ret =3D=3D 0) {
> -        /* The MMU fault was handled without causing real CPU fault.
> -         *  Retain helper_retaddr for a possible second fault.
> -         */
> -        return 1;
> -    }
> -
> -    /* All other paths lead to cpu_exit; clear helper_retaddr
> -     * for next execution.
> +    /*
> +     * There is no way the target can handle this other than raising
> +     * an exception.  Undo signal and retaddr state prior to longjmp.
>       */
> +    sigprocmask(SIG_SETMASK, old_set, NULL);
>      helper_retaddr =3D 0;
>
> -    if (ret < 0) {
> -        return 0; /* not an MMU fault */
> +    cc =3D CPU_GET_CLASS(cpu);
> +    if (cc->tlb_fill) {
> +        access_type =3D is_write ? MMU_DATA_STORE : MMU_DATA_LOAD;
> +        cc->tlb_fill(cpu, address, 0, access_type, MMU_USER_IDX, false, =
pc);
> +        g_assert_not_reached();
> +    } else {
> +        ret =3D cc->handle_mmu_fault(cpu, address, 0, is_write, MMU_USER=
_IDX);
> +        g_assert(ret > 0);
> +        cpu_loop_exit_restore(cpu, pc);
>      }
> -
> -    /* Now we have a real cpu fault.  */
> -    cpu_restore_state(cpu, pc, true);
> -
> -    sigprocmask(SIG_SETMASK, old_set, NULL);
> -    cpu_loop_exit(cpu);
> -
> -    /* never comes here */
> -    return 1;
>  }
>
>  #if defined(__i386__)
> --
> 2.17.1
>
>


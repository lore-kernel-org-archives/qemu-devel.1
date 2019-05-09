Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D843AC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E9E21479
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mh3xDUQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E9E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54710 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOjEJ-0001Ud-Nb
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 09:36:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOjCc-0000MH-VY
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:35:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOjCb-0008Rf-MP
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:35:14 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hOjCb-0008R8-Dk
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:35:13 -0400
Received: by mail-ot1-x343.google.com with SMTP id i8so2257372oth.10
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 06:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=fo7hbPyZIIstVs2SEBBFQ2JxtjYBVAlfcShN7okdhYU=;
	b=Mh3xDUQY3uqihe9aSDVBXXgMjdFYhSsj7yG8WgEU6KUY08gj63Abj74m0nZ5hQRkPZ
	1wBKsaXxU/E9RlE1kkx5SJJx6SbujFZDJGvg5z+r7rzHpdyjBJw7kM07/F/HUoGfB/22
	fEkC8Vy16rTlmvEzKZY9Hg2Zc+/xkfJwXWXhIBB42Jh4RK42W7D8sFWv3OGURKWKbc54
	KAS/hiFu2cg03BMdaTJ2y8KXpXRIiPVamewbWkWHfhibpvCbvrYgpIYiqDdqDM544agV
	q+A2GqetsDthPzGBw22a1N6V43Lpx6KzF2KxcN9fYOSmgaFtMH/xkcT/TiaC819T0/kp
	ybhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=fo7hbPyZIIstVs2SEBBFQ2JxtjYBVAlfcShN7okdhYU=;
	b=Z5EAQJ7vIyfg7n0CKCsQvk7ShbvDFb6RX6yDgCpbn1xlJL3TZqYPceJQjxk5l4eVry
	aUqQwAuM2uoqGISQbZhfBn3ljSW2+DsbLNBm023S/sUzCh6sTIMvLgQZBnJEw+pzCvtE
	KRpOIuS0+qaymh3r1OMiRxZHMzWyJR8QIgazh4lbQmSLJPYHORetlG65qx7yS5GC0dWx
	DvdUEq18M2v4whmN6HPd1WIsGZNjAbuYOMpMhC72bYxBl+Ze7aNWBVHhNoQ8xmfut7vf
	6HUdj+azLMnuzMD0/MuV8EotbifS/4/CLZGQn1t58op3H2AmzRLXdmEn+WnucpzgXDOE
	ieKA==
X-Gm-Message-State: APjAAAXuY5cIkzcFgHoQXldBStzm8CBasYVXebpcnAUqZzACkZ1JE2af
	aHw1pwwsEy1C3/8fE/4R/TfeduLGiHji+7ZGJZXAKQ==
X-Google-Smtp-Source: APXvYqxtV2nMVIpNc+UCZx9TNEH4hsBFToHWwUXVMexfDWIP6CsI7aJ45RSck/twvdA/PVFoIwwPx9dTKcovSktkrRk=
X-Received: by 2002:a9d:6156:: with SMTP id c22mr2442199otk.363.1557408912296; 
	Thu, 09 May 2019 06:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190509060246.4031-1-richard.henderson@linaro.org>
	<20190509060246.4031-21-richard.henderson@linaro.org>
In-Reply-To: <20190509060246.4031-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 May 2019 14:35:01 +0100
Message-ID: <CAFEAcA_2SbYfaOf4_p1r5O2iCLmoBWixWpgBnAcZYaWixr2KKQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v2 20/27] target/sparc: Convert to
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 May 2019 at 07:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Keep user-only, sparc32, and sparc64 tlb_fill separate.
> ---
>  target/sparc/cpu.h         |  5 ++-
>  target/sparc/cpu.c         |  5 +--
>  target/sparc/ldst_helper.c | 11 +-----
>  target/sparc/mmu_helper.c  | 78 ++++++++++++++++++++++----------------
>  4 files changed, 51 insertions(+), 48 deletions(-)

>  /* Perform address translation */
> -int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
> -                               int mmu_idx)
> +bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                        MMUAccessType access_type, int mmu_idx,
> +                        bool probe, uintptr_t retaddr)
>  {
>      SPARCCPU *cpu = SPARC_CPU(cs);
>      CPUSPARCState *env = &cpu->env;
> @@ -220,22 +222,18 @@ int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
>
>      address &= TARGET_PAGE_MASK;
>      error_code = get_physical_address(env, &paddr, &prot, &access_index,
> -                                      address, rw, mmu_idx, &page_size);
> +                                      address, access_type,
> +                                      mmu_idx, &page_size);
>      vaddr = address;
> -    if (error_code == 0) {
> +    if (likely(error_code == 0)) {
>          qemu_log_mask(CPU_LOG_MMU,
> -                "Translate at %" VADDR_PRIx " -> " TARGET_FMT_plx ", vaddr "
> -                TARGET_FMT_lx "\n", address, paddr, vaddr);
> +                      "Translate at %" VADDR_PRIx " -> "
> +                      TARGET_FMT_plx ", vaddr " TARGET_FMT_lx "\n",
> +                      address, paddr, vaddr);
>          tlb_set_page(cs, vaddr, paddr, prot, mmu_idx, page_size);
> -        return 0;
> +        return true;
>      }
>
> -    if (env->mmuregs[3]) { /* Fault status register */
> -        env->mmuregs[3] = 1; /* overflow (not read before another fault) */
> -    }
> -    env->mmuregs[3] |= (access_index << 5) | error_code | 2;
> -    env->mmuregs[4] = address; /* Fault address register */
> -

In the old code, we set these MMU registers before checking
for the MMU_NF case...

>      if ((env->mmuregs[0] & MMU_NF) || env->psret == 0)  {
>          /* No fault mode: if a mapping is available, just override
>             permissions. If no mapping is available, redirect accesses to
> @@ -243,15 +241,25 @@ int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
>             switching to normal mode. */
>          prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>          tlb_set_page(cs, vaddr, paddr, prot, mmu_idx, TARGET_PAGE_SIZE);
> -        return 0;
> -    } else {
> -        if (rw & 2) {
> -            cs->exception_index = TT_TFAULT;
> -        } else {
> -            cs->exception_index = TT_DFAULT;
> -        }
> -        return 1;
> +        return true;
>      }
> +
> +    if (probe) {
> +        return false;
> +    }
> +
> +    if (env->mmuregs[3]) { /* Fault status register */
> +        env->mmuregs[3] = 1; /* overflow (not read before another fault) */
> +    }
> +    env->mmuregs[3] |= (access_index << 5) | error_code | 2;
> +    env->mmuregs[4] = address; /* Fault address register */
> +
> +    if (access_type == MMU_INST_FETCH) {
> +        cs->exception_index = TT_TFAULT;
> +    } else {
> +        cs->exception_index = TT_DFAULT;
> +    }
> +    cpu_loop_exit_restore(cs, retaddr);
>  }

...but in the new code we only set them if we're really
going to fault.

The v8 SPARC architecture manual appending H says that
when the NF bit is 1 faults detected by the MMU cause
FSR and FAR to be updated even though no fault is generated
to the processor. So I think the change here is not correct.

(The spec also says that ASI 9 is supposed to be special and
not affected by NF==1; and I think that since we put entries in
the TLB for the NF case we won't correctly set the fault address
register if the CPU makes two successive accesses to the same
page, because the second access won't take the slow path and
won't update the FAR. But those are pre-existing bugs.)

thanks
-- PMM


Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A665DC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7861C205C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7861C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59914 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOFgr-0004Lm-Rn
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 02:04:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOFfj-0003jC-Rn
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOFfi-0004zW-Nh
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:03:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOFfi-0004zK-HC
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:03:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id 198so1574665wme.3
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 23:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=tu/9fx57pCAN0/5aWQ8Fn1A3wr56U2TEQAw/xbWOIqI=;
	b=aMipJ2ic24sSLCTXXfF3pbuzgfykHBqyS9YXa54r/BGUqu/VzV+Ct+/PhZNIm+cYE+
	XlzHeIVlqzKda6yITzSpo5EohWogK62B4pk5OS087OpRILTmELBowdmUJY8fZq+ifWu1
	I/HhsmloXwPSz+2rKWuk5NtB7/Iy+RIFJIBrPSswf0h6GZcBSOKOyTUQRdiZHteTA6cm
	IDkLuzng4xdaGzc1809wb6NaObgpD3E0WWgvO1qrcpLDZw03GBgUwadCGnyzC4oSib9u
	8qm09u9u4XTdq2pHWfZsp/lva7G9WJCLPLy+YVYE+i3x2vI7HPyjdP49TZzGPdFTNTHe
	ZQAw==
X-Gm-Message-State: APjAAAUdd36I13lDs1LsWoBzuW5XzmHu5VzcZzbAh9LCFbr31+TB4EaP
	wPYgCwDjfB2nByVbn9PuoAYnF5RlXiI=
X-Google-Smtp-Source: APXvYqzCMjPHygi/NyvpvLqgUaAlxU+w+dqcoCRxBglQ3dS4xRqJzXP1bcg4yEV78pT0BnHliMn2IQ==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr1516416wmc.108.1557295397337; 
	Tue, 07 May 2019 23:03:17 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	q2sm19810563wrd.48.2019.05.07.23.03.16
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 23:03:16 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-26-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e4b3bc9c-d5aa-32e8-b99e-119ed0086571@redhat.com>
Date: Wed, 8 May 2019 08:03:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403034358.21999-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH 25/26] tcg: Remove
 CPUClass::handle_mmu_fault
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/19 5:43 AM, Richard Henderson wrote:
> This hook is now completely replaced by tlb_fill.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/qom/cpu.h     |  3 ---
>  accel/tcg/user-exec.c | 13 +++----------
>  2 files changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 7e96a0aed3..8afcf0c427 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -118,7 +118,6 @@ struct TranslationBlock;
>   *       This always includes at least the program counter; some targets
>   *       will need to do more. If this hook is not implemented then the
>   *       default is to call @set_pc(tb->pc).
> - * @handle_mmu_fault: Callback for handling an MMU fault.
>   * @tlb_fill: Callback for handling a softmmu tlb miss or user-only
>   *       address fault.  For system mode, if the access is valid, call
>   *       tlb_set_page and return true; if the access is invalid, and
> @@ -198,8 +197,6 @@ typedef struct CPUClass {
>                                 Error **errp);
>      void (*set_pc)(CPUState *cpu, vaddr value);
>      void (*synchronize_from_tb)(CPUState *cpu, struct TranslationBlock *tb);
> -    int (*handle_mmu_fault)(CPUState *cpu, vaddr address, int size, int rw,
> -                            int mmu_index);
>      bool (*tlb_fill)(CPUState *cpu, vaddr address, int size,
>                       MMUAccessType access_type, int mmu_idx,
>                       bool probe, uintptr_t retaddr);
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index f13c0b2b67..d79bed0266 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -63,7 +63,6 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
>  {
>      CPUState *cpu = current_cpu;
>      CPUClass *cc;
> -    int ret;
>      unsigned long address = (unsigned long)info->si_addr;
>      MMUAccessType access_type;
>  
> @@ -162,15 +161,9 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
>      helper_retaddr = 0;
>  
>      cc = CPU_GET_CLASS(cpu);
> -    if (cc->tlb_fill) {
> -        access_type = is_write ? MMU_DATA_STORE : MMU_DATA_LOAD;
> -        cc->tlb_fill(cpu, address, 0, access_type, MMU_USER_IDX, false, pc);
> -        g_assert_not_reached();
> -    } else {
> -        ret = cc->handle_mmu_fault(cpu, address, 0, is_write, MMU_USER_IDX);
> -        g_assert(ret > 0);
> -        cpu_loop_exit_restore(cpu, pc);
> -    }
> +    access_type = is_write ? MMU_DATA_STORE : MMU_DATA_LOAD;
> +    cc->tlb_fill(cpu, address, 0, access_type, MMU_USER_IDX, false, pc);
> +    g_assert_not_reached();
>  }
>  
>  #if defined(__i386__)
> 


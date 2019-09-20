Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12376C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 18:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB52C2080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 18:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcO8jRsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB52C2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBO0C-0001Np-0X
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 14:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iBNyk-0000GY-3B
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 14:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iBNyi-00051h-Oe
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 14:50:01 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:35809)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iBNyi-00051M-Gy
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 14:50:00 -0400
Received: by mail-lj1-x243.google.com with SMTP id m7so8074515lji.2
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 11:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VbEgoFgtwbLwBLi/Z5fRf6m51jP1tfd7k4yqNpjwsUY=;
 b=JcO8jRsze3uzifnvnfKMIOf0oFHzbXMajhongLr1i7PChRk0F/xv2IvP5yJncLHXUL
 AbHstR8lClLku6btJ/T3dCaHSY3pioFV8OPGsRHvvOfOTA2adQRf++tAKzojMkI+bols
 zxIn7KFgE6XfgsYcquUdxFVHwZqbE74TwUzBwvzdOtA/OQt7s2OJ9YpXLxWRxUYAfkgj
 wqFx1VrSNqGODTyb6dyvUPNX/TGBIPyDXad8b+P2TrNp2HNDo+pJft7DkNfGhcziWF47
 oLfuFASqYQ6IWide4WHekcysJp3/0X9ma7memKZKIgaZB8iuUVkavTJJgaQgV6IfJPu4
 Gvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VbEgoFgtwbLwBLi/Z5fRf6m51jP1tfd7k4yqNpjwsUY=;
 b=R2hKwhmgQ3kW+Z/luxpMYvN9twEkQllS/SMwR8vGMusLIlmQtWxMNk+agjMtqRlv2q
 FIEjo2cPpgS3CRMZ2+zhIgHFaUt7M6BlIiUJGavW9thuS0HMhIKRauaposvcmvc/Vc/R
 lB4x9GK6WAbXuH2PJ9qGdZLVcpuOVSEx3RyijxLGNbmkez8+usj07odQrfd5PvvxtHdq
 nXBuFevSZwusHEBk2fi7UV8bkrY4XYc5h4ZRuiAqSxBhAnHL6Htcj9V/sX67WueEPojR
 4A8uTUoyW0Xm9u1WmdukFWY/F8aplTO4O5dBlPvS52n8NyuwEMr6m60WfvU3NtPeVM8A
 pgiw==
X-Gm-Message-State: APjAAAVxGns3B2JyKk423xAKnrruBr+DkTVkPg53nyzi6qUYXYPfsRgf
 ku+jgwy3ck7Au0vJ22YZNVbImGQS2916xhpxC5U=
X-Google-Smtp-Source: APXvYqwIS1CUnxJ+5ZGCqNSqZqPeqP3Bm5Ng8GyC1AWRJU80Azwn7c1Hsn/0Naq4ujNfWZeH/X0A62aapdZQGDMKKZI=
X-Received: by 2002:a2e:91c7:: with SMTP id u7mr9643752ljg.146.1569005398912; 
 Fri, 20 Sep 2019 11:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190920125008.13604-1-peter.maydell@linaro.org>
In-Reply-To: <20190920125008.13604-1-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 20 Sep 2019 11:45:23 -0700
Message-ID: <CAKmqyKOZdwGe-HM7YxAaTgEGOesaLBQxwMtRRF1=k1qqF-B14Q@mail.gmail.com>
Subject: Re: [PATCH] Remove unassigned_access CPU hook
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 20, 2019 at 5:52 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> All targets have now migrated away from the old unassigned_access
> hook to the new do_transaction_failed hook. This means we can remove
> the core-code infrastructure for that hook and the code that calls it.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Based-on: <cover.1568762497.git.alistair.francis@wdc.com>
> ("[PATCH v1 0/2] RISC-V: Convert to do_transaction_failed hook")
>  -- the last of the conversions isn't in master yet, but I figured
> I might as well put the cleanup patch out for review.
>
>  include/hw/core/cpu.h | 24 ------------------------
>  accel/tcg/cputlb.c    |  1 -
>  memory.c              |  7 -------
>  3 files changed, 32 deletions(-)
>
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index c7cda65c66d..a5a13e26a20 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -71,10 +71,6 @@ typedef enum MMUAccessType {
>
>  typedef struct CPUWatchpoint CPUWatchpoint;
>
> -typedef void (*CPUUnassignedAccess)(CPUState *cpu, hwaddr addr,
> -                                    bool is_write, bool is_exec, int opaque,
> -                                    unsigned size);
> -
>  struct TranslationBlock;
>
>  /**
> @@ -86,8 +82,6 @@ struct TranslationBlock;
>   * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
>   * @has_work: Callback for checking if there is work to do.
>   * @do_interrupt: Callback for interrupt handling.
> - * @do_unassigned_access: Callback for unassigned access handling.
> - * (this is deprecated: new targets should use do_transaction_failed instead)
>   * @do_unaligned_access: Callback for unaligned access handling, if
>   * the target defines #TARGET_ALIGNED_ONLY.
>   * @do_transaction_failed: Callback for handling failed memory transactions
> @@ -174,7 +168,6 @@ typedef struct CPUClass {
>      int reset_dump_flags;
>      bool (*has_work)(CPUState *cpu);
>      void (*do_interrupt)(CPUState *cpu);
> -    CPUUnassignedAccess do_unassigned_access;
>      void (*do_unaligned_access)(CPUState *cpu, vaddr addr,
>                                  MMUAccessType access_type,
>                                  int mmu_idx, uintptr_t retaddr);
> @@ -414,12 +407,6 @@ struct CPUState {
>       */
>      uintptr_t mem_io_pc;
>      vaddr mem_io_vaddr;
> -    /*
> -     * This is only needed for the legacy cpu_unassigned_access() hook;
> -     * when all targets using it have been converted to use
> -     * cpu_transaction_failed() instead it can be removed.
> -     */
> -    MMUAccessType mem_io_access_type;
>
>      int kvm_fd;
>      struct KVMState *kvm_state;
> @@ -879,17 +866,6 @@ void cpu_interrupt(CPUState *cpu, int mask);
>  #ifdef NEED_CPU_H
>
>  #ifdef CONFIG_SOFTMMU
> -static inline void cpu_unassigned_access(CPUState *cpu, hwaddr addr,
> -                                         bool is_write, bool is_exec,
> -                                         int opaque, unsigned size)
> -{
> -    CPUClass *cc = CPU_GET_CLASS(cpu);
> -
> -    if (cc->do_unassigned_access) {
> -        cc->do_unassigned_access(cpu, addr, is_write, is_exec, opaque, size);
> -    }
> -}
> -
>  static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
>                                          MMUAccessType access_type,
>                                          int mmu_idx, uintptr_t retaddr)
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index abae79650c0..9c21b320eb4 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -914,7 +914,6 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>      }
>
>      cpu->mem_io_vaddr = addr;
> -    cpu->mem_io_access_type = access_type;
>
>      if (mr->global_locking && !qemu_mutex_iothread_locked()) {
>          qemu_mutex_lock_iothread();
> diff --git a/memory.c b/memory.c
> index b9dd6b94cac..93a05395cff 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1278,10 +1278,6 @@ static uint64_t unassigned_mem_read(void *opaque, hwaddr addr,
>  #ifdef DEBUG_UNASSIGNED
>      printf("Unassigned mem read " TARGET_FMT_plx "\n", addr);
>  #endif
> -    if (current_cpu != NULL) {
> -        bool is_exec = current_cpu->mem_io_access_type == MMU_INST_FETCH;
> -        cpu_unassigned_access(current_cpu, addr, false, is_exec, 0, size);
> -    }
>      return 0;
>  }
>
> @@ -1291,9 +1287,6 @@ static void unassigned_mem_write(void *opaque, hwaddr addr,
>  #ifdef DEBUG_UNASSIGNED
>      printf("Unassigned mem write " TARGET_FMT_plx " = 0x%"PRIx64"\n", addr, val);
>  #endif
> -    if (current_cpu != NULL) {
> -        cpu_unassigned_access(current_cpu, addr, true, false, 0, size);
> -    }
>  }
>
>  static bool unassigned_mem_accepts(void *opaque, hwaddr addr,
> --
> 2.20.1
>
>


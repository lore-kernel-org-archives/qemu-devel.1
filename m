Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4796C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C4E5206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqwrSZTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4E5206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBJ8Q-0007oP-4X
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 09:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBJ5M-0004uP-7r
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBJ5K-0005vP-Mh
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:36:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25202
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBJ5K-0005vJ-J2
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1568986589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=9R4CS7A6+lTn6fF47JZVqUOyVjkGDedsnNZ1LBIczaA=;
 b=HqwrSZTCo9aICMuM49o2fE4jTB6ZUFBrwMhAjroQYzD5TARE6T0Y+3/gZQPVESVN4bq72x
 Q0kEHnnGNw1QZ+C9nuJ5VTksGSZQRr0XUyuyWvcBwrscHWY+exCQg4gwUrhBiI2skGBpuu
 lwHiHPBVP9xzBIJ2qkAnFMiaFG+t6DQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-rueDJuwNMi-2EceK4z_8Iw-1; Fri, 20 Sep 2019 09:36:27 -0400
Received: by mail-wm1-f71.google.com with SMTP id m6so1013107wmf.2
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 06:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ygWuSyf7YVokPKCfnGj2dm6FUv1ZPyW4PWNvxMidmBQ=;
 b=KmovCZLQZyYQojXyWcw6XLB7ySWPQ+OsMDR7DPPYgHOAJtjmjuJWw07XJi7BTn5g+5
 NvDwHLiTHEUa6YjDEkgOh6orLc6qRk9oQ3aZT9LhAiQmKZS2yi2GKDckeRxw30TKlNFi
 f/da673by7FAQ90zYvjY/wsQVo0040/qW/vkOsvJo/P/qm5GR6kZRwGN28Mic8NzU/Sb
 5JGT4CKZGRns4M4tVah6ZVX3eFyI0w6NWvzNo5dYn9wNePKkDGctfY875P97/h1I0PWJ
 FFLx1ADOC+vKm/H4hV59QxXt8Zw8r/iwONIxokk5H8MfeTO2fYqzj3jDZoOQTkZxE1sx
 jZaw==
X-Gm-Message-State: APjAAAUBAiFbdE2eb1D7wG+g2mFnt528kE1Z+9EqtjsdyvhxqvqIgHUo
 Q7z91/0CCC4pJrsEwJ1sis975/JadQNWUahY6Cwgf3xgVYPyzrv9oiePbLPNikKurSVueqY1Jn8
 8wAs/Vi2i0kqTQ7s=
X-Received: by 2002:adf:f343:: with SMTP id e3mr3278454wrp.268.1568986585305; 
 Fri, 20 Sep 2019 06:36:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwmEac1TNzHoYPFHjKMKfnwUVLyYIkDEOyYl42YJixDBbrTiLgdfK5u5b5DRK85jbmn1a/OeQ==
X-Received: by 2002:adf:f343:: with SMTP id e3mr3278438wrp.268.1568986585090; 
 Fri, 20 Sep 2019 06:36:25 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id y186sm4321286wmd.26.2019.09.20.06.36.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2019 06:36:24 -0700 (PDT)
Subject: Re: [PATCH] Remove unassigned_access CPU hook
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190920125008.13604-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c441b9fb-744e-428e-9b20-c1c21cc7b6a5@redhat.com>
Date: Fri, 20 Sep 2019 15:36:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190920125008.13604-1-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: rueDJuwNMi-2EceK4z_8Iw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 9/20/19 2:50 PM, Peter Maydell wrote:
> All targets have now migrated away from the old unassigned_access
> hook to the new do_transaction_failed hook. This means we can remove
> the core-code infrastructure for that hook and the code that calls it.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Based-on: <cover.1568762497.git.alistair.francis@wdc.com>
> ("[PATCH v1 0/2] RISC-V: Convert to do_transaction_failed hook")
>  -- the last of the conversions isn't in master yet, but I figured
> I might as well put the cleanup patch out for review.

Hopefully this hook is neither implemented by the RX/AVR targets posted
on the list recently.

>  include/hw/core/cpu.h | 24 ------------------------
>  accel/tcg/cputlb.c    |  1 -
>  memory.c              |  7 -------
>  3 files changed, 32 deletions(-)
>=20
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index c7cda65c66d..a5a13e26a20 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -71,10 +71,6 @@ typedef enum MMUAccessType {
> =20
>  typedef struct CPUWatchpoint CPUWatchpoint;
> =20
> -typedef void (*CPUUnassignedAccess)(CPUState *cpu, hwaddr addr,
> -                                    bool is_write, bool is_exec, int opa=
que,
> -                                    unsigned size);
> -
>  struct TranslationBlock;
> =20
>  /**
> @@ -86,8 +82,6 @@ struct TranslationBlock;
>   * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
>   * @has_work: Callback for checking if there is work to do.
>   * @do_interrupt: Callback for interrupt handling.
> - * @do_unassigned_access: Callback for unassigned access handling.
> - * (this is deprecated: new targets should use do_transaction_failed ins=
tead)
>   * @do_unaligned_access: Callback for unaligned access handling, if
>   * the target defines #TARGET_ALIGNED_ONLY.
>   * @do_transaction_failed: Callback for handling failed memory transacti=
ons
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
> =20
>      int kvm_fd;
>      struct KVMState *kvm_state;
> @@ -879,17 +866,6 @@ void cpu_interrupt(CPUState *cpu, int mask);
>  #ifdef NEED_CPU_H
> =20
>  #ifdef CONFIG_SOFTMMU
> -static inline void cpu_unassigned_access(CPUState *cpu, hwaddr addr,
> -                                         bool is_write, bool is_exec,
> -                                         int opaque, unsigned size)
> -{
> -    CPUClass *cc =3D CPU_GET_CLASS(cpu);
> -
> -    if (cc->do_unassigned_access) {
> -        cc->do_unassigned_access(cpu, addr, is_write, is_exec, opaque, s=
ize);
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
> @@ -914,7 +914,6 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBE=
ntry *iotlbentry,
>      }
> =20
>      cpu->mem_io_vaddr =3D addr;
> -    cpu->mem_io_access_type =3D access_type;
> =20
>      if (mr->global_locking && !qemu_mutex_iothread_locked()) {
>          qemu_mutex_lock_iothread();
> diff --git a/memory.c b/memory.c
> index b9dd6b94cac..93a05395cff 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1278,10 +1278,6 @@ static uint64_t unassigned_mem_read(void *opaque, =
hwaddr addr,
>  #ifdef DEBUG_UNASSIGNED
>      printf("Unassigned mem read " TARGET_FMT_plx "\n", addr);
>  #endif
> -    if (current_cpu !=3D NULL) {
> -        bool is_exec =3D current_cpu->mem_io_access_type =3D=3D MMU_INST=
_FETCH;
> -        cpu_unassigned_access(current_cpu, addr, false, is_exec, 0, size=
);
> -    }
>      return 0;
>  }
> =20
> @@ -1291,9 +1287,6 @@ static void unassigned_mem_write(void *opaque, hwad=
dr addr,
>  #ifdef DEBUG_UNASSIGNED
>      printf("Unassigned mem write " TARGET_FMT_plx " =3D 0x%"PRIx64"\n", =
addr, val);
>  #endif
> -    if (current_cpu !=3D NULL) {
> -        cpu_unassigned_access(current_cpu, addr, true, false, 0, size);
> -    }
>  }

Having unassigned_mem_read/unassigned_mem_write with
CPUReadMemoryFunc/CPUWriteMemoryFunc prototype only used for logging is
rather confusing. We can kill them and use trace events instead in
memory_region_dispatch_read/write. I'll send a follow-up cleanup patch.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> =20
>  static bool unassigned_mem_accepts(void *opaque, hwaddr addr,
>=20



Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA0CC28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 16:09:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2025E2192A
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 16:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJv7bFlA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2025E2192A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXS2W-0001Nz-7y
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 12:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXS1U-0008QJ-E1; Sat, 09 May 2020 12:08:20 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46634)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXS1T-0006sj-Io; Sat, 09 May 2020 12:08:20 -0400
Received: by mail-wr1-x442.google.com with SMTP id w7so5478114wre.13;
 Sat, 09 May 2020 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KKufh5BT6a1UYTGLsqZj6CC3M1OVbx8BNKL5Xs7X+qc=;
 b=YJv7bFlARZfY+zeDPXp4vT1yQrfZ9jBFJ+oQvJAHmVeafJQt0k2qakBRUYRUHdqfci
 GdgI3cpAfIYOm97zQJiMFIMFWE9wk9ChRM2oq5kW7Jr9cUuRyTO8NYumFLg8Lz5Wms+j
 yTaz2Ui/y/8F1PFglv90J1pqxBud/dp2B1WgljZ4SUevn17dXUj43wBLuGBuEplbUgBg
 frRewC6i3lBIo7jbLUZUpZW9XHvKNcXbjijhJ7iUlS+O47BA2ihLknQsCu+U58tPUdKf
 YvxMJtnMUyW04d3c0xbX9G9epOjN7BgKFlOhbJEf/6VMu5Jc4XQW2TQXobuC+oItcU0m
 7edA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KKufh5BT6a1UYTGLsqZj6CC3M1OVbx8BNKL5Xs7X+qc=;
 b=WHm3QsgYU+685iDWDGexe09HH4Pdsihk8Nh3dRK52QGdM8mpS+K8s0+yqGo7z7JZZ0
 Wbm5Kxd1cAHKGL4fgVLTNsHjbjoOV9+m+1EQF6Fb+4+tmw3p7RuCWWqlHqeOfO+7M0jX
 FgJXYH30X943Oop7Drl3uXK8ZKgHlHB0rqGGQXhqhzcSG92/zEjwm5cSci4ULlyautM0
 Nt6hkkIkQPLAsTmMI/7DHpAMq3zN4khGMjXjBtJd2G2bzsZxt3Qsq9jsPDFuVpCp7TO7
 HOXfVmalSWMaMbVvpXdYB7g7fSnI9WvWajDJqXtBVgQWLoEvf+1LW+XRtHrKywC66tXv
 PcKA==
X-Gm-Message-State: AGi0PuZgVDtPIsSWmqF8+lhurj3hIR/8pqiuxTzUuC/LrWKm2TD2ncl/
 uGMbbDbFagFuJkQffvqB1PY=
X-Google-Smtp-Source: APiQypJM8xAG79sIeKgcs9BdP6pxuviaphd3M6rHZ398H22ZOU7gakAJvDiC43fvmPm+hTtadVbywg==
X-Received: by 2002:a5d:4e8f:: with SMTP id e15mr8965515wru.91.1589040496463; 
 Sat, 09 May 2020 09:08:16 -0700 (PDT)
Received: from [192.168.1.37] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id z11sm8476488wro.48.2020.05.09.09.08.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 May 2020 09:08:15 -0700 (PDT)
Subject: Re: [PATCH 09/11] target/cpu: Restrict handlers using hwaddr type to
 system-mode
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200509130910.26335-1-f4bug@amsat.org>
 <20200509130910.26335-10-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ba3d3ba1-09bf-17a0-2116-549fa92e1ed6@amsat.org>
Date: Sat, 9 May 2020 18:08:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200509130910.26335-10-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/9/20 3:09 PM, Philippe Mathieu-Daudé wrote:
> Restrict the following handlers to system-mode:
> - do_unaligned_access
> - do_transaction_failed
> - get_phys_page_debug
> - get_phys_page_attrs_debug
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   include/hw/core/cpu.h           |  8 +++++---
>   target/alpha/cpu.h              |  4 +++-
>   target/arm/cpu.h                |  6 +++---
>   target/arm/internals.h          |  4 ++++
>   target/cris/cpu.h               |  2 ++
>   target/hppa/cpu.h               |  2 +-
>   target/i386/cpu.h               |  2 ++
>   target/m68k/cpu.h               |  7 ++++++-
>   target/microblaze/cpu.h         |  5 ++++-
>   target/mips/internal.h          |  2 +-
>   target/nios2/cpu.h              |  5 ++++-
>   target/openrisc/cpu.h           |  3 ++-
>   target/ppc/cpu.h                |  2 +-
>   target/riscv/cpu.h              | 20 ++++++++++----------
>   target/sh4/cpu.h                |  2 +-
>   target/sparc/cpu.h              |  2 ++
>   target/xtensa/cpu.h             | 12 +++++++-----
>   target/hppa/cpu.c               |  4 +++-
>   target/ppc/translate_init.inc.c |  2 +-
>   19 files changed, 62 insertions(+), 32 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 5bf94d28cf..ed09d056d1 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -167,6 +167,7 @@ typedef struct CPUClass {
>       int reset_dump_flags;
>       bool (*has_work)(CPUState *cpu);
>       void (*do_interrupt)(CPUState *cpu);
> +#ifndef CONFIG_USER_ONLY

I forgot once Peter Maydell told me we can't do that for some reason I 
don't remember.

At least this changes the sizeof(CPUClass), so we get:

qom/object.c:315:type_initialize: assertion failed: (parent->class_size 
<= ti->class_size)

So we can't poison the hwaddr type? (final patch of this series).

>       void (*do_unaligned_access)(CPUState *cpu, vaddr addr,
>                                   MMUAccessType access_type,
>                                   int mmu_idx, uintptr_t retaddr);
> @@ -174,6 +175,10 @@ typedef struct CPUClass {
>                                     unsigned size, MMUAccessType access_type,
>                                     int mmu_idx, MemTxAttrs attrs,
>                                     MemTxResult response, uintptr_t retaddr);
> +    hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);
> +    hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
> +                                        MemTxAttrs *attrs);
> +#endif /* CONFIG_USER_ONLY */
>       bool (*virtio_is_big_endian)(CPUState *cpu);
>       int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
>                              uint8_t *buf, int len, bool is_write);
> @@ -189,9 +194,6 @@ typedef struct CPUClass {
>       bool (*tlb_fill)(CPUState *cpu, vaddr address, int size,
>                        MMUAccessType access_type, int mmu_idx,
>                        bool probe, uintptr_t retaddr);
> -    hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);
> -    hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
> -                                        MemTxAttrs *attrs);
>       int (*asidx_from_attrs)(CPUState *cpu, MemTxAttrs attrs);
>       int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int reg);
>       int (*gdb_write_register)(CPUState *cpu, uint8_t *buf, int reg);
[...]


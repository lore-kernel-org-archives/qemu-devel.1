Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624E0C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 20:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DEDC20872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 20:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEDC20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDwki-0001wh-BC
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 16:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iDwjq-0001Uv-5E
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 16:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iDwjo-0000Je-Ts
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 16:21:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38268)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iDwjo-0000JY-LQ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 16:21:12 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A245D85A03
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 20:21:11 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id 190so3033664wme.4
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 13:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wCc+agJntvVV6r+jGML/mfHX+1d8anYXuAZXAMkQGvs=;
 b=M7cMOYKTvvmFqS85agNvSjCcVWgXnydPZai9Q+Vu43K+dL/P36/2kKLXfOLiTR4FiD
 xQ/v2VfEi4ZfnhVCrSuT+b2RuWCdf7I0tBc068Wjlpf2NKEaaRX2lP0g3PJ0bndh4Nsl
 9h3luaqWcLHN7YA01mfOOBfR+wuvDwfI595clgxjWAJnipPF8XdXliaCZhlCnKAlwC2U
 ETg8ijHpmlNXsRTDeyjw+Ts0dJFkkEEX2Og426ZWRbUhfQKKoKquQhHyUNaW7eQYBjfh
 xr6K3wWSW2lN3ccrz28nBJH/SDBg9SlWXTM6+KlMJ0Kxy8E9s5Y5OJaB2RGt+H/wqe8I
 0tpw==
X-Gm-Message-State: APjAAAXv2xtSwTMzXXo/Keg65Ptc7Jz1Rffp5hPOversC/7EWWBWEKFX
 vbgBBGiT+SwihzluSqwhYnbBJInRmcQaXSuZaAs7IlPqa4jSQijMCvxrHMXkXA9au8yGVZhiPqJ
 Yi+Y/9bSW6Ds4nsE=
X-Received: by 2002:adf:ce04:: with SMTP id p4mr4181073wrn.130.1569615670045; 
 Fri, 27 Sep 2019 13:21:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwGThSqgvb4OGVExaGVnCKjAjZ97d01qKj2SSqGyxEkK8llWygcS7DD96R5tIaZ7cV3FomQOA==
X-Received: by 2002:adf:ce04:: with SMTP id p4mr4181060wrn.130.1569615669737; 
 Fri, 27 Sep 2019 13:21:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id s19sm5232580wrb.14.2019.09.27.13.21.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2019 13:21:09 -0700 (PDT)
Subject: Re: [PATCH] Fix wrong behavior of cpu_memory_rw_debug() function in
 SMM
To: Dmitry Poletaev <poletaev@ispras.ru>, qemu-devel@nongnu.org
References: <20190918100706.19753-1-poletaev@ispras.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4787dcf2-1593-1bfa-63b6-8c7d162b28d5@redhat.com>
Date: Fri, 27 Sep 2019 22:21:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918100706.19753-1-poletaev@ispras.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/09/19 12:07, Dmitry Poletaev wrote:
> There is a problem, that you don't have access to the data using cpu_memory_rw_debug() function when in SMM. You can't remotely debug SMM mode program because of that for example.
> Likely attrs version of get_phys_page_debug should be used to get correct asidx at the end to handle access properly.
> Here the patch to fix it.
> 
> Signed-off-by: Dmitry Poletaev <poletaev@ispras.ru>
> ---
>  target/i386/cpu.c    | 2 +-
>  target/i386/cpu.h    | 3 ++-
>  target/i386/helper.c | 5 ++++-
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 9e0bac31e8..8ade4ed2c6 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5984,7 +5984,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
>  #ifndef CONFIG_USER_ONLY
>      cc->asidx_from_attrs = x86_asidx_from_attrs;
>      cc->get_memory_mapping = x86_cpu_get_memory_mapping;
> -    cc->get_phys_page_debug = x86_cpu_get_phys_page_debug;
> +    cc->get_phys_page_attrs_debug = x86_cpu_get_phys_page_attrs_debug;
>      cc->write_elf64_note = x86_cpu_write_elf64_note;
>      cc->write_elf64_qemunote = x86_cpu_write_elf64_qemunote;
>      cc->write_elf32_note = x86_cpu_write_elf32_note;
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 5f6e3a029a..bbd00d8deb 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1549,7 +1549,8 @@ void x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
>  
>  void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
>  
> -hwaddr x86_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> +hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
> +                                         MemTxAttrs *attrs);
>  
>  int x86_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>  int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index 0fa51be646..c3a6e4fabe 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -715,7 +715,8 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
>  }
>  
>  #if !defined(CONFIG_USER_ONLY)
> -hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
> +hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
> +                                         MemTxAttrs *attrs)
>  {
>      X86CPU *cpu = X86_CPU(cs);
>      CPUX86State *env = &cpu->env;
> @@ -725,6 +726,8 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>      uint32_t page_offset;
>      int page_size;
>  
> +    *attrs = cpu_get_mem_attrs(env);
> +
>      a20_mask = x86_get_a20_mask(env);
>      if (!(env->cr[0] & CR0_PG_MASK)) {
>          pte = addr & a20_mask;
> 

Queued, thanks.

Paolo


Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A45DC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0287E207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGzM980Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0287E207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY7S7-0000UX-7j
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 08:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jY7R7-0007P1-Ks; Mon, 11 May 2020 08:21:33 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34408)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jY7R6-0002k0-TM; Mon, 11 May 2020 08:21:33 -0400
Received: by mail-wm1-x344.google.com with SMTP id g14so6729522wme.1;
 Mon, 11 May 2020 05:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WE9of2IJLN2TV5g7cx+rhe2s1pQe8LZRT+6pv5bh5k8=;
 b=qGzM980ZCFb5AQQoFEA8MQ32JHEcCgIFy7qb8jmVriTJ854tcVpOkUw0Gp9mgcRJrz
 umtOArEPEl7uvJ8T/LeDb/hmJKl3eW5yDTQdnEYvwx3X/FDLJoSWXWsr8XBX24C+SjKU
 b7qBt82KcsHm2v5FKk6W9RPUZGMnKYZIBlJjcerdI1CETnciF9qIx3Acj8b7rrZ0f17+
 ZYJLbpbMf9sjMcjFRaKpkezpHivwX5v9i6ItjGdtwmXagTe771d1ajaaohdvsud9DfMl
 NQqMMzJ4n0fjerHvv5PkPH1agEGq6Bk1/QSUpdTBYn4NFgEfBgD/diZhmDg0l2y799zP
 BNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WE9of2IJLN2TV5g7cx+rhe2s1pQe8LZRT+6pv5bh5k8=;
 b=ItHGx1YTgMrnr+raO7OSbbqwT7yRruQyhcT1Z4OErYa1Q79VaBzDgZvxlJ7blzh6np
 LUivNLFnh91YWVjHj35Rbb9i2mI+qh6oTHaEXM8fjY4WWi8XufHiRTPs4LwBzm/pyTyE
 F+T0rMJAUfKTHhclukudB9Q6yf3C3gpHp2I8M3wwPzn8xBiMdit1MWgXzIqoL9ODBqFA
 OxSAI060sULQiXNh1a2/nhgnA/4Z4hL644rSpqIFLTPCwVY5AyM3KBdvFqOmbBFjSH5h
 uXie3lLkCYXw3JEzIRsZ5f+s2Nd/JslqUfHn4gFw0753wyJIh2GA0jR42TjmELjd9z0C
 /KoQ==
X-Gm-Message-State: AGi0PuaqedOtTWEXRF980djz/f3CMPX9vhTOUz15fEwCK9pvlnc3bPFB
 dXXl2X7VEIcnp5OHNf+2FJM=
X-Google-Smtp-Source: APiQypKH7kdNb8EUfpUHVeikZqJT8lT9P8SHiIFTGIpNxNO7QySfuZWNHc1TFk/GYCKJaP6LJeFjag==
X-Received: by 2002:a1c:3d08:: with SMTP id k8mr21123055wma.16.1589199689700; 
 Mon, 11 May 2020 05:21:29 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id q5sm10055936wra.36.2020.05.11.05.21.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 05:21:28 -0700 (PDT)
Subject: Re: [PATCH 08/11] target/s390x: Restrict system-mode declarations
To: Cornelia Huck <cohuck@redhat.com>
References: <20200509130910.26335-1-f4bug@amsat.org>
 <20200509130910.26335-9-f4bug@amsat.org>
 <20200511124804.1a7a43aa.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2bb91290-32c5-997d-c689-4d651836c7fc@amsat.org>
Date: Mon, 11 May 2020 14:21:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200511124804.1a7a43aa.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Marek Vasut <marex@denx.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/11/20 12:48 PM, Cornelia Huck wrote:
> On Sat,  9 May 2020 15:09:07 +0200
> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> 
>> As these declarations are restricted to !CONFIG_USER_ONLY in
>> helper.c, only declare them when system-mode emulation is used.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   target/s390x/internal.h | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/s390x/internal.h b/target/s390x/internal.h
>> index c1678dc6bc..ddc276cdf4 100644
>> --- a/target/s390x/internal.h
>> +++ b/target/s390x/internal.h
>> @@ -236,7 +236,6 @@ int s390_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
>>   
>>   /* cc_helper.c */
>>   const char *cc_name(enum cc_op cc_op);
>> -void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr);
>>   uint32_t calc_cc(CPUS390XState *env, uint32_t cc_op, uint64_t src, uint64_t dst,
>>                    uint64_t vr);
>>   
>> @@ -303,18 +302,20 @@ void s390_cpu_gdb_init(CPUState *cs);
>>   
>>   /* helper.c */
>>   void s390_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
>> -hwaddr s390_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>> -hwaddr s390_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
>> +void do_restart_interrupt(CPUS390XState *env);
>> +
>> +#ifndef CONFIG_USER_ONLY
>> +void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr);
> 
> load_psw() is in cc_helper.c (and not in helper.c). Rather add the
> #ifndef above, even if it is a bit awkward? Otherwise, the wrong
> comment makes it confusing.

I've been tempted to remove the kinda outdated /* helper.c */ comment...

> 
>>   uint64_t get_psw_mask(CPUS390XState *env);
>>   void s390_cpu_recompute_watchpoints(CPUState *cs);
>>   void s390x_tod_timer(void *opaque);
>>   void s390x_cpu_timer(void *opaque);
>> -void do_restart_interrupt(CPUS390XState *env);
>>   void s390_handle_wait(S390CPU *cpu);
>> +hwaddr s390_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>> +hwaddr s390_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
>>   #define S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_save_area)
>>   int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch);
>>   int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len);
>> -#ifndef CONFIG_USER_ONLY
>>   LowCore *cpu_map_lowcore(CPUS390XState *env);
>>   void cpu_unmap_lowcore(LowCore *lowcore);
>>   #endif /* CONFIG_USER_ONLY */
> 
> 


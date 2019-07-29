Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FAAC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 05:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2B342070B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 05:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="zIsYo/T7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B342070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrxox-0006gk-3U
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 01:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38867)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aik@ozlabs.ru>) id 1hrxoX-0006I1-D7
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 01:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1hrxoV-0004uD-U7
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 01:03:13 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36718)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1hrxoV-0004tb-FX
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 01:03:11 -0400
Received: by mail-pf1-x441.google.com with SMTP id r7so27356116pfl.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2019 22:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fl1ThdW7Yvl7O0x8vrJjjvGcZGO3rVNRcau4gqd8NBo=;
 b=zIsYo/T71KGH418w97UepD1WaUJUT7wUAi76/AC9wW+9czn6jJgnrPv1X624EQkEPD
 vIQHF8A/zEw+iSr9NsxuBU64BJFBEzAm09T0hk9txCn6CmvVhSiGSpmczKWQ3p6KQGTQ
 gjFLGxHbQV9fBkM/SdSK4frRFj+ZTmVQwAD0YI3o+pnuyqtOWvqOJ7vIMr2+t+zo04c0
 Dd1VQfRMqhEYyz0KqzPkGwI+hCyhYfWhiPz1Lstb4K4DZS3QkC6Qj2DuRUuJbhg8p/nL
 0ARSfvjH1XgdSK+ObrVjSWpqmrZCkIHFcD33d6qaAKu+lGJeUBXNPt+8DUIDh2Jazrrb
 XGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=fl1ThdW7Yvl7O0x8vrJjjvGcZGO3rVNRcau4gqd8NBo=;
 b=ImWVeETPFnCndIbulolvFjNFC6hoyFZwbHWQaeAO2JedMHSk4qx1Ekkacc1jIj9gAv
 W4ir3iG5663qo4oxAStbiTfBiuEFOQ1HauTGzF3K4rH65vEtLmdTz/jSi4A4cClidUcJ
 zPJZSWF3//8BkerEER/5YcY+yrYCDcbOxWgIg0iceYpYvv4a0k0jEL+BDzSy/yJAoPHl
 zpGkRNTU15eOTkcJdUjLInFTUm/ZbM6DSKGhlExfckxlsGXmEApt2q6OelF/AeHJi9ay
 J/jmjg9qnZ+RE+7fgJ4gPHOI/eLJe/zobMH2Z9Cx0giHaYHK2ZgYG4WkjrdpoxnMy02a
 lR6g==
X-Gm-Message-State: APjAAAXjLLcnyVlH+bGdij/z0N8k0tnvx//eIzFYVUEmH2ZoNjrJw7Wc
 PW5/FNrZZW7sWObeAs0/TKc=
X-Google-Smtp-Source: APXvYqzXFedHHC0EcgBuMGZEEeyl5vATJP/dAThr0VJm6VAoQiFdl1dZsmXI43pfWZAfpxujD0b0lA==
X-Received: by 2002:a63:31c1:: with SMTP id
 x184mr98928933pgx.128.1564376589385; 
 Sun, 28 Jul 2019 22:03:09 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4300:3dc5:2820:1c5a:e911:b719])
 by smtp.gmail.com with ESMTPSA id h16sm64296993pfo.34.2019.07.28.22.03.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 28 Jul 2019 22:03:08 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190720012850.14369-1-aik@ozlabs.ru>
 <20190720012850.14369-5-aik@ozlabs.ru> <20190728060955.GC5110@umbus>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <42e056b1-46ea-6dfb-6a56-e02a04fc3162@ozlabs.ru>
Date: Mon, 29 Jul 2019 15:03:07 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190728060955.GC5110@umbus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH qemu RFC 4/4] spapr: Implement SLOF-less
 client_architecture_support
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
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 28/07/2019 16:09, David Gibson wrote:
> On Sat, Jul 20, 2019 at 11:28:50AM +1000, Alexey Kardashevskiy wrote:
>> QEMU already implements H_CAS called by SLOF. The existing handler
>> prepares a diff FDT and SLOF applies it on top of its current tree.
>> In SLOF-less setup when the user explicitly selected "bios=no",
>> this updates the FDT from the OS, updates it and writes back to the OS.
>> The new behavior is advertised to the OS via "/chosen/qemu,h_cas".
> 
> I don't love having two different paths here, I'm wondering if we can
> unify things at all.
> 
> I have wondered at some points if there's anything preventing us just
> giving a whole new device tree at CAS, rather than selected updates -
> that could simplify several things.


An update has a header, and this patch just copies the fdt over, if I
add a header to this new path, this will require a few more changes in
the guest which I would rather avoid. Thanks,


> 
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  include/hw/ppc/spapr.h |  5 +++++
>>  hw/ppc/spapr.c         | 24 ++++++++++++++++-----
>>  hw/ppc/spapr_hcall.c   | 49 +++++++++++++++++++++++++++++++++++++++---
>>  3 files changed, 70 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 7f5d7a70d27e..73cd9cf25b83 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -766,9 +766,14 @@ struct SpaprEventLogEntry {
>>  
>>  void spapr_events_init(SpaprMachineState *sm);
>>  void spapr_dt_events(SpaprMachineState *sm, void *fdt);
>> +int spapr_h_cas_do_compose_response(SpaprMachineState *spapr, void *fdt,
>> +                                    SpaprOptionVector *ov5_updates);
>>  int spapr_h_cas_compose_response(SpaprMachineState *sm,
>>                                   target_ulong addr, target_ulong size,
>>                                   SpaprOptionVector *ov5_updates);
>> +#define FDT_MAX_SIZE 0x100000
>> +void *spapr_build_fdt(SpaprMachineState *spapr);
>> +
>>  void close_htab_fd(SpaprMachineState *spapr);
>>  void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr);
>>  void spapr_free_hpt(SpaprMachineState *spapr);
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index b097a99951f1..f84895f4a8b4 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -978,6 +978,19 @@ static bool spapr_hotplugged_dev_before_cas(void)
>>      return false;
>>  }
>>  
>> +int spapr_h_cas_do_compose_response(SpaprMachineState *spapr, void *fdt,
>> +                                    SpaprOptionVector *ov5_updates)
> 
> Not a great function name.
> 
>> +{
>> +    /* Fixup cpu nodes */
>> +    _FDT((spapr_fixup_cpu_dt(fdt, spapr)));
>> +
>> +    if (spapr_dt_cas_updates(spapr, fdt, ov5_updates)) {
>> +        return -1;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>  int spapr_h_cas_compose_response(SpaprMachineState *spapr,
>>                                   target_ulong addr, target_ulong size,
>>                                   SpaprOptionVector *ov5_updates)
>> @@ -1009,10 +1022,7 @@ int spapr_h_cas_compose_response(SpaprMachineState *spapr,
>>      _FDT((fdt_open_into(fdt_skel, fdt, size)));
>>      g_free(fdt_skel);
>>  
>> -    /* Fixup cpu nodes */
>> -    _FDT((spapr_fixup_cpu_dt(fdt, spapr)));
>> -
>> -    if (spapr_dt_cas_updates(spapr, fdt, ov5_updates)) {
>> +    if (spapr_h_cas_do_compose_response(spapr, fdt, ov5_updates)) {
>>          return -1;
>>      }
>>  
>> @@ -1232,6 +1242,10 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
>>  
>>      /* We always implemented RTAS as hcall, tell guests to call it directly */
>>      _FDT(fdt_setprop_cell(fdt, chosen, "qemu,h_rtas", 1));
>> +    /* Tell the guest that H_CAS will return the entire FDT now, not the diff */
>> +    if (!spapr->bios_enabled) {
>> +        _FDT(fdt_setprop_cell(fdt, chosen, "qemu,h_cas", 1));
> 
> As with H_RTAS< using qemu,hypertas-functions would be more
> appropriate for this.
> 
>> +    }
>>  
>>      spapr_dt_ov5_platform_support(spapr, fdt, chosen);
>>  
>> @@ -1262,7 +1276,7 @@ static void spapr_dt_hypervisor(SpaprMachineState *spapr, void *fdt)
>>      }
>>  }
>>  
>> -static void *spapr_build_fdt(SpaprMachineState *spapr)
>> +void *spapr_build_fdt(SpaprMachineState *spapr)
>>  {
>>      MachineState *machine = MACHINE(spapr);
>>      MachineClass *mc = MACHINE_GET_CLASS(machine);
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index b964d94f330b..c5cb06c9d507 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -17,6 +17,7 @@
>>  #include "hw/ppc/spapr_ovec.h"
>>  #include "mmu-book3s-v3.h"
>>  #include "hw/mem/memory-device.h"
>> +#include "sysemu/device_tree.h"
>>  
>>  static bool has_spr(PowerPCCPU *cpu, int spr)
>>  {
>> @@ -1774,9 +1775,51 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>>              /* legacy hash or new hash: */
>>              spapr_setup_hpt_and_vrma(spapr);
>>          }
>> -        spapr->cas_reboot =
>> -            (spapr_h_cas_compose_response(spapr, args[1], args[2],
>> -                                          ov5_updates) != 0);
>> +
>> +        if (spapr->bios_enabled) {
>> +            spapr->cas_reboot =
>> +                (spapr_h_cas_compose_response(spapr, args[1], args[2],
>> +                                              ov5_updates) != 0);
>> +        } else {
>> +            int size;
>> +            void *fdt, *fdt_skel;
>> +            struct fdt_header hdr = { 0 };
>> +
>> +            cpu_physical_memory_read(args[1], &hdr, sizeof(hdr));
>> +            size = fdt32_to_cpu(hdr.totalsize);
>> +            if (size > FDT_MAX_SIZE) {
>> +                return H_NOT_AVAILABLE;
>> +            }
>> +
>> +            fdt_skel = g_malloc0(size);
>> +            cpu_physical_memory_read(args[1], fdt_skel, size);
>> +
>> +            fdt = g_malloc0(FDT_MAX_SIZE);
>> +            fdt_open_into(fdt_skel, fdt, FDT_MAX_SIZE);
>> +            g_free(fdt_skel);
> 
> fdt_open_into() explicitly permits using the same buffer for both
> arguments, so you don't need two allocations here - you can just
> allocate FDT_MAX_SIZE, read it in, then fdt_open_into() in place.
> 
> You probably should check for errors from fdt_open_into(), though.
> 
>> +
>> +            if (spapr_h_cas_do_compose_response(spapr, fdt, ov5_updates)) {
>> +                g_free(fdt);
>> +                return H_NOT_AVAILABLE;
>> +            }
>> +            fdt_pack(fdt);
>> +            if (fdt_totalsize(fdt) > FDT_MAX_SIZE) {
> 
> This can't actually happen - you only ever allocated a buffer of size
> FDT_MAX_SIZE, so if the DT was going to exceed that you would have hit
> FDT_ERR_NOSPACE in an earlier step.
> 
>> +                error_report("FDT too big ! 0x%x bytes (max is 0x%x)",
>> +                             fdt_totalsize(fdt), FDT_MAX_SIZE);
>> +                g_free(fdt);
>> +                return H_NOT_AVAILABLE;
>> +            }
>> +
>> +            /* Load the fdt */
>> +            cpu_physical_memory_write(args[1], fdt, fdt_totalsize(fdt));
>> +
>> +            g_free(spapr->fdt_blob);
>> +            spapr->fdt_size = fdt_totalsize(fdt);
>> +            spapr->fdt_initial_size = spapr->fdt_size;
>> +            spapr->fdt_blob = fdt;
>> +
>> +            qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>> +        }
>>      }
>>  
>>      /*
> 

-- 
Alexey


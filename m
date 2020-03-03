Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902C8C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6221D214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSVgInoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6221D214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94ny-0000jw-IP
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j94cY-0006Xo-AU
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j94cX-00017d-9m
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:17:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35262
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j94cX-00017M-5l
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583230668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mDXhtuCKcBCj0ptyfw3vySEWeddkh4becNgYWoU/51g=;
 b=TSVgInoOF5HMJNPTLF9Wl3x9tRPvSpRc/StUcyyer9zgoS2PvB/AroHNPRoOjSAzUN4JBw
 5+jC1J6TYB8whP2zmNDQdJXyZx4TOsaqNie8aHJ2KAJTpTMYmsH8MS3NoNluXm8nKYyeOn
 J7FsVr38eJwT1xXqXccmW6IndPTauCg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-bAPSt1a5PXGsR6P1Oq_qOg-1; Tue, 03 Mar 2020 05:17:45 -0500
X-MC-Unique: bAPSt1a5PXGsR6P1Oq_qOg-1
Received: by mail-wm1-f72.google.com with SMTP id k65so219079wmf.7
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 02:17:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mDXhtuCKcBCj0ptyfw3vySEWeddkh4becNgYWoU/51g=;
 b=smsmONdxZHrqSvyvZCLTRYR1e1J7ikOhuEosSP0NY3pDTv9uOcVvy+NGvPJIUOVUHc
 JcUWm98LcsQpYtEH73v+G4nFXYjVY0OhMPSRlYuV2DEKMmglwZnjrfMKNcxwntwp7sXp
 zD150IqBmzP+qUAaxBsbTK9fWSL8QvfNgVi8qu2djaQ+RMaqg3jXq03ZgQ6Bpsre5335
 ueeCbdEY2A8Mt7Fud50H9SfSLcecJHg2YZdLPrcZU1XRtewQysEO3X/X+4fIVUF5eTbu
 AJqICzrYtSPh0AhysLzNPfFyr9xO0BbTuXknN4ylT7NfsJBIqcFPhMGVCaqzzquvv0a+
 BwLA==
X-Gm-Message-State: ANhLgQ1Ebpla6frmd6t/ASJneWILvjXs9c9QaRcBqOVDpzev4j1ObYK7
 3Qhun8keMgs4/0xsd17nfxSAlUuUYbuNwOTaoABnk2MgdKDZN67YRU0HBmCveoBot2MYCtG3ePn
 gGtQz6BclorqtIps=
X-Received: by 2002:adf:ed91:: with SMTP id c17mr4327957wro.388.1583230664090; 
 Tue, 03 Mar 2020 02:17:44 -0800 (PST)
X-Google-Smtp-Source: ADFU+vt4n5qyIk5TBATqRi+3H978zI3roN3HzOvesq7TmUH4VXfE7e4gDRzD++DBGkiDJE2UAGC3lg==
X-Received: by 2002:adf:ed91:: with SMTP id c17mr4327934wro.388.1583230663835; 
 Tue, 03 Mar 2020 02:17:43 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993?
 ([2001:b07:6468:f312:9def:34a0:b68d:9993])
 by smtp.gmail.com with ESMTPSA id z10sm3057819wmk.31.2020.03.03.02.17.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2020 02:17:43 -0800 (PST)
Subject: Re: [PATCH] WHPX: Use proper synchronization primitives while
 processing
To: Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
References: <SN4PR2101MB0880A1C19D64131DE3D261B5C0EC0@SN4PR2101MB0880.namprd21.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <55f40d1a-0a08-e34b-dd48-527cb77a5c48@redhat.com>
Date: Tue, 3 Mar 2020 11:17:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <SN4PR2101MB0880A1C19D64131DE3D261B5C0EC0@SN4PR2101MB0880.namprd21.prod.outlook.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Stefan Weil <sw@weilnetz.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Justin Terry \(SF\)" <juterry@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/02/20 20:27, Sunil Muthuswamy wrote:
> WHPX wasn't using the proper synchronization primitives while
> processing async events, which can cause issues with SMP.
> 
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
>  target/i386/whpx-all.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index 35601b8176..868ade5fd0 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -841,9 +841,8 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
>  
>      if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
>          !(env->hflags & HF_SMM_MASK)) {
> -
> +        whpx_cpu_synchronize_state(cpu);
>          do_cpu_init(x86_cpu);
> -        cpu->vcpu_dirty = true;
>          vcpu->interruptable = true;
>      }
>  
> @@ -859,17 +858,13 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
>      }
>  
>      if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
> -        if (!cpu->vcpu_dirty) {
> -            whpx_get_registers(cpu);
> -        }
> +        whpx_cpu_synchronize_state(cpu);
>          do_cpu_sipi(x86_cpu);
>      }
>  
>      if (cpu->interrupt_request & CPU_INTERRUPT_TPR) {
>          cpu->interrupt_request &= ~CPU_INTERRUPT_TPR;
> -        if (!cpu->vcpu_dirty) {
> -            whpx_get_registers(cpu);
> -        }
> +        whpx_cpu_synchronize_state(cpu);
>          apic_handle_tpr_access_report(x86_cpu->apic_state, env->eip,
>                                        env->tpr_access_type);
>      }
> @@ -1067,8 +1062,10 @@ static int whpx_vcpu_run(CPUState *cpu)
>  
>  static void do_whpx_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
>  {
> -    whpx_get_registers(cpu);
> -    cpu->vcpu_dirty = true;
> +    if (!cpu->vcpu_dirty) {
> +        whpx_get_registers(cpu);
> +        cpu->vcpu_dirty = true;
> +    }
>  }
>  
>  static void do_whpx_cpu_synchronize_post_reset(CPUState *cpu,
> 

Queued, thanks.

Paolo



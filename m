Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79A3C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 06:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAD0207C4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 06:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAD0207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTJYp-0004Ic-86
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 02:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1kTJY1-0003t1-0p
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 02:49:05 -0400
Received: from mailout10.t-online.de ([194.25.134.21]:46304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1kTJXy-00076H-Tx
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 02:49:04 -0400
Received: from fwd27.aul.t-online.de (fwd27.aul.t-online.de [172.20.26.132])
 by mailout10.t-online.de (Postfix) with SMTP id DCFCE41F6362;
 Fri, 16 Oct 2020 08:49:00 +0200 (CEST)
Received: from [192.168.211.200]
 (Jr+OhqZY8hBIR2KfzBCl7i73NW3C2NIC1ITpiWp2IHd3wxOztAmgZ3zs6k6ibbOQ-0@[46.86.52.112])
 by fwd27.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kTJXr-2os0Js0; Fri, 16 Oct 2020 08:48:55 +0200
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: Re: [PULL 07/37] cpus: extract out hax-specific code to target/i386/
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201006072947.487729-1-pbonzini@redhat.com>
 <20201006072947.487729-8-pbonzini@redhat.com>
Message-ID: <a412667e-c486-b002-1e9c-5128345cad75@t-online.de>
Date: Fri, 16 Oct 2020 08:48:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201006072947.487729-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ID: Jr+OhqZY8hBIR2KfzBCl7i73NW3C2NIC1ITpiWp2IHd3wxOztAmgZ3zs6k6ibbOQ-0
X-TOI-EXPURGATEID: 150726::1602830935-0000CED0-19AF125B/0/0 CLEAN NORMAL
X-TOI-MSGID: 2797998b-66b8-4a78-976e-d1f997f66e60
Received-SPF: none client-ip=194.25.134.21; envelope-from=vr_qemu@t-online.de;
 helo=mailout10.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 02:49:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Claudio Fontana <cfontana@suse.de>
>
> register a "CpusAccel" interface for HAX as well.
>

> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
> index 9fa73735a2..900fff827a 100644
> --- a/softmmu/cpus.c
> +++ b/softmmu/cpus.c
> @@ -416,35 +403,6 @@ void qemu_wait_io_event(CPUState *cpu)
>      qemu_wait_io_event_common(cpu);
>  }
>  
> -static void *qemu_hax_cpu_thread_fn(void *arg)
> -{
> -    CPUState *cpu = arg;
> -    int r;
> -
> -    rcu_register_thread();
> -    qemu_mutex_lock_iothread();
> -    qemu_thread_get_self(cpu->thread);
> -
> -    cpu->thread_id = qemu_get_thread_id();
> -    current_cpu = cpu;

Hi Claudio,

is there a reason why you removed current_cpu = cpu; from hax_cpu_thread_fn() when you moved that function to target/i386/hax-cpus.c? This change broke HAX on Windows. Adding back that line makes it work again.

The simplest reproducer is:
$ ./qemu-system-x86_64.exe -machine pc,accel=hax -smp 2 -display gtk
HAX is working and emulator runs in fast virt mode.

Then the QEMU window opens and shows 'Guest has not initialized the display (yet).' forever.

A look at the Windows Task Manager suggests one thread is busy looping.

With best regards,
Volker

> -    hax_init_vcpu(cpu);
> -    cpu_thread_signal_created(cpu);
> -    qemu_guest_random_seed_thread_part2(cpu->random_seed);
> -
> -    do {
> -        if (cpu_can_run(cpu)) {
> -            r = hax_smp_cpu_exec(cpu);
> -            if (r == EXCP_DEBUG) {
> -                cpu_handle_guest_debug(cpu);
> -            }
> -        }
> -
> -        qemu_wait_io_event(cpu);
> -    } while (!cpu->unplug || cpu_can_run(cpu));
> -    rcu_unregister_thread();
> -    return NULL;
> -}
> -
>  /* The HVF-specific vCPU thread function. This one should only run when the host
>   * CPU supports the VMX "unrestricted guest" feature. */
>  static void *qemu_hvf_cpu_thread_fn(void *arg)
>


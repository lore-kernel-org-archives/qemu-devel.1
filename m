Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C370C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB6E2082F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB6E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqhte-0002lo-Lt
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 14:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jqhst-0002BM-1o
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:55:03 -0400
Received: from relay64.bu.edu ([128.197.228.104]:43810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jqhsq-000205-TR
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:55:02 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 061Is54p030416
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 1 Jul 2020 14:54:10 -0400
Date: Wed, 1 Jul 2020 14:54:05 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH] cpus: Initialize current_cpu with the first vCPU
 created
Message-ID: <20200701185304.f3hjftxmtcb2tzue@mozz.bu.edu>
References: <20200701182100.26930-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701182100.26930-1-philmd@redhat.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 14:55:00
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Bug 1878645 <1878645@bugs.launchpad.net>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200701 2021, Philippe Mathieu-Daudé wrote:
> We can run I/O access with the 'i' or 'o' HMP commands in the
> monitor. These commands are expected to run on a vCPU. The
> monitor is not a vCPU thread. To avoid crashing, initialize
> the 'current_cpu' variable with the first vCPU created. The
> command executed on the monitor will end using it.
> 
> This fixes:
> 
>   $ cat << EOF| qemu-system-i386 -M q35 -nographic -serial none -monitor stdio
>   o/4 0xcf8 0x8400f841
>   o/4 0xcfc 0xaa215d6d
>   o/4 0x6d30 0x2ef8ffbe
>   o/1 0xb2 0x20
>   EOF
>   Segmentation fault (core dumped)
> 
>   Thread 1 "qemu-system-i38" received signal SIGSEGV, Segmentation fault.
>   0x00005555558946c7 in tcg_handle_interrupt (cpu=0x0, mask=64) at accel/tcg/tcg-all.c:57
>   57          old_mask = cpu->interrupt_request;
>   (gdb) bt
>   #0  0x00005555558946c7 in tcg_handle_interrupt (cpu=0x0, mask=64) at accel/tcg/tcg-all.c:57
>   #1  0x00005555558ed7d2 in cpu_interrupt (cpu=0x0, mask=64) at include/hw/core/cpu.h:877
>   #2  0x00005555558ee776 in ich9_apm_ctrl_changed (val=32, arg=0x555556e2ff50) at hw/isa/lpc_ich9.c:442
>   #3  0x0000555555b47f96 in apm_ioport_writeb (opaque=0x555556e308c0, addr=0, val=32, size=1) at hw/isa/apm.c:44
>   #4  0x0000555555879931 in memory_region_write_accessor (mr=0x555556e308e0, addr=0, value=0x7fffffffb9f8, size=1, shift=0, mask=255, attrs=...) at memory.c:483
>   #5  0x0000555555879b5a in access_with_adjusted_size (addr=0, value=0x7fffffffb9f8, size=4, access_size_min=1, access_size_max=1, access_fn=
>       0x55555587984e <memory_region_write_accessor>, mr=0x555556e308e0, attrs=...) at memory.c:544
>   #6  0x000055555587ca32 in memory_region_dispatch_write (mr=0x555556e308e0, addr=0, data=32, op=MO_32, attrs=...) at memory.c:1465
>   #7  0x000055555581b7e9 in flatview_write_continue (fv=0x55555698a790, addr=178, attrs=..., ptr=0x7fffffffbb84, len=4, addr1=0, l=4, mr=0x555556e308e0) at exec.c:3198
>   #8  0x000055555581b92e in flatview_write (fv=0x55555698a790, addr=178, attrs=..., buf=0x7fffffffbb84, len=4) at exec.c:3238
>   #9  0x000055555581bc81 in address_space_write (as=0x555556441220 <address_space_io>, addr=178, attrs=..., buf=0x7fffffffbb84, len=4) at exec.c:3329
>   #10 0x0000555555873f08 in cpu_outl (addr=178, val=32) at ioport.c:80
>   #11 0x000055555598a26a in hmp_ioport_write (mon=0x5555567621b0, qdict=0x555557702600) at monitor/misc.c:937
>   #12 0x0000555555c9c5a5 in handle_hmp_command (mon=0x5555567621b0, cmdline=0x55555676aae1 "/1 0xb2 0x20") at monitor/hmp.c:1082
>   #13 0x0000555555c99e02 in monitor_command_cb (opaque=0x5555567621b0, cmdline=0x55555676aae0 "o/1 0xb2 0x20", readline_opaque=0x0) at monitor/hmp.c:47
>                             ^
>     HMP command from monitor
> 
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1878645
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Cc: Bug 1878645 <1878645@bugs.launchpad.net>
> 
> RFC because I believe the correct fix is to NOT use current_cpu
> out of cpus.c, at least use qemu_get_cpu(0) to get the first vCPU.
> ---
>  cpus.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/cpus.c b/cpus.c
> index 41d1c5099f..1f6f43d221 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -2106,6 +2106,9 @@ void qemu_init_vcpu(CPUState *cpu)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
>  
> +    if (!current_cpu) {
> +        current_cpu = cpu;
> +    }

Seems like a neat solution.
is it fair to assume that qemu_init_vcpu is called before any threads
that can do I/O are created? I confirmed that the qtest and hmp crashes
are avoided.
-Alex

>      cpu->nr_cores = ms->smp.cores;
>      cpu->nr_threads =  ms->smp.threads;
>      cpu->stopped = true;
> -- 
> 2.21.3
> 


Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014E4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5762B2074F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5762B2074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS4NI-0006Mr-BS
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 16:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kS4M6-0005Wg-RP
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:23:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:54520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kS4M4-0001DW-Hz
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:23:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id ED691AC12;
 Mon, 12 Oct 2020 20:23:34 +0000 (UTC)
Subject: Re: [PATCH 1/2] accel: move qtest CpusAccel functions to a common
 location
To: Jason Andryuk <jandryuk@gmail.com>, qemu-devel@nongnu.org
References: <20201012200725.64137-1-jandryuk@gmail.com>
 <20201012200725.64137-2-jandryuk@gmail.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <f29b58c7-62c5-ad10-91c8-47598759c876@suse.de>
Date: Mon, 12 Oct 2020 22:23:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201012200725.64137-2-jandryuk@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 01:21:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 10:07 PM, Jason Andryuk wrote:
> Move and rename accel/qtest/qtest-cpu.* files to accel/dummy/ so they
> can be re-used by Xen.
> 
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> ---
>  .../qtest-cpus.c => dummy/dummy-cpus.c}       | 22 +++++--------------
>  .../qtest-cpus.h => dummy/dummy-cpus.h}       | 10 ++++-----
>  accel/dummy/meson.build                       |  6 +++++
>  accel/meson.build                             |  1 +
>  accel/qtest/meson.build                       |  1 -
>  accel/qtest/qtest.c                           |  7 +++++-
>  6 files changed, 23 insertions(+), 24 deletions(-)
>  rename accel/{qtest/qtest-cpus.c => dummy/dummy-cpus.c} (76%)
>  rename accel/{qtest/qtest-cpus.h => dummy/dummy-cpus.h} (59%)
>  create mode 100644 accel/dummy/meson.build
> 
> diff --git a/accel/qtest/qtest-cpus.c b/accel/dummy/dummy-cpus.c
> similarity index 76%
> rename from accel/qtest/qtest-cpus.c
> rename to accel/dummy/dummy-cpus.c
> index 7c5399ed9d..efade99f03 100644
> --- a/accel/qtest/qtest-cpus.c
> +++ b/accel/dummy/dummy-cpus.c
> @@ -1,5 +1,5 @@
>  /*
> - * QTest accelerator code
> + * Dummy cpu thread code
>   *
>   * Copyright IBM, Corp. 2011
>   *
> @@ -13,21 +13,14 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/rcu.h"
> -#include "qapi/error.h"
> -#include "qemu/module.h"
> -#include "qemu/option.h"
> -#include "qemu/config-file.h"
> -#include "sysemu/accel.h"
> -#include "sysemu/qtest.h"
>  #include "sysemu/cpus.h"
> -#include "sysemu/cpu-timers.h"
>  #include "qemu/guest-random.h"
>  #include "qemu/main-loop.h"
>  #include "hw/core/cpu.h"
>  
> -#include "qtest-cpus.h"
> +#include "dummy-cpus.h"
>  
> -static void *qtest_cpu_thread_fn(void *arg)
> +static void *dummy_cpu_thread_fn(void *arg)
>  {
>  #ifdef _WIN32
>      error_report("qtest is not supported under Windows");

I wonder if this should be changed to "dummy cpu thread is not supported under Windows".

Does not matter probably.

> @@ -72,7 +65,7 @@ static void *qtest_cpu_thread_fn(void *arg)
>  #endif
>  }
>  
> -static void qtest_start_vcpu_thread(CPUState *cpu)
> +void dummy_start_vcpu_thread(CPUState *cpu)
>  {
>      char thread_name[VCPU_THREAD_NAME_SIZE];
>  
> @@ -81,11 +74,6 @@ static void qtest_start_vcpu_thread(CPUState *cpu)
>      qemu_cond_init(cpu->halt_cond);
>      snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/DUMMY",
>               cpu->cpu_index);
> -    qemu_thread_create(cpu->thread, thread_name, qtest_cpu_thread_fn, cpu,
> +    qemu_thread_create(cpu->thread, thread_name, dummy_cpu_thread_fn, cpu,
>                         QEMU_THREAD_JOINABLE);
>  }
> -
> -const CpusAccel qtest_cpus = {
> -    .create_vcpu_thread = qtest_start_vcpu_thread,
> -    .get_virtual_clock = qtest_get_virtual_clock,
> -};
> diff --git a/accel/qtest/qtest-cpus.h b/accel/dummy/dummy-cpus.h
> similarity index 59%
> rename from accel/qtest/qtest-cpus.h
> rename to accel/dummy/dummy-cpus.h
> index 739519a472..a7a0469b17 100644
> --- a/accel/qtest/qtest-cpus.h
> +++ b/accel/dummy/dummy-cpus.h
> @@ -7,11 +7,11 @@
>   * See the COPYING file in the top-level directory.
>   */
>  
> -#ifndef QTEST_CPUS_H
> -#define QTEST_CPUS_H
> +#ifndef DUMMY_CPUS_H
> +#define DUMMY_CPUS_H
>  
> -#include "sysemu/cpus.h"
> +#include "qemu/typedefs.h"
>  
> -extern const CpusAccel qtest_cpus;
> +void dummy_start_vcpu_thread(CPUState *);
>  
> -#endif /* QTEST_CPUS_H */
> +#endif /* DUMMY_CPUS_H */
> diff --git a/accel/dummy/meson.build b/accel/dummy/meson.build
> new file mode 100644
> index 0000000000..5fbe27de90
> --- /dev/null
> +++ b/accel/dummy/meson.build
> @@ -0,0 +1,6 @@
> +dummy_ss = ss.source_set()
> +dummy_ss.add(files(
> +  'dummy-cpus.c',
> +))
> +
> +specific_ss.add_all(when: ['CONFIG_SOFTMMU', 'CONFIG_POSIX'], if_true: dummy_ss)
> diff --git a/accel/meson.build b/accel/meson.build
> index bb00d0fd13..d45a33fb8e 100644
> --- a/accel/meson.build
> +++ b/accel/meson.build
> @@ -1,5 +1,6 @@
>  softmmu_ss.add(files('accel.c'))
>  
> +subdir('dummy')
>  subdir('qtest')
>  subdir('kvm')
>  subdir('tcg')
> diff --git a/accel/qtest/meson.build b/accel/qtest/meson.build
> index e477cb2ae2..a2f3276459 100644
> --- a/accel/qtest/meson.build
> +++ b/accel/qtest/meson.build
> @@ -1,7 +1,6 @@
>  qtest_ss = ss.source_set()
>  qtest_ss.add(files(
>    'qtest.c',
> -  'qtest-cpus.c',
>  ))
>  
>  specific_ss.add_all(when: ['CONFIG_SOFTMMU', 'CONFIG_POSIX'], if_true: qtest_ss)
> diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
> index 537e8b449c..ac54bc8f52 100644
> --- a/accel/qtest/qtest.c
> +++ b/accel/qtest/qtest.c
> @@ -25,7 +25,12 @@
>  #include "qemu/main-loop.h"
>  #include "hw/core/cpu.h"
>  
> -#include "qtest-cpus.h"
> +#include "accel/dummy/dummy-cpus.h"

this is a bit strange from my perspective, does not look right.

Maybe this dummy cpu prototype should be somewhere in include/ ,
like include/sysemu/cpus.h or even better include/sysemu/accel.h

> +
> +const CpusAccel qtest_cpus = {
> +    .create_vcpu_thread = dummy_start_vcpu_thread,
> +    .get_virtual_clock = qtest_get_virtual_clock,
> +};
>  
>  static int qtest_init_accel(MachineState *ms)
>  {
> 



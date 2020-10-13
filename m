Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409DFC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8977247E2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8977247E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSL3u-0005wd-Q7
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 10:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kSL2Y-0004ws-2H
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:12:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:56880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kSL2V-0007Al-Qq
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:12:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 570B3ABCC;
 Tue, 13 Oct 2020 14:12:30 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] accel: move qtest CpusAccel functions to a common
 location
To: Jason Andryuk <jandryuk@gmail.com>, qemu-devel@nongnu.org
References: <20201013140511.5681-1-jandryuk@gmail.com>
 <20201013140511.5681-3-jandryuk@gmail.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <d966d230-6a1c-f44a-805f-8f1076a72303@suse.de>
Date: Tue, 13 Oct 2020 16:12:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201013140511.5681-3-jandryuk@gmail.com>
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
 Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 4:05 PM, Jason Andryuk wrote:
> Move and rename accel/qtest/qtest-cpus.c files to accel/dummy-cpus.c so
> it can be re-used by Xen.
> 
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> 
> ---
> v2:
>  - Use accel/dummy-cpus.c
>  - Put prototype in include/sysemu/cpus.h
> ---
>  accel/{qtest/qtest-cpus.c => dummy-cpus.c} | 22 ++++------------------
>  accel/meson.build                          |  7 +++++++
>  accel/qtest/meson.build                    |  1 -
>  accel/qtest/qtest-cpus.h                   | 17 -----------------
>  accel/qtest/qtest.c                        |  5 ++++-
>  include/sysemu/cpus.h                      |  3 +++
>  6 files changed, 18 insertions(+), 37 deletions(-)
>  rename accel/{qtest/qtest-cpus.c => dummy-cpus.c} (75%)
>  delete mode 100644 accel/qtest/qtest-cpus.h
> 
> diff --git a/accel/qtest/qtest-cpus.c b/accel/dummy-cpus.c
> similarity index 75%
> rename from accel/qtest/qtest-cpus.c
> rename to accel/dummy-cpus.c
> index db094201c1..10429fdfb2 100644
> --- a/accel/qtest/qtest-cpus.c
> +++ b/accel/dummy-cpus.c
> @@ -1,5 +1,5 @@
>  /*
> - * QTest accelerator code
> + * Dummy cpu thread code
>   *
>   * Copyright IBM, Corp. 2011
>   *
> @@ -13,21 +13,12 @@
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
> -
> -static void *qtest_cpu_thread_fn(void *arg)
> +static void *dummy_cpu_thread_fn(void *arg)
>  {
>      CPUState *cpu = arg;
>      sigset_t waitset;
> @@ -67,7 +58,7 @@ static void *qtest_cpu_thread_fn(void *arg)
>      return NULL;
>  }
>  
> -static void qtest_start_vcpu_thread(CPUState *cpu)
> +void dummy_start_vcpu_thread(CPUState *cpu)
>  {
>      char thread_name[VCPU_THREAD_NAME_SIZE];
>  
> @@ -76,11 +67,6 @@ static void qtest_start_vcpu_thread(CPUState *cpu)
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
> diff --git a/accel/meson.build b/accel/meson.build
> index bb00d0fd13..9a417396bd 100644
> --- a/accel/meson.build
> +++ b/accel/meson.build
> @@ -5,3 +5,10 @@ subdir('kvm')
>  subdir('tcg')
>  subdir('xen')
>  subdir('stubs')
> +
> +dummy_ss = ss.source_set()
> +dummy_ss.add(files(
> +  'dummy-cpus.c',
> +))
> +
> +specific_ss.add_all(when: ['CONFIG_SOFTMMU', 'CONFIG_POSIX'], if_true: dummy_ss)
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
> diff --git a/accel/qtest/qtest-cpus.h b/accel/qtest/qtest-cpus.h
> deleted file mode 100644
> index 739519a472..0000000000
> --- a/accel/qtest/qtest-cpus.h
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -/*
> - * Accelerator CPUS Interface
> - *
> - * Copyright 2020 SUSE LLC
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or later.
> - * See the COPYING file in the top-level directory.
> - */
> -
> -#ifndef QTEST_CPUS_H
> -#define QTEST_CPUS_H
> -
> -#include "sysemu/cpus.h"
> -
> -extern const CpusAccel qtest_cpus;
> -
> -#endif /* QTEST_CPUS_H */
> diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
> index 537e8b449c..b282cea5cf 100644
> --- a/accel/qtest/qtest.c
> +++ b/accel/qtest/qtest.c
> @@ -25,7 +25,10 @@
>  #include "qemu/main-loop.h"
>  #include "hw/core/cpu.h"
>  
> -#include "qtest-cpus.h"
> +const CpusAccel qtest_cpus = {
> +    .create_vcpu_thread = dummy_start_vcpu_thread,
> +    .get_virtual_clock = qtest_get_virtual_clock,
> +};
>  
>  static int qtest_init_accel(MachineState *ms)
>  {
> diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
> index 231685955d..e8156728c6 100644
> --- a/include/sysemu/cpus.h
> +++ b/include/sysemu/cpus.h
> @@ -25,6 +25,9 @@ typedef struct CpusAccel {
>  /* register accel-specific cpus interface implementation */
>  void cpus_register_accel(const CpusAccel *i);
>  
> +/* Create a dummy vcpu for CpusAccel->create_vcpu_thread */
> +void dummy_start_vcpu_thread(CPUState *);
> +
>  /* interface available for cpus accelerator threads */
>  
>  /* For temporary buffers for forming a name */
> 
Reviewed-by: Claudio Fontana <cfontana@suse.de>


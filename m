Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4644C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A163320708
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGTREJRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A163320708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPOi-0000Jl-To
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jrPNr-0007tC-8R
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 13:21:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55954
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jrPNo-0003xB-VQ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 13:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593796911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yD5W7hldw0yqgtkLgg0v0rYzMiddbYcM3b6hkdLcKkQ=;
 b=AGTREJRtgsvVQpn3tFOUIcJHvICiVEw5O3aj8zBDDwgqBy0cl4eL0222ap+DiaQUpcWfdd
 bimiEM/H8lB918Fi/kAlf2/pR8PnZKgSnGeYGMoH8mhG3U810L+rQzNRfv9n64OIzjfg+8
 LdPmm37rlibFgXecXkRejng1ngu3zAw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-3Dj1q91uOsqCJVIpo6I3jA-1; Fri, 03 Jul 2020 13:21:48 -0400
X-MC-Unique: 3Dj1q91uOsqCJVIpo6I3jA-1
Received: by mail-wr1-f71.google.com with SMTP id 89so8914432wrr.15
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 10:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yD5W7hldw0yqgtkLgg0v0rYzMiddbYcM3b6hkdLcKkQ=;
 b=g6Zv/gdZi+TcGVgXWNiflybr6GdYc4YziawtHcSeeC2BNZDAE/NR6Q4WZpJr7U8vQl
 C81lPY5cpEM8Tthm6K8otJBM61S4mXt02dMBVCW+KRRFrdKENZvN+NzmP9hsBHfZA8sW
 XM+r0hX660StskTtygmzzf3f92M14xuRF0LA1/ipOzYtXSX5gKrQ4xXfrd6yYyPvtr/X
 0xjvvVzwCo1HIUwrd2B79StWpAGI6sQKV9J2W2QLgn2rMhqtvFavu0CNrPpyNaQSozjx
 hcqfwdyYbWHu7FcRHMrBFDfrBcKRunw9xud/g/H4KEhA43pTf85fnWf0yjfwbBBsFjGP
 3uGw==
X-Gm-Message-State: AOAM530TraB3uzDVoh2k3YCNtDm2havLXb1yN8mzhPYonwhco5MgE8/g
 4WihyiTDVFqIG+wLrUpu9GsCxOeoZrMdLHrXbXvz14+K6KLXhWusXsFDIn6gBmAsopkU1JqMa42
 b9ToZzE2W63UWues=
X-Received: by 2002:adf:c542:: with SMTP id s2mr10352532wrf.132.1593796906674; 
 Fri, 03 Jul 2020 10:21:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAC7AVnk+xqoRJsTXskspys23+Sj5JhxrgdeXczTzrAG/xY6frRa6+28nlPOquG9gO9NghDw==
X-Received: by 2002:adf:c542:: with SMTP id s2mr10352511wrf.132.1593796906408; 
 Fri, 03 Jul 2020 10:21:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5cf9:fc14:deb7:51fc?
 ([2001:b07:6468:f312:5cf9:fc14:deb7:51fc])
 by smtp.gmail.com with ESMTPSA id v20sm13588230wmh.26.2020.07.03.10.21.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 10:21:45 -0700 (PDT)
Subject: Re: [PATCH 0/3] QEMU cpus.c refactoring part1
To: Claudio Fontana <cfontana@suse.de>, Alex Bennee <alex.bennee@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>
References: <20200629093504.3228-1-cfontana@suse.de>
 <771b3944-aa29-2926-21d3-3648900f8fea@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f37f342b-fec2-4f5f-02a3-44c3a97537ab@redhat.com>
Date: Fri, 3 Jul 2020 19:21:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <771b3944-aa29-2926-21d3-3648900f8fea@suse.de>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/07/20 08:27, Claudio Fontana wrote:
> Hi Alex, Markus, Paolo, 
> 
> maybe this could be queued in one of your queues?

Nevermind, Thunderbird was acting funny.  Queued all now.

Paolo

> Thanks a lot,
> 
> Claudio
> 
> On 6/29/20 11:35 AM, Claudio Fontana wrote:
>> Motivation and higher level steps:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg04628.html
>>
>> Previous series: [RFC RESEND v7 0/4] QEMU cpus.c refactoring
>>
>> This series is already reviewed, and is a split of the first three patches
>> from the previous series (RFC). The forth and last of the previous series
>> will then be posted separately.
>>
>> PREVIOUS DISCUSSIONS:
>>
>> * should we reorder patches or moves inside patches to avoid code going
>>   from cpus.c to softmmu/cpus.c and then again to softmmu/somethingelse.c ?
>>   (Philippe)
>>
>> * some questions about headers in include/softmmu (Philippe)
>>
>>
>> [SPLIT into TWO series, changed from RFC to PATCH]
>> ----
>>
>> v6 -> v7:
>>
>> * rebased changes on top of Pavel Dovgalyuk changes to dma-helpers.c
>>   "icount: make dma reads deterministic"
>>
>> ----
>>
>> v5 -> v6:
>>
>> * rebased changes on top of Emilio G. Cota changes to cpus.c
>>   "cpu: convert queued work to a QSIMPLEQ"
>>
>> * keep a pointer in cpus.c instead of a copy of CpusAccel
>>   (Alex)
>>
>> ----
>>
>>
>> v4 -> v5: rebase on latest master
>>
>> * rebased changes on top of roman series to remove one of the extra states for hvf.
>>   (Is the result now functional for HVF?)
>>
>> * rebased changes on top of icount changes and fixes to icount_configure and
>>   the new shift vmstate. (Markus)
>>
>> v3 -> v4:
>>
>> * overall: added copyright headers to all files that were missing them
>>   (used copyright and license of the module the stuff was extracted from).
>>   For the new interface files, added SUSE LLC.
>>
>> * 1/4 (move softmmu only files from root):
>>
>>   MAINTAINERS: moved softmmu/cpus.c to its final location (from patch 2)
>>
>> * 2/4 (cpu-throttle):
>>
>>   MAINTAINERS (to patch 1),
>>   copyright Fabrice Bellard and license from cpus.c
>>
>> * 3/4 (cpu-timers, icount):
>>
>>   - MAINTAINERS: add cpu-timers.c and icount.c to Paolo
>>
>>   - break very long lines (patchew)
>>
>>   - add copyright SUSE LLC, GPLv2 to cpu-timers.h
>>
>>   - add copyright Fabrice Bellard and license from cpus.c to timers-state.h
>>     as it is lifted from cpus.c
>>
>>   - vl.c: in configure_accelerators bail out if icount_enabled()
>>     and !tcg_enabled() as qtest does not enable icount anymore.
>>
>> * 4/4 (accel stuff to accel):
>>
>>   - add copyright SUSE LLC to files that mostly only consist of the
>>     new interface. Add whatever copyright was in the accelerator code
>>     if instead they mostly consist of accelerator code.
>>
>>   - change a comment to mention the result of the AccelClass experiment
>>
>>   - moved qtest accelerator into accel/qtest/ , make it like the others.
>>
>>   - rename xxx-cpus-interface to xxx-cpus (remove "interface" from names)
>>
>>   - rename accel_int to cpus_accel
>>
>>   - rename CpusAccel functions from cpu_synchronize_* to synchronize_*
>>
>>
>> --------
>>
>> v2 -> v3:
>>
>> * turned into a 4 patch series, adding a first patch moving
>>   softmmu code currently in top_srcdir to softmmu/
>>
>> * cpu-throttle: moved to softmmu/
>>
>> * cpu-timers, icount:
>>
>>   - moved to softmmu/
>>
>>   - fixed assumption of qtest_enabled() => icount_enabled()
>>   causing the failure of check-qtest-arm goal, in test-arm-mptimer.c
>>
>>   Fix is in hw/core/ptimer.c,
>>
>>   where the artificial timeout rate limit should not be applied
>>   under qtest_enabled(), in a similar way to how it is not applied
>>   for icount_enabled().
>>
>> * CpuAccelInterface: no change.
>>
>>
>> --------
>>
>>
>> v1 -> v2:
>>
>> * 1/3 (cpu-throttle): provide a description in the commit message
>>
>> * 2/3 (cpu-timers, icount): in this v2 separate icount from cpu-timers,
>>   as icount is actually TCG-specific. Only build it under CONFIG_TCG.
>>
>>   To do this, qtest had to be detached from icount. To this end, a
>>   trivial global counter for qtest has been introduced.
>>
>> * 3/3 (CpuAccelInterface): provided a description.
>>
>> This is point 8) in that plan. The idea is to extract the unrelated parts
>> in cpus, and register interfaces from each single accelerator to the main
>> cpus module (cpus.c).
>>
>> While doing this RFC, I noticed some assumptions about Windows being
>> either TCG or HAX (not considering WHPX) that might need to be revisited.
>> I added a comment there.
>>
>> The thing builds successfully based on Linux cross-compilations for
>> windows/hax, windows/whpx, and I got a good build on Darwin/hvf.
>>
>> Tests run successully for tcg and kvm configurations, but did not test on
>> windows or darwin.
>>
>> Welcome your feedback and help on this,
>>
>> Claudio
>>
>> Claudio Fontana (3):
>>   softmmu: move softmmu only files from root
>>   cpu-throttle: new module, extracted from cpus.c
>>   cpu-timers, icount: new modules
>>
>>  MAINTAINERS                                  |  15 +-
>>  Makefile.target                              |   7 +-
>>  accel/qtest.c                                |   6 +-
>>  accel/tcg/cpu-exec.c                         |  43 +-
>>  accel/tcg/tcg-all.c                          |   7 +-
>>  accel/tcg/translate-all.c                    |   3 +-
>>  dma-helpers.c                                |   4 +-
>>  docs/replay.txt                              |   6 +-
>>  exec.c                                       |   4 -
>>  hw/core/ptimer.c                             |   8 +-
>>  hw/i386/x86.c                                |   1 +
>>  include/exec/cpu-all.h                       |   4 +
>>  include/exec/exec-all.h                      |   4 +-
>>  include/hw/core/cpu.h                        |  37 --
>>  include/qemu/main-loop.h                     |   5 +
>>  include/qemu/timer.h                         |  22 +-
>>  include/sysemu/cpu-throttle.h                |  68 +++
>>  include/sysemu/cpu-timers.h                  |  81 +++
>>  include/sysemu/cpus.h                        |  12 +-
>>  include/sysemu/qtest.h                       |   2 +
>>  include/sysemu/replay.h                      |   4 +-
>>  migration/migration.c                        |   1 +
>>  migration/ram.c                              |   1 +
>>  replay/replay.c                              |   6 +-
>>  softmmu/Makefile.objs                        |  13 +
>>  arch_init.c => softmmu/arch_init.c           |   0
>>  balloon.c => softmmu/balloon.c               |   0
>>  softmmu/cpu-throttle.c                       | 122 ++++
>>  softmmu/cpu-timers.c                         | 284 +++++++++
>>  cpus.c => softmmu/cpus.c                     | 839 +--------------------------
>>  softmmu/icount.c                             | 499 ++++++++++++++++
>>  ioport.c => softmmu/ioport.c                 |   0
>>  memory.c => softmmu/memory.c                 |   0
>>  memory_mapping.c => softmmu/memory_mapping.c |   0
>>  qtest.c => softmmu/qtest.c                   |  34 +-
>>  softmmu/timers-state.h                       |  69 +++
>>  softmmu/vl.c                                 |   8 +-
>>  stubs/Makefile.objs                          |   3 +-
>>  stubs/clock-warp.c                           |   4 +-
>>  stubs/cpu-get-clock.c                        |   3 +-
>>  stubs/cpu-get-icount.c                       |  21 -
>>  stubs/icount.c                               |  22 +
>>  stubs/qemu-timer-notify-cb.c                 |   8 +
>>  stubs/qtest.c                                |   5 +
>>  target/alpha/translate.c                     |   3 +-
>>  target/arm/helper.c                          |   7 +-
>>  target/riscv/csr.c                           |   8 +-
>>  tests/ptimer-test-stubs.c                    |   7 +-
>>  tests/test-timed-average.c                   |   2 +-
>>  util/main-loop.c                             |   4 +-
>>  util/qemu-timer.c                            |  12 +-
>>  51 files changed, 1343 insertions(+), 985 deletions(-)
>>  create mode 100644 include/sysemu/cpu-throttle.h
>>  create mode 100644 include/sysemu/cpu-timers.h
>>  rename arch_init.c => softmmu/arch_init.c (100%)
>>  rename balloon.c => softmmu/balloon.c (100%)
>>  create mode 100644 softmmu/cpu-throttle.c
>>  create mode 100644 softmmu/cpu-timers.c
>>  rename cpus.c => softmmu/cpus.c (59%)
>>  create mode 100644 softmmu/icount.c
>>  rename ioport.c => softmmu/ioport.c (100%)
>>  rename memory.c => softmmu/memory.c (100%)
>>  rename memory_mapping.c => softmmu/memory_mapping.c (100%)
>>  rename qtest.c => softmmu/qtest.c (95%)
>>  create mode 100644 softmmu/timers-state.h
>>  delete mode 100644 stubs/cpu-get-icount.c
>>  create mode 100644 stubs/icount.c
>>  create mode 100644 stubs/qemu-timer-notify-cb.c
>>
> 



Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B92FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4CAB2071C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CAB2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdFHT-00051j-3K
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jdFGk-0004a2-UI
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:44:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:45278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jdFGk-0006Zc-0a
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:44:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 23FF8AC77;
 Mon, 25 May 2020 15:44:03 +0000 (UTC)
Subject: Re: [RFC v3 3/4] cpu-timers, icount: new modules
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200525145440.29728-1-cfontana@suse.de>
 <20200525145440.29728-4-cfontana@suse.de>
 <1a4eb7bb-9b92-7536-9de3-a7e56afd9da4@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <949ffed9-a6ef-fcb0-08c4-6bfedcf96cf6@suse.de>
Date: Mon, 25 May 2020 17:43:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1a4eb7bb-9b92-7536-9de3-a7e56afd9da4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:03:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Colin Xu <colin.xu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/20 5:16 PM, Philippe Mathieu-Daudé wrote:
> On 5/25/20 4:54 PM, Claudio Fontana wrote:
>> refactoring of cpus.c continues with cpu timer state extraction.
>>
>> cpu-timers: responsible for the cpu timers state, and for access to
>> cpu clocks and ticks.
>>
>> icount: counts the TCG instructions executed. As such it is specific to
>> the TCG accelerator. Therefore, it is built only under CONFIG_TCG.
>>
>> One complication is due to qtest, which misuses icount to warp time
>> (qtest_clock_warp). In order to solve this problem, detach instead qtest
>> from icount, and use a trivial separate counter for it.
>>
>> This requires fixing assumptions scattered in the code that
>> qtest_enabled() implies icount_enabled().
>>
>> No functionality change.
>>
>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
>> ---
>>  accel/qtest.c                |   6 +-
>>  accel/tcg/cpu-exec.c         |  43 ++-
>>  accel/tcg/tcg-all.c          |   7 +-
>>  accel/tcg/translate-all.c    |   3 +-
>>  docs/replay.txt              |   6 +-
>>  exec.c                       |   4 -
>>  hw/core/ptimer.c             |   6 +-
>>  hw/i386/x86.c                |   1 +
>>  include/exec/cpu-all.h       |   4 +
>>  include/exec/exec-all.h      |   4 +-
>>  include/qemu/timer.h         |  22 +-
>>  include/sysemu/cpu-timers.h  |  72 +++++
>>  include/sysemu/cpus.h        |  12 +-
>>  include/sysemu/qtest.h       |   2 +
>>  include/sysemu/replay.h      |   4 +-
>>  replay/replay.c              |   6 +-
>>  softmmu/Makefile.objs        |   2 +
>>  softmmu/cpu-timers.c         | 267 ++++++++++++++++
>>  softmmu/cpus.c               | 731 +------------------------------------------
>>  softmmu/icount.c             | 496 +++++++++++++++++++++++++++++
>>  softmmu/qtest.c              |  34 +-
>>  softmmu/timers-state.h       |  45 +++
>>  softmmu/vl.c                 |   8 +-
>>  stubs/Makefile.objs          |   3 +-
>>  stubs/clock-warp.c           |   4 +-
>>  stubs/cpu-get-clock.c        |   3 +-
>>  stubs/cpu-get-icount.c       |  21 --
>>  stubs/icount.c               |  22 ++
>>  stubs/qemu-timer-notify-cb.c |   8 +
>>  stubs/qtest.c                |   5 +
>>  target/alpha/translate.c     |   3 +-
>>  target/arm/helper.c          |   7 +-
>>  target/riscv/csr.c           |   8 +-
>>  tests/ptimer-test-stubs.c    |   7 +-
>>  tests/test-timed-average.c   |   2 +-
>>  util/main-loop.c             |   4 +-
>>  util/qemu-timer.c            |  12 +-
>>  37 files changed, 1062 insertions(+), 832 deletions(-)
>>  create mode 100644 include/sysemu/cpu-timers.h
>>  create mode 100644 softmmu/cpu-timers.c
>>  create mode 100644 softmmu/icount.c
>>  create mode 100644 softmmu/timers-state.h
>>  delete mode 100644 stubs/cpu-get-icount.c
>>  create mode 100644 stubs/icount.c
>>  create mode 100644 stubs/qemu-timer-notify-cb.c
> 
> Similarly I'd rather see this patch comes before your current #1 "move
> softmmu only files from root". Anyway wait for other reviewers before
> spending time to reorder the series.
> 
> 

I understand the desire to avoid moving cpus code back and forth,
will then wait for other comments as you suggest.

Ciao and thanks,

Claudio



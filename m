Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFF6C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B0D2087D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B0D2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqUF-0004a0-5U
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kLqHa-0007E1-EF
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:09:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:49766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kLqHX-0004TQ-Ah
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:09:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6057BAE19;
 Fri, 25 Sep 2020 16:09:08 +0000 (UTC)
Subject: Re: [PATCH v8 00/17] QEMU cpus.c refactoring part2
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200916142004.27429-1-cfontana@suse.de>
 <d0bb4af9-55a1-b332-af6f-7601dfb10db7@linaro.org>
 <402c303b-64a4-c2ed-151a-48f2e2cb40ac@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <66180c1d-f075-dd0c-cddc-bc26e511aef3@suse.de>
Date: Fri, 25 Sep 2020 18:09:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <402c303b-64a4-c2ed-151a-48f2e2cb40ac@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 00:10:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.238,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Colin Xu <colin.xu@intel.com>, haxm-team@intel.com,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Wenchao Wang <wenchao.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 3:09 PM, Paolo Bonzini wrote:
> On 18/09/20 21:00, Richard Henderson wrote:
>> On 9/16/20 7:19 AM, Claudio Fontana wrote:
>>> Motivation and higher level steps:
>>>
>>> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg04628.html
>>>
>>> Current state is mostly all reviewed, but I include here a few resolutions
>>> of rebasing conflicts and a new patch to use current_machine instead of
>>> qdev_get_machine in softmmu context.
>>>
>>> It's minor, but if additional reviewing is necessary, here is the whole series again.
>>>
>>> CI is all green, and also available at https://github.com/hw-claudio/qemu.git "cpus-refactoring"
>>>
>>> The following changes since commit 5a77bbb53b087f95dbba7ce30b02ac2d7b147a3a:
>>>
>>>   iotests: Work around failing readlink -f (2020-09-15 18:19:26 +0200)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://github.com/hw-claudio/qemu.git 
>>>
>>> for you to fetch changes up to f9ec667595537400a6bc0aaf094a5ca6bbaacf44:
>>>
>>>   accel/tcg: use current_machine as it is always set for softmmu (2020-09-15 18:19:27 +0200)
>>
>> Queuing this to tcg-next, with Phil's suggested change to current_machine in
>> the final patch.
> 
> This doesn't apply anymore, but I've fixed it up because I had it as a
> prerequisite for my next pull request.  If you want, I can shepherd it too.
> 
> Paolo
> 


Hi, if it is helpful I just rebased on latest master and pushed to

https://github.com/hw-claudio/qemu.git branch: "cpus-refactoring"

The following changes since commit d4277402b5e4645e4c7706a3221f8acd3f1a50f7:

  tests: add missing genh dependency (2020-09-25 14:10:56 +0200)

are available in the Git repository at:

  https://github.com/hw-claudio/qemu.git 

for you to fetch changes up to 4822a683c261c249e46d26cd65ff37cc1e1cfb94:

  accel/tcg: use current_machine as it is always set for softmmu (2020-09-25 17:34:07 +0200)

----------------------------------------------------------------
Claudio Fontana (17):
      cpu-timers, icount: new modules
      icount: rename functions to be consistent with the module name
      cpus: prepare new CpusAccel cpu accelerator interface
      cpus: extract out TCG-specific code to accel/tcg
      cpus: extract out qtest-specific code to accel/qtest
      cpus: extract out kvm-specific code to accel/kvm
      cpus: extract out hax-specific code to target/i386/
      cpus: extract out whpx-specific code to target/i386/
      cpus: extract out hvf-specific code to target/i386/hvf/
      cpus: cleanup now unneeded includes
      cpus: remove checks for non-NULL cpus_accel
      cpus: add handle_interrupt to the CpusAccel interface
      hvf: remove hvf specific functions from global includes
      whpx: remove whpx specific functions from global includes
      hax: remove hax specific functions from global includes
      kvm: remove kvm specific functions from global includes
      accel/tcg: use current_machine as it is always set for softmmu

 MAINTAINERS                    |    5 +-
 accel/kvm/kvm-all.c            |   14 +-
 accel/kvm/kvm-cpus.c           |   88 +++
 accel/kvm/kvm-cpus.h           |   24 +
 accel/kvm/meson.build          |    5 +-
 accel/meson.build              |    2 +-
 accel/qtest/meson.build        |    7 +
 accel/qtest/qtest-cpus.c       |   91 +++
 accel/qtest/qtest-cpus.h       |   17 +
 accel/{ => qtest}/qtest.c      |   13 +-
 accel/stubs/hax-stub.c         |   10 -
 accel/stubs/hvf-stub.c         |   30 -
 accel/stubs/kvm-stub.c         |   23 -
 accel/stubs/meson.build        |    2 -
 accel/stubs/whpx-stub.c        |   47 --
 accel/tcg/cpu-exec.c           |   43 +-
 accel/tcg/meson.build          |    2 +-
 accel/tcg/tcg-all.c            |   42 +-
 accel/tcg/tcg-cpus.c           |  579 ++++++++++++++
 accel/tcg/tcg-cpus.h           |   17 +
 accel/tcg/translate-all.c      |    3 +-
 dma-helpers.c                  |    4 +-
 docs/replay.txt                |    6 +-
 exec.c                         |    4 -
 hw/core/cpu.c                  |   14 +-
 hw/core/ptimer.c               |    8 +-
 hw/i386/x86.c                  |    3 +-
 include/exec/cpu-all.h         |    4 +
 include/exec/exec-all.h        |    4 +-
 include/hw/core/cpu.h          |   14 -
 include/qemu/timer.h           |   24 +-
 include/sysemu/cpu-timers.h    |   90 +++
 include/sysemu/cpus.h          |   50 +-
 include/sysemu/hax.h           |   17 -
 include/sysemu/hvf.h           |    8 -
 include/sysemu/hw_accel.h      |   69 +-
 include/sysemu/kvm.h           |    7 -
 include/sysemu/qtest.h         |    2 +
 include/sysemu/replay.h        |    4 +-
 include/sysemu/whpx.h          |   19 -
 replay/replay.c                |    6 +-
 softmmu/cpu-timers.c           |  279 +++++++
 softmmu/cpus.c                 | 1706 +++-------------------------------------
 softmmu/icount.c               |  492 ++++++++++++
 softmmu/meson.build            |   10 +-
 softmmu/qtest.c                |   34 +-
 softmmu/timers-state.h         |   69 ++
 softmmu/vl.c                   |    8 +-
 stubs/clock-warp.c             |    7 -
 stubs/cpu-get-clock.c          |    3 +-
 stubs/cpu-get-icount.c         |   16 -
 stubs/cpu-synchronize-state.c  |    9 +
 stubs/cpus-get-virtual-clock.c |    8 +
 stubs/icount.c                 |   45 ++
 stubs/meson.build              |    6 +-
 stubs/qemu-timer-notify-cb.c   |    2 +-
 stubs/qtest.c                  |    5 +
 target/alpha/translate.c       |    3 +-
 target/arm/helper.c            |    7 +-
 target/i386/hax-all.c          |   17 +-
 target/i386/hax-cpus.c         |   84 ++
 target/i386/hax-cpus.h         |   33 +
 target/i386/hax-i386.h         |    2 +
 target/i386/hax-mem.c          |    2 +-
 target/i386/hax-posix.c        |   13 +-
 target/i386/hax-windows.c      |   22 +-
 target/i386/hax-windows.h      |    2 +
 target/i386/hvf/hvf-cpus.c     |  131 +++
 target/i386/hvf/hvf-cpus.h     |   25 +
 target/i386/hvf/hvf.c          |   12 +-
 target/i386/hvf/meson.build    |    1 +
 target/i386/hvf/x86hvf.c       |    2 +
 target/i386/hvf/x86hvf.h       |    1 -
 target/i386/meson.build        |   14 +-
 target/i386/whpx-all.c         |   13 +-
 target/i386/whpx-cpus.c        |   96 +++
 target/i386/whpx-cpus.h        |   34 +
 target/riscv/csr.c             |    8 +-
 tests/ptimer-test-stubs.c      |    5 +-
 tests/test-timed-average.c     |    2 +-
 util/main-loop.c               |   12 +-
 util/qemu-timer.c              |   14 +-
 82 files changed, 2639 insertions(+), 2036 deletions(-)
 create mode 100644 accel/kvm/kvm-cpus.c
 create mode 100644 accel/kvm/kvm-cpus.h
 create mode 100644 accel/qtest/meson.build
 create mode 100644 accel/qtest/qtest-cpus.c
 create mode 100644 accel/qtest/qtest-cpus.h
 rename accel/{ => qtest}/qtest.c (81%)
 delete mode 100644 accel/stubs/hvf-stub.c
 delete mode 100644 accel/stubs/whpx-stub.c
 create mode 100644 accel/tcg/tcg-cpus.c
 create mode 100644 accel/tcg/tcg-cpus.h
 create mode 100644 include/sysemu/cpu-timers.h
 create mode 100644 softmmu/cpu-timers.c
 create mode 100644 softmmu/icount.c
 create mode 100644 softmmu/timers-state.h
 delete mode 100644 stubs/clock-warp.c
 delete mode 100644 stubs/cpu-get-icount.c
 create mode 100644 stubs/cpu-synchronize-state.c
 create mode 100644 stubs/cpus-get-virtual-clock.c
 create mode 100644 stubs/icount.c
 create mode 100644 target/i386/hax-cpus.c
 create mode 100644 target/i386/hax-cpus.h
 create mode 100644 target/i386/hvf/hvf-cpus.c
 create mode 100644 target/i386/hvf/hvf-cpus.h
 create mode 100644 target/i386/whpx-cpus.c
 create mode 100644 target/i386/whpx-cpus.h


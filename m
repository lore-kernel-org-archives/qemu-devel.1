Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E039C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 07:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087422075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 07:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087422075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jax5P-000073-55
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 03:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jax4Y-000877-No
 for qemu-devel@nongnu.org; Tue, 19 May 2020 03:53:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:55652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jax4X-0007gz-FK
 for qemu-devel@nongnu.org; Tue, 19 May 2020 03:53:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5E0A8AD94;
 Tue, 19 May 2020 07:53:58 +0000 (UTC)
Subject: Re: sharing intention for developing per-target, dynamically loadable
 accelerator modules
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <1b5c9fee-6574-ddf4-b2d0-aa12e6fc9c84@suse.de>
 <87k119jeee.fsf@linaro.org>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <350b2ad7-b92d-659b-481a-e41fe7cfc738@suse.de>
Date: Tue, 19 May 2020 09:53:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87k119jeee.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 01:02:41
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 8:18 PM, Alex Bennée wrote:
> 
> Claudio Fontana <cfontana@suse.de> writes:
> 
>> Hello all,
>>
>> my intention would be to develop per-target, dynamically loadable accelerator modules.
>>
>> This would allow to distribute a single QEMU base binary, and then provide accelerators as optional additional binary packages to install,
>> with the first separate optional package being TCG.
>>
>> CONFIG_TCG would become 'm' as a result, but then also CONFIG_KVM, CONFIG_HAX, CONFIG_WHPX, CONFIG_HVF.
>>
>> Here are some elements that seem to be needed:
>>
>> 1 - The module CONFIG_MODULE part of the build system would need some extension to add per-target modules. I have some tentative results that shows that this is possible (but a bit clunky atm).
>>     There is some existing instability in the existing Makefile infrastructure of modules that shows up when trying to extend it.
>>
>> 2 - new "accelerator drivers" seems to be needed, either in addition or as additional functionality inside the current AccelState.
>>
>> 3 - for target/i386 in particular, there is some refactoring work needed to split even more different unrelated bits and pieces.
>>     dependencies of hw/i386 machine stuff with accelerator-specific
>> stuff are also painful.
> 
> There are a couple of per-arch hacks in the main TCG cpu loops it would
> be good to excise from the code.
> 
>>
>> 4 - CPU Arch Classes could be extended with per-accelerator methods. Initial fooling around shows it should probably work.
>>     One alternative would be trying to play with the dynamic linker (weak symbols, creative use of dlsym etc), but I have not sorted out the details of this option.
>>
>> 5 - cputlb, in particular tlb_flush and friends is a separate problem
>> since it is not part of the cpuclass. Should it be?
> 
> tlb_flush and friends are TCG implementation details for softmmu that
> ensure a lookup for any address will always return to a guest specific
> tlb_fill to rebuild the cache. The behaviour is not guest-specific
> per-se although we do partition the table entries based on the guest
> size.
> 
> Perhaps we can make it more dynamic but it would have to ensure both the
> slow path and the fast path are using the same mask and shifts when
> walking the table.
> 
>> 6 - a painpoint is represented by the fact that in USER mode, the accel class is not applied, which causes a lot of uncleanliness all around
>>     (tcg_allowed outside of the AccelClass).
> 
> The user-mode run loops are a whole separate chunk of code. I don't know
> if it is worth trying to make them plugable as you will only ever have
> one per linux-user binary.
> 
>> 7 - I have not really thought about the KConfig aspects because I am not super-familiar
>>
>> 8 - cpus.c needs some good splitting
> 
> Although there are several different run loops in there I think they
> share a lot of commonality which is why they are bundled together. They
> all share the same backend for dealing with ioevents and generic
> pause/unpause machinery. But feel free to prove me wrong ;-)

Hi Alex, I got my first compile, and it is currently in github, I still need to split the series though and there is still cleanup needed.

https://github.com/hw-claudio/qemu.git
branch "cpus-refactoring"

just in case you are interested in a peek.

The idea results currently in:

 cpu-throttle.c                |  154 +++++++++
 cpu-timers.c                  |  784 +++++++++++++++++++++++++++++++++++++++++++++
 cpus-tcg.c                    |  515 ++++++++++++++++++++++++++++++
 cpus.c                        | 1405 +++++----------------------------------------------------------------------------

New interfaces are in:

include/sysemu/cpu-throttle.h |   50 +++
include/sysemu/cpu-timers.h   |   73 +++++
include/sysemu/cpus.h         |   44 ++-

cpu-throttle (new) is self-explanatory, contains the cpu-throttle in cpus.c
cpu-timers (new) contains the icount, ticks, clock timers from cpus.c

cpus.h adds an interface to per-accel vcpu threads:

qemu_register_start_vcpu(void (*f)(CPUState *cpu));
bool all_cpu_threads_idle(void);
bool cpu_can_run(CPUState *cpu);
void qemu_wait_io_event_common(CPUState *cpu);
void qemu_wait_io_event(CPUState *cpu);
void cpu_thread_signal_created(CPUState *cpu);
void cpu_thread_signal_destroyed(CPUState *cpu);
void cpu_handle_guest_debug(CPUState *cpu);

Very much still all WIP...

Ciao,

C


> 
>> ... more things to find out and think about ...
>>
>> Overall, I think that the activity has the potential to provide benefits overall beyond the actual goal, in the form of cleanups, leaner configurations,
>> minor fixes, maybe improving the CONFIG_MODULE instabilities if any
>> etc.
> 
> There are certainly some ugly bits we could shave down in such an
> exercise.
> 
>> As an example, the first activity I would plan to submit as RFC is point 8 above,
>> there is the split between cpus.c and cpus-tcg.c that results in lots of TCG-specific code being removed from non-tcg builds (using CONFIG_TCG).
>>
>> One thing that should be kept in check is any performance impact of
>> the changes, in particular for point 4, hot paths should probably
>> avoid going through too many pointer indirections.
> 
> Maybe - certainly for TCG you have pretty much lost if you have exited
> the main execution loop I doubt it would show up much. Not so sure about
> the HW accelerators. Most of the performance sensitive stuff is dealt
> with close to the ioctls IIRC.
> 
>> Does anybody share similar goals? Any major obstacle or blocker that would put the feasibility into question?
>> Any suggestion on any of this? In particular point 4 and 5 come to
>> mind, as well as some better understanding of the reasons behind 6, or
>> even suggestions on how to best to 2.
> 
> For linux-user each CPU run loop is it's own special snowflake because
> pretty much every architecture has it's own special set of EXCP_ exits
> to deal with various bits. There are per-arch EXCP_ flags for system
> emulation as well but not nearly as many.
> 
>>
>> Anyway, I will continue to work on the first RFC for some smaller initial steps and hopefully have something to submit soon.
>>
>> Ciao ciao,
>>
>> Claudio
> 
> 



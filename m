Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439DEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B4A321744
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B4A321744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3EzE-0004sl-AF
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 04:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k3EyW-0003zn-0k
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:40:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:36016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k3EyU-0007kp-3u
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:40:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C1F42B653;
 Wed,  5 Aug 2020 08:40:51 +0000 (UTC)
Subject: Re: [RFC v3 2/8] cpus: prepare new CpusAccel cpu accelerator interface
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200803090533.7410-1-cfontana@suse.de>
 <20200803090533.7410-3-cfontana@suse.de>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <cf676419-09e6-4c36-c511-031edddf8cba@suse.de>
Date: Wed, 5 Aug 2020 10:40:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200803090533.7410-3-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 00:43:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Wenchao Wang <wenchao.wang@intel.com>, haxm-team@intel.com,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

could you give a check to this detail, marked as a comment here?

While doing the refactoring and looking at the history,
I _think_ I noticed something that could be wrong related to whpx and hax,

and I marked this as a comment. Maybe Paolo?


On 8/3/20 11:05 AM, Claudio Fontana wrote:
[...]

  
> -static void qemu_wait_io_event(CPUState *cpu)
> +void qemu_wait_io_event(CPUState *cpu)
>  {
>      bool slept = false;
>  
> @@ -437,7 +538,8 @@ static void qemu_wait_io_event(CPUState *cpu)
>      }
>  
>  #ifdef _WIN32
> -    /* Eat dummy APC queued by qemu_cpu_kick_thread.  */
> +    /* Eat dummy APC queued by qemu_cpu_kick_thread. */
> +    /* NB!!! Should not this be if (hax_enabled)? Is this wrong for whpx? */
>      if (!tcg_enabled()) {
>          SleepEx(0, TRUE);
>      }


Looking at the history here, I think this should be if (hax_enabled());
this check was added at a time when whpx did not exist, so I _think_ there might have been an assumption here
that !tcg_enabled() on windows means actually hax_enabled() for eating this dummy APC.

Probably it does not cause problems, because whpx does not end up calling qemu_wait_io_event,
instead it calls qemu_wait_io_event_common. But it would be more expressive to use if (hax_enabled()) I think.

Could be separately patched.. relevant commits in history follow.

Thanks,

Claudio


commit db08b687cdd5319286665aabd34f82665630416f
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu Jan 11 13:53:12 2018 +0100

    cpus: unify qemu_*_wait_io_event
    
    Except for round-robin TCG, every other accelerator is using more or
    less the same code around qemu_wait_io_event_common.  The exception
    is HAX, which also has to eat the dummy APC that is queued by
    qemu_cpu_kick_thread.
    
    We can add the SleepEx call to qemu_wait_io_event under "if
    (!tcg_enabled())", since that is the condition that is used in
    qemu_cpu_kick_thread, and unify the function for KVM, HAX, HVF and
    multi-threaded TCG.  Single-threaded TCG code can also be simplified
    since it is only used in the round-robin, sleep-if-all-CPUs-idle case.
    
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>


commit 19306806ae30b7fb5fe61a9130c6995402acad00
Author: Justin Terry (VM) <juterry@microsoft.com>
Date:   Mon Jan 22 13:07:49 2018 -0800

    Add the WHPX acceleration enlightenments
    
    Implements the WHPX accelerator cpu enlightenments to actually use the whpx-all
    accelerator on Windows platforms.
    
    Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
    Message-Id: <1516655269-1785-5-git-send-email-juterry@microsoft.com>
    [Register/unregister VCPU thread with RCU. - Paolo]
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

commit b0cb0a66d6d535112aa513568ef21dcb1ad283ed
Author: Vincent Palatin <vpalatin@chromium.org>
Date:   Tue Jan 10 11:59:57 2017 +0100

    Plumb the HAXM-based hardware acceleration support
    
    Use the Intel HAX is kernel-based hardware acceleration module for
    Windows (similar to KVM on Linux).
    
    Based on the "target/i386: Add Intel HAX to android emulator" patch
    from David Chou <david.j.chou@intel.com>
    
    Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
    Message-Id: <7b9cae28a0c379ab459c7a8545c9a39762bd394f.1484045952.git.vpalatin@chromium.org>
    [Drop hax_populate_ram stub. - Paolo]
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>









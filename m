Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63389C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36AF520720
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36AF520720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtBa7-0006wI-Ei
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 11:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jtBYZ-00065g-GE
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:00:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:42250)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jtBYX-00073O-6h
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:00:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 35F6AAFCD;
 Wed,  8 Jul 2020 15:00:16 +0000 (UTC)
Subject: Re: [PATCH 3/3] cpu-timers, icount: new modules
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200629093504.3228-1-cfontana@suse.de>
 <20200629093504.3228-4-cfontana@suse.de>
 <aa45a793-35b1-d3bd-18a8-4c52ad888029@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <f89f249d-dbc4-779b-5b53-fc408461f072@suse.de>
Date: Wed, 8 Jul 2020 17:00:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <aa45a793-35b1-d3bd-18a8-4c52ad888029@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:20:38
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/20 4:34 PM, Paolo Bonzini wrote:
> On 29/06/20 11:35, Claudio Fontana wrote:
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
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
> Claudio,
> 
> this weirdly enough causes iotest 267 (i.e. basically vmstate
> save/restore) to break on s390:
> 
> +Unexpected storage key flag data: 0
> +error while loading state for instance 0x0 of device 's390-skeys'
> +Error: Error -22 while loading VM state
> 
> Bisectable, 100% failure rate, etc. :(  Can you split the patch in
> multiple parts, specifically separating any rename or introducing of
> includes from the final file move?

Hi Paolo,

will take a look!

Is this captured by some travis / cirrus-ci / anything I can easily see the result of?


> 
> Also, the patch breaks --disable-tcg, which is easily fixed by changing
> the prototype for icount_enabled() to
> 
> 	#if defined CONFIG_TCG || !defined NEED_CPU_H
> 	extern bool icount_enabled(void);
> 	#else
> 	#define icount_enabled() 0
> 	#endif
> 
> (This way, more TCG-only code in cpus.c gets elided).  You can integrate
> this change in the next version.
> 
> Paolo
> 

Weird, I tested with --disable-tcg explicitly (but may be some time ago now, as I constantly rebased).

Will take a look at the introduction of this #defines in place of variables,
as this mechanisms will not work in the future for target-specific modules.

Ciao, will let you know what I find,

Claudio




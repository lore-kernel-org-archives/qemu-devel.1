Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF263C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B42AB206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42AB206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtC2T-0005EF-Vu
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 11:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jtC1U-0004Z5-A4
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:30:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:55298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jtC1S-0004bS-E5
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:30:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7B159AEC1;
 Wed,  8 Jul 2020 15:30:09 +0000 (UTC)
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
 <f89f249d-dbc4-779b-5b53-fc408461f072@suse.de>
 <ecf5f26b-ce86-3e13-5c5c-567919433acb@redhat.com>
 <46322ba4-8aff-e8d6-8a1c-ea1043098624@suse.de>
 <bc76504a-0d81-7f81-42fd-c70d8cc13bc5@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <db4b0418-9b60-f456-08be-8f20472dbbb3@suse.de>
Date: Wed, 8 Jul 2020 17:30:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <bc76504a-0d81-7f81-42fd-c70d8cc13bc5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 7/8/20 5:23 PM, Paolo Bonzini wrote:
> On 08/07/20 17:17, Claudio Fontana wrote:
>> On 7/8/20 5:05 PM, Paolo Bonzini wrote:
>>> On 08/07/20 17:00, Claudio Fontana wrote:
>>>>> Bisectable, 100% failure rate, etc. :(  Can you split the patch in
>>>>> multiple parts, specifically separating any rename or introducing of
>>>>> includes from the final file move?
>>>> Hi Paolo,
>>>>
>>>> will take a look!
>>>>
>>>> Is this captured by some travis / cirrus-ci / anything I can easily see the result of?
>>>>
>>>>
>>>
>>> Nope, unfortunately we don't have an s390 CI.  But if you can get your
>>> hands on one, just "./configure --target-list=s390x-softmmu && make &&
>>> make check-block" will show it.
>>>
>>>>>
>>>>> 	#if defined CONFIG_TCG || !defined NEED_CPU_H
>>>>> 	extern bool icount_enabled(void);
>>>>> 	#else
>>>>> 	#define icount_enabled() 0
>>>>> 	#endif
>>>>>
>>>>> (This way, more TCG-only code in cpus.c gets elided).  You can integrate
>>>>> this change in the next version.
>>>>>
>>>>> Paolo
>>>>>
>>>>
>>>> Weird, I tested with --disable-tcg explicitly (but may be some time ago now, as I constantly rebased).
>>>>
>>>> Will take a look at the introduction of this #defines in place of variables,
>>>> as this mechanisms will not work in the future for target-specific modules.
>>>
>>> This is only done for per-target files so it should not be a problem.
>>>
>>> Paolo
>>>
>>
>> K, I tried with latest master, disable-tcg build still works for me on x86, so it is something in queue I guess?
> 
> Peter reported the issue in the v1 pull request; there were two
> different breakages but the cpus.c one was yours.
> 
> Paolo
> 

I see, since I don't manage to reproduce the problem at the moment, I will wait for master to be updated, after which I expect the issue to become apparent.

As of now, I do

configure --disable-tcg
make -j120

which works for me, based on latest master.

Ciao,

C


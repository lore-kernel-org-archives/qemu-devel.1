Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86F2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C37AB2177B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37AB2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3F8k-0003rQ-1U
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 04:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k3F7v-0002oR-FP
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:50:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:43794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k3F7t-0000La-TU
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:50:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2D966AC12;
 Wed,  5 Aug 2020 08:50:37 +0000 (UTC)
Subject: Re: [RFC v3 2/8] cpus: prepare new CpusAccel cpu accelerator interface
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200803090533.7410-1-cfontana@suse.de>
 <20200803090533.7410-3-cfontana@suse.de>
 <cf676419-09e6-4c36-c511-031edddf8cba@suse.de>
 <5594481c-e887-e48e-630b-c9ebbe542212@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <92648e68-b2ac-83a5-40de-16f48fb2a28c@suse.de>
Date: Wed, 5 Aug 2020 10:50:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5594481c-e887-e48e-630b-c9ebbe542212@redhat.com>
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

On 8/5/20 10:47 AM, Paolo Bonzini wrote:
> On 05/08/20 10:40, Claudio Fontana wrote:
>>>  #ifdef _WIN32
>>> -    /* Eat dummy APC queued by qemu_cpu_kick_thread.  */
>>> +    /* Eat dummy APC queued by qemu_cpu_kick_thread. */
>>> +    /* NB!!! Should not this be if (hax_enabled)? Is this wrong for whpx? */
>>>      if (!tcg_enabled()) {
>>>          SleepEx(0, TRUE);
>>>      }
>>
>> Looking at the history here, I think this should be if (hax_enabled());
>> this check was added at a time when whpx did not exist, so I _think_ there might have been an assumption here
>> that !tcg_enabled() on windows means actually hax_enabled() for eating this dummy APC.
> 
> Yes, that matches the condition under which QueueUserAPC is called in
> qemu_cpu_kick_thread.
> 
> Paolo
> 
>> Probably it does not cause problems, because whpx does not end up calling qemu_wait_io_event,
>> instead it calls qemu_wait_io_event_common. But it would be more expressive to use if (hax_enabled()) I think.
> 

Thanks for the clarification, indeed,
I'd then convert it to hax_enabled() in the series then, because this allows removing an extra include in cpus.c

(no need to check for tcg_enabled() in cpus.c anymore)...

thanks,

Claudio


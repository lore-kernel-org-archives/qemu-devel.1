Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EDDC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 12:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 369CB2076A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 12:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369CB2076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juEwd-0000P5-Gu
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 08:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1juEw5-0008P3-Qg
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 08:48:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:54654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1juEw3-0000qo-OE
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 08:48:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EBE9CAD12;
 Sat, 11 Jul 2020 12:48:53 +0000 (UTC)
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
 <e9dca3d1-f52d-13ce-2d7d-66958bc15765@suse.de>
 <996dc455-548e-5964-9c87-f4abe5b63907@redhat.com>
 <146b0cf2-509b-6a48-e82b-b93740e4c60d@redhat.com>
 <e3cc11a4-8ba7-917a-844b-4f6ec69d140a@suse.de>
 <76aac4ac-40f5-4870-ed2b-bab8b68b0a64@redhat.com>
 <9630c685-0a37-a1e7-4614-9d692988a799@suse.de>
 <22228280-f3b4-3f64-d2ba-30cfc47c8b0d@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <9d11375f-6893-76f1-0110-ee48ab657d4d@suse.de>
Date: Sat, 11 Jul 2020 14:48:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <22228280-f3b4-3f64-d2ba-30cfc47c8b0d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 23:52:14
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/11/20 2:19 PM, Paolo Bonzini wrote:
> On 11/07/20 13:49, Claudio Fontana wrote:
>>> Apart from the name, icount is more like deterministic execution than
>>
>> Maybe we should start choosing names more carefully in a way to express what we mean?
> 
> I don't disagree.  For icount in particular however we're about 12 years
> too late.
> 
>>>  qtests need to be deterministic and
>>> describe which qtest instructions run before a given timer fires and
>>> which run after.
>>>
>>> And in both cases, determinism is achieved by controlling the
>>> advancement of QEMU_CLOCK_VIRTUAL.  It's only this central component of
>>> icount that is shared by qtest and TCG, and I think the problem is that
>>> this patch conflates all of them together:
>>
>> I think that the existing code in master conflates them together actually.
>> Qtest can have its own counter, it does not need to be the icount
>> instruction counter.
> 
> If you want you can add to your accelerator ops series one for
> qemu_get_clock_ns(QEMU_CLOCK_VIRTUAL), cpu_get_ticks() and
> qemu_start_warp_timer(), that would certainly work for me; those three
> are the only non-TCG-specific functions that read use_icount, as far as
> I can see.  qemu_start_warp_timer() does have an "if (qtest_enabled())"
> even, so it's clearly fishy.
> 
> It may even be a good idea for TCG to have three sets of accelerator ops
> for respectively multi-threaded, round-robin and icount.
> 
> My point is that this patch is not the right way to start the
> refactoring because *for now* it's wrong to treat icount as a TCG-only
> concept.  Having more separation between accelerators, as well as a
> clear interface between core and accelerators is certainly a laudable
> goal though.
> 
>>> - the basic "is QEMU_CLOCK_VIRTUAL software-driven" part is embedded in
>>> qemu-timer and should not be carved out into a separate module.  This
>>> includes the use_icount variable, which should be kept in core QEMU code.
>>
>> I don't see how this follows, how is using a global use_icount variable better than having this checked using icount_enabled()?
> 
> If you can get rid of use_icount using a new accelerator ops member, it
> would be even better. :)
> 
>> I will come back to this later on, this patch seems to have uncovered an underlying issue, which shows on s390.
>>
>> I'd rather now continue investigating that, choosing to try to
>> actually understand the issue, rather than hiding it under the
>> carpet.
> 
> Thanks.  But I don't think it's sweeping anything under the carpet; it's
> great if we find a currently latent s390 bug, but it is orthogonal to
> the design of that core<->accelerator interface.

Yes, absolutely this is what I wanted to express.

I would like to find out what the problem is that appears in s390,
I am not sure though that it is actually an s390-specific problem, it could even be a migration qemu-file issue,
as apparently just flushing with qemu_fflush(f) "fixes" it.

My patch made the stream a bit smaller, and changed the layout of the s390-skeys, which have an interesting field length (32768),
I wonder if I got just the right alignment to trigger a bug where the qemu-file buffer is not properly flushed.

> 
> (And by the way, my suggested patch to icount_enabled() was completely
> wrong!).
> 
> Paolo
> 
> 

We will come back to this later, thanks a lot for the exchange!

Ciao,

Claudio


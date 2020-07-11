Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C79EC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 09:15:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E5FC206F0
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 09:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5FC206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juBbF-0000L5-GI
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 05:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1juBaa-0008NO-6n
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 05:14:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:42656)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1juBaY-0001mr-EU
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 05:14:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2F261AB3D;
 Sat, 11 Jul 2020 09:14:29 +0000 (UTC)
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
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <e3cc11a4-8ba7-917a-844b-4f6ec69d140a@suse.de>
Date: Sat, 11 Jul 2020 11:14:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <146b0cf2-509b-6a48-e82b-b93740e4c60d@redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/11/20 12:45 AM, Paolo Bonzini wrote:
> On 10/07/20 06:36, Thomas Huth wrote:
>>
>> In short this goes away if I again set icount to enabled for qtest,
>> basically ensuring that --enable-tcg is there and then reenabling icount.
>>
>> qtest was forcing icount and shift=0 by creating qemu options, in order to misuse its counter feature,
>> instead of using a separate counter.
> 
> Why would it need a separate counter?  In both cases it's a
> manually-updated counter that is used for QEMU_CLOCK_VIRTUAL.  The only
> difference is that shift > 0 doesn't make sense for qtest.
> 
> Paolo
> 

I think I would reverse the question. Why reuse for qtest a counter that has absolutely nothing to do with it?

qtest has nothing to do with instruction counting.

Keeping the relationship between qtest and the icount module means that
functionality of icount cannot be carved out into a separate module that is only included with tcg.

Ciao,

CLaudio


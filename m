Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A9DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2263B2071C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2263B2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdFAk-0006yN-Cg
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jdFAC-0006Wh-FP
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:37:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:41514)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jdFAB-0005Ho-Ek
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:37:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 25F22ABE2;
 Mon, 25 May 2020 15:37:15 +0000 (UTC)
Subject: Re: [RFC v3 1/4] softmmu: move softmmu only files from root
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200525145440.29728-1-cfontana@suse.de>
 <20200525145440.29728-2-cfontana@suse.de>
 <871bcac5-ee79-d9cd-817a-98666849e8a6@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <f886b539-6dcf-80b3-6cbc-8b6e7ed26109@suse.de>
Date: Mon, 25 May 2020 17:37:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <871bcac5-ee79-d9cd-817a-98666849e8a6@redhat.com>
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
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Roman Bolshakov <r.bolshakov@yadro.com>, haxm-team@intel.com,
 Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/20 5:12 PM, Philippe Mathieu-Daudé wrote:
> On 5/25/20 4:54 PM, Claudio Fontana wrote:
>> move arch_init, balloon, cpus, ioport, memory, memory_mapping, qtest.
>>
>> They are all specific to CONFIG_SOFTMMU.
>>
>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
>> ---
>>  MAINTAINERS                                  | 12 ++++++------
>>  Makefile.target                              |  7 ++-----
>>  softmmu/Makefile.objs                        | 10 ++++++++++
>>  arch_init.c => softmmu/arch_init.c           |  0
> 
> OK.
> 
>>  balloon.c => softmmu/balloon.c               |  0
> 
> OK
> 
>>  cpus.c => softmmu/cpus.c                     |  0
> 
> I'm still not 100% convinced.

Hi Philippe, do you see a reason to keep cpus.c in the top_srcdir?

The way I see it, it belongs in softmmu/,

we have a separate cpu-common.c that is target-indep and in common between user and softmmu,
while cpus.c is softmmu-only right?


> 
>>  ioport.c => softmmu/ioport.c                 |  0
> 
> OK
> 
>>  memory.c => softmmu/memory.c                 |  0
> 
> OK
> 
>>  memory_mapping.c => softmmu/memory_mapping.c |  0
> 
> I am not sure (yet).

headers are already in sysemu (sysemu/memory_mapping.h)

> 
>>  qtest.c => softmmu/qtest.c                   |  0
> 
> This one seems to belong to accel/

We already have accel/qtest.c , that is the qtest AccelClass.

Here we are talking about qtest.c from the top_srcdir, which it the
qtest server and is built with softmmu code, with header in sysemu/qtest.h

Thomas?

>>  10 files changed, 18 insertions(+), 11 deletions(-)
>>  rename arch_init.c => softmmu/arch_init.c (100%)
>>  rename balloon.c => softmmu/balloon.c (100%)
>>  rename cpus.c => softmmu/cpus.c (100%)
>>  rename ioport.c => softmmu/ioport.c (100%)
>>  rename memory.c => softmmu/memory.c (100%)
>>  rename memory_mapping.c => softmmu/memory_mapping.c (100%)
>>  rename qtest.c => softmmu/qtest.c (100%)
> 
> What about the corresponding headers?

headers already in sysemu/ :

sysemu/arch_init.h
sysemu/balloon.h
sysemu/cpus.h
sysemu/qtest.h - (again, for the qtest server)
sysemu/memory_mapping.h

headers currently in exec/ :

exec/memory.h
exec/ioport.h

Paolo?

> 
> [...]
> 



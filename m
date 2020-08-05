Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A52C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 11:50:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A6222D03
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 11:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HftU6+BN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A6222D03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3HwE-0003dU-Dv
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 07:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3HvZ-0003E5-Hx
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 07:49:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40254
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3HvW-0006hQ-FT
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 07:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596628185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=njhWcbukVV2h1TsMTJw231NAf03r13z89cs/CFBn98Y=;
 b=HftU6+BN3BQHZr155+v7pTwAurrN0TzWt6iY3PTcob7zKxNpKgbbeEJQFUCJKRS4JVGMRW
 johg+9ZZ/08zln/9v2HCtejexY/gWAeEQmQNRDjn/Y9CKuEmUquZ+kcsZri9kHgOnNBztA
 jO41jPlY0p/dTZlc9BTf526QhkGr5GY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-AafdwiSqNPO0tiDP0Ul5RQ-1; Wed, 05 Aug 2020 07:49:42 -0400
X-MC-Unique: AafdwiSqNPO0tiDP0Ul5RQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 050F680183C;
 Wed,  5 Aug 2020 11:49:41 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-142.ams2.redhat.com [10.36.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA13B7B90D;
 Wed,  5 Aug 2020 11:49:36 +0000 (UTC)
Subject: Re: [PATCH-for-5.1 v2 2/2] stubs: Remove qemu_notify_event()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200805085526.9787-1-philmd@redhat.com>
 <20200805085526.9787-3-philmd@redhat.com>
 <6846f9a0-ba29-059a-e400-603116f5bb69@redhat.com>
 <38110319-24ea-9a1d-0274-f09f5d33527a@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <effa1326-e4fe-bf45-3ca2-e22cb1ce096b@redhat.com>
Date: Wed, 5 Aug 2020 13:49:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <38110319-24ea-9a1d-0274-f09f5d33527a@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 04:10:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/08/2020 11.59, Philippe Mathieu-Daudé wrote:
> On 8/5/20 11:42 AM, Philippe Mathieu-Daudé wrote:
>> On 8/5/20 10:55 AM, Philippe Mathieu-Daudé wrote:
>>> We don't need the qemu_notify_event() stub anymore.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>>  stubs/cpu-get-icount.c | 2 +-
>>>  stubs/notify-event.c   | 6 ------
>>>  stubs/Makefile.objs    | 1 -
>>>  3 files changed, 1 insertion(+), 8 deletions(-)
>>>  delete mode 100644 stubs/notify-event.c
>>>
>>> diff --git a/stubs/cpu-get-icount.c b/stubs/cpu-get-icount.c
>>> index b35f844638..8962dfd71f 100644
>>> --- a/stubs/cpu-get-icount.c
>>> +++ b/stubs/cpu-get-icount.c
>>> @@ -17,5 +17,5 @@ int64_t cpu_get_icount_raw(void)
>>>  
>>>  void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
>>>  {
>>> -    qemu_notify_event();
>>> +    abort();
>>
>> This abort makes iotest 077 fail.
>> I think I'll simply repost without it.
> 
> I don't understand what from 077 trigger this callback, but
> I confirm doing nothing is safe, ...
> 
>>
>>>  }
>>> diff --git a/stubs/notify-event.c b/stubs/notify-event.c
>>> deleted file mode 100644
>>> index 827bb52d1a..0000000000
>>> --- a/stubs/notify-event.c
>>> +++ /dev/null
>>> @@ -1,6 +0,0 @@
>>> -#include "qemu/osdep.h"
>>> -#include "qemu/main-loop.h"
>>> -
>>> -void qemu_notify_event(void)
>>> -{
> 
> ... as this is the current behavior.

But could we maybe end up in a scenario, where the stub from
stubs/cpu-get-icount.c is used, which then calls the real implementation
of qemu_notify_event() in main-loop.c ?

 Thomas



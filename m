Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620F3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 05:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24F232053B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 05:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TM9vVy1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F232053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtOwZ-0005Dw-1B
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 01:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtOuh-0003TC-Rj
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 01:16:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49433
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtOuf-0000cc-OW
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 01:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594271761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=pc5o370BzgO1uMu/Pn3ru7m7lUk9SU/9Nvs7USvug44=;
 b=TM9vVy1jAKeqaHE933ddhajc4uxHEWa7zhYLCjiHVqjmORcZ0S4nxWHBmcZOEE9I3XIBlS
 KjaLWnv43uMRBLLY4VJfj9mIEabrLZEqzBzykVIEJZSZikG5aDMmIh67q1/L/cvEyOI84j
 D89ks/NqpkEkqBEJS/q1FxFufJyPm+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-TEkcx5BiPgevb4ge7ipJrw-1; Thu, 09 Jul 2020 01:15:59 -0400
X-MC-Unique: TEkcx5BiPgevb4ge7ipJrw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BE27107B265;
 Thu,  9 Jul 2020 05:15:58 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-106.ams2.redhat.com [10.36.112.106])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 866A8797FE;
 Thu,  9 Jul 2020 05:15:50 +0000 (UTC)
Subject: Re: [PATCH-for-5.1 2/2] fuzz: add missing header for rcu_enable_atfork
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200708200104.21978-1-alxndr@bu.edu>
 <20200708200104.21978-3-alxndr@bu.edu>
 <96f1c98a-982b-c146-80af-8f83e8117ac5@redhat.com>
 <3afe7750-3401-7365-bfe8-d5fd02663b69@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9a0e3688-3531-1b6f-a5bc-6192a034a8bd@redhat.com>
Date: Thu, 9 Jul 2020 07:15:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3afe7750-3401-7365-bfe8-d5fd02663b69@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bandan Das <bsd@redhat.com>, liq3ea@163.com,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/2020 07.09, Philippe Mathieu-Daudé wrote:
> On 7/9/20 7:03 AM, Philippe Mathieu-Daudé wrote:
>> On 7/8/20 10:01 PM, Alexander Bulekov wrote:
>>> In 45222b9a90, I fixed a broken check for rcu_enable_atfork introduced
>>> in d6919e4cb6. I added a call to rcu_enable_atfork after the
>>> call to qemu_init in fuzz.c, but forgot to include the corresponding
>>> header, breaking --enable-fuzzing --enable-werror builds.
>>>
>>> Fixes: 45222b9a90 ("fuzz: fix broken qtest check at rcu_disable_atfork")
>>> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>>> ---
>>>  tests/qtest/fuzz/fuzz.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
>>> index a36d9038e0..0b66e43409 100644
>>> --- a/tests/qtest/fuzz/fuzz.c
>>> +++ b/tests/qtest/fuzz/fuzz.c
>>> @@ -19,6 +19,7 @@
>>>  #include "sysemu/runstate.h"
>>>  #include "sysemu/sysemu.h"
>>>  #include "qemu/main-loop.h"
>>> +#include "qemu/rcu.h"
>>>  #include "tests/qtest/libqtest.h"
>>>  #include "tests/qtest/libqos/qgraph.h"
>>>  #include "fuzz.h"
>>>
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
> 
> Please add the include to softmmu/vl.c too.

Why? Did you run into compile problems here, too?

 Thomas



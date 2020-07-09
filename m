Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D2AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11542074B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqWTNSxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11542074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtX4O-0001D9-7b
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 09:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtX3m-0000ay-AY
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:57:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21844
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtX3k-0006sF-0k
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594303074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=qVA5PpTtAOVaYGIT+Z13yYBrcMSbKSY5FrbiyxXR2ms=;
 b=WqWTNSxHyOp4hzrLQrDXsahCqRjgs6LtLqKmkiWRIC2JQ7Mfv4UJ0q/bcxlDBFHFLCM/Hu
 hxgpNltv/m1reA12ZsBh8wuwL1x6tRjc95rO01X5hfCSIp3dpOE5NT6rObx2LQPRf8fknK
 DkJPgC87b+KqLoMK8eJcbDennf+jvWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-zBPVNUU_MbKSoWykkCrPzg-1; Thu, 09 Jul 2020 09:57:52 -0400
X-MC-Unique: zBPVNUU_MbKSoWykkCrPzg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B825E10059B0;
 Thu,  9 Jul 2020 13:57:51 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-106.ams2.redhat.com [10.36.112.106])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 027B21A888;
 Thu,  9 Jul 2020 13:57:43 +0000 (UTC)
Subject: Re: [PATCH-for-5.1 2/2] fuzz: add missing header for rcu_enable_atfork
To: Alexander Bulekov <alxndr@bu.edu>
References: <20200708200104.21978-1-alxndr@bu.edu>
 <20200708200104.21978-3-alxndr@bu.edu>
 <75c61011-3be4-a450-3188-4b875703df07@redhat.com>
 <20200709133841.olbpg7jwaeklc6v6@mozz.bu.edu>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1b914b76-3842-af13-c70a-ced8d3d30a29@redhat.com>
Date: Thu, 9 Jul 2020 15:57:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200709133841.olbpg7jwaeklc6v6@mozz.bu.edu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:33:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, liq3ea@163.com,
 qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/2020 15.38, Alexander Bulekov wrote:
> On 200709 0718, Thomas Huth wrote:
>> On 08/07/2020 22.01, Alexander Bulekov wrote:
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
>>
>> D'oh, mea culpa, I also apparently did not properly compile test that
>> patch :-( I think we need a CI job that at least compile tests the
>> fuzzing code - I can look into that once Alex Bennée's current testing
>> pull request has been merged.
> 
> My bad - I should have done a clean build with a version of clang
> that doesn't require me to -disable-werror
> 
>> Alexander, is there also a way to run a fuzzer just for some few
>> minutes? E.g. a fuzzing test that finishes quickly, or an option to
>> limit the time that a test is running? If so, we could also add that
>> quick test to the CI pipeline, to make sure that the fuzzer code does
>> not only compile, but is also able to run (at least a little bit).
> 
> Yes. I think the sequence could look something like:
> CC=clang CXX=clang++ ../configure --enable-fuzzing --enable-sanitizers \
>              --enable-werror
> make i386-softmmu/fuzz
> ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=i440fx-qtest-reboot-fuzz -runs=5000
> 
> This will run the i440fx fuzzer over 5000 inputs which should finish in
> a second or so. I don't expect it to actually find any crashes in the
> i440fx in such a short period, so, ideally, all errors would be
> fuzzer-related.
> 
> Where can I get started with building out a CI job for this?

I'd suggest to use gitlab, since we're currently focusing on that for
our CI. So get an account on gitlab, clone the qemu repository there
(https://gitlab.com/qemu-project/qemu) to your account, and then you
should almost be ready to go: Edit the .gitlab-ci.yml file in the
repository, and once you push your local branch to the gitlab server,
you should see the jobs running in the "CI / CD" section. (Not sure
anymore whether you have to enable the CI manually for your project,
though, but it should not be too hard to find that setting if that's the
case)

> One aside: running this right now, QEMU exits and AddressSanitizer
> complains about some leaks. There is a patch in Paolo's PR that should
> fix this, but I was surprised that existing CI tests didn't catch it. Is
> leak detection usually disabled in CI?

I'm not aware of any CI tests that is currently using leak detection ...
so it's certainly welcome if we get more test coverage here!

 Thomas



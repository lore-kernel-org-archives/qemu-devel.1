Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D23C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 05:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C13D20684
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 05:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMDPWn7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C13D20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwJ1h-0004ct-UG
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 01:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jwJ0G-0003om-Ob
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 01:33:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49916
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jwJ0E-00058s-Vl
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 01:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594964026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=OlYXEO7WEy59EVfHDigTFR8A/+1MIG8d3lc8eI8xP5I=;
 b=iMDPWn7yRsL+PqT92SS+ECO9cWN+xwqELVm/wbojWa2xfbdR/9PaT2ZI3Cf3CQbrnqLlFM
 T8mKLMU4ySl+ywOU8MsZhxaSuz0aC2OXJmik9f3sIbotIYXTgQNiJZEDAESSh7HUW6TW/S
 NRS5MiQGHWy5XPxUhu7F4FC5DY5+18Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333--kVF1XI6OaiOnHeicPsUVg-1; Fri, 17 Jul 2020 01:33:42 -0400
X-MC-Unique: -kVF1XI6OaiOnHeicPsUVg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEA4B1888AAD;
 Fri, 17 Jul 2020 05:33:41 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-62.ams2.redhat.com [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4F1660C05;
 Fri, 17 Jul 2020 05:33:31 +0000 (UTC)
Subject: Re: [PATCH] gitlab-ci.yml: Add fuzzer tests
To: Alexander Bulekov <alxndr@bu.edu>
References: <20200716100950.27396-1-thuth@redhat.com>
 <20200716164557.gmt62pll4aszyknf@mozz.bu.edu>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <899ff957-1840-98e6-bc0c-459556452900@redhat.com>
Date: Fri, 17 Jul 2020 07:33:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200716164557.gmt62pll4aszyknf@mozz.bu.edu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 01:06:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/07/2020 18.46, Alexander Bulekov wrote:
> On 200716 1209, Thomas Huth wrote:
>> So far we neither compile-tested nor run any of the new fuzzers in our CI,
>> which led to some build failures of the fuzzer code in the past weeks.
>> To avoid this problem, add a job to compile the fuzzer code and run some
>> loops (which likely don't find any new bugs via fuzzing, but at least we
>> know that the code can still be run).
>>
>> A nice side-effect of this test is that the leak tests are enabled here,
>> so we should now notice some of the memory leaks in our code base earlier.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Thank you for this, Thomas. I just sent a patch to add a job that runs
> similar tests with the build-script that we use on oss-fuzz
> Patch: <20200716163330.29141-1-alxndr@bu.edu>

Good idea! ... but it does not work quite yet, I gave it a try and ended
up here:

 https://gitlab.com/huth/qemu/-/jobs/643353500

> I know that these jobs have a lot of overlap, but there are enough
> quirks in the oss-fuzz build-script that I, personally, don't think
> they are redundant.

I think we should finally go with your approach and compile the fuzzing
test via the script. But since that seems to need some more work first,
let's go with my patch now, so that we have something for 5.1-rc1, and
then when your patch is ready, replace my "build-fuzzer" job with yours, ok?

>> +build-fuzzer:
>> +  <<: *native_build_job_definition
>> +  variables:
>> +    IMAGE: fedora
>> +  script:
>> +    - mkdir build
>> +    - cd build
>> +    - ../configure --cc=clang --cxx=clang++ --enable-fuzzing
>> +                   --target-list=x86_64-softmmu
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg02310.html
> When/if this gets merged, enable-fuzzing won't build with
> AddressSanitizer, by default, so I would add --enable-sanitizers, just
> to be safe. 

Ok, thanks, I'll add that.

>> +    - make -j"$JOBS" all check-build x86_64-softmmu/fuzz
>> +    - make check
>> +    - for fuzzer in i440fx-qos-fork-fuzz i440fx-qos-noreset-fuzz
>> +        i440fx-qtest-reboot-fuzz virtio-scsi-flags-fuzz virtio-scsi-fuzz ; do
> 
> Any reason for these particular fuzzers? I know the virtio-net ones find
> crashes pretty quickly, but I dont think that causes a non-zero exit.

I did not include the virtio-net fuzzers because I read that warning
"May result in network traffic emitted from the  process. Run in an
isolated network environment." in the help text ... so I was not sure
whether they are really suitable for the CI on the gitlab machines?

 Thomas



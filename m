Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2BAC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 07:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CBB20704
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 07:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+lLE9LI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CBB20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwLAQ-0007wC-Fn
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 03:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jwL9r-0007To-My
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 03:51:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58998
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jwL9p-0003G9-Ad
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 03:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594972308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=K7AQPb7PUuxb2Ye33lxWiYJZitXRZDQ5i0Qr4BNakeU=;
 b=Z+lLE9LI50ff6GKKOo7+BeWZTXzms9QTOOAM4W/HUEBuijKg17GjJBSYHfEPoeSoLOQ4Pb
 t7YpaT0eqHvKISFIdg/1Vw4waDYMzuY9BXTYWvr4jOEUaCYooLc72E2/SIDMWQuANnTZ/b
 qzZbMb+iklhql525K9o0h9NSNysO/i8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-30wgs9TUO0mnBXANbw6qjA-1; Fri, 17 Jul 2020 03:51:44 -0400
X-MC-Unique: 30wgs9TUO0mnBXANbw6qjA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5113D1009600;
 Fri, 17 Jul 2020 07:51:43 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-62.ams2.redhat.com [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2815474F70;
 Fri, 17 Jul 2020 07:51:32 +0000 (UTC)
Subject: Re: [PATCH] gitlab-ci.yml: Add oss-fuzz build tests
From: Thomas Huth <thuth@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200716163330.29141-1-alxndr@bu.edu>
 <75839163-5e7c-3ff4-6d89-870d69ea5979@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9ddec0a1-d106-e36a-b25e-d54235bf75b5@redhat.com>
Date: Fri, 17 Jul 2020 09:51:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <75839163-5e7c-3ff4-6d89-870d69ea5979@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/07/2020 07.40, Thomas Huth wrote:
> On 16/07/2020 18.33, Alexander Bulekov wrote:
>> This tries to build and run the fuzzers with the same build-script used
>> by oss-fuzz. This doesn't guarantee that the builds on oss-fuzz will
>> also succeed, since oss-fuzz provides its own compiler and fuzzer vars,
>> but it can catch changes that are not compatible with the the
>> ./scripts/oss-fuzz/build.sh script.
>> The strange way of finding fuzzer binaries stems from the method used by
>> oss-fuzz:
>> https://github.com/google/oss-fuzz/blob/master/infra/base-images/base-runner/targets_list
>>
>> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>> ---
>>
>> Similar to Thomas' patch:
>>
>>> Note: This patch needs two other patches merged first to work correctly:
>>
>>> - 'fuzz: Expect the cmdline in a freeable GString' from Alexander
>>
>>> - 'qom: Plug memory leak in "info qom-tree"' from Markus
>>
>> Otherwise the test will fail due to detected memory leaks.
>>
>> Fair warning: I haven't been able to trigger this new job yet. I tried
>> to run the pipeline with these changes on my forked repo on gitlab, but
>> did not reach the build-oss-fuzz. I think this is due to some failures
>> in the Containers-layer-2 stage:

I think I've got it basically working like this:

build-oss-fuzz:
  <<: *native_build_job_definition
  variables:
    IMAGE: fedora
  script:
    - mkdir build-oss-fuzz
    - CC="clang" CXX="clang++" CFLAGS="-fsanitize=address"
      ./scripts/oss-fuzz/build.sh
    - for fuzzer in $(find build-oss-fuzz/DEST_DIR/ -executable -type f
                      | grep -v slirp); do
        grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 ||
continue ;
        echo Testing ${fuzzer} ... ;
        "${fuzzer}" -runs=1000 || exit 1 ;
      done

However, it still triggered a memory leak and thus the pipeline failed:

 https://gitlab.com/huth/qemu/-/jobs/643472695

... and this was with all the other "leak fix" patches already applied.
Is there an easy way to debug that issue? That information from the
LeakSanitizer looks pretty sparse...

 Thomas



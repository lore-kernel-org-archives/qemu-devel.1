Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBF6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD71E20737
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixk/F595"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD71E20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwSTS-0000u9-2S
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 11:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jwSST-0008Q7-Mi
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 11:39:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59401
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jwSSN-0000PV-8O
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 11:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595000365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=dFqrJxF2Ot6v954AoBPlfWRXyFSr5C3yGX9H4fYchDQ=;
 b=ixk/F595d/oKSXIHyYRNkqoMm7lz0Iaav9JK+07oZZI//8WNSt3NTmXnoU0yLlJL939iND
 gifw9PYlxIv/+ej/ZmFT04a6lMS5axmjB08p+Kjod7RpYhJcxGHLOwFjo3/UF53nL4o+52
 zdc7tl60ow+C8rQGKxTmrocstal/E00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-V-X_baCbM9usgbwzNFWFfA-1; Fri, 17 Jul 2020 11:39:23 -0400
X-MC-Unique: V-X_baCbM9usgbwzNFWFfA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C7F41800D42;
 Fri, 17 Jul 2020 15:39:22 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-141.ams2.redhat.com [10.36.113.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3220E5FC2E;
 Fri, 17 Jul 2020 15:39:07 +0000 (UTC)
Subject: Re: [PATCH] gitlab-ci.yml: Add oss-fuzz build tests
To: Alexander Bulekov <alxndr@bu.edu>
References: <20200716163330.29141-1-alxndr@bu.edu>
 <75839163-5e7c-3ff4-6d89-870d69ea5979@redhat.com>
 <9ddec0a1-d106-e36a-b25e-d54235bf75b5@redhat.com>
 <20200717132007.bux2neofbktbl522@mozz.bu.edu>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e426d4cd-4e2a-de7a-80e3-b523384b37a9@redhat.com>
Date: Fri, 17 Jul 2020 17:39:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200717132007.bux2neofbktbl522@mozz.bu.edu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 05:27:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/07/2020 15.20, Alexander Bulekov wrote:
> On 200717 0951, Thomas Huth wrote:
>> On 17/07/2020 07.40, Thomas Huth wrote:
[...]
>> I think I've got it basically working like this:
>>
>> build-oss-fuzz:
>>   <<: *native_build_job_definition
>>   variables:
>>     IMAGE: fedora
>>   script:
>>     - mkdir build-oss-fuzz
>>     - CC="clang" CXX="clang++" CFLAGS="-fsanitize=address"
>>       ./scripts/oss-fuzz/build.sh
>>     - for fuzzer in $(find build-oss-fuzz/DEST_DIR/ -executable -type f
>>                       | grep -v slirp); do
>>         grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 ||
>> continue ;
>>         echo Testing ${fuzzer} ... ;
>>         "${fuzzer}" -runs=1000 || exit 1 ;
>>       done
>>
>> However, it still triggered a memory leak and thus the pipeline failed:
>>
>>  https://gitlab.com/huth/qemu/-/jobs/643472695
>>
>> ... and this was with all the other "leak fix" patches already applied.
>> Is there an easy way to debug that issue? That information from the
>> LeakSanitizer looks pretty sparse...
> 
> Strange... Especially since Philippe didn't get the same error. We
> should probably add -seed=1 after -runs=1000, to make sure the fuzzer is
> using the same rng seed. That said, I just ran the fuzzer for 50k
> iterations, and still could not reproduce the leak...
> 
> This environment variable should fix the partial stacktrace, so we don't
> have to guess next time:
> ASAN_OPTIONS="fast_unwind_on_malloc=0"

Thanks, that did the trick:

 https://gitlab.com/huth/qemu/-/jobs/644354706#L3616

... that also explains why I haven't seen it in my other tests where I
am using the --fuzz-target parameter : The leak only happens if the
fuzz-target is encoded in the program name - looks like we have to free
the memory returned by g_path_get_dirname() there...

 Thomas



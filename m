Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F19C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 05:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD01206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 05:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Al/Mq1aS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD01206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwJ81-0006ot-V6
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 01:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jwJ78-0006OQ-FA
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 01:40:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35386
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jwJ76-0007Jn-F0
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 01:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594964451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=Jdm6gMqQua6kepije5jayYuw5WUMf4NiIUfepEtuLbs=;
 b=Al/Mq1aSrydl8NelfuEninZzMcEeO2e/ODEheTzPhTFqcPQ+HTqlNTmrBKSqJQOdjUxvLR
 BvDH5zuqZ1ZCl8RdVdM53laXFni5L8wGqPaJEzVBL7wPHwpFhvhb2dpGrBGfeahsqEd7Gb
 lGeJ6YwuWtDhNuGNhe8GrHy2JSdcn/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-bybjIHJ_NKGl7JQOQp4rug-1; Fri, 17 Jul 2020 01:40:45 -0400
X-MC-Unique: bybjIHJ_NKGl7JQOQp4rug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE77C1888AAD;
 Fri, 17 Jul 2020 05:40:44 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-62.ams2.redhat.com [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4339119D82;
 Fri, 17 Jul 2020 05:40:32 +0000 (UTC)
Subject: Re: [PATCH] gitlab-ci.yml: Add oss-fuzz build tests
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200716163330.29141-1-alxndr@bu.edu>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <75839163-5e7c-3ff4-6d89-870d69ea5979@redhat.com>
Date: Fri, 17 Jul 2020 07:40:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200716163330.29141-1-alxndr@bu.edu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 23:13:19
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
Cc: philmd@redhat.com, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/07/2020 18.33, Alexander Bulekov wrote:
> This tries to build and run the fuzzers with the same build-script used
> by oss-fuzz. This doesn't guarantee that the builds on oss-fuzz will
> also succeed, since oss-fuzz provides its own compiler and fuzzer vars,
> but it can catch changes that are not compatible with the the
> ./scripts/oss-fuzz/build.sh script.
> The strange way of finding fuzzer binaries stems from the method used by
> oss-fuzz:
> https://github.com/google/oss-fuzz/blob/master/infra/base-images/base-runner/targets_list
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
> 
> Similar to Thomas' patch:
> 
>> Note: This patch needs two other patches merged first to work correctly:
> 
>> - 'fuzz: Expect the cmdline in a freeable GString' from Alexander
> 
>> - 'qom: Plug memory leak in "info qom-tree"' from Markus
> 
> Otherwise the test will fail due to detected memory leaks.
> 
> Fair warning: I haven't been able to trigger this new job yet. I tried
> to run the pipeline with these changes on my forked repo on gitlab, but
> did not reach the build-oss-fuzz. I think this is due to some failures
> in the Containers-layer-2 stage:
> 
> ...
> Error response from daemon: manifest for
> registry.gitlab.com/a1xndr/qemu/qemu/debian-all-test-cross:latest not
> found: manifest unknown: manifest unknown
> #2 [internal] load .dockerignore
> #2 transferring context:
> #2 transferring context: 2B 0.1s done
> #2 DONE 0.1s
> #1 [internal] load build definition from tmpg8j4xoop.docker
> #1 transferring dockerfile: 2.21kB 0.1s done
> #1 DONE 0.2s
> #3 [internal] load metadata for docker.io/qemu/debian10:latest
> #3 ERROR: pull access denied, repository does not exist or may require
> authorization: server message: insufficient_scope: authorization failed

These look like the problems that we've seen with the main repo until
two days ago, too, e.g.:

 https://gitlab.com/qemu-project/qemu/-/jobs/640410842

Maybe Alex (Bennée) can comment on how to resolve them?

> 
>  .gitlab-ci.yml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index e96f8794b9..a50df420c9 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -182,6 +182,20 @@ build-fuzzer:
>              || exit 1 ;
>        done

As mentioned in my other mail, I think you can replace my build-fuzzer
job once this is working.

> +build-oss-fuzz:
> +  <<: *native_build_job_definition
> +  variables:
> +    IMAGE: fedora
> +  script:
> +    - OUT_DIR="./build" CC=clang-9 CXX=clang++-9 CFLAGS="-fsanitize=address"
> +      LIB_FUZZING_ENGINE="-fsanitize=fuzzer" CFL

That "CFL" at the end seems to be a typo (leftover from "CFLAGS")?

Also the fedora container does not have clang-9 :

 https://gitlab.com/huth/qemu/-/jobs/643383032#L28

I think it is at clang 10 already, so maybe just use CC=clang (without
version number)?

> +      ./scripts/oss-fuzz/build.sh
> +    - for fuzzer in $(find ./build-oss-fuzz/DEST_DIR/ -executable -type f); do
> +        grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 || continue ;
> +        echo Testing ${fuzzer} ... ;
> +        "${fuzzer}" -runs=1000 || exit 1 ;
> +      done

Should we exclude the virtio-net tests, since they could leak network
traffic to the host?

 Thomas



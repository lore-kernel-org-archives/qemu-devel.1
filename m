Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDB6C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F3B520849
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3B520849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw73C-0007Mm-QB
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 12:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jw72a-0006uy-Oe
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:47:24 -0400
Received: from relay64.bu.edu ([128.197.228.104]:45612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jw72Y-0002MF-Qk
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:47:24 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 06GGkEAH021904
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 16 Jul 2020 12:46:19 -0400
Date: Thu, 16 Jul 2020 12:46:14 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] gitlab-ci.yml: Add fuzzer tests
Message-ID: <20200716164557.gmt62pll4aszyknf@mozz.bu.edu>
References: <20200716100950.27396-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716100950.27396-1-thuth@redhat.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 12:47:21
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200716 1209, Thomas Huth wrote:
> So far we neither compile-tested nor run any of the new fuzzers in our CI,
> which led to some build failures of the fuzzer code in the past weeks.
> To avoid this problem, add a job to compile the fuzzer code and run some
> loops (which likely don't find any new bugs via fuzzing, but at least we
> know that the code can still be run).
> 
> A nice side-effect of this test is that the leak tests are enabled here,
> so we should now notice some of the memory leaks in our code base earlier.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Thank you for this, Thomas. I just sent a patch to add a job that runs
similar tests with the build-script that we use on oss-fuzz
Patch: <20200716163330.29141-1-alxndr@bu.edu>

I know that these jobs have a lot of overlap, but there are enough
quirks in the oss-fuzz build-script that I, personally, don't think
they are redundant.

A couple notes below, and I haven't been able to test on my own fork of
qemu on gitlab, yet due to some pipeline errors, but otherwise

Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

> ---
>  .gitlab-ci.yml | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 5eeba2791b..e96f8794b9 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -161,9 +161,27 @@ build-clang:
>      IMAGE: fedora
>      CONFIGURE_ARGS: --cc=clang --cxx=clang++
>      TARGETS: alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu
> -      ppc-softmmu s390x-softmmu x86_64-softmmu arm-linux-user
> +      ppc-softmmu s390x-softmmu arm-linux-user
>      MAKE_CHECK_ARGS: check
>  
> +build-fuzzer:
> +  <<: *native_build_job_definition
> +  variables:
> +    IMAGE: fedora
> +  script:
> +    - mkdir build
> +    - cd build
> +    - ../configure --cc=clang --cxx=clang++ --enable-fuzzing
> +                   --target-list=x86_64-softmmu

https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg02310.html
When/if this gets merged, enable-fuzzing won't build with
AddressSanitizer, by default, so I would add --enable-sanitizers, just
to be safe. 

> +    - make -j"$JOBS" all check-build x86_64-softmmu/fuzz
> +    - make check
> +    - for fuzzer in i440fx-qos-fork-fuzz i440fx-qos-noreset-fuzz
> +        i440fx-qtest-reboot-fuzz virtio-scsi-flags-fuzz virtio-scsi-fuzz ; do

Any reason for these particular fuzzers? I know the virtio-net ones find
crashes pretty quickly, but I dont think that causes a non-zero exit.

> +          echo Testing ${fuzzer} ... ;
> +          x86_64-softmmu/qemu-fuzz-x86_64 --fuzz-target=${fuzzer} -runs=1000
> +            || exit 1 ;
> +      done
> +
>  build-tci:
>    <<: *native_build_job_definition
>    variables:
> -- 
> 2.18.1
> 


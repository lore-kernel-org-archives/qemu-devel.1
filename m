Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001ABC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA95723770
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSxkvVkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA95723770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jprA4-0001M0-0n
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 06:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jpr9V-0000su-3Y
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:36:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52883
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jpr9T-0001sH-Cd
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593426998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1tTiesGuPGgSGly8BOyQm4sUCPMjfNBcm0UoU5+g25s=;
 b=SSxkvVkVFlqRzK1BS/YljS/3zxkAYCgVzszZaWX1DGlaWrs9mtuTDky7Ka6O9WynuvHRMm
 +AW5Ag2YD2aVlcoGwgw6n1DpSz8Z54gVpo6jZpDNobxMlhLXVOXxMl/lF1LGmbUZjuoIQB
 gZ/91YXnOa2Mn1+L9jelF3P9ZXYq3FE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-doxSk4zlOCiQYMjxcgnG0Q-1; Mon, 29 Jun 2020 06:36:34 -0400
X-MC-Unique: doxSk4zlOCiQYMjxcgnG0Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E402C87950C;
 Mon, 29 Jun 2020 10:36:32 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-140.ams2.redhat.com [10.36.112.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75C3C1002388;
 Mon, 29 Jun 2020 10:36:27 +0000 (UTC)
Subject: Re: [PATCH v3 24/30] gitlab: add acceptance testing to system builds
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200626181357.26211-1-alex.bennee@linaro.org>
 <20200626181357.26211-25-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8fb07d83-d70b-4f52-9d00-45b5d2bebd12@redhat.com>
Date: Mon, 29 Jun 2020 12:36:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200626181357.26211-25-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:03:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, "Daniel P. Berrange" <berrange@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, cota@braap.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/06/2020 20.13, Alex Bennée wrote:
> As part of migrating things from Travis to GitLab add the acceptance
> tests. To do this:
> 
>    - rename system1 to system-ubuntu-main
>    - rename system2 to system-fedora-misc
>    - split into build/check/acceptance
>    - remove -j from check stages
>    - use artifacts to save build stage
>    - add post acceptance template and use
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20200622143204.12921-16-alex.bennee@linaro.org>
> 
> ---
> v2
>    - updated with danp's docker changes
>    - use needs instead of dependancies
>    - touch all the build files to prevent rebuild
> ---
>   .gitlab-ci.yml | 66 +++++++++++++++++++++++++++++++++++++++++++++++---
>   .travis.yml    | 23 ------------------
>   2 files changed, 63 insertions(+), 26 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index a7abc55a5c6..5ae8130bd1a 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -1,8 +1,12 @@
> +# Currently we have two build stages after our containers are built:
> +#  - build (for traditional build and test or first stage build)
> +#  - test (for test stages, using build artefacts from a build stage)
>   stages:
>     - containers
>     - containers-layer2
>     - containers-layer3
>     - build
> +  - test
>   
>   include:
>     - local: '/.gitlab-ci.d/edk2.yml'
> @@ -24,26 +28,82 @@ include:
>           ../configure --enable-werror $CONFIGURE_ARGS ;
>         fi
>       - make -j"$JOBS"
> -    - make -j"$JOBS" $MAKE_CHECK_ARGS
> +    - if test -n "$MAKE_CHECK_ARGS";
> +      then
> +        make $MAKE_CHECK_ARGS ;
> +      fi
> +
> +.native_test_job_template: &native_test_job_definition
> +  stage: test
> +  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
> +  script:
> +    - cd build
> +    - find . -type f -exec touch {} +
> +    - make $MAKE_CHECK_ARGS
> +
> +.post_acceptance_template: &post_acceptance
> +  after_script:
> +    - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
> +    - du -chs $HOME/avocado/data/cache
>   
> -build-system1:
> +build:system-ubuntu-main:
>     <<: *native_build_job_definition
>     variables:
>       IMAGE: ubuntu2004
>       TARGETS: aarch64-softmmu alpha-softmmu cris-softmmu hppa-softmmu lm32-softmmu
>         moxie-softmmu microblazeel-softmmu mips64el-softmmu m68k-softmmu ppc-softmmu
>         riscv64-softmmu sparc-softmmu
> +  artifacts:
> +    paths:
> +      - build
> +
> +check:system-ubuntu-main:
> +  <<: *native_test_job_definition
> +  needs:
> +    - job: build:system-ubuntu-main
> +      artifacts: true
> +  variables:
> +    IMAGE: ubuntu2004
>       MAKE_CHECK_ARGS: check
>   
> -build-system2:
> +acceptance:system-ubuntu-main:
> +  <<: *native_test_job_definition
> +  needs:
> +    - job: build:system-ubuntu-main
> +      artifacts: true
> +  variables:
> +    IMAGE: ubuntu2004
> +    MAKE_CHECK_ARGS: check-acceptance
> +
> +build:system-fedora-alt:
>     <<: *native_build_job_definition
>     variables:
>       IMAGE: fedora
>       TARGETS: tricore-softmmu unicore32-softmmu microblaze-softmmu mips-softmmu
>         riscv32-softmmu s390x-softmmu sh4-softmmu sparc64-softmmu x86_64-softmmu
>         xtensa-softmmu nios2-softmmu or1k-softmmu
> +  artifacts:
> +    paths:
> +      - build
> +
> +check:system-fedora-alt:
> +  <<: *native_test_job_definition
> +  needs:
> +    - job: build:system-fedora-alt
> +      artifacts: true
> +  variables:
> +    IMAGE: fedora
>       MAKE_CHECK_ARGS: check
>   
> +check:system-fedora-alt:
> +  <<: *native_test_job_definition
> +  needs:
> +    - job: build:system-fedora-alt
> +      artifacts: true
> +  variables:
> +    IMAGE: fedora
> +    MAKE_CHECK_ARGS: check-acceptance

Why is Ubuntu "-main" and "Fedora "-alt" ? ... that does not make sense 
to me.

We also might want to rework the list of targets. To speed up the 
testing, I originally omitted some targets like sh4eb-softmmu which did 
not seem very interesting, but now that we add more and more builds in 
parallel, we could maybe split the two system targets into three or even 
four instead, and then add these targets, too. It would also be nice to 
have some tests with "centos8" and a debian container, too.

And "rx-softmmu" is also still missing in the target list.

Ok, it's quite a bit of change that still needs to be done here ... 
maybe that's rather something for a separate patch later.

  Thomas



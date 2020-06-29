Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE4CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA9FF23A32
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkGbrkE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9FF23A32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jprkX-0004Fl-3d
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 07:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jprjR-0003nY-E4
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:13:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40943
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jprjP-0008O5-BE
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593429226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4LcQkw4Lb++/1a2TQi2E9whttLQ9KRbPjwDIuH7PtL4=;
 b=KkGbrkE9oEKezeZqQtT9KBXRaNx9nRc5uIYKfI3+PksQi6T5nlDwjjh7Iw4agQ/lu8+T/E
 u82q75odXOWV5C99O1JO4Qu2kOfDNk5zN8Ta+XM8k2DuXNLoFmckZ6KI0R2MM24ZMI19rU
 8VBTuCqwd2Rr2CH0XLT2QphPz0LtXZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-SLPBl8s6O--YpouSVj1rPw-1; Mon, 29 Jun 2020 07:13:02 -0400
X-MC-Unique: SLPBl8s6O--YpouSVj1rPw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1C42106B247;
 Mon, 29 Jun 2020 11:13:00 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-140.ams2.redhat.com [10.36.112.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FE425C1D4;
 Mon, 29 Jun 2020 11:12:54 +0000 (UTC)
Subject: Re: [PATCH v3 24/30] gitlab: add acceptance testing to system builds
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200626181357.26211-1-alex.bennee@linaro.org>
 <20200626181357.26211-25-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <60337384-7a08-86f9-0ddc-ab7e1c028e35@redhat.com>
Date: Mon, 29 Jun 2020 13:12:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200626181357.26211-25-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:37:37
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
Cc: fam@euphon.net, berrange@redhat.com, richard.henderson@linaro.org,
 f4bug@amsat.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 cota@braap.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
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

Copy-n-paste bug: This should be "acceptance:..." instead. By the way, I 
think the use of a colon after "check" or "acceptance" is a little bit 
confusing here, since this is also a character used by the YML syntax.
Could you name the jobs with a dash here instead? (check-system-fedora, 
acceptance-system-fedora, ...)

> +  <<: *native_test_job_definition
> +  needs:
> +    - job: build:system-fedora-alt
> +      artifacts: true
> +  variables:
> +    IMAGE: fedora
> +    MAKE_CHECK_ARGS: check-acceptance

  Thomas



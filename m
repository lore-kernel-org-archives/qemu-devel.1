Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E45C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF9023CD4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cIYgRs1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF9023CD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jptHy-00064w-DX
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 08:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jptFn-0004GW-Fw
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:51:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35568)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jptFf-00017h-JG
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:51:19 -0400
Received: by mail-wr1-x442.google.com with SMTP id g18so16462323wrm.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 05:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=rwEoxkUubhaMko7b0QebtBGPOyJ+qU/UUgxzA4gSt8Y=;
 b=cIYgRs1IjG2kaEmfIvb09Z842cxW9kOeQF/MDln4pf0by2xBzS/EghoDxnVDtOpYRP
 GQklBmYN7sQgQ/t3145hwoE+/EVRlxS6DeXeWYpcqIFcXFomMQaLYx9+iHskYDCtO0PW
 iRLa3q1vMcro7sr4hRTLWqmNDbiAM3tFKmLf9ZFmEUnYWN7V09tCKwLR7fx0vhCpEGC+
 DIsxLOYpiUX3TJ9jYgzmfvgkCiTy0lZH9dUCBYfCdhpV3h8RbsRgLL7uMiAUFl5LPRHe
 9+80LWW5W477MZOim4EFej+uoWW9xGVzMrpnahA1rw6dAw769w9Ix0wwmgBuvqJiemuC
 Vjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=rwEoxkUubhaMko7b0QebtBGPOyJ+qU/UUgxzA4gSt8Y=;
 b=VSwaqylvzj7JMFsr8+7LTeeG2QapIKu7142Og0mart5EcyO3UxPXmDKmlsfxksZLhw
 Al4NYJYpPmGU9XAlvKf+qKMh2ga35xTDqNrDqxCBCUcdGZK49p+XJ2aOWrYGIJifYE3O
 3CmoEsbm2+j5jPLVzf5msbQtW6awEYxnvzyzGN9Q+5ue4vxwUsNa59+U+u5rMd+Kvjcj
 dj1TeQYOXdKy+/TAgKZIW1brDBgDwif/MumxD7ggWuQXHSCQMF+rOJDFGU0Plw9Yx7Yo
 p8n8lp+GN9iyJw9OoKeRo3VC/gQy2dDbeLyrcvNHhjA1rvNjzrhcPZBohIhLE5oUw4O3
 QK9g==
X-Gm-Message-State: AOAM530rp9ww39TDOWAwTs41R38TSoKDMTR9XowmDoSEpWSwUzOLtE4O
 p7QBD/DtecdZ0Pg33yuf17q10w==
X-Google-Smtp-Source: ABdhPJzW84PWTvCSeHNntWL+uSK+TQkpMfUu18KOMKo64Rnbe7MzUVQQlh9Bk+Nqu+/41Bza5GK7lQ==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr16631772wrm.82.1593435069193; 
 Mon, 29 Jun 2020 05:51:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c17sm26673770wmd.10.2020.06.29.05.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 05:51:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 536BB1FF7E;
 Mon, 29 Jun 2020 13:51:07 +0100 (BST)
References: <20200626181357.26211-1-alex.bennee@linaro.org>
 <20200626181357.26211-25-alex.bennee@linaro.org>
 <8fb07d83-d70b-4f52-9d00-45b5d2bebd12@redhat.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 24/30] gitlab: add acceptance testing to system builds
In-reply-to: <8fb07d83-d70b-4f52-9d00-45b5d2bebd12@redhat.com>
Date: Mon, 29 Jun 2020 13:51:07 +0100
Message-ID: <87mu4mrq6c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, f4bug@amsat.org,
 cota@braap.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 26/06/2020 20.13, Alex Benn=C3=A9e wrote:
>> As part of migrating things from Travis to GitLab add the acceptance
>> tests. To do this:
>>=20
>>    - rename system1 to system-ubuntu-main
>>    - rename system2 to system-fedora-misc
>>    - split into build/check/acceptance
>>    - remove -j from check stages
>>    - use artifacts to save build stage
>>    - add post acceptance template and use
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20200622143204.12921-16-alex.bennee@linaro.org>
>>=20
>> ---
>> v2
>>    - updated with danp's docker changes
>>    - use needs instead of dependancies
>>    - touch all the build files to prevent rebuild
>> ---
>>   .gitlab-ci.yml | 66 +++++++++++++++++++++++++++++++++++++++++++++++---
>>   .travis.yml    | 23 ------------------
>>   2 files changed, 63 insertions(+), 26 deletions(-)
>>=20
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index a7abc55a5c6..5ae8130bd1a 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -1,8 +1,12 @@
>> +# Currently we have two build stages after our containers are built:
>> +#  - build (for traditional build and test or first stage build)
>> +#  - test (for test stages, using build artefacts from a build stage)
>>   stages:
>>     - containers
>>     - containers-layer2
>>     - containers-layer3
>>     - build
>> +  - test
>>=20=20=20
>>   include:
>>     - local: '/.gitlab-ci.d/edk2.yml'
>> @@ -24,26 +28,82 @@ include:
>>           ../configure --enable-werror $CONFIGURE_ARGS ;
>>         fi
>>       - make -j"$JOBS"
>> -    - make -j"$JOBS" $MAKE_CHECK_ARGS
>> +    - if test -n "$MAKE_CHECK_ARGS";
>> +      then
>> +        make $MAKE_CHECK_ARGS ;
>> +      fi
>> +
>> +.native_test_job_template: &native_test_job_definition
>> +  stage: test
>> +  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
>> +  script:
>> +    - cd build
>> +    - find . -type f -exec touch {} +
>> +    - make $MAKE_CHECK_ARGS
>> +
>> +.post_acceptance_template: &post_acceptance
>> +  after_script:
>> +    - python3 -c 'import json; r =3D json.load(open("tests/results/late=
st/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"]=
 not in ("PASS", "SKIP")]' | xargs cat
>> +    - du -chs $HOME/avocado/data/cache
>>=20=20=20
>> -build-system1:
>> +build:system-ubuntu-main:
>>     <<: *native_build_job_definition
>>     variables:
>>       IMAGE: ubuntu2004
>>       TARGETS: aarch64-softmmu alpha-softmmu cris-softmmu hppa-softmmu l=
m32-softmmu
>>         moxie-softmmu microblazeel-softmmu mips64el-softmmu m68k-softmmu=
 ppc-softmmu
>>         riscv64-softmmu sparc-softmmu
>> +  artifacts:
>> +    paths:
>> +      - build
>> +
>> +check:system-ubuntu-main:
>> +  <<: *native_test_job_definition
>> +  needs:
>> +    - job: build:system-ubuntu-main
>> +      artifacts: true
>> +  variables:
>> +    IMAGE: ubuntu2004
>>       MAKE_CHECK_ARGS: check
>>=20=20=20
>> -build-system2:
>> +acceptance:system-ubuntu-main:
>> +  <<: *native_test_job_definition
>> +  needs:
>> +    - job: build:system-ubuntu-main
>> +      artifacts: true
>> +  variables:
>> +    IMAGE: ubuntu2004
>> +    MAKE_CHECK_ARGS: check-acceptance
>> +
>> +build:system-fedora-alt:
>>     <<: *native_build_job_definition
>>     variables:
>>       IMAGE: fedora
>>       TARGETS: tricore-softmmu unicore32-softmmu microblaze-softmmu mips=
-softmmu
>>         riscv32-softmmu s390x-softmmu sh4-softmmu sparc64-softmmu x86_64=
-softmmu
>>         xtensa-softmmu nios2-softmmu or1k-softmmu
>> +  artifacts:
>> +    paths:
>> +      - build
>> +
>> +check:system-fedora-alt:
>> +  <<: *native_test_job_definition
>> +  needs:
>> +    - job: build:system-fedora-alt
>> +      artifacts: true
>> +  variables:
>> +    IMAGE: fedora
>>       MAKE_CHECK_ARGS: check
>>=20=20=20
>> +check:system-fedora-alt:
>> +  <<: *native_test_job_definition
>> +  needs:
>> +    - job: build:system-fedora-alt
>> +      artifacts: true
>> +  variables:
>> +    IMAGE: fedora
>> +    MAKE_CHECK_ARGS: check-acceptance
>
> Why is Ubuntu "-main" and "Fedora "-alt" ? ... that does not make sense=20
> to me.

In a previous revision I had one do MAIN_SOFTMMU_TARGETS and therefor
the other was the alternate ones.

> We also might want to rework the list of targets. To speed up the=20
> testing, I originally omitted some targets like sh4eb-softmmu which did=20
> not seem very interesting, but now that we add more and more builds in=20
> parallel, we could maybe split the two system targets into three or even=
=20
> four instead, and then add these targets, too. It would also be nice to=20
> have some tests with "centos8" and a debian container, too.
>
> And "rx-softmmu" is also still missing in the target list.
>
> Ok, it's quite a bit of change that still needs to be done here ...=20
> maybe that's rather something for a separate patch later.

It's getting tricky with --target-list and target-list-exclude because
the run times are getting quite long although the splitting helps.

>
>   Thomas


--=20
Alex Benn=C3=A9e


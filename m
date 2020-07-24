Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19812C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B44206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWtNhqU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B44206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz0jo-0002Rk-1m
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 12:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jz0it-0000bW-4m
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:39:03 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jz0ir-0001UB-6M
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:39:02 -0400
Received: by mail-wm1-x341.google.com with SMTP id c80so8500134wme.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 09:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=M1ywS3JuuBHjGFiuytvjByOCh82CYAK+09EO/apj9e4=;
 b=CWtNhqU7B7++66aixkGS8feEqrWmv2yba9qfY4vrXYuI6yEtZ809COkcb/slMDmhAW
 Ck9yxfWOASYv5Vpy5+ufZR7x5VXMihpAFKPYTlAE86//PcJRWoIh82jeSqzX6OmW8SvX
 Rfa57cw6IMeOX5nCHbZL1WkJE3gfueT1miT55+dKKZL2qOOK0z2MTWguRlrbpitgZSHW
 Pm1+jGEhoXjiE4yfFEKSJmhHePkXgcjncAsNEGKe5R6ZkoTtC28lQZxXL421ltztJAaI
 OvzboutXkS4lUBd4MQEykzn6TNeWlk4qd2kDqS3qe3zm30GFgGq2yO4KM8yfPuiGIa2B
 dI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M1ywS3JuuBHjGFiuytvjByOCh82CYAK+09EO/apj9e4=;
 b=RoIBxLcoyVvi33/Lv0wlK3cUebbA4Jw7gqbxEhESMDj1jqCmm6mk9DgRRfuL+XX6Rc
 MjFe+Ik4nXDLGdJq5UpqMexriB7RRKIbyKSN8CtMJCssUOpCZLbkK2wa7vt30CjXyyV0
 VVkic1JLjY7HcwiSkXIj8TFeBaQeo+FkuYb/0ufCxqJK8NuEZUBoUZi7z6PUPkO24DPh
 2LgRqDf71VsiIty36El08fFA8HzfPnpTR86PLjdRuXb2tySo4jCtzOIwuc/JzXFErC8/
 vZZcCikCIdu1qWZlXaGz7tesLVVvhJDyRs5eOc20RQgW5r7rMkiWvVUyF4PdGXlLg33E
 gPCg==
X-Gm-Message-State: AOAM531QxidqT4KBfrlLib2il9VnXxjfo+wxObdwCjK5aBu/7ukcZKgF
 3Raer900J/G3CG0YQiX/Q/g=
X-Google-Smtp-Source: ABdhPJwJQPrIn7Exxay97zNsYjI5EAjJZPGwmSAMuICkDMKw/5hhkqbzrH/3KNA5gTx+Ld4o1Hd/Xw==
X-Received: by 2002:a1c:3bc1:: with SMTP id i184mr9346983wma.119.1595608739137; 
 Fri, 24 Jul 2020 09:38:59 -0700 (PDT)
Received: from [192.168.1.33] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id j6sm2026187wro.25.2020.07.24.09.38.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 09:38:58 -0700 (PDT)
Subject: Re: [PATCH v2] gitlab-ci: Fix Avocado cache usage
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20200724074251.28782-1-f4bug@amsat.org>
 <ad3b1a85-3ac0-e21f-1d39-3e9dc6e9635a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4dbee992-d14f-343f-2d04-60b4db411c3c@amsat.org>
Date: Fri, 24 Jul 2020 18:38:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ad3b1a85-3ac0-e21f-1d39-3e9dc6e9635a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Willian Rampazzo <willianr@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/24/20 5:52 PM, Wainer dos Santos Moschetta wrote:
> Hi Philippe,
> 
> On 7/24/20 4:42 AM, Philippe Mathieu-Daudé wrote:
>> In commit 6957fd98dc ("gitlab: add avocado asset caching") we
>> tried to save the Avocado cache (as in commit c1073e44b4 with
>> Travis-CI) however it doesn't work as expected. For some reason
>> Avocado uses /root/avocado_cache/ which we can not select later.
>>
>> Manually generate a Avocado config to force the use of the
>> current directory.
>>
>> We add a new 'build-acceptance-cache' job that runs first,
>> (during the 'build' stage) to create/update the cache.
>>
>> The cache content is then pulled (but not updated) during the
>> 'test' stage.
>>
>> See:
>> - https://docs.gitlab.com/ee/ci/caching/
>> -
>> https://avocado-framework.readthedocs.io/en/latest/guides/writer/chapters/writing.html#fetching-asset-files
>>
>>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Fixes: 6957fd98dc ("gitlab: add avocado asset caching")
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> Since v1:
>> - add a specific 'build-acceptance-cache' job
>>
>> Thomas prefers to use a different cache for each job.
>> Since I had this patch ready, I prefer to post it as
>> v2 and will work on a v3 using Thomas suggestion.
>>
>> Supersedes: <20200723200318.28214-1-f4bug@amsat.org>
>> Based-on: <20200724073524.26589-1-f4bug@amsat.org>
>>            "tests: Add 'fetch-acceptance' rule"
>> ---
>>   .gitlab-ci.yml | 61 ++++++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 52 insertions(+), 9 deletions(-)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 362e5ee755..a8d8a7e849 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -8,11 +8,9 @@ stages:
>>     - build
>>     - test
>>   -# We assume GitLab has it's own caching set up for RPM/APT
>> repositories so we
>> -# just take care of avocado assets here.
>> -cache:
>> -  paths:
>> -    - $HOME/avocado/data/cache
>> +# We assume GitLab has it's own caching set up for RPM/APT repositories
>> +cache: &global_cache
>> +  policy: pull
>>     include:
>>     - local: '/.gitlab-ci.d/edk2.yml'
>> @@ -47,11 +45,52 @@ include:
>>       - find . -type f -exec touch {} +
>>       - make $MAKE_CHECK_ARGS
>>   -.post_acceptance_template: &post_acceptance
>> +.acceptance_template: &acceptance_definition
> 
> What if you:
> 
> - Keep the post_acceptance section which defines the common after_script
> only.
> 
> - Create the acceptance_definition as you did, with before_script only.
> This way it doesn't need to repeat the logic in build-acceptance-cache
> job definition.

See below [*].

> 
> 
>> +  cache:
>> +    # inherit all global cache settings
>> +    <<: *global_cache
>> +    key: acceptance_cache
>> +    paths:
>> +      - $CI_PROJECT_DIR/avocado_cache
>> +    policy: pull
> 
> Isn't this policy inherited from global settings already?

Uh, bug! I had it right and messed when cleaning before posting...
This one is "pull-push" (while global_cache is pull).

> 
>> +  before_script:
>> +    - JOBS=$(expr $(nproc) + 1)
>> +    - mkdir -p ~/.config/avocado
>> +    - echo "[datadir.paths]" > ~/.config/avocado/avocado.conf
>> +    - echo "cache_dirs = ['${CI_PROJECT_DIR}/avocado_cache']" >>
>> ~/.config/avocado/avocado.conf
>>     after_script:
>>       - cd build
>>       - python3 -c 'import json; r =
>> json.load(open("tests/results/latest/results.json"));
>> [print(t["logfile"]) for t in r["tests"] if t["status"] not in
>> ("PASS", "SKIP")]' | xargs cat
>> -    - du -chs $HOME/avocado/data/cache
>> +    - du -chs $CI_PROJECT_DIR/avocado_cache
>> +
>> +build-acceptance-cache:
>> +  stage: build
>> +  cache:
>> +    # inherit all global cache settings
>> +    <<: *global_cache
>> +    key: acceptance_cache
>> +    paths:
>> +      - $CI_PROJECT_DIR/avocado_cache
>> +    policy: pull-push
>> +  variables:
>> +    # any image should work
>> +    IMAGE: ubuntu2004
>> +    CONFIGURE_ARGS: --disable-user --disable-system
>> +      --disable-docs --disable-tools
>> +    MAKE_CHECK_ARGS: fetch-acceptance
>> +  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
>> +  before_script:
>> +    - mkdir -p ~/.config/avocado
>> +    - echo "[datadir.paths]" > ~/.config/avocado/avocado.conf
>> +    - echo "cache_dirs = ['${CI_PROJECT_DIR}/avocado_cache']" >>
>> ~/.config/avocado/avocado.conf
>> +  script:
>> +    - mkdir build
>> +    - cd build
>> +    - ../configure --disable-user --disable-system --disable-docs
>> --disable-tools
> Use the CONFIGURE_ARGS variable here, or not define it.
>> +    # ignore "asset fetched or already on cache" error
>> +    - make fetch-acceptance || true
> 
> Likewise for MAKE_CHECK_ARGS.

[*] The point here is to not call 'make -j"$JOBS"'. Using
variables for the same script seems over complicated IMO.

> 
> Regards,
> 
> Wainer
> 
>> +  after_script:
>> +    - du -chs $CI_PROJECT_DIR/avocado_cache
>>     build-system-ubuntu-main:
>>     <<: *native_build_job_definition
>> @@ -76,13 +115,15 @@ check-system-ubuntu-main:
>>     acceptance-system-ubuntu-main:
>>     <<: *native_test_job_definition
>> +  <<: *acceptance_definition
>>     needs:
>>       - job: build-system-ubuntu-main
>>         artifacts: true
>> +    - job: build-acceptance-cache
>> +      artifacts: false
>>     variables:
>>       IMAGE: ubuntu2004
>>       MAKE_CHECK_ARGS: check-acceptance
>> -  <<: *post_acceptance
>>     build-system-fedora-alt:
>>     <<: *native_build_job_definition
>> @@ -107,13 +148,15 @@ check-system-fedora-alt:
>>     acceptance-system-fedora-alt:
>>     <<: *native_test_job_definition
>> +  <<: *acceptance_definition
>>     needs:
>>       - job: build-system-fedora-alt
>>         artifacts: true
>> +    - job: build-acceptance-cache
>> +      artifacts: false
>>     variables:
>>       IMAGE: fedora
>>       MAKE_CHECK_ARGS: check-acceptance
>> -  <<: *post_acceptance
>>     build-disabled:
>>     <<: *native_build_job_definition
> 


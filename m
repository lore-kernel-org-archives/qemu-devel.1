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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4A4C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 15:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 690122063A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 15:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BIbPb8Yo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690122063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz01v-0001LE-Np
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 11:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wainersm@redhat.com>)
 id 1jz00b-00007t-AJ
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 11:53:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51517
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wainersm@redhat.com>)
 id 1jz00Y-0002AY-QG
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 11:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595605992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EJhX5NHEqamElHfMx1gUnCGSOf8k9avle2vpCKVj7ok=;
 b=BIbPb8YoLUDhAWV4Cers72uvyX0thYpDfzDEf4uKy3DZwsZKMkFqv/w9Oj7pgCQNoM3W69
 uSDeIFyQ+fbvZjqjY0LdgIZ+ODzThrdRYO1PRRxWwKw3gf/6ZlBNnGVxqwPmobNSjCpvNo
 ydts1gxMaY7VrepNTASfw4OlbusOblQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-odZlaTzBOCOFq26Pmzv7Jw-1; Fri, 24 Jul 2020 11:53:09 -0400
X-MC-Unique: odZlaTzBOCOFq26Pmzv7Jw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEFC0802B73;
 Fri, 24 Jul 2020 15:52:59 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-96.gru2.redhat.com
 [10.97.116.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BA0D5C221;
 Fri, 24 Jul 2020 15:52:52 +0000 (UTC)
Subject: Re: [PATCH v2] gitlab-ci: Fix Avocado cache usage
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200724074251.28782-1-f4bug@amsat.org>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <ad3b1a85-3ac0-e21f-1d39-3e9dc6e9635a@redhat.com>
Date: Fri, 24 Jul 2020 12:52:51 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200724074251.28782-1-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wainersm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=wainersm@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:00:27
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
Cc: Willian Rampazzo <willianr@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On 7/24/20 4:42 AM, Philippe Mathieu-Daudé wrote:
> In commit 6957fd98dc ("gitlab: add avocado asset caching") we
> tried to save the Avocado cache (as in commit c1073e44b4 with
> Travis-CI) however it doesn't work as expected. For some reason
> Avocado uses /root/avocado_cache/ which we can not select later.
>
> Manually generate a Avocado config to force the use of the
> current directory.
>
> We add a new 'build-acceptance-cache' job that runs first,
> (during the 'build' stage) to create/update the cache.
>
> The cache content is then pulled (but not updated) during the
> 'test' stage.
>
> See:
> - https://docs.gitlab.com/ee/ci/caching/
> - https://avocado-framework.readthedocs.io/en/latest/guides/writer/chapters/writing.html#fetching-asset-files
>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Fixes: 6957fd98dc ("gitlab: add avocado asset caching")
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Since v1:
> - add a specific 'build-acceptance-cache' job
>
> Thomas prefers to use a different cache for each job.
> Since I had this patch ready, I prefer to post it as
> v2 and will work on a v3 using Thomas suggestion.
>
> Supersedes: <20200723200318.28214-1-f4bug@amsat.org>
> Based-on: <20200724073524.26589-1-f4bug@amsat.org>
>            "tests: Add 'fetch-acceptance' rule"
> ---
>   .gitlab-ci.yml | 61 ++++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 52 insertions(+), 9 deletions(-)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 362e5ee755..a8d8a7e849 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -8,11 +8,9 @@ stages:
>     - build
>     - test
>   
> -# We assume GitLab has it's own caching set up for RPM/APT repositories so we
> -# just take care of avocado assets here.
> -cache:
> -  paths:
> -    - $HOME/avocado/data/cache
> +# We assume GitLab has it's own caching set up for RPM/APT repositories
> +cache: &global_cache
> +  policy: pull
>   
>   include:
>     - local: '/.gitlab-ci.d/edk2.yml'
> @@ -47,11 +45,52 @@ include:
>       - find . -type f -exec touch {} +
>       - make $MAKE_CHECK_ARGS
>   
> -.post_acceptance_template: &post_acceptance
> +.acceptance_template: &acceptance_definition

What if you:

- Keep the post_acceptance section which defines the common after_script 
only.

- Create the acceptance_definition as you did, with before_script only. 
This way it doesn't need to repeat the logic in build-acceptance-cache 
job definition.


> +  cache:
> +    # inherit all global cache settings
> +    <<: *global_cache
> +    key: acceptance_cache
> +    paths:
> +      - $CI_PROJECT_DIR/avocado_cache
> +    policy: pull

Isn't this policy inherited from global settings already?

> +  before_script:
> +    - JOBS=$(expr $(nproc) + 1)
> +    - mkdir -p ~/.config/avocado
> +    - echo "[datadir.paths]" > ~/.config/avocado/avocado.conf
> +    - echo "cache_dirs = ['${CI_PROJECT_DIR}/avocado_cache']" >> ~/.config/avocado/avocado.conf
>     after_script:
>       - cd build
>       - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
> -    - du -chs $HOME/avocado/data/cache
> +    - du -chs $CI_PROJECT_DIR/avocado_cache
> +
> +build-acceptance-cache:
> +  stage: build
> +  cache:
> +    # inherit all global cache settings
> +    <<: *global_cache
> +    key: acceptance_cache
> +    paths:
> +      - $CI_PROJECT_DIR/avocado_cache
> +    policy: pull-push
> +  variables:
> +    # any image should work
> +    IMAGE: ubuntu2004
> +    CONFIGURE_ARGS: --disable-user --disable-system
> +      --disable-docs --disable-tools
> +    MAKE_CHECK_ARGS: fetch-acceptance
> +  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
> +  before_script:
> +    - mkdir -p ~/.config/avocado
> +    - echo "[datadir.paths]" > ~/.config/avocado/avocado.conf
> +    - echo "cache_dirs = ['${CI_PROJECT_DIR}/avocado_cache']" >> ~/.config/avocado/avocado.conf
> +  script:
> +    - mkdir build
> +    - cd build
> +    - ../configure --disable-user --disable-system --disable-docs --disable-tools
Use the CONFIGURE_ARGS variable here, or not define it.
> +    # ignore "asset fetched or already on cache" error
> +    - make fetch-acceptance || true

Likewise for MAKE_CHECK_ARGS.

Regards,

Wainer

> +  after_script:
> +    - du -chs $CI_PROJECT_DIR/avocado_cache
>   
>   build-system-ubuntu-main:
>     <<: *native_build_job_definition
> @@ -76,13 +115,15 @@ check-system-ubuntu-main:
>   
>   acceptance-system-ubuntu-main:
>     <<: *native_test_job_definition
> +  <<: *acceptance_definition
>     needs:
>       - job: build-system-ubuntu-main
>         artifacts: true
> +    - job: build-acceptance-cache
> +      artifacts: false
>     variables:
>       IMAGE: ubuntu2004
>       MAKE_CHECK_ARGS: check-acceptance
> -  <<: *post_acceptance
>   
>   build-system-fedora-alt:
>     <<: *native_build_job_definition
> @@ -107,13 +148,15 @@ check-system-fedora-alt:
>   
>   acceptance-system-fedora-alt:
>     <<: *native_test_job_definition
> +  <<: *acceptance_definition
>     needs:
>       - job: build-system-fedora-alt
>         artifacts: true
> +    - job: build-acceptance-cache
> +      artifacts: false
>     variables:
>       IMAGE: fedora
>       MAKE_CHECK_ARGS: check-acceptance
> -  <<: *post_acceptance
>   
>   build-disabled:
>     <<: *native_build_job_definition



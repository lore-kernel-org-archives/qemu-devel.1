Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA8FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EEEA20709
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evQN4ufS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EEEA20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joOJc-0000Zq-SA
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 05:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joOIg-0008Fq-Qo
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:36:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60885
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joOIe-0004rm-IS
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593077763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9c0yusJAxB3TmwNrBcC+tj896Hqe1T0MUXp7p5hFbcM=;
 b=evQN4ufSbgwYRwIfqhYI+r01Wo8lDC95ED60vUbGatnXjgMS0YtmGjGMXv/PhMxglvLAQY
 KQmvX4xcWXLEEkRMGYCv78shxScxMM9NaJnpwxGuw8y//bmvArHV0okFe94Ik4IMwPiyMW
 Da5pAKE/5P90ngN5XpF2ribgvd3BMvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-j-2wYjrwOIq2RRYhV2px0w-1; Thu, 25 Jun 2020 05:36:02 -0400
X-MC-Unique: j-2wYjrwOIq2RRYhV2px0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 048FF805EE1;
 Thu, 25 Jun 2020 09:36:01 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-150.ams2.redhat.com [10.36.112.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BEB310016DA;
 Thu, 25 Jun 2020 09:35:55 +0000 (UTC)
Subject: Re: [PATCH RFC 2/3] gitlab: build all container images during CI
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200622153318.751107-1-berrange@redhat.com>
 <20200622153318.751107-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b9da6d29-0615-d96d-5fb7-ba4dc2d5f3d8@redhat.com>
Date: Thu, 25 Jun 2020 11:35:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200622153318.751107-3-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/06/2020 17.33, Daniel P. Berrangé wrote:
> We have a number of container images in tests/docker/dockerfiles
> that are intended to provide well defined environments for doing
> test builds. We want our CI system to use these containers too.
> 
> This introduces builds of all of them as the first stage in the
> CI, so that the built containers are available for later build
> jobs. The containers are setup to use the GitLab container
> registry as the cache, so we only pay the penalty of the full
> build when the dockerfiles change. The main qemu-project/qemu
> repo is used as a second cache, so that users forking QEMU will
> see a fast turnaround time on their CI jobs.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/containers.yml | 248 ++++++++++++++++++++++++++++++++++++
>   .gitlab-ci.yml              |   3 +
>   2 files changed, 251 insertions(+)
>   create mode 100644 .gitlab-ci.d/containers.yml
> 
> diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
> new file mode 100644
> index 0000000000..ea1edbb196
> --- /dev/null
> +++ b/.gitlab-ci.d/containers.yml
> @@ -0,0 +1,248 @@
> +
> +
> +.container_job_template: &container_job_definition
> +  image: docker:stable
> +  stage: containers
> +  services:
> +    - docker:dind
> +  before_script:
> +    - export TAG="$CI_REGISTRY_IMAGE/ci-$NAME:latest"
> +    - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/ci-$NAME:latest"
> +    - docker info
> +    - docker login registry.gitlab.com -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"

I can see this in the output:

WARNING! Using --password via the CLI is insecure. Use --password-stdin.

I have to admit that I have only little knowledge about docker ... but 
could there be an issue here? Should this be done in a different way?

> +  script:
> +    - docker pull "$TAG" || docker pull "$COMMON_TAG" || true
> +    - sed -i -e "s,FROM qemu:,FROM $CI_REGISTRY_IMAGE/ci-," tests/docker/dockerfiles/$NAME.docker
> +    - docker build --cache-from "$TAG" --cache-from "$COMMON_TAG" --tag "$TAG" -f "tests/docker/dockerfiles/$NAME.docker" tests/docker/dockerfiles
> +    - docker push "$TAG"
> +  after_script:
> +    - docker logout
> +
> +amd64-centos7-container:
> +  <<: *container_job_definition
> +  variables:
> +    NAME: centos7
> +
> +amd64-centos8-container:
> +  <<: *container_job_definition
> +  variables:
> +    NAME: centos8
> +
> +amd64-debian10-container:
> +  <<: *container_job_definition
> +  variables:
> +    NAME: debian10
> +
> +amd64-debian11-container:
> +  <<: *container_job_definition
> +  variables:
> +    NAME: debian11
> +
> +amd64-debian9-container:
> +  <<: *container_job_definition
> +  variables:
> +    NAME: debian9
> +
> +amd64-debian9-mxe-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian9-container']
> +  variables:
> +    NAME: debian9-mxe
> +
> +alpha-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian10-container']
> +  variables:
> +    NAME: debian-alpha-cross
> +
> +amd64-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian10-container']
> +  variables:
> +    NAME: debian-amd64-cross
> +
> +amd64-debian-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian10-container']
> +  variables:
> +    NAME: debian-amd64
> +
> +arm64-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian10-container']
> +  variables:
> +    NAME: debian-arm64-cross
> +
> +arm64-test-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian11-container']
> +  variables:
> +    NAME: debian-arm64-test-cross
> +
> +armel-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian10-container']
> +  variables:
> +    NAME: debian-armel-cross
> +
> +armhf-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian10-container']
> +  variables:
> +    NAME: debian-armhf-cross
> +
> +hppa-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian10-container']
> +  variables:
> +    NAME: debian-hppa-cross
> +
> +m68k-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian10-container']
> +  variables:
> +    NAME: debian-m68k-cross
> +
> +mips64-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian10-container']
> +  variables:
> +    NAME: debian-mips64-cross
> +
> +mips64el-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian10-container']
> +  variables:
> +    NAME: debian-mips64el-cross
> +
> +mips-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian10-container']
> +  variables:
> +    NAME: debian-mips-cross
> +
> +mipsel-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian10-container']
> +  variables:
> +    NAME: debian-mipsel-cross
> +
> +powerpc-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian10-container']
> +  variables:
> +    NAME: debian-powerpc-cross
> +
> +ppc64-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian10-container']
> +  variables:
> +    NAME: debian-ppc64-cross
> +
> +ppc64el-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian10-container']
> +  variables:
> +    NAME: debian-ppc64el-cross
> +
> +riscv64-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian10-container']
> +  variables:
> +    NAME: debian-riscv64-cross
> +
> +s390x-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian10-container']
> +  variables:
> +    NAME: debian-s390x-cross
> +
> +sh4-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian10-container']
> +  variables:
> +    NAME: debian-sh4-cross
> +
> +sparc64-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian10-container']
> +  variables:
> +    NAME: debian-sparc64-cross
> +
> +tricore-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer2
> +  needs: ['amd64-debian9-container']
> +  variables:
> +    NAME: debian-tricore-cross
> +
> +win32-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer3
> +  needs: ['amd64-debian9-mxe-container']
> +  variables:
> +    NAME: debian-win32-cross
> +
> +win64-debian-cross-container:
> +  <<: *container_job_definition
> +  stage: containers-layer3
> +  needs: ['amd64-debian9-mxe-container']
> +  variables:
> +    NAME: debian-win64-cross
> +
> +xtensa-debian-cross-container:
> +  <<: *container_job_definition
> +  variables:
> +    NAME: debian-xtensa-cross
> +
> +cris-fedora-cross-container:
> +  <<: *container_job_definition
> +  variables:
> +    NAME: fedora-cris-cross
> +
> +amd64-fedora-container:
> +  <<: *container_job_definition
> +  variables:
> +    NAME: fedora
> +
> +i386-fedora-cross-container:
> +  <<: *container_job_definition
> +  variables:
> +    NAME: fedora-i386-cross
> +
> +amd64-ubuntu1804-container:
> +  <<: *container_job_definition
> +  variables:
> +    NAME: ubuntu1804
> +
> +amd64-ubuntu2004-container:
> +  <<: *container_job_definition
> +  variables:
> +    NAME: ubuntu2004
> +
> +amd64-ubuntu-container:
> +  <<: *container_job_definition
> +  variables:
> +    NAME: ubuntu
> +
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 9fdc752ea6..72d688875f 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -1,10 +1,13 @@
>   stages:
>     - containers
> +  - containers-layer2
> +  - containers-layer3
>     - build
>   
>   include:
>     - local: '/.gitlab-ci.d/edk2.yml'
>     - local: '/.gitlab-ci.d/opensbi.yml'
> +  - local: '/.gitlab-ci.d/containers.yml'
>   
>   .update_apt_template: &before_script_apt
>    before_script:
> 

Acked-by: Thomas Huth <thuth@redhat.com>



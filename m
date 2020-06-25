Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF75C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD129206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBrp2v/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD129206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joOoX-0005NY-27
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1joOmp-0003F4-IX
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:07:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51375
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1joOmn-0002KA-9D
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593079632;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94NTy+WJjz/PzbnAJg63mZ5vF2J89DxMjCp1e+acriQ=;
 b=OBrp2v/Wk7v3DGhrA8TlYsNYPONLAa+vmSPttB/rhEA2a3J8B0T9+XibV6RN7Lmy16AQg7
 CscB5uQiGBJAP12iAzXbkxGCn3b2ut3Qtk/HHR1JOfElMu5B4awlrhakHmCWF5jq+c05V/
 SqXHY4/Zzv492AN8smvXAFOKB73J6NQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-AqvxZ_0NM7WiQ2YL_qu2uw-1; Thu, 25 Jun 2020 06:07:10 -0400
X-MC-Unique: AqvxZ_0NM7WiQ2YL_qu2uw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFB681800D4A;
 Thu, 25 Jun 2020 10:07:09 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED4ACA3944;
 Thu, 25 Jun 2020 10:07:04 +0000 (UTC)
Date: Thu, 25 Jun 2020 11:07:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 2/3] gitlab: build all container images during CI
Message-ID: <20200625100701.GE1009994@redhat.com>
References: <20200622153318.751107-1-berrange@redhat.com>
 <20200622153318.751107-3-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200622153318.751107-3-berrange@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 04:33:17PM +0100, Daniel P. Berrangé wrote:
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
>  .gitlab-ci.d/containers.yml | 248 ++++++++++++++++++++++++++++++++++++
>  .gitlab-ci.yml              |   3 +
>  2 files changed, 251 insertions(+)
>  create mode 100644 .gitlab-ci.d/containers.yml

Thinking about this at 3am with insomnia, I started considering possible
ways this could result in CI failures. I came up with

 - Distro repos are unavialable due to transient network/mirror problems
 
 - Distro pushes bad packages or changes something that invalidates QEMU
   assumptions

The first one can hit at any time, but I think that we're reasonably well
insulated from it due to our usage of caching. Only a small number of CI
jobs are going to actually trigger a full rebuild of an image, most will
just hit the cache.

The second one is probably not likely, *provided* we only use stable branches
of distros. It looks like we're ok in that regard as we're not using Debian
Sid, or Fedora rawhide for any images currently.

If we did want to reduce the risk though, we could mark some of the
container jobs as non-fatal. We could mark the subset of images that are
not actually required by later build jobs that we currently have.

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
>  stages:
>    - containers
> +  - containers-layer2
> +  - containers-layer3
>    - build
>  
>  include:
>    - local: '/.gitlab-ci.d/edk2.yml'
>    - local: '/.gitlab-ci.d/opensbi.yml'
> +  - local: '/.gitlab-ci.d/containers.yml'
>  
>  .update_apt_template: &before_script_apt
>   before_script:
> -- 
> 2.24.1
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



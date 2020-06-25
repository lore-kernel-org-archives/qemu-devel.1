Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F3BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:15:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B062076E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXA2I6y7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B062076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joOui-0002Ni-Km
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joOu7-0001wC-HX
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:14:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31016
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joOu5-0003ix-9s
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593080083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T2fSux9bb+o+V81aE7I3ffJXxyo2lH97r+hupqzEj04=;
 b=hXA2I6y77vjTRChSluVR9o01LIUEPrphGBxbarYfoMUAm4tb3Ejmjpdwfo3CAyPdfnZZOa
 vQknLCYJtjSj7ll5BEEa+z+J65mbNVSrvfE0YnemhApz6cg8jyuHPUzGRxKMsnlQAEk/tk
 W5+RUEsggo+ThcybHhGnLvp42XSIIHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-PyA7biy_NZG6c-9conpX7g-1; Thu, 25 Jun 2020 06:14:41 -0400
X-MC-Unique: PyA7biy_NZG6c-9conpX7g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47382BFC2;
 Thu, 25 Jun 2020 10:14:40 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-150.ams2.redhat.com [10.36.112.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F6115BAC9;
 Thu, 25 Jun 2020 10:14:35 +0000 (UTC)
Subject: Re: [PATCH RFC 2/3] gitlab: build all container images during CI
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200622153318.751107-1-berrange@redhat.com>
 <20200622153318.751107-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <745e1e86-3042-7b7c-89c7-81eb9a8f7905@redhat.com>
Date: Thu, 25 Jun 2020 12:14:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200622153318.751107-3-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
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
> +  script:
> +    - docker pull "$TAG" || docker pull "$COMMON_TAG" || true
> +    - sed -i -e "s,FROM qemu:,FROM $CI_REGISTRY_IMAGE/ci-," tests/docker/dockerfiles/$NAME.docker
> +    - docker build --cache-from "$TAG" --cache-from "$COMMON_TAG" --tag "$TAG" -f "tests/docker/dockerfiles/$NAME.docker" tests/docker/dockerfiles
> +    - docker push "$TAG"
> +  after_script:
> +    - docker logout

.gitlab-ci.d/edk2.yml uses a "changes" rule to only run the pipeline if 
something really has been changed. Could you use something similar here? 
E.g.:

rules:
  - changes:
    - .gitlab-ci.d/containers.yml
    - tests/docker/*
    - tests/docker/dockerfiles/*

?

  Thomas



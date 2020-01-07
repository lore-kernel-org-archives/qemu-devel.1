Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0008C282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 19:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA942080A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 19:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQgDl+i5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA942080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iouMo-0001Ai-3N
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 14:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iouKw-0008DF-Rm
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:16:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iouKu-0006Ro-5K
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:16:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50118
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iouKu-0006Qr-1d
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578424575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BSQKB1C+oi1dlxxhi6PWE3Ei1e7foJmCgOsMpVdObUs=;
 b=IQgDl+i5N5ClfABOnf1mN+uA2f54mf7cUREB2KfvNwUn6aggrC3rIwsrEGFtsymlF65uZh
 egpki67H0TgF8DXB7vINHCqXBdrP/aracpZeaD4OKSJiTeuk5Eegxyi0k08l9NSkOG6xGH
 8yWfvOr9+2784iahSx7HWVER3UmDeBw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-4Pd3snNXMXqN7NjYDEF5sg-1; Tue, 07 Jan 2020 14:16:13 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F5231923251;
 Tue,  7 Jan 2020 19:16:12 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-126.ams2.redhat.com
 [10.36.117.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 856B410027BA;
 Tue,  7 Jan 2020 19:16:08 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] gitlab-ci.yml: Add jobs to build the EDK2 firmware
 binaries
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200107153154.21401-1-philmd@redhat.com>
 <20200107153154.21401-3-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <be9b76e9-d22b-5189-6b30-b6ffbe03f10d@redhat.com>
Date: Tue, 7 Jan 2020 20:16:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200107153154.21401-3-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 4Pd3snNXMXqN7NjYDEF5sg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/07/20 16:31, Philippe Mathieu-Daud=C3=A9 wrote:
> Add two GitLab job to build the EDK2 firmware binaries.
>=20
> The first job build a Docker image with the packages requisite
> to build EDK2, and store this image in the GitLab registry.
> The second job pull the image from the registry and build the
> EDK2 firmware binaries.
>=20
> The docker image is only rebuilt if the GitLab YAML or the
> Dockerfile is updated.
> The second job is only built when the roms/edk2/ submodule is
> updated, when a git-ref starts with 'edk2' or when the last
> commit contains 'EDK2'. The files generated are archived in
> the artifacts.zip file.
>=20
> With edk2-stable201905, it took 2 minutes 52 seconds to build
> the docker image, and 36 minutes 28 seconds to generate the
> artifacts.zip with the firmware binaries (filesize: 10MiB).
>=20
> See: https://gitlab.com/philmd/qemu/pipelines/107553178
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2:
> - Split job, build docker image first
> - addressed Laszlo comments but kept the git-submodule-update call
> ---
>  .gitlab-ci-edk2.yml          | 49 ++++++++++++++++++++++++++++++++++++
>  .gitlab-ci.d/edk2/Dockerfile | 27 ++++++++++++++++++++
>  .gitlab-ci.yml               |  3 +++
>  MAINTAINERS                  |  4 ++-
>  4 files changed, 82 insertions(+), 1 deletion(-)
>  create mode 100644 .gitlab-ci-edk2.yml
>  create mode 100644 .gitlab-ci.d/edk2/Dockerfile
>=20
> diff --git a/.gitlab-ci-edk2.yml b/.gitlab-ci-edk2.yml
> new file mode 100644
> index 0000000000..088ba4b43a
> --- /dev/null
> +++ b/.gitlab-ci-edk2.yml
> @@ -0,0 +1,49 @@
> +docker-edk2:
> + stage: build
> + rules: # Only run this job when the Dockerfile is modified
> + - changes:
> +   - .gitlab-ci-edk2.yml
> +   - .gitlab-ci.d/edk2/Dockerfile
> +   when: always
> + image: docker:19.03.1
> + services:
> + - docker:19.03.1-dind
> + variables:
> +  GIT_DEPTH: 3
> +  IMAGE_TAG: $CI_REGISTRY_IMAGE:edk2-cross-build
> +  # We don't use TLS
> +  DOCKER_HOST: tcp://docker:2375
> +  DOCKER_TLS_CERTDIR: ""
> + before_script:
> + - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGIST=
RY
> + script:
> + - docker pull $IMAGE_TAG || true
> + - docker build --cache-from $IMAGE_TAG --tag $CI_REGISTRY_IMAGE:$CI_COM=
MIT_SHA
> +                                        --tag $IMAGE_TAG .gitlab-ci.d/ed=
k2
> + - docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
> + - docker push $IMAGE_TAG
> +
> +build-edk2:
> + rules: # Only run this job when ...
> + - changes: # ... roms/edk2/ is modified (submodule updated)
> +   - roms/edk2/*
> +   when: always
> + - if: '$CI_COMMIT_REF_NAME =3D~ /^edk2/' # or the branch/tag starts wit=
h 'edk2'
> +   when: always
> + - if: '$CI_COMMIT_MESSAGE =3D~ /edk2/i' # or last commit description co=
ntains 'EDK2'
> +   when: always
> + artifacts:
> +   paths: # 'artifacts.zip' will contains the following files:
> +   - pc-bios/edk2*bz2
> +   - pc-bios/edk2-licenses.txt
> +   - edk2-stdout.log
> +   - edk2-stderr.log
> + image: $CI_REGISTRY_IMAGE:edk2-cross-build
> + variables:
> +   GIT_DEPTH: 3
> + script: # Clone the required submodules and build EDK2
> + - git submodule update --init roms/edk2
> + - git -C roms/edk2 submodule update --init
> + - export JOBS=3D$(($(getconf _NPROCESSORS_ONLN) + 1))
> + - echo "=3D=3D=3D Using ${JOBS} simultaneous jobs =3D=3D=3D"
> + - make -j${JOBS} -C roms efi 2>&1 1>edk2-stdout.log | tee -a edk2-stder=
r.log >&2
> diff --git a/.gitlab-ci.d/edk2/Dockerfile b/.gitlab-ci.d/edk2/Dockerfile
> new file mode 100644
> index 0000000000..b4584d1cf6
> --- /dev/null
> +++ b/.gitlab-ci.d/edk2/Dockerfile
> @@ -0,0 +1,27 @@
> +#
> +# Docker image to cross-compile EDK2 firmware binaries
> +#
> +FROM ubuntu:16.04
> +
> +MAINTAINER Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> +
> +# Install packages required to build EDK2
> +RUN apt update \
> +    && \
> +    \
> +    DEBIAN_FRONTEND=3Dnoninteractive \
> +    apt install --assume-yes --no-install-recommends \
> +        build-essential \
> +        ca-certificates \
> +        dos2unix \
> +        gcc-aarch64-linux-gnu \
> +        gcc-arm-linux-gnueabi \
> +        git \
> +        iasl \
> +        make \
> +        nasm \
> +        python \
> +        uuid-dev \
> +    && \
> +    \
> +    rm -rf /var/lib/apt/lists/*
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index ebcef0ebe9..f799246047 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -1,3 +1,6 @@
> +include:
> +  - local: '/.gitlab-ci-edk2.yml'
> +
>  before_script:
>   - apt-get update -qq
>   - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev geni=
soimage
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd2dc137a3..93620ed406 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2358,6 +2358,8 @@ F: roms/edk2
>  F: roms/edk2-*
>  F: tests/data/uefi-boot-images/
>  F: tests/uefi-test-tools/
> +F: .gitlab-ci-edk2.yml
> +F: .gitlab-ci.d/edk2/
> =20
>  Usermode Emulation
>  ------------------
> @@ -2701,7 +2703,7 @@ W: https://cirrus-ci.com/github/qemu/qemu
>  GitLab Continuous Integration
>  M: Thomas Huth <thuth@redhat.com>
>  S: Maintained
> -F: .gitlab-ci.yml
> +F: .gitlab-ci*.yml
> =20
>  Guest Test Compilation Support
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20

The Docker stuff is not my cup of tea, but the edk2 build stuff looks OK.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo



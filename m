Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A42C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:14:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D51E2073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6HTBsU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D51E2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iokwb-0005I2-RI
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 04:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iojb6-0007w3-Uw
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:48:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iojb5-0000hz-HN
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:48:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57182
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iojb5-0000he-Do
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578383295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TDsDpjQEeigFEbAW7KwgNlddB4JxuHx0FcxRbUhT+zQ=;
 b=O6HTBsU5i5YaZ1v2BvP4JQ3o4lCPB1n1EHwtu6EiDHGw1zsf+SGW9U8heknBYMqiXBw6Zb
 7nYupoKXE3bJ4NeckIbvQwNRQ+vKzjPHlVhz5UbL9ziF0d+0w3f7wEKy0apsVkSC7MR2bp
 yAFLvt0s/Ft+gO4zooEL68LKFu+WhDM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-xovdreAbNGOlNzHM1Ci5vQ-1; Tue, 07 Jan 2020 02:48:13 -0500
Received: by mail-wr1-f70.google.com with SMTP id u18so28232236wrn.11
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:48:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IkWmwLjSXadxN0KJJSgFhipvSsRqAGVMgxYrERWX2DU=;
 b=dHCjzS5Zuk7CSgEJMbjVjZrc1udXPAkMj42N4NFinBqQvUVK/Q5N8Sb33GYLVIyLUF
 LP2tFXJAkhqHMjQ6KE3TmaeN8ztHH/C5FwGLlowXpQjtXNLUhpahPJCDiv1BQ6OPjK2H
 tlK9+cPgFEo457ZhFuX5rvXGlGQXSKssE18vaof7D7bXf6QgGKLdCOa30e3MyFDM6m33
 cxEeBWUoyFVMqyYMC1L+h+2mkwJoK1lNw9yvq/drzSfA5x9indN9nuI0/VB+Bz5wA7Hu
 MO5J8yRPR/BdC+IkqY6oQl6pepTUu1F6OdHzVyWJJ/JjizzFHbyOIdJn5o0yMuDzP2Py
 UOLQ==
X-Gm-Message-State: APjAAAXiAh9bMKFfWi3Jr/LRjWu+2IEaaoEJ6TRdTaBYfL6sAncBw3rk
 XZPkt4y5IhANmkFk2aAzNIQmL2QmL2t7S7EeSq/OLh6dKfhP+xvPHK00hPzuW5mWg+N8GzOgTcD
 bDz4gv9KfaY7UDEw=
X-Received: by 2002:a7b:cf39:: with SMTP id m25mr39280719wmg.146.1578383291842; 
 Mon, 06 Jan 2020 23:48:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqw00GjYq36540x5z3siw3d/YG8EhWeS+M81fsDja4A58k9LHsloTOa9xoKQKeGXrvgye7OR/g==
X-Received: by 2002:a7b:cf39:: with SMTP id m25mr39280692wmg.146.1578383291524; 
 Mon, 06 Jan 2020 23:48:11 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id z11sm76003459wrt.82.2020.01.06.23.48.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2020 23:48:11 -0800 (PST)
Subject: Re: [PATCH 2/3] gitlab-ci.yml: Add a job to build EDK2 firmware
 binaries
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
References: <20200106184601.25453-1-philmd@redhat.com>
 <20200106184601.25453-3-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e77690e0-b3e1-37fd-3615-7c84c5490d6d@redhat.com>
Date: Tue, 7 Jan 2020 08:48:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200106184601.25453-3-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: xovdreAbNGOlNzHM1Ci5vQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On 1/6/20 7:46 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Add a GitLab job to build the EDK2 firmware binaries.
> This job is only built when the roms/edk2/ submodule is updated,
> when a git-ref starts with 'edk2' or when the last commit contains
> 'EDK2'.
>=20
> GitLab CI generates an artifacts.zip file containing the firmware
> binaries.
>=20
> With edk2-stable201905, the job took 40 minutes 26 seconds,
> the artifacts.zip takes 10MiB.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   .gitlab-ci-edk2.yml | 37 +++++++++++++++++++++++++++++++++++++
>   .gitlab-ci.yml      |  3 +++
>   MAINTAINERS         |  3 ++-
>   3 files changed, 42 insertions(+), 1 deletion(-)
>   create mode 100644 .gitlab-ci-edk2.yml
>=20
> diff --git a/.gitlab-ci-edk2.yml b/.gitlab-ci-edk2.yml
> new file mode 100644
> index 0000000000..abfaf52874
> --- /dev/null
> +++ b/.gitlab-ci-edk2.yml
> @@ -0,0 +1,37 @@
> +build-edk2:
> + rules: # Only run this job when ...
> + - changes: # ... roms/edk2/ is modified (submodule updated)
> +   - roms/edk2/*
> +   when: always
> + - if: '$CI_COMMIT_REF_NAME =3D~ /^edk2/' # ... the branch/tag starts wi=
th 'edk2'
> +   when: always
> + - if: '$CI_COMMIT_MESSAGE =3D~ /edk2/i' # last commit description conta=
ins 'EDK2'
> +   when: always
> + artifacts:
> +   paths: # 'artifacts.zip' will contains the following files:
> +   - pc-bios/edk2*bz2
> +   - pc-bios/edk2-licenses.txt
> +   - edk2-stdout.log
> +   - edk2-stderr.log
> + image: ubuntu:16.04 # Use Ubuntu Xenial
> + before_script: # Install packages requiered to build EDK2

typo "required"

> + - apt-get update --quiet --quiet
> + - DEBIAN_FRONTEND=3Dnoninteractive
> +   apt-get install --assume-yes --no-install-recommends --quiet --quiet
> +     build-essential
> +     ca-certificates
> +     dos2unix
> +     gcc-aarch64-linux-gnu
> +     gcc-arm-linux-gnueabi
> +     git
> +     iasl
> +     make
> +     nasm
> +     python
> +     uuid-dev
> + script: # Clone the required submodules and build EDK2
> + - git submodule update --init roms/edk2
> + - git -C roms/edk2 submodule update --init
> + - export JOBS=3D$(($(getconf _NPROCESSORS_ONLN) + 1))
> + - echo "=3D=3D=3D Using ${JOBS} simultaneous jobs =3D=3D=3D"
> + - make -j${JOBS} -C roms efi 1>edk2-stdout.log 2> >(tee -a edk2-stderr.=
log >&2)
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index ebcef0ebe9..f799246047 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -1,3 +1,6 @@
> +include:
> +  - local: '/.gitlab-ci-edk2.yml'
> +
>   before_script:
>    - apt-get update -qq
>    - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev gen=
isoimage
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8571327881..22a1fd5824 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2346,6 +2346,7 @@ F: roms/edk2
>   F: roms/edk2-*
>   F: tests/data/uefi-boot-images/
>   F: tests/uefi-test-tools/
> +F: .gitlab-ci-edk2.yml
>  =20
>   Usermode Emulation
>   ------------------
> @@ -2689,7 +2690,7 @@ W: https://cirrus-ci.com/github/qemu/qemu
>   GitLab Continuous Integration
>   M: Thomas Huth <thuth@redhat.com>
>   S: Maintained
> -F: .gitlab-ci.yml
> +F: .gitlab-ci*.yml
>  =20
>   Guest Test Compilation Support
>   M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20



Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9263BC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 20:31:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63FCD21D79
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 20:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FCD21D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDDwU-00032D-2g
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 16:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDDsj-0001OE-Es
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 16:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDDsg-0004W0-BZ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 16:27:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49336)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDDsg-0004V5-3d
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 16:27:22 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0683489AC0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 20:27:21 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id q10so37707wro.22
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 13:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ms99ka1ox/KGMSrY7TCk/Icutm9EG4MoHda48WjfdtM=;
 b=svFSl0S3GLSQH4HImZPE19PjmPu4yPcyxbfzzu76f8D6cyTKN4H9wewm2QHNkZS9c9
 y7aQca2nxm9rDlc9E55nh6PtZsh4365nhm+3rrKJcACUHnSikjMmzdNgoCdulCaupBro
 kbXFbGGPgxsCTxSWPGTdSILOy7lVGTRbVw7SPcvk95UvPMBHFbQw6iuZ39YN4yhUvIH3
 Os+fOBIh9k4+aE4yeKiL9iokraX/c2xl8no1c9gYdnvwbpzpc3gs6mSpiMWu31tV/X9+
 5lHZGRWVIxZA5FKwdnAQM1z03m8SMC8c69v//e5R0wL77WB6dANoLdI/e8pbAlXNcDjS
 h9/w==
X-Gm-Message-State: APjAAAVlDgw6yAU2MxQND8Ptsd9w3R0jEpswzdmO8p4zsnkHvz7NTATO
 r4R+fe1onwglIJYNUoUa3+5Uy3iFBOyw2ausE6ELrnAeshM9/Ilu3+KalAkACkp0y7lM/7Vvbs6
 hD/gpuEEqHtEq11w=
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr84605wml.10.1569443239758;
 Wed, 25 Sep 2019 13:27:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyQMLwRYBomYvhqvsneEaayh7iX5yjiydR6wruL0JaJ4VOO8cfhN2icayHRG+JTnE0p5aNI2w==
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr84587wml.10.1569443239523;
 Wed, 25 Sep 2019 13:27:19 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id d10sm59531wma.42.2019.09.25.13.27.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 13:27:18 -0700 (PDT)
Subject: Re: [PATCH v3 25/33] tests/docker: Add fedora-win10sdk-cross image
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-26-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7e2fffd9-4b88-870f-1c18-1f08c3f44737@redhat.com>
Date: Wed, 25 Sep 2019 22:27:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924210106.27117-26-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, jsnow@redhat.com, f4bug@amsat.org,
 Justin Terry <juterry@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On 9/24/19 11:00 PM, Alex Benn=C3=A9e wrote:
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> To build WHPX (Windows Hypervisor) binaries, we need the WHPX
> headers provided by the Windows SDK.

Justin is checking with his company if this patch is OK with them,
I'd rather wait before merging it:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg646351.html

Can you unqueue this and the next patch (which depends of it) meanwhile
please?

Thanks,

Phil.

> Add a script that fetches the required MSI/CAB files from the
> latest SDK (currently 10.0.18362.1).
>=20
> Headers are accessible under /opt/win10sdk/include.
>=20
> Set the QEMU_CONFIGURE_OPTS environment variable accordingly,
> enabling HAX and WHPX. Due to CPP warnings related to Microsoft
> specific #pragmas, we also need to use the '--disable-werror'
> configure flag.
>=20
> Cc: Justin Terry <juterry@microsoft.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20190920113329.16787-3-philmd@redhat.com>
> ---
>  tests/docker/Makefile.include                 |  2 ++
>  .../dockerfiles/fedora-win10sdk-cross.docker  | 23 ++++++++++++++++
>  tests/docker/dockerfiles/win10sdk-dl.sh       | 27 +++++++++++++++++++
>  3 files changed, 52 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/fedora-win10sdk-cross.dock=
er
>  create mode 100755 tests/docker/dockerfiles/win10sdk-dl.sh
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 3fc7a863e51..e85e73025ba 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -125,6 +125,8 @@ docker-image-debian-ppc64-cross: docker-image-debia=
n10
>  docker-image-debian-riscv64-cross: docker-image-debian10
>  docker-image-debian-sh4-cross: docker-image-debian10
>  docker-image-debian-sparc64-cross: docker-image-debian10
> +docker-image-fedora-win10sdk-cross: docker-image-fedora
> +docker-image-fedora-win10sdk-cross: EXTRA_FILES:=3D$(DOCKER_FILES_DIR)=
/win10sdk-dl.sh
> =20
>  docker-image-travis: NOUSER=3D1
> =20
> diff --git a/tests/docker/dockerfiles/fedora-win10sdk-cross.docker b/te=
sts/docker/dockerfiles/fedora-win10sdk-cross.docker
> new file mode 100644
> index 00000000000..55ca933d40d
> --- /dev/null
> +++ b/tests/docker/dockerfiles/fedora-win10sdk-cross.docker
> @@ -0,0 +1,23 @@
> +#
> +# Docker MinGW64 cross-compiler target with WHPX header installed
> +#
> +# This docker target builds on the Fedora 30 base image.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +FROM qemu:fedora
> +
> +RUN dnf install -y \
> +        cabextract \
> +        msitools \
> +        wget
> +
> +# Install WHPX headers from Windows Software Development Kit:
> +# https://developer.microsoft.com/en-us/windows/downloads/windows-10-s=
dk
> +ADD win10sdk-dl.sh /usr/local/bin/win10sdk-dl.sh
> +RUN /usr/local/bin/win10sdk-dl.sh
> +
> +ENV QEMU_CONFIGURE_OPTS ${QEMU_CONFIGURE_OPTS} \
> +    --cross-prefix=3Dx86_64-w64-mingw32- \
> +    --extra-cflags=3D-I/opt/win10sdk/include --disable-werror \
> +    --enable-hax --enable-whpx
> diff --git a/tests/docker/dockerfiles/win10sdk-dl.sh b/tests/docker/doc=
kerfiles/win10sdk-dl.sh
> new file mode 100755
> index 00000000000..1c35c2a2524
> --- /dev/null
> +++ b/tests/docker/dockerfiles/win10sdk-dl.sh
> @@ -0,0 +1,27 @@
> +#!/bin/bash
> +#
> +# Install WHPX headers from Windows Software Development Kit
> +# https://developer.microsoft.com/en-us/windows/downloads/windows-10-s=
dk
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +WINDIR=3D/opt/win10sdk
> +mkdir -p ${WINDIR}
> +pushd ${WINDIR}
> +# Get the bundle base for Windows SDK v10.0.18362.1
> +BASE_URL=3D$(curl --silent --include 'http://go.microsoft.com/fwlink/?=
prd=3D11966&pver=3D1.0&plcid=3D0x409&clcid=3D0x409&ar=3DWindows10&sar=3DS=
DK&o1=3D10.0.18362.1' | sed -nE 's_Location: (.*)/\r_\1_p')/Installers
> +# Fetch the MSI containing the headers
> +wget --no-verbose ${BASE_URL}/'Windows SDK Desktop Headers x86-x86_en-=
us.msi'
> +while true; do
> +    # Fetch all cabinets required by this MSI
> +    CAB_NAME=3D$(msiextract Windows\ SDK\ Desktop\ Headers\ x86-x86_en=
-us.msi 3>&1 2>&3 3>&-| sed -nE "s_.*Error opening file $PWD/(.*): No suc=
h file or directory_\1_p")
> +    test -z "${CAB_NAME}" && break
> +    wget --no-verbose ${BASE_URL}/${CAB_NAME}
> +done
> +rm *.{cab,msi}
> +mkdir /opt/win10sdk/include
> +# Only keep the WHPX headers
> +for inc in "${WINDIR}/Program Files/Windows Kits/10/Include/10.0.18362=
.0/um"/WinHv*; do
> +    ln -s "${inc}" /opt/win10sdk/include
> +done
> +popd > /dev/null
>=20


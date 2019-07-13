Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2195BC742A7
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 14:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E244420830
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 14:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E244420830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmJSW-0004lY-1l
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 10:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52367)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hmJSK-0004F4-I7
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 10:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hmJSJ-0007Pu-4J
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 10:56:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50305)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hmJSI-0007P5-TW
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 10:56:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so11319416wml.0
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2019 07:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RqJLY8lpsDPDZvp0h+DmOIWrKUuAgzNMrfP+VYR/8X4=;
 b=aOYb0ntpvieH3yfj/f5Bm+HRbOGuaw6Vuy3fwPPsVc4mS5qEQikQRkI1E2JbgHMS1i
 nsPgVKswfQ+fFC6o0if8Z8ccq9ltoTYp5UBThh10kw6b4Ro1phyJhWTiPWDwH5fAPL0c
 GSaAvVV1zKD+9Z09v8UHF1MzThtY8nRf92F6dfTMCWbcXwFazhxMDmd4hx/yV/N0ZVFE
 9czbWOp7FAwBz/5lnPBan2QqLxFOm7UjSLHOWx5RuM6DgC0oCoHE69cFVyhGoMZEWQVU
 i9W+36yXxEmkoKF/gikGZmsH5dlZ79+RPV/+yaDS3ehuBu3Guw4Fup3V+fMBaC126amj
 zbAA==
X-Gm-Message-State: APjAAAXntUCfQ3oBwzLVgnPBXPGUJUN5pwILcoDiYnnoixKJba97s2sB
 z9NbVaqlmf1hrLVAqo+na90qqw==
X-Google-Smtp-Source: APXvYqzGhnVDZlvuzK0sebFCqHsNtin9YtlaJhAuyyNSekj1AGJtxbVoG8N7+1tWQF9kErrYoMrXnw==
X-Received: by 2002:a1c:407:: with SMTP id 7mr15926633wme.113.1563029813516;
 Sat, 13 Jul 2019 07:56:53 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id r11sm15655848wre.14.2019.07.13.07.56.52
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sat, 13 Jul 2019 07:56:53 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190712111849.9006-1-alex.bennee@linaro.org>
 <20190712111849.9006-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c9409240-3afe-e9ca-0910-8c8ed48ef7af@redhat.com>
Date: Sat, 13 Jul 2019 16:56:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190712111849.9006-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v1 6/7] tests/dockerfiles: update the win
 cross builds to stretch
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
Cc: Fam Zheng <fam@euphon.net>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/19 1:18 PM, Alex Bennée wrote:
> While fixing up pkg.mxe.cc they move the URLs around a bit and dropped
> Jessie support in favour of Stretch. We also need to update the keys
> used to verify the packages.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include                         |  6 +++---
>  tests/docker/dockerfiles/debian-win32-cross.docker    |  4 ++--
>  tests/docker/dockerfiles/debian-win64-cross.docker    |  4 ++--
>  .../{debian8-mxe.docker => debian9-mxe.docker}        | 11 +++++++----
>  4 files changed, 14 insertions(+), 11 deletions(-)
>  rename tests/docker/dockerfiles/{debian8-mxe.docker => debian9-mxe.docker} (56%)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index aaf5396b85d..dbd58e548c1 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -85,7 +85,7 @@ endif
>  
>  # Enforce dependencies for composite images
>  docker-image-debian: docker-image-debian9
> -docker-image-debian8-mxe: docker-image-debian8
> +docker-image-debian9-mxe: docker-image-debian9
>  docker-image-debian-amd64: docker-image-debian9
>  docker-image-debian-armel-cross: docker-image-debian9
>  docker-image-debian-armhf-cross: docker-image-debian9
> @@ -96,8 +96,8 @@ docker-image-debian-mipsel-cross: docker-image-debian9
>  docker-image-debian-mips64el-cross: docker-image-debian9
>  docker-image-debian-ppc64el-cross: docker-image-debian9
>  docker-image-debian-s390x-cross: docker-image-debian9
> -docker-image-debian-win32-cross: docker-image-debian8-mxe
> -docker-image-debian-win64-cross: docker-image-debian8-mxe
> +docker-image-debian-win32-cross: docker-image-debian9-mxe
> +docker-image-debian-win64-cross: docker-image-debian9-mxe
>  
>  docker-image-debian-alpha-cross: docker-image-debian-sid
>  docker-image-debian-hppa-cross: docker-image-debian-sid
> diff --git a/tests/docker/dockerfiles/debian-win32-cross.docker b/tests/docker/dockerfiles/debian-win32-cross.docker
> index 0a4970c0683..c787e432454 100644
> --- a/tests/docker/dockerfiles/debian-win32-cross.docker
> +++ b/tests/docker/dockerfiles/debian-win32-cross.docker
> @@ -1,9 +1,9 @@
>  #
>  # Docker mingw32 cross-compiler target
>  #
> -# This docker target builds on the debian Jessie MXE base image.
> +# This docker target builds on the debian Stretch MXE base image.
>  #
> -FROM qemu:debian8-mxe
> +FROM qemu:debian9-mxe
>  
>  MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
>  
> diff --git a/tests/docker/dockerfiles/debian-win64-cross.docker b/tests/docker/dockerfiles/debian-win64-cross.docker
> index b27985b1b1f..a7068ed6ac6 100644
> --- a/tests/docker/dockerfiles/debian-win64-cross.docker
> +++ b/tests/docker/dockerfiles/debian-win64-cross.docker
> @@ -1,9 +1,9 @@
>  #
>  # Docker mingw64 cross-compiler target
>  #
> -# This docker target builds on the debian Jessie MXE base image.
> +# This docker target builds on the debian Stretch MXE base image.
>  #
> -FROM qemu:debian8-mxe
> +FROM qemu:debian9-mxe
>  
>  MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
>  
> diff --git a/tests/docker/dockerfiles/debian8-mxe.docker b/tests/docker/dockerfiles/debian9-mxe.docker
> similarity index 56%
> rename from tests/docker/dockerfiles/debian8-mxe.docker
> rename to tests/docker/dockerfiles/debian9-mxe.docker
> index 2df4cc8c5c9..5bc8a6d5c36 100644
> --- a/tests/docker/dockerfiles/debian8-mxe.docker
> +++ b/tests/docker/dockerfiles/debian9-mxe.docker
> @@ -1,15 +1,18 @@
>  #
>  # Docker mingw cross-compiler target
>  #
> -# This docker target builds on the debian Jessie base image.
> +# This docker target builds on the debian Stretch base image.
>  #
> -FROM qemu:debian8
> +FROM qemu:debian9
>  
>  MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
>  
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt install -y --no-install-recommends gnupg dirmngr
> +
>  # Add the foreign architecture we want and install dependencies
> -RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D43A795B73B16ABE9643FE1AFD8FFF16DB45C6AB && \
> -    echo "deb http://pkg.mxe.cc/repos/apt/debian jessie main" > /etc/apt/sources.list.d/mxeapt.list
> +RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C6BF758A33A3A276 && \
> +    echo "deb http://pkg.mxe.cc/repos/apt stretch main" > /etc/apt/sources.list.d/mxeapt.list
>  RUN apt-get update
>  RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>      apt-get install -y --no-install-recommends \
> 

Thank you Alex!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


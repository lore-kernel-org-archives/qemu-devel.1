Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FEBC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:42:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF1420675
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF1420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58651 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOn4K-0005Gp-G6
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:42:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOn38-0004QA-Id
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOn37-0000IX-IK
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:41:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOn37-0000HW-Cf
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:41:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id y5so4229345wma.2
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 10:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=yBWqIVlYzQPBJGo2C/fDVtzjo9zv+2KOatBDLPbG498=;
	b=PigjaqisnTtJyxgv+ar7ddn8EuyMxv37ntxwO9G0EAsQoiSO698OoTgIi2Pi9t2h+J
	n7tdqUk4QZRIU6G0Zt2RLAuH/jGoUsWmASoLsuUOGPIznvxsOv55K/xw1conG6T7RqZS
	9SIMdvUBiqJNiEXJAe8sz7soWgrrKCYYTpgpggPE3fOcqOsZHozvJ8NKl48wh44/E046
	h8XSd8zOnxjSuGXUFceCqiW2080yvDYBwusj51T2vh6E/LqesAWTY5Sqox5sxHeIwmlQ
	6ijSyPNn8oSz7xtGJKZtvFb0im++4UgRuLuvDLLPWe3877UR9MtvNYz4nA0yEL5yonoD
	VQ8A==
X-Gm-Message-State: APjAAAX2FPyyqtTz18AWa6vJnpMe+59iQcFdMYNNrwIprEPq/E8fuyN6
	1LcIX47lF9fTBWNJVUzVvvn7/ydxAvE=
X-Google-Smtp-Source: APXvYqxgqOYxuQT1Wd1mIbBcZdP8Uu97209LlfieXlZXkhSccxuGuqaFpBeg8VUD//bONAUjGZB13w==
X-Received: by 2002:a1c:cc15:: with SMTP id h21mr3817090wmb.85.1557423700509; 
	Thu, 09 May 2019 10:41:40 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id y6sm1877103wrw.60.2019.05.09.10.41.39
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 10:41:39 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190509165912.10512-1-alex.bennee@linaro.org>
	<20190509165912.10512-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <90a1309d-7e93-1023-773f-ef23db0c7438@redhat.com>
Date: Thu, 9 May 2019 19:41:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509165912.10512-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v1 01/23] tests/docker: add ubuntu 18.04
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, qemu-arm@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/9/19 6:58 PM, Alex Bennée wrote:
> From: Gerd Hoffmann <kraxel@redhat.com>
> 
> Based on the ubuntu.docker file.
> Used to reproduce the build failure Peter was seeing.
> Others might find this useful too ;)
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Message-Id: <20190503070241.24786-1-kraxel@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/ubuntu1804.docker | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/ubuntu1804.docker
> 
> diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
> new file mode 100644
> index 00000000000..2e2900150b0
> --- /dev/null
> +++ b/tests/docker/dockerfiles/ubuntu1804.docker
> @@ -0,0 +1,57 @@
> +FROM ubuntu:18.04
> +ENV PACKAGES flex bison \
> +    ccache \
> +    clang \
> +    gcc \
> +    gettext \
> +    git \
> +    glusterfs-common \
> +    libaio-dev \
> +    libattr1-dev \
> +    libbluetooth-dev \
> +    libbrlapi-dev \
> +    libbz2-dev \
> +    libcacard-dev \
> +    libcap-dev \
> +    libcap-ng-dev \
> +    libcurl4-gnutls-dev \
> +    libdrm-dev \
> +    libepoxy-dev \
> +    libfdt-dev \
> +    libgbm-dev \
> +    libgtk-3-dev \
> +    libibverbs-dev \
> +    libiscsi-dev \
> +    libjemalloc-dev \
> +    libjpeg-turbo8-dev \
> +    liblzo2-dev \
> +    libncurses5-dev \
> +    libncursesw5-dev \
> +    libnfs-dev \
> +    libnss3-dev \
> +    libnuma-dev \
> +    libpixman-1-dev \
> +    librados-dev \
> +    librbd-dev \
> +    librdmacm-dev \
> +    libsasl2-dev \
> +    libsdl2-dev \
> +    libseccomp-dev \
> +    libsnappy-dev \
> +    libspice-protocol-dev \
> +    libspice-server-dev \
> +    libssh2-1-dev \
> +    libusb-1.0-0-dev \
> +    libusbredirhost-dev \
> +    libvdeplug-dev \
> +    libvte-2.91-dev \
> +    libxen-dev \
> +    make \
> +    python-yaml \
> +    sparse \
> +    texinfo \
> +    xfslibs-dev
> +RUN apt-get update && \
> +    apt-get -y install $PACKAGES
> +RUN dpkg -l $PACKAGES | sort > /packages.txt
> +ENV FEATURES clang pyyaml sdl2
> 


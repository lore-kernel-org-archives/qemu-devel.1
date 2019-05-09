Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25042C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDDA920675
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDA920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58639 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOn2c-0003s2-3U
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:41:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOn1g-0003Ow-R2
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOn1f-0007IA-N8
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:40:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOn1f-0007H0-Ca
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:40:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id f2so4222959wmj.3
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 10:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=fevb3l/p5zVEWGTm7Zi/zkky6bCKPzqheYXEJdK+uUA=;
	b=TV3wrKVzOg7+pFXOG0B3tHiBDqVmnKU70B0XqllxM7cbu8yUFeCcWxJxvHqFJ40lZj
	P9EbNG/+3dbykXG6QVf1Gt/pxdrlQzmfHHFZDCm7d1aHwxe+1x/slcA5wNCCCpXnzyic
	rjl/MSHFlExGZl+iiW1CZSePkAE2oDKZqjFvNJ8mkKi+zYYpQAa8RZPxYu764Ii2oKum
	x90O0Mhz/uceFxEPzD4Gb4dtaw/L7y/FbhsdS+Y+qglpASyaV7VmkyQ7A09NWjGe5W4C
	gKweIps1IfCw7lw6825vtW5hDQSE0Tr5+9V+k/ZKUXQKXFCJShoBSn7RyWp+yT+Ys8fa
	zQbg==
X-Gm-Message-State: APjAAAUGWzF8e0ucBWef0vvmqMNyvQExhDwIMLaCDNtiO7TAMSMp/sJK
	SopzvOC6aKN9tnAPjiqZ8939nw==
X-Google-Smtp-Source: APXvYqxo9tb18hOiu2nizx1mU2PxBMC9v4YJIlPg148ZlOJyCi4eWAJ3a/nELO2XiYhT1dekEilZzA==
X-Received: by 2002:a1c:7518:: with SMTP id o24mr3815304wmc.42.1557423610191; 
	Thu, 09 May 2019 10:40:10 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	h12sm1674857wrq.95.2019.05.09.10.40.09
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 10:40:09 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190509165912.10512-1-alex.bennee@linaro.org>
	<20190509165912.10512-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <089bf7b5-8461-699b-4c9a-30c4d735282e@redhat.com>
Date: Thu, 9 May 2019 19:40:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509165912.10512-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v1 02/23] tests/docker: Test more
 components on the Fedora default image
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
Cc: Fam Zheng <fam@euphon.net>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/9/19 6:58 PM, Alex Bennée wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Install optional dependencies of QEMU to get better coverage.
> 
> The following components are now enabled:
> 
>   $ ./configure
>   ...
>   Multipath support yes
>   VNC SASL support  yes
>   RDMA support      yes
>   PVRDMA support    yes
>   libiscsi support  yes
>   seccomp support   yes
>   libpmem support   yes
>   libudev           yes
> 
> Note: The udev-devel package is provided by systemd-devel.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Acked-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

> Message-Id: <20190504055440.20406-1-philmd@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/fedora.docker | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
> index 69d4a7f5d75..afbba29adaa 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -8,6 +8,7 @@ ENV PACKAGES \
>      bzip2-devel \
>      ccache \
>      clang \
> +    cyrus-sasl-devel \
>      device-mapper-multipath-devel \
>      findutils \
>      flex \
> @@ -23,13 +24,17 @@ ENV PACKAGES \
>      libaio-devel \
>      libasan \
>      libattr-devel \
> +    libblockdev-mpath-devel \
>      libcap-devel \
>      libcap-ng-devel \
>      libcurl-devel \
>      libfdt-devel \
> +    libiscsi-devel \
>      libjpeg-devel \
> +    libpmem-devel \
>      libpng-devel \
>      librbd-devel \
> +    libseccomp-devel \
>      libssh2-devel \
>      libubsan \
>      libusbx-devel \
> @@ -74,10 +79,12 @@ ENV PACKAGES \
>      pixman-devel \
>      python3 \
>      PyYAML \
> +    rdma-core-devel \
>      SDL2-devel \
>      snappy-devel \
>      sparse \
>      spice-server-devel \
> +    systemd-devel \
>      systemtap-sdt-devel \
>      tar \
>      usbredir-devel \
> 


Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C20C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B15A206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B15A206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44723 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMbZL-0006sl-2b
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 13:01:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMbXv-0005mO-Ge
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMbXu-0002CW-F5
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:00:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMbXu-00027t-80
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:00:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15so3024790wrb.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 10:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ebNZju2Wi3RVNXpbg06Iu1r9sZixLioOjoS0f6IionE=;
	b=HnEkVW1NPH6X4xHfYR5YeYBPTg1ikVp6EzpT0Ezv6rwWSMWPiBvDkGDekVZSXDdEYI
	QLHjqjUjxQffhs21L7O1PE4uZAKaUkGsG6CagdqRiqvXeKAp1cFnNpYLVG2Q0kSxH6yP
	pplrlo32vaoZ3qEMCMWTCPNsNFGlDIc/tQrao3yk018vOe/vrq6Z5TBlywWbt0JKy6W7
	AOJslQBeb9x7mC4+Qr93znwQ24Pg896XJTI52uM7pGq/g7aGhxJRF/Ct0o8rFvYO7T6V
	Kqokj2fMTth5LzprnuoE2otkbeu1UVT1MXjwc2xHPM/VnJEBwXteYBDnCNf1BNt0UnHm
	8vIA==
X-Gm-Message-State: APjAAAXPii75SDUGMB0QBfnOP+u1kmIFcuYv5PVU1m5chEQRiDHWsfZ9
	VITvEalHTnWsKi3xl5FrbYbMgw==
X-Google-Smtp-Source: APXvYqxizMOIFH/nKZZlwNzniJNdni+awwa+OAtGlB4zjo0tTSEai6sVr5HW7AfERTepX13+rHC5QQ==
X-Received: by 2002:a5d:548d:: with SMTP id h13mr8121765wrv.218.1556902822827; 
	Fri, 03 May 2019 10:00:22 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	a20sm5267749wrf.37.2019.05.03.10.00.21
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 10:00:22 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Gerd Hoffmann <kraxel@redhat.com>
References: <20190503070241.24786-1-kraxel@redhat.com>
	<87a7g34hhn.fsf@zen.linaroharston>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6f291a03-0ff4-1c61-1a29-bd334e502564@redhat.com>
Date: Fri, 3 May 2019 19:00:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87a7g34hhn.fsf@zen.linaroharston>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] tests/docker: add ubuntu 18.04
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503170021.jrjP5ziD1VLS-zFLIgWhOsVPfncFKHbbBqs9Qja9Qg8@z>

On 5/3/19 6:42 PM, Alex Bennée wrote:
> 
> Gerd Hoffmann <kraxel@redhat.com> writes:
> 
>> Based on the ubuntu.docker file.
>> Used to reproduce the build failure Peter was seeing.
>> Others might find this useful too ;)
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  tests/docker/dockerfiles/ubuntu1804.docker | 57 ++++++++++++++++++++++
>>  1 file changed, 57 insertions(+)
>>  create mode 100644 tests/docker/dockerfiles/ubuntu1804.docker
>>
>> diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
>> new file mode 100644
>> index 000000000000..2e2900150b09
>> --- /dev/null
>> +++ b/tests/docker/dockerfiles/ubuntu1804.docker
>> @@ -0,0 +1,57 @@
>> +FROM ubuntu:18.04
>> +ENV PACKAGES flex bison \
>> +    ccache \
>> +    clang \
>> +    gcc \
>> +    gettext \
>> +    git \
>> +    glusterfs-common \
>> +    libaio-dev \
>> +    libattr1-dev \
>> +    libbluetooth-dev \
>> +    libbrlapi-dev \
>> +    libbz2-dev \
>> +    libcacard-dev \
>> +    libcap-dev \
>> +    libcap-ng-dev \
>> +    libcurl4-gnutls-dev \
>> +    libdrm-dev \
>> +    libepoxy-dev \
>> +    libfdt-dev \
>> +    libgbm-dev \
>> +    libgtk-3-dev \
>> +    libibverbs-dev \
>> +    libiscsi-dev \
>> +    libjemalloc-dev \
>> +    libjpeg-turbo8-dev \
>> +    liblzo2-dev \
>> +    libncurses5-dev \
>> +    libncursesw5-dev \
>> +    libnfs-dev \
>> +    libnss3-dev \
>> +    libnuma-dev \
>> +    libpixman-1-dev \
>> +    librados-dev \
>> +    librbd-dev \
>> +    librdmacm-dev \
>> +    libsasl2-dev \
>> +    libsdl2-dev \
>> +    libseccomp-dev \
>> +    libsnappy-dev \
>> +    libspice-protocol-dev \
>> +    libspice-server-dev \
>> +    libssh2-1-dev \
>> +    libusb-1.0-0-dev \
>> +    libusbredirhost-dev \
>> +    libvdeplug-dev \
>> +    libvte-2.91-dev \
>> +    libxen-dev \
>> +    make \
>> +    python-yaml \
>> +    sparse \
>> +    texinfo \
>> +    xfslibs-dev
>> +RUN apt-get update && \
>> +    apt-get -y install $PACKAGES
>> +RUN dpkg -l $PACKAGES | sort > /packages.txt
>> +ENV FEATURES clang pyyaml sdl2
> 
> Queued to testing/next, thanks.

Just finished builds, so if it's not too late:

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

I'm not sure whichever {ubuntu1804/ubuntu18.04}.docker is better,
anyway:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> --
> Alex Bennée
> 


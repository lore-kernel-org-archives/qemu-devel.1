Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A107C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 06:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61AD4264C4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 06:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AD4264C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37651 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWbRh-00015q-Ip
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 02:55:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWbQp-0000p6-RM
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWbQn-0005PN-QR
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:54:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hWbQn-0005Ni-KL
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:54:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so2243956wml.0
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 23:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=10U5Fl7M40HZaHjWG5jxpOaJB/CsRIcKQequJQd38ro=;
	b=Atf6rWGQX/eHvhhYspb+nXyzH82oszi0gcv8oEJyA6z/4sKomWwX0pUYEZUkla+i5Y
	2SKlky0bVAjUrm5f/KM3S40Hx/QGukbm4QOOuXrrUPDuL/EOInso6biAXt6i6h0lKhQ4
	HmEpU5FPRTAzvPeKpVp1z7Zhcnw1XBIi/9DnakhP+S6Lf3weCerWgmyrWpafWZ7kostP
	pVxuXl7u/xi+0RThyY5ZjsVe9LHAz04FY/uG/P/vHkRR2c5HLXCAAK8EJ2v4a2ITu/ot
	8Tt4Yrdx22w1WHnfWF7bIOvyD8GMUKXOTO0Xtda6/T0t9dVALbznJDYTesr7t5Ilh7W/
	qEwQ==
X-Gm-Message-State: APjAAAWoMkuVHtnV61dHY/SRT90XU629ME3yynrhY4lYLdOCgGR3qS8Y
	v0bAWZ0rBKaz/WNXFu+zpJUIdw==
X-Google-Smtp-Source: APXvYqwP7kb9/0hu8B+Xf5Y67sJCqVhB2tbI7lkShw8uyDhRBVuA4pMw240oG/CsV39iqGAMFbB51Q==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr4515949wma.120.1559285664615; 
	Thu, 30 May 2019 23:54:24 -0700 (PDT)
Received: from [192.168.1.43] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183])
	by smtp.gmail.com with ESMTPSA id 95sm9774975wrk.70.2019.05.30.23.54.23
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 23:54:23 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190530101603.22254-1-alex.bennee@linaro.org>
	<20190530101603.22254-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <65b4b611-c187-b6b9-3873-3b1b5ff293ba@redhat.com>
Date: Fri, 31 May 2019 08:54:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530101603.22254-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v1 05/26] tests/docker: Update the Fedora
 cross compile images to 30
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
Cc: Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/30/19 12:15 PM, Alex Bennée wrote:
> While at it remove the bogus :latest tag for cris cross compiler. It
> tends to break caching and cause confusion.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/fedora-cris-cross.docker | 2 +-
>  tests/docker/dockerfiles/fedora-i386-cross.docker | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/fedora-cris-cross.docker b/tests/docker/dockerfiles/fedora-cris-cross.docker
> index b168ada615a..09e7e449f9b 100644
> --- a/tests/docker/dockerfiles/fedora-cris-cross.docker
> +++ b/tests/docker/dockerfiles/fedora-cris-cross.docker
> @@ -2,7 +2,7 @@
>  # Cross compiler for cris system tests
>  #
>  
> -FROM fedora:latest
> +FROM fedora:30
>  ENV PACKAGES gcc-cris-linux-gnu
>  RUN dnf install -y $PACKAGES
>  RUN rpm -q $PACKAGES | sort > /packages.txt
> diff --git a/tests/docker/dockerfiles/fedora-i386-cross.docker b/tests/docker/dockerfiles/fedora-i386-cross.docker
> index eb8108d1185..9106cf9ebed 100644
> --- a/tests/docker/dockerfiles/fedora-i386-cross.docker
> +++ b/tests/docker/dockerfiles/fedora-i386-cross.docker
> @@ -1,4 +1,4 @@
> -FROM fedora:29
> +FROM fedora:30
>  ENV PACKAGES \
>      gcc \
>      glib2-devel.i686 \
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


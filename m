Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CED9C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DF82082C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DF82082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46184 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hduwt-0007k7-5t
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 07:09:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45284)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hdufU-00026z-Kv
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hduRY-0002kb-Pz
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:39:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38994)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hduRY-0002kI-Bv
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:37:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so2626497wma.4
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 03:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6XOkMNnu/oBbGb6IwW3PSO+VJZc+rgVboB98f1bhlX4=;
 b=JzvYDtcE9Qzk/fEOVot21PzkH6FH3QLqoUCn0+hv4VoT+nRDmnlwk0eXkC5oioFkq+
 g4fRI+7lpRdyExTxd81GF1uMKusHH2wBEg/32Q0BpZBvWxZa0/0FxjHhTBPbTfaXOjwa
 m7MKteT0xuvnONB3hKK3ENJcG1h22lJPEXI43WlkuVr3hZ8c4qpDk9bPyoSgsCI6Mw8J
 CTl9kpJb3zFa/Yo1irrYJ0rjuuY2UNuea9zNxBFpZAmzD1R8IxsPyHM529AciykEKK0H
 t6lWo1vGqssdf0hCOUrKFM7bCpXF4IIMxQRxNWLDMCudtT7Urn5UpUZFKGyajXDjVyUP
 W6yA==
X-Gm-Message-State: APjAAAX8NHyUXvFhkbsq98CFUppz+loav16BNUT2m11hwrVYiNgSxcC1
 9bzL6Nz5OtYsRnl6IGijGlWPsw==
X-Google-Smtp-Source: APXvYqx5BntLx0TqE7cgIp5Ha6JsyH0+h1c8mGpidp3W0QV+2VX3E26zrR2wfH9ClJ86NNJUO6P5bw==
X-Received: by 2002:a1c:a1c1:: with SMTP id k184mr2430200wme.81.1561027043202; 
 Thu, 20 Jun 2019 03:37:23 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id y12sm21614135wrr.3.2019.06.20.03.37.22
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 03:37:22 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190619194021.8240-1-alex.bennee@linaro.org>
 <20190619194021.8240-17-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e91b8ecf-4e6f-c4a4-9d79-de504cc779dd@redhat.com>
Date: Thu, 20 Jun 2019 12:37:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190619194021.8240-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v1 16/17] .travis.yml: default the
 --disable-system build to --static
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
Cc: Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/19 9:40 PM, Alex Bennée wrote:
> It's fairly common to build qemu-user binaries with --static linking
> so the binary can be copied around without libraries. Enable --static
> in the default qemu-user build to cover this.
> 
> There are other qemu-user builds that use dynamic linking so they
> should catch any problems there.
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index aeb9b211cd..9750dc905c 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -80,7 +80,7 @@ script:
>  matrix:
>    include:
>      - env:
> -        - CONFIG="--disable-system"
> +        - CONFIG="--disable-system --static"
>  
>  
>      # we split the system builds as it takes a while to build them all
> 


Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDB9C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 295EF206E0
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295EF206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46180 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hduwK-0006yY-Au
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 07:09:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45550)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hdufU-0002J8-JB
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hduRw-0002oN-R3
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:39:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51992)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hduRw-0002o7-M3
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:37:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so2561021wma.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 03:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eHUX/y3Sb/DWW/S/XCbD7pIyatOUuN3iWSz7ievukq4=;
 b=exbAhONHeO9LpMVJj2nNLBqRv4sqcH2WDZWay6yakprcF+ZQQhy0y9v/zFJQq5syIw
 29zo6af/BevLhBRk+yRiS6hlq4p6WSibc9dn7pjOKNEa6qKi1qgIceZUU4RqnmpgXCNV
 q3GCs4KBQ6BGwN/rSJMkvXpcHDFP+6AoJkbic5or/RXawgTTSn2zU6CkTLw9rFvtMx2Z
 4t3tLRAu5y9sn/ls+miDU7jiiBN1oAVC/ANk80BUYHii+W8RqWpHjjhUpXi1Pu5/O4aD
 HKv4Cuz/TlGjf9jQyJGVaO4LobJCBMZQsbV6/RZs7hKswOfDJe5mg6nh/T9Okh/lRqSx
 gDjg==
X-Gm-Message-State: APjAAAVJ3l/v9ldan00i8aA4tKX6Unet4SQzWVYc2Epp0QevYbDpBZ83
 iE5En+a3EQXZ8usUR0uNSBuVDw==
X-Google-Smtp-Source: APXvYqwpqo0l8DLSxC/DTQiFv9MIxDEa8dtG8DKPJhePrUzB/I7My3mwvyr21e5GwGJ5p96xNUQoUQ==
X-Received: by 2002:a1c:2c6:: with SMTP id 189mr2262874wmc.108.1561027067693; 
 Thu, 20 Jun 2019 03:37:47 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id w23sm5255551wmi.45.2019.06.20.03.37.46
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 03:37:47 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190619194021.8240-1-alex.bennee@linaro.org>
 <20190619194021.8240-18-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8eb890c7-75a2-62e6-c7a7-86522251b527@redhat.com>
Date: Thu, 20 Jun 2019 12:37:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190619194021.8240-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v1 17/17] .travis.yml: force a brew update
 for MacOS builds
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
> It looks like the Travis image package databases are out of date
> causing the build to error with:
> 
>   Error: Your Homebrew is outdated. Please run `brew update`.
>   Error: Kernel.exit
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .travis.yml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 9750dc905c..a891ce2485 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -43,6 +43,7 @@ addons:
>        - glib
>        - pixman
>        - gnu-sed
> +    update: true
>  
>  
>  # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
> 


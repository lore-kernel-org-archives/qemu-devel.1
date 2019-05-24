Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7555C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 05:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B2AA20657
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 05:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2AA20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48962 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU2ZH-00025X-DQ
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 01:16:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU2YU-0001QA-Va
	for qemu-devel@nongnu.org; Fri, 24 May 2019 01:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU2YU-00080c-3R
	for qemu-devel@nongnu.org; Fri, 24 May 2019 01:15:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hU2YT-0007za-TN
	for qemu-devel@nongnu.org; Fri, 24 May 2019 01:15:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id l17so126774wrm.10
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 22:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=e4zprs88BXXclC45bINRBM0taSC8754jl0PsFbkfdws=;
	b=rkmz8qzPuxGcVHINWBMKMSujQ2tXcr1B7xf8cuOtqpYkYbtdWTpjQo5uzW3gKX1JO2
	6TknCKX8cILIfQCdd3QeCvpoar/PDPLC6jHAqwm1GB1MfCAmSrNmi3QpqKoOp/qfSAcA
	Zs/hjU4efKiWGfs9zufYiVBTRv7Thh7Sn359MOc0zT8703PTw2w1S4ed8J1+j4kccbxA
	mgQ9XQlt92LC/rXxlXjLubZxAcngNTRQuc4k+i0tMEhbseSlDv53EqDuXkog5xKLBT3U
	dZQBLtMcoWlPXXOcZ98zbIwsS9O9t3vFnP7UvuN2v++CglOk0Ub6yAhWvdG7FfWGq+79
	hLuQ==
X-Gm-Message-State: APjAAAWKI+UsTp1by4eZhxhIkjv/iofCMTyzG+idgfpfvj2a5fZvXAkw
	7vsKjSBub+Z1lUGYoBg51ahqeg==
X-Google-Smtp-Source: APXvYqzgoZWR8pWTs8Q5xg4gXS8kNoZ+z+ykQcJxusfhhOE+K835QGo+grD2dszVa+YkbzBnGwrugg==
X-Received: by 2002:adf:f743:: with SMTP id z3mr15869155wrp.129.1558674944372; 
	Thu, 23 May 2019 22:15:44 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id l8sm993607wrw.56.2019.05.23.22.15.43
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 22:15:43 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190523081538.2291-1-armbru@redhat.com>
	<20190523081538.2291-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f109f025-420a-536a-bb50-804d9ca2c69a@redhat.com>
Date: Fri, 24 May 2019 07:15:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523081538.2291-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [RFC v4 1/7] Makefile: Remove code to smooth
 transition to config.status
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
Cc: peter.maydell@linaro.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Markus,

On 5/23/19 10:15 AM, Markus Armbruster wrote:
> When commit bdf523e6923 made configure generate config.status, it
> added a fallback to Makefile to smooth the transition, with a TODO
> "code can be removed after QEMU 1.7."  It's been more than five years.
> Remove it.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  Makefile | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 155f066a20..8ec833a5fb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -69,14 +69,7 @@ CONFIG_ALL=y
>  
>  config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/pc-bios $(SRC_PATH)/VERSION
>  	@echo $@ is out-of-date, running configure
> -	@# TODO: The next lines include code which supports a smooth
> -	@# transition from old configurations without config.status.
> -	@# This code can be removed after QEMU 1.7.
> -	@if test -x config.status; then \
> -	    ./config.status; \
> -        else \
> -	    sed -n "/.*Configured with/s/[^:]*: //p" $@ | sh; \
> -	fi
> +	./config.status

We could prepend a '@' since we already describe what this rule does
("config-host.mak is out-of-date, running configure").

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  else
>  config-host.mak:
>  ifneq ($(filter-out $(UNCHECKED_GOALS),$(MAKECMDGOALS)),$(if $(MAKECMDGOALS),,fail))
> 


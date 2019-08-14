Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F64DC32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 366192083B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366192083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxsjD-0004xi-F4
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 08:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hxsga-0002rL-OZ
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxsgY-0006IL-QH
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:47:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38311)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hxsgY-0006Hu-KZ
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:47:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so110970351wrr.5
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 05:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GC88iupRSuNnyAPJpl7DNBIbadpWmmmmfnXyCOrnxdA=;
 b=CIMXaf3Fc4dJojy9jGwUrdSkb3W9D309jRLjJdj6EZmsaJiZl35a93+t+Ldpua+W+v
 gAGR+GZiEJt5BqLY0EdWdUDnFwhzohFmxkVdnkIAg5A2O9ZTo7QwG8AVcgcDyZ+z8R2J
 KDv5rqzuG0pNpMQO1FApoIoYrSeHMd74HuP9XchZ/AfLF6GTx5AaFEQTHcNPcPJquW/V
 ATw+tdYgkUvCpK21Cc6LeWF7Hl2s/6//parrA0JEkah6xJNN0EQA/neKsuGeic7j1dxz
 UGlHZVzvdXlWcN4A4S4P8qqXHHSX1db6LyjKUOBu0nTjnYlzWZYTzMEQOIwtjnYoJhFx
 nCQA==
X-Gm-Message-State: APjAAAUZ3oFiyxXmuTfcv3sKUibPd5BRbuvxAqB8yDQDeeYO6etU3r06
 wAtgexqIFlzlufE/u111y9jwsA==
X-Google-Smtp-Source: APXvYqwSct0RcaqpUduab3tgYMGI0w6mVQ3cTs5V0Yg4ICVpFuKmgCALN1TKJ/bC+2Qy/kz8wZmYsA==
X-Received: by 2002:a5d:54ce:: with SMTP id x14mr27046370wrv.237.1565786845734; 
 Wed, 14 Aug 2019 05:47:25 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id w14sm10127884wrl.21.2019.08.14.05.47.24
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 Aug 2019 05:47:25 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190712133928.21394-1-philmd@redhat.com>
 <20190712133928.21394-4-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0ded162d-50cf-42f6-bfcf-a0d1b0d97007@redhat.com>
Date: Wed, 14 Aug 2019 14:47:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190712133928.21394-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH-for-4.1? 3/7] MAINTAINERS: Add an entry for
 the Bluetooth devices
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Miroslav Rezanina <mrezanin@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing qemu-trivial@ to salvage this patch.

On 7/12/19 3:39 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc9636b43a..5d8f27d9bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1733,6 +1733,13 @@ F: hw/*/*xive*
>  F: include/hw/*/*xive*
>  F: docs/*/*xive*
>  
> +Bluetooth
> +S: Orphan
> +F: bt-*.c
> +F: hw/bt/
> +F: include/hw/bt.h
> +F: include/sysemu/bt.h
> +
>  Subsystems
>  ----------
>  Audio
> 


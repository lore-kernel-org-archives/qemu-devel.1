Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214A6C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 21:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34AEA206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 21:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AEA206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35598 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJmIh-0006jy-8G
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 17:53:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJmHj-0006Jp-Cb
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJmHi-0004j3-Ba
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:52:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJmHi-0004hm-4c
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:52:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id b1so1469789wru.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 14:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=SRar4Kq1hkJ+EW2L7kQITpYzNLgV/Vp9T0bSy7oHqlQ=;
	b=gDkNGNJrwAhBOQq2QgWETz3Arl81nztAxkCBpsMoY0mYIOZPsQJ9kZCE84cIOAYJP2
	kRoXz2oyEcgRVbPrfbiTMEaWVspdG9BNk9rptqaXUJTMNF//DXSBnYCyiNJ6Y1WlK/ro
	8fA19u5pzOP3tBmfXGgledLZsL515dA1FqPq5A886MsX3UBI2vqyzAZZLgJq6dxvkMsn
	FNeppgvvUTbjAckljAXyteg8WOWs3C5aLI6Ab/djn/IXHIH8symtBnBvlinB8xopBoMH
	9bNJteGTjWCHo/Lllfn4I2gwqYWqo43xklrxqpavFQkJbDvMwcAiRAv+W8A4Bf4QjYih
	XW/w==
X-Gm-Message-State: APjAAAULT3c/Ta0dClsHw3x4HoF1BmkCEUdYcJhpnfPIZ1n+4/DLWumR
	XRUX9bRJx2Nni3adAx/bd9VOLA==
X-Google-Smtp-Source: APXvYqy8MrH8AQtetwSvWdphJmJaSLk3ZOBCSGdmHfAa07WH2zaxI9lrfdMOmbykgNSUhfCo5bSB6w==
X-Received: by 2002:a05:6000:cc:: with SMTP id
	q12mr16783826wrx.251.1556229121037; 
	Thu, 25 Apr 2019 14:52:01 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	o6sm46182699wre.60.2019.04.25.14.51.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 14:52:00 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-29-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c7f48b17-1a52-5c0e-bfd8-04eec2893fbc@redhat.com>
Date: Thu, 25 Apr 2019 23:51:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-29-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 28/29] hw/arm: Express
 dependencies of the musca machines with Kconfig
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
Cc: Rob Herring <robh@kernel.org>, Jan Kiszka <jan.kiszka@web.de>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-block@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Philippe Mathieu-Daude <f4bug@amsat.org>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Beniamino Galvani <b.galvani@gmail.com>, Andrew Jeffery <andrew@aj.id.au>,
	Cedric Le Goater <clg@kaod.org>, qemu-arm@nongnu.org,
	Peter Chubb <peter.chubb@nicta.com.au>, Gerd Hoffmann <kraxel@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	John Snow <jsnow@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425215157.g0pS4uIX0NIJlw8d59tcg02Md5Es8HJHaJzgMg__KGg@z>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Dependencies have been determined with trial-and-error and by
> looking at the musca.c source file.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/arm/Kconfig | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 22be1e1231..eca8387050 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -75,6 +75,12 @@ config MAINSTONE
>      select PFLASH_CFI01
>      select SMC91C111
>  
> +config MUSCA
> +    bool
> +    select ARMSSE
> +    select PL011
> +    select PL031
> +
>  config MUSICPAL
>      bool
>      select BITBANG_I2C
> @@ -423,6 +429,3 @@ config ARMSSE_CPUID
>  
>  config ARMSSE_MHU
>      bool
> -
> -config MUSCA
> -    bool
> 


Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EEDC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 19:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 865E22070D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 19:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865E22070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54010 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEfdy-0006XH-P1
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 15:45:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEfdB-000625-2U
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEfd9-0000cH-5s
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:45:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEfd5-0000ak-IN
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:45:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so8116261wmd.0
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 12:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=eXYNXIUDBz02ft5TYfBJasZetXxdXPyiPUATBW+pV4c=;
	b=lW7o7TLbl2T9sBps0Fh2w3GZnhmsytbYLqGJ/ugBWK3zbzimApb1VVQztc3Pk5xDTB
	utXcSB3VbyqM25MJNHBnrgcba80HOW9mD3Zb8g1kzTnaA8fNBChTmmz32Yl0V9abKz/8
	LEGGDD+Qeq/siCwKbu6EAY06e0EQufRyD4F/PSq0hmIVhLJoWZPDLGSsoaXuUVmHAoU8
	XJTUb3Q7UzGzwL3ekLxs1fJswbvtibs+vT2vVNVvKo7nXePJLM60UQHqESVM1q6E7bp0
	dKeDlRlnzW4zM36lPybOT4j0UG5JbiVDxaoPOGQL43Mr5mYQdtLywMo0f1ns7FKwttMB
	FZlA==
X-Gm-Message-State: APjAAAVPGJor9UCfyJMWEzJPZJOB7yRdsxemm5a99n/aK2VC8qRQT/B+
	8boptCqDjq0GLrOdC//tK9mhqg==
X-Google-Smtp-Source: APXvYqzIOPmWhvpmpmXR613apa40YhfPmv5rBjIIZBbfDjrI4YE5lqPJlRI2tsRRJvL2wE0gvZzSpA==
X-Received: by 2002:a1c:5543:: with SMTP id j64mr8049334wmb.37.1555011896848; 
	Thu, 11 Apr 2019 12:44:56 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	f15sm50244371wru.21.2019.04.11.12.44.55
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 12:44:56 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190411182240.5957-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e869e7fd-26f1-6bac-9a48-f302e4095a5c@redhat.com>
Date: Thu, 11 Apr 2019 21:44:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411182240.5957-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw/input: Add a CONFIG_PS2 switch
 for the ps2.c file
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411194455.StxWbLIn66d-owqApNubAqqZ-1ySfjqoSKsi9a6Agow@z>

On 4/11/19 8:22 PM, Thomas Huth wrote:
> ps2.c only needs to be compiled if we are building pckbd.c or pl050.c.

Hehe I have the same patch staged locally =)

> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/input/Kconfig       | 5 +++++
>  hw/input/Makefile.objs | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/input/Kconfig b/hw/input/Kconfig
> index e2e66f0858..316573f782 100644
> --- a/hw/input/Kconfig
> +++ b/hw/input/Kconfig
> @@ -8,10 +8,15 @@ config LM832X
>  config PCKBD
>      bool
>      default y
> +    select PS2
>      depends on ISA_BUS
>  
>  config PL050
>      bool
> +    select PS2
> +
> +config PS2
> +    bool
>  
>  config STELLARIS_INPUT
>      bool
> diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
> index c8b00f71ec..6db5ee0e71 100644
> --- a/hw/input/Makefile.objs
> +++ b/hw/input/Makefile.objs
> @@ -3,7 +3,7 @@ common-obj-y += hid.o
>  common-obj-$(CONFIG_LM832X) += lm832x.o
>  common-obj-$(CONFIG_PCKBD) += pckbd.o
>  common-obj-$(CONFIG_PL050) += pl050.o
> -common-obj-y += ps2.o
> +common-obj-$(CONFIG_PS2) += ps2.o
>  common-obj-$(CONFIG_STELLARIS_INPUT) += stellaris_input.o
>  common-obj-$(CONFIG_TSC2005) += tsc2005.o
>  
> 


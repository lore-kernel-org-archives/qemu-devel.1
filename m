Return-Path: <SRS0=ydMe=SX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3D3C10F14
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 10:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD0720859
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 10:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD0720859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51350 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hI9j8-0004fe-6y
	for qemu-devel@archiver.kernel.org; Sun, 21 Apr 2019 06:29:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hI9iI-0004N9-Un
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 06:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hI9iI-0007Ea-36
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 06:28:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hI9iH-0007Dw-TC
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 06:28:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so11283779wmi.0
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 03:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=0dHEsicK6J3qZx7y3wpuTbPejCudZ/guQ6NekyKYy/k=;
	b=hg+l45amK/N4OMQnBNDpaU6kKySUWgcafU8M5V9xD871Hvwv84j4zD4gbR9pI1m+d6
	o7IbinlE07SChnWOT6inyqe+kGSUd0VTOd8ATI7HFMmHrPI7T31aR5EUukcd/c2R/YbK
	wp1aNJQXDhtsVsNBQ/zuBlsreUgVVuSRBK/dHrYKGCmxAhVubWQdDh8XsRhC2JMEMS6S
	MI/st6x36IIRijjf1U+BYUkWGc2VoPXjizLg50k2PnRttkEKjBuuqx1BNfwctvzc/SsI
	M4UIMNILlkUsMrfuAv88V1dYm0AJ4kCbQ5XDBvkQd9ZDtqlAC8q3FseFhu1Wh18DgoYL
	wSAg==
X-Gm-Message-State: APjAAAX9El6fUulCofOtVYdBSj32K8WesYGD6upTzPfN7bsNqQ3d2iqe
	c9jNszPheROdqyQdIHU4YtxS+5O+cdowZg==
X-Google-Smtp-Source: APXvYqwU2gkcvhhw/XMWUbrWuz/9LhUGnwJCi7lp3PkIpnTEHTjCDkinMeuCeI9NsbUhK3L+fLFI2Q==
X-Received: by 2002:a1c:1a53:: with SMTP id a80mr8765982wma.15.1555842524449; 
	Sun, 21 Apr 2019 03:28:44 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	z74sm20278639wmc.2.2019.04.21.03.28.43
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Sun, 21 Apr 2019 03:28:43 -0700 (PDT)
To: Li Qiang <liq3ea@163.com>, jslaby@suse.cz, pbonzini@redhat.com
References: <20190420161446.2274-1-liq3ea@163.com>
	<20190420161446.2274-2-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <46a216be-0898-2d52-485d-fd07428c8b76@redhat.com>
Date: Sun, 21 Apr 2019 12:28:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190420161446.2274-2-liq3ea@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2 1/3] edu: mmio: set 'max_access_size' to
 8
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190421102842.Q4msqusYSFDrr75BZAbTODc7psNzcgXmCfLb4WQbE8I@z>

Hi Li,

The patch title is not very descriptive, maybe "allow 64-bit access"


On 4/20/19 6:14 PM, Li Qiang wrote:
> The edu spec said, the MMIO area can be accessed by 8 bytes.

or 64-bit...

> However currently the 'max_access_size' is not so the MMIO
> access dispatch can only access 4 bytes one time. This patch

32-bit

> fixes this to respect the spec.
> 
> Notice: here the 'min_access_size' is not a must, I set this
> for completement.

Which one? valid/impl? I think you can drop this comment from the commit
description.

> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/misc/edu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index 91af452c9e..65fc32b928 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -289,6 +289,15 @@ static const MemoryRegionOps edu_mmio_ops = {
>      .read = edu_mmio_read,
>      .write = edu_mmio_write,
>      .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,

Per the spec, this is correct.

> +        .max_access_size = 8,

Correct.

> +    },
> +    .impl = {
> +        .min_access_size = 4,

OK.

> +        .max_access_size = 8,

Correct.

> +    },
> +
>  };
>  
>  /*
> 

With title/description updated:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>



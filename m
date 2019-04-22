Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1864C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 16:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5894214AE
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 16:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5894214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39877 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIbwK-0004lD-Na
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 12:37:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIbua-00037f-TR
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 12:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIbnd-00072O-4s
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 12:28:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIbnX-0006yj-Ej
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 12:28:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so15052690wmk.4
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 09:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=tbo3lvT6di9+ns0khXTKA2QoC/BUksB/Vvba9a+5L+k=;
	b=mj76f5ZfHsth7kHLLMC6NDLLiUMjvBxOEWQCPWz3hdPnnCkBYW/YUZFdjnIis8z2R9
	aEdTHpiQlbKxkQtlQoSEfnJ3ULKoq5ad80aQTFOPnRK+usiA/T9tbwjLIYFxRImsnqiT
	Dd1NkWu1AaD6oJhVZSUV995Zx6CK3/skLwDW2Rv9nPCbFok2hIxWHdQEKsHsWgekkGkF
	gNJet/fa7/gKDo74lO7F55FWVpGmhHPYBZiMPXUYZCmWxxHNnoLYt9zt1luQMyljrh8G
	62Scy+OkVOdiXkI4Ce/BHNXcerbTpSwG5Y3wH12iO1wgpos6cpK3cAjeEVGbgDgRnltX
	yEqw==
X-Gm-Message-State: APjAAAXCT/HoQKqe6sLo581PaoJjNs1j5M3Kq1marL+lVOj5BvZbnEdg
	4SwuS0ZZnpdgc50C/0wj8mBPJ6pyYVhIcQ==
X-Google-Smtp-Source: APXvYqyNGr9ry7J87Fxw392plQWNLS1LTS68RLa5uxfVJeO2ceBukNrZHf1XKhxsAJhxq7R6UUmyZg==
X-Received: by 2002:a1c:1d97:: with SMTP id
	d145mr12313979wmd.136.1555950480779; 
	Mon, 22 Apr 2019 09:28:00 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	i28sm31601189wrc.32.2019.04.22.09.27.59
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 Apr 2019 09:27:59 -0700 (PDT)
To: Li Qiang <liq3ea@gmail.com>
References: <20190420161446.2274-1-liq3ea@163.com>
	<20190420161446.2274-2-liq3ea@163.com>
	<46a216be-0898-2d52-485d-fd07428c8b76@redhat.com>
	<CAKXe6S+5TTO3Czxsx98rd3d5UvyCnd5gMeWE6RW8b_eeE_b+3Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6538e063-8710-3ad1-cb88-cda110d57212@redhat.com>
Date: Mon, 22 Apr 2019 18:27:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKXe6S+5TTO3Czxsx98rd3d5UvyCnd5gMeWE6RW8b_eeE_b+3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
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
Cc: Jiri Slaby <jslaby@suse.cz>, Li Qiang <liq3ea@163.com>,
	Qemu Developers <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422162758.qnGdd5u66LS91BkXBgVRBSN-dP4WfLKNkA9eKwX90P4@z>

On 4/22/19 3:17 AM, Li Qiang wrote:
> 
> 
> Philippe Mathieu-Daudé <philmd@redhat.com <mailto:philmd@redhat.com>> 于
> 2019年4月21日周日 下午6:28写道：
> 
>     Hi Li,
> 
>     The patch title is not very descriptive, maybe "allow 64-bit access"
> 
> 
>     On 4/20/19 6:14 PM, Li Qiang wrote:
>     > The edu spec said, the MMIO area can be accessed by 8 bytes.
> 
>     or 64-bit...
> 
>     > However currently the 'max_access_size' is not so the MMIO
>     > access dispatch can only access 4 bytes one time. This patch
> 
>     32-bit
> 
>     > fixes this to respect the spec.
>     >
>     > Notice: here the 'min_access_size' is not a must, I set this
>     > for completement.
> 
>     Which one? valid/impl? I think you can drop this comment from the commit
>     description.
> 
> 
> Both needed. from memory_access_size, if we has no valid.max_access_size,
> this function will set it to 4.
> 
> static int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
> {
>     unsigned access_size_max = mr->ops->valid.max_access_size;
> 
>     /* Regions are assumed to support 1-4 byte accesses unless
>        otherwise specified.  */
>     if (access_size_max == 0) {
>         access_size_max = 4;
>     }
>    ...
> } 
> 
> From access_with_adjusted_size, if we has no impl.max_access_size,
> this function will set it to 4.
> 
> ps: I will appreciate if anyone can explain what's the meaning of valid
> and impl's min/max_access_size
> and how it affects the behavior.

"valid" describes the valid access from the bus to the device.

Indeed in the EDU case those are 4 and 8.

"impl" describes the accesses implemented by the QEMU device model.
The developper who writes the device is free to choose the accesses he
will model.

If valid/impl accesses don't match, the function
access_with_adjusted_size() from memory.c will adjust the bus access to
the device implementation.

For example, if the device only implements 1 and 2 bytes accesses, with
a 1-4 valid access, if the CPU executes a 32-bit access, this function
will do 2x 16-bit access to the device (incrementing the address by 2)
and returns a 32-bit result.

Similarly, if the CPU does a 8-bit access on a 32-bit impl device,
access_with_adjusted_size() will execute a single 32-bit access to the
device, then mask/shift the returned value and returns a 8-bit result to
the caller.

> Thanks,
> Li Qiang
> 
>     >
>     > Signed-off-by: Li Qiang <liq3ea@163.com <mailto:liq3ea@163.com>>
>     > ---
>     >  hw/misc/edu.c | 9 +++++++++
>     >  1 file changed, 9 insertions(+)
>     >
>     > diff --git a/hw/misc/edu.c b/hw/misc/edu.c
>     > index 91af452c9e..65fc32b928 100644
>     > --- a/hw/misc/edu.c
>     > +++ b/hw/misc/edu.c
>     > @@ -289,6 +289,15 @@ static const MemoryRegionOps edu_mmio_ops = {
>     >      .read = edu_mmio_read,
>     >      .write = edu_mmio_write,
>     >      .endianness = DEVICE_NATIVE_ENDIAN,
>     > +    .valid = {
>     > +        .min_access_size = 4,
> 
>     Per the spec, this is correct.
> 
>     > +        .max_access_size = 8,
> 
>     Correct.
> 
>     > +    },
>     > +    .impl = {
>     > +        .min_access_size = 4,
> 
>     OK.
> 
>     > +        .max_access_size = 8,
> 
>     Correct.
> 
>     > +    },
>     > +
>     >  };
>     > 
>     >  /*
>     >
> 
>     With title/description updated:
>     Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
> 


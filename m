Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D997C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 11:10:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22CB520675
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 11:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22CB520675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33486 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSgBi-0003kN-8h
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 07:10:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSgAr-0003Me-Km
	for qemu-devel@nongnu.org; Mon, 20 May 2019 07:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSgAq-0006KQ-KC
	for qemu-devel@nongnu.org; Mon, 20 May 2019 07:09:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hSgAq-0006Ik-F5
	for qemu-devel@nongnu.org; Mon, 20 May 2019 07:09:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id 15so8535067wmg.5
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 04:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Fi9JkrAxVjZQtxgJ9kWkUXilTWmZw7lNfIgiEeQhb0Q=;
	b=tuk8MLw2oNQJp1XDP05pJv9Yb7H9b99w0ECcyv2LrhAstoGjQw5dhRiY1Af5YxN2GN
	+NF1dnvfS98mH5sTAW1kHuLat0goq2D7rLeTmpOywZ11Jm8UuaANzdG5K+7Z5mrSAXfh
	UOm/1As6BLV60S4MjVAIQoMv+DPAo0ddopcVoH9rejKwbnhJr0430RqB5zT5LoGYtyUZ
	dggyNr0EFjzU1poBVV88om2XRiMyoAKzC6cM4p4dRDrl2lvOipC5kyKBusGMm9YP6K1Z
	EnU1d46NQvaMOu/THZTKJbxOYZ1VsVzPY+5OGE28cgXPiZ/UqfVfpB9L/qf+cnsdDDSR
	q3Tg==
X-Gm-Message-State: APjAAAUXewQ0+Wpk1yN0An8LcX4SzbfxrIRD4xL6zH5LHEptpjuxSBa7
	ZCFXqPSvhhthVTZSR3csqCHLtw==
X-Google-Smtp-Source: APXvYqy+1aW9pgXsrVnWumvzKq/XYfoh/EN+Rz+DBOymuwfy4z+tSQxUxdYqSovvfT5TEf6Klcud1g==
X-Received: by 2002:a1c:ca0b:: with SMTP id a11mr41833907wmg.52.1558350583228; 
	Mon, 20 May 2019 04:09:43 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	t15sm15489459wmt.2.2019.05.20.04.09.42
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 04:09:42 -0700 (PDT)
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
	Peter Maydell <peter.maydell@linaro.org>
References: <20190506142042.28096-1-clg@kaod.org>
	<b12201c8-7d5f-2108-6666-75543c38f243@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f1ca56fd-c83d-8ad6-29c9-a8fc6af4531c@redhat.com>
Date: Mon, 20 May 2019 13:09:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b12201c8-7d5f-2108-6666-75543c38f243@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v2 0/3] aspeed: cleanups and extensions
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/19 9:47 AM, Cédric Le Goater wrote:
> Hello,
> 
> On 5/6/19 4:20 PM, Cédric Le Goater wrote:
>> Hello,
>>
>> Here is a series adding a couple of cleanups to the Aspeed SoCs to
>> prepare ground for extensions and new SoCs.
>>
>> Thanks,
>>
>> C.
>>
>> Changes since v1:
>>
>>  - moved enum defining the Aspeed controller names under aspeed_soc.h
>>  - removed AspeedSoCInfo 'sdram_base' field
>>  - fixed clang compilation
>>
>> Cédric Le Goater (3):
>>   aspeed: add a per SoC mapping for the interrupt space
>>   aspeed: add a per SoC mapping for the memory space
> 
> I think these two patches are fine to go even if Philippe's comments 
> are not addressed. There are valid but not a blocker to me.  

OK, so:

patches 1 & 2:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Peter, can you apply them?

> 
>>   aspeed: use sysbus_init_child_obj() to initialize children
> 
> Philippe has taken over this patch in a larger series which will go 
> through Eduardo's tree, if I understood well the emails. When merged, 
> we can try to re-merge the RTC patchset from Joel. I think we made 
> things a little more complex than they should have been. 

Sorry if I made things more complex. I went on PTO after sending
"hw/arm: Use object_initialize_child for correct reference counting" [*]
then was slow to address Thomas/Markus comments.
Then maybe I should start pinging maintainer more aggressively when my
series are reviewed but not merged, to not delay further developments.

I took note of your comment and will try to keep things simple the next
time.

Regards,

Phil.

> 
> Thanks,
> 
> C.



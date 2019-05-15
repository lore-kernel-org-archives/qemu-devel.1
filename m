Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33190C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 07:22:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0078620862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 07:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0078620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60913 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQoFJ-0005jq-AV
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 03:22:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQoEU-0005Lr-Kl
	for qemu-devel@nongnu.org; Wed, 15 May 2019 03:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQoES-00026w-Iz
	for qemu-devel@nongnu.org; Wed, 15 May 2019 03:21:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQoER-00021a-83
	for qemu-devel@nongnu.org; Wed, 15 May 2019 03:21:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so827829wrs.5
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 00:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=DHU7btz1CbthsCNrHK5WKuk0ODkg7vTcDEeYx/un5e8=;
	b=gLkyz9V2S3mlVWuyK+8QBGbRz0/HSQOWCPmYdNAywr3SuWbf7NK5WN3mJ7UaLFbQ4b
	5xlX7TDb1kHDnnP3+zR9O7Th3OvoGYOEo044vBH7CToEV6N/oy31xwNddnbDoHJRZ/Ou
	0Ij1WJ+QOZlLURIyLWZRt5+yWMHXC8n8qdkq0JQ2oDI6KM4d4rQ62QgnHfVDCZx0aPig
	Iiycw4lmG9tqcv2CSQVBsBxSYjR+O4wnD9YVaaXuphhHUeovVqxu05VSA29GbXw1QWX4
	017pHUf4w+SxAtn702QYyzkPXvhrL4I4JCiLuZRdp88e2Lt5syJ4aZRYoloi9DFL8pYY
	+Bhw==
X-Gm-Message-State: APjAAAXU0jJL0IBhM7ZmyQvkCK9tcbyafi3XEuOYvELDnO79PFflrOpp
	qwQPW9QGRM7doVJqav8Lh5TQUA==
X-Google-Smtp-Source: APXvYqxZJHsU/UUuvLDWEt6o0aTmJ1QmsEUe1zwhcWGF6nV3TxMLqVd3kAW5HEogGMbZaJbTKuDy6g==
X-Received: by 2002:adf:e8d2:: with SMTP id k18mr17744917wrn.329.1557904901123;
	Wed, 15 May 2019 00:21:41 -0700 (PDT)
Received: from [192.168.1.43] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id 7sm1160221wro.85.2019.05.15.00.21.40
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 15 May 2019 00:21:40 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190515070357.882-1-philmd@redhat.com>
	<552b024d-39bd-dd3f-bf44-3c3e0a9f1198@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b9ca67e7-e9d4-0f7c-1ec6-166643d4c5cb@redhat.com>
Date: Wed, 15 May 2019 09:21:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <552b024d-39bd-dd3f-bf44-3c3e0a9f1198@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] docs/devel/build-system: Update an example
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/19 9:16 AM, Thomas Huth wrote:
> On 15/05/2019 09.03, Philippe Mathieu-Daudé wrote:
>> The default-configs/ example added in 717171bd2025 is no
>> more accurate since fa212a2b8b60 (and various further other
>> commits).
>>
>> The Kconfig build system is now in place.
>> Use the aarch64-softmmu config as example.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  docs/devel/build-system.txt | 15 +++++----------
>>  1 file changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/docs/devel/build-system.txt b/docs/devel/build-system.txt
>> index addd274eebd..79a85bfba06 100644
>> --- a/docs/devel/build-system.txt
>> +++ b/docs/devel/build-system.txt
>> @@ -415,16 +415,11 @@ context.
>>  The files under default-configs/ control what emulated hardware is built
>>  into each QEMU system and userspace emulator targets. They merely
>>  contain a long list of config variable definitions. For example,
> 
> "long list" is now often also not very accurate anymore. Maybe rephrase

Still accurate for MIPS :(

> that sentence à la: "contain a list of config variable definitions like
> the machines that should be included" ?

Good idea.

> 
>> -default-configs/x86_64-softmmu.mak has:
>> -
>> -  include sound.mak
>> -  include usb.mak
>> -  CONFIG_QXL=$(CONFIG_SPICE)
>> -  CONFIG_VGA_ISA=y
>> -  CONFIG_VGA_CIRRUS=y
>> -  CONFIG_VMWARE_VGA=y
>> -  CONFIG_VIRTIO_VGA=y
>> -  ...snip...
>> +default-configs/aarch64-softmmu.mak has:
>> +
>> +  include arm-softmmu.mak
>> +  CONFIG_XLNX_ZYNQMP_ARM=y
>> +  CONFIG_XLNX_VERSAL=y
>>  
>>  These files rarely need changing unless new devices / hardware need to
>>  be enabled for a particular system/userspace emulation target
>>
> 
> Anyway,
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Thanks!

Phil.


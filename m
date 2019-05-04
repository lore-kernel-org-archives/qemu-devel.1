Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43F8C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 14:19:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B89206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 14:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B89206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57264 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMvW3-0006ZL-HS
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 10:19:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMvU0-0005IF-FP
	for qemu-devel@nongnu.org; Sat, 04 May 2019 10:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMvTy-0006Nm-Uh
	for qemu-devel@nongnu.org; Sat, 04 May 2019 10:17:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMvTy-0006N3-Of
	for qemu-devel@nongnu.org; Sat, 04 May 2019 10:17:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id v189so1507077wmf.2
	for <qemu-devel@nongnu.org>; Sat, 04 May 2019 07:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=V8JCfOXytt3Wb5bbw6Fx43wj8nhFahWQodb/zSt5jJw=;
	b=mGNZH0OaFuyhxhcUfIdgo3ohOi4Q30MUisQrmr+9Wv6GTda6sz61WGssoce3nffe68
	U3MJm6lc4R9tNh8/DNKF3fb59KTtEPEwDhqmYmWRouVlBvuCLvHGl4P7+CB64dDaOIUk
	NnagSVI0p/fJTwpBF8dG4mjlVePZCIeBWOrAGTL4dy1Lzqi5zltw3HUhWLE3vKSu2xS8
	KWDYYJ3Sqqlv1DK0mSGlICFwTs/fjK5h6xlpsOP1YpPTJovFRruqZhMx0Zun19hOxq5F
	gBjIlNHShGJRre5xyi9XfGB5k26/lPIVlu2kIxdDsxdxdPj9IkhKf/UBUMB3yJsESq4C
	0aMA==
X-Gm-Message-State: APjAAAUleU3DVgi2NkKaTw2OFGMvZmBiU5xi1RXBwMDR02k3GVwQp0fj
	XdYcEgbID0ama0S3+QnpdV1jTg==
X-Google-Smtp-Source: APXvYqxK1k2fIUEfEBMDbSHWQpmGHdm/cZ/Q302oPVYDRWdxjbTWVsTyCOumDXqcG15Ojbvoc4PLGQ==
X-Received: by 2002:a1c:4c09:: with SMTP id z9mr9986631wmf.87.1556979460797;
	Sat, 04 May 2019 07:17:40 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	z140sm7657501wmc.27.2019.05.04.07.17.39
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Sat, 04 May 2019 07:17:40 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190504123538.14952-1-philmd@redhat.com>
	<ffe3d73d-b9a2-a0e3-6dee-222a3d87cc28@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b10a02d5-e54a-7dd5-4e7e-3a39b3fd0b1a@redhat.com>
Date: Sat, 4 May 2019 16:17:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ffe3d73d-b9a2-a0e3-6dee-222a3d87cc28@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] hw/net/ne2000: Extract the PCI device from
 the chipset common code
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504141739.dO8BCCy_6gGQCchVIbK6_B_IjbVsjriM1F5wAMs32ZI@z>

On 5/4/19 4:09 PM, Thomas Huth wrote:
> On 04/05/2019 14.35, Philippe Mathieu-Daudé wrote:
>> The ne2000.c file contains functions common the the ISA and PCI
>> devices. To allow to build with one or another, extract the PCI
>> specific part into a new file.
>>
>> This fix an issue where the NE2000_ISA Kconfig had to pull the
>> full PCI core objects.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/net/Kconfig       |   7 ++-
>>  hw/net/Makefile.objs |   3 +-
>>  hw/net/ne2000-pci.c  | 132 +++++++++++++++++++++++++++++++++++++++++++
>>  hw/net/ne2000.c      | 105 ----------------------------------
>>  4 files changed, 139 insertions(+), 108 deletions(-)
>>  create mode 100644 hw/net/ne2000-pci.c
>>
>> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
>> index 7d7bbc5d7c9..4ef86dc3a53 100644
>> --- a/hw/net/Kconfig
>> +++ b/hw/net/Kconfig
>> @@ -1,10 +1,14 @@
>>  config DP8393X
>>      bool
>>  
>> +config NE2000_COMMON
>> +    bool
> 
> I'd maybe rather simply name it "NE2000" instead of "NE2000_COMMON", but
> that's just a matter of taste.

I started using this name, but then realized it is confuse and someone
could enable CONFIG_NE2000=y expecting a network device, but none would
be linked.

Paolo, would it be useful to add some 'internal' Kconfig property (like
"default")? So that config is not user-selectable, but only
dependency-selectable. CONFIG_ARM_V7M might be a similar example (we
don't want the user to unselect it).

> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!


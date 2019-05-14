Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA47C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 10:48:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58E2208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 10:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58E2208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45276 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQUyy-000260-6G
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 06:48:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQUrD-0004YD-G4
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQUd9-0005UZ-Fu
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:25:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQUd9-0005O7-9y
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:25:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id s17so2099208wru.3
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 03:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=2y96/CJ+pYaj7fBKEham+qsGpqkSMXqxPa1MXm51blM=;
	b=Asu2xG6RGuTGnGaKq2aVHblIG0Y636jnaekzVusGJltp88eC99zzoXUiY8ciPtgqcF
	B0uRf8dmz2StBdn8FgashpQrzQ37YOhUMk2c0M8OJEEVSpjeKm4jQBlxsgAgNi7sCFh+
	nADkIEDCBAOB5ZMcFa2YDx24gm9GVh/Z3LK1NK5LMT5tWAYCVqUUOZYWOr6M4QCGvUZI
	Or5LltHteiq6HpF/86ZA68/hV7gjSpGRPKEWgryUmsZrEu0nwsFnHJtcj9qLvUrND69c
	U6PMJ8eBwnycz6/KftUm4Gn7QzH0DY3nb23APtIXovrAtEAckfAQiyHkulKouRz2Ecv1
	IXew==
X-Gm-Message-State: APjAAAW1Ea9AuVl84fg1IbkTBuSkYGXusMvZBOWIVjXa9FgRXURKI61Y
	dnol+lrBIFEeqvwSybT099/8dQ==
X-Google-Smtp-Source: APXvYqxblmjyMk1ZZsSzfT0YfU4t1Qd+bW6lchb7g5KXO0+6n8nDIZgxB8jxbFJpk5b/8iawr5wrAA==
X-Received: by 2002:a5d:5401:: with SMTP id g1mr21145084wrv.25.1557829553965; 
	Tue, 14 May 2019 03:25:53 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	q24sm2076120wmc.18.2019.05.14.03.25.53
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 03:25:53 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20190514100019.13263-1-thuth@redhat.com>
	<20190514100019.13263-3-thuth@redhat.com>
	<CAFEAcA9bGr1249Ofx=TXLK3JNs1KMWTnRR+-FexKr__0AJAipQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <41876537-aa47-6d13-5298-a3af03d11b8a@redhat.com>
Date: Tue, 14 May 2019 12:25:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9bGr1249Ofx=TXLK3JNs1KMWTnRR+-FexKr__0AJAipQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/4] hw/core: Add a config
 switch for the "or-irq" device
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
	qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 12:06 PM, Peter Maydell wrote:
> On Tue, 14 May 2019 at 11:00, Thomas Huth <thuth@redhat.com> wrote:
>>
>> The "or-irq" device is only used by certain machines. Let's add
>> a proper config switch for it so that it only gets compiled when we
>> really need it.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/arm/Kconfig        | 2 ++
>>  hw/core/Kconfig       | 3 +++
>>  hw/core/Makefile.objs | 2 +-
>>  hw/pci-host/Kconfig   | 3 ++-
>>  4 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index af8cffde9c..0bb3bbe9d3 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -277,6 +277,7 @@ config RASPI
>>  config STM32F205_SOC
>>      bool
>>      select ARM_V7M
>> +    select OR_IRQ
>>      select STM32F2XX_TIMER
>>      select STM32F2XX_USART
>>      select STM32F2XX_SYSCFG
>> @@ -424,6 +425,7 @@ config ARMSSE
>>      select IOTKIT_SECCTL
>>      select IOTKIT_SYSCTL
>>      select IOTKIT_SYSINFO
>> +    select OR_IRQ
>>      select TZ_MPC
>>      select TZ_MSC
>>      select TZ_PPC
> 
> In cases like this where a device is used both by
> an SoC and also directly by the board code that uses
> that SoC, should we put the select OR_IRQ only in
> the SoC's config, or also in the board model's config
> (ie, in "config MPS2" as well as "config ARMSSE") ?

Someone should be able to work on the board without having to look at
the SoC code/config, so both :) The idea of Kconfig is you only worry
about a specific device, and the qgraph sort the rest out.

So having in both place is safer, and helps to visualize dependencies in
the graph tree (I'm slowly working on this feature to help new-comer to
understand model dependencies).


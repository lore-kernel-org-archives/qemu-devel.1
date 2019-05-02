Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08E7C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5FDC20645
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5FDC20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55341 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMEb5-0000dK-V6
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 12:30:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMEa3-00005Z-Eo
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMEZv-00044h-7Z
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:29:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMEZu-00043r-W2
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:28:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id b188so3864843wmb.0
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 09:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=4z9U0ar2TrC4tAGl+jGrsc/I/ZXdtMN2Pv4yEKEk2xA=;
	b=rswT+kIhiEY+km5VdNTrKBw48BjA7tQjPdBmIu9HkoykOOu6ADfrl3x2hsrHgCP92r
	wJCZItrjnQzhttFLbr9G8H4iFymcYffelPHMsWq8Y6TLn2MjHKa3WveTLcUzDfLab083
	S4ifQl+q7f45aEUpllLSMVySZ59OYwaCnz7uRDVVKpkfYWjineYJPoHjWBhIS5NYHRs2
	hOaCO7IjGMjnVC7R6GQOK6hQpV4Haof1HDktzyQWEOyIcarb03Vp6mbP2ZIXWodUtM2+
	/dd7amE9SjeculOt7iVPtPnZtc+7um8C2EL3J0u1grbxy7BFSgIoGnSsQYMcrICZEVyw
	6Bpg==
X-Gm-Message-State: APjAAAWbBcKbvCioNHYw5uExy20IUeE7Z0+kqY8wQR9LJD6lUzmfGIiq
	h21h9UEKNknwEoCdTjU0O1ezMQ==
X-Google-Smtp-Source: APXvYqysHYF6XkDPmGaTup1oO4BKA5vPnGNKmVwHXSEJQfaFFllVjGM++TUKNMDaaLzzp8CaJ8TGvA==
X-Received: by 2002:a1c:e90f:: with SMTP id q15mr3149095wmc.1.1556814537857;
	Thu, 02 May 2019 09:28:57 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id y7sm3582741wrg.45.2019.05.02.09.28.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 02 May 2019 09:28:57 -0700 (PDT)
To: minyard@acm.org
References: <20190428064731.29913-1-philmd@redhat.com>
	<20190428064731.29913-2-philmd@redhat.com>
	<20190502132437.GI6623@minyard.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9657d158-b952-b30e-f8ab-64b32e42a41c@redhat.com>
Date: Thu, 2 May 2019 18:28:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502132437.GI6623@minyard.net>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v2 1/6] hw/acpi: Move the IPMI stub to the
 stubs/ directory
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502162856.KY9EzXHV7udvf7L0Fd8ox_97UI8LFBulXALPDgjGfVw@z>

Hi Corey,

On 5/2/19 3:24 PM, Corey Minyard wrote:
> On Sun, Apr 28, 2019 at 08:47:26AM +0200, Philippe Mathieu-Daudé wrote:
>> Move the IPMI stub file to the stubs/ directory to simplify the
>> hw/acpi Makefile.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> I'm not sure of the overall view of this, but this is ok from an
> IPMI point of view in my view.

IIRC I had linking failure when building with Kconfig +ACPI -IPMI on
MIPS/PPC (series will come on top of this one).

I'll verify, I only looked at MIPS but it seems UEFI firmwares also use
it on PPC and ARM (currently the ACPI table is only built on X86).

Also I'll might rename stubs/ipmi.c -> stubs/acpi-ipmi.c.

> 
> Acked-by: Corey Minyard <cminyard@mvista.com>

Thanks for the review!

> 
>> ---
>>  MAINTAINERS                         | 1 +
>>  hw/acpi/Makefile.objs               | 3 +--
>>  stubs/Makefile.objs                 | 1 +
>>  hw/acpi/ipmi-stub.c => stubs/ipmi.c | 0
>>  4 files changed, 3 insertions(+), 2 deletions(-)
>>  rename hw/acpi/ipmi-stub.c => stubs/ipmi.c (100%)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 23db6f8408a..e1681eca5cb 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1309,6 +1309,7 @@ S: Maintained
>>  F: include/hw/ipmi/*
>>  F: hw/ipmi/*
>>  F: hw/smbios/smbios_type_38.c
>> +F: stubs/ipmi.c
>>  F: tests/ipmi*
>>  T: git https://github.com/cminyard/qemu.git master-ipmi-rebase
>>  
>> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
>> index 2d46e3789ae..4e302feb885 100644
>> --- a/hw/acpi/Makefile.objs
>> +++ b/hw/acpi/Makefile.objs
>> @@ -14,8 +14,7 @@ common-obj-y += aml-build.o
>>  common-obj-$(CONFIG_TPM) += tpm.o
>>  
>>  common-obj-$(CONFIG_IPMI) += ipmi.o
>> -common-obj-$(call lnot,$(CONFIG_IPMI)) += ipmi-stub.o
>>  else
>>  common-obj-y += acpi-stub.o
>>  endif
>> -common-obj-$(CONFIG_ALL) += acpi-stub.o ipmi-stub.o
>> +common-obj-$(CONFIG_ALL) += acpi-stub.o
>> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
>> index 269dfa58326..36bb9ff0b1d 100644
>> --- a/stubs/Makefile.objs
>> +++ b/stubs/Makefile.objs
>> @@ -9,6 +9,7 @@ stub-obj-y += error-printf.o
>>  stub-obj-y += fdset.o
>>  stub-obj-y += gdbstub.o
>>  stub-obj-y += get-vm-name.o
>> +stub-obj-y += ipmi.o
>>  stub-obj-y += iothread.o
>>  stub-obj-y += iothread-lock.o
>>  stub-obj-y += is-daemonized.o
>> diff --git a/hw/acpi/ipmi-stub.c b/stubs/ipmi.c
>> similarity index 100%
>> rename from hw/acpi/ipmi-stub.c
>> rename to stubs/ipmi.c
>> -- 
>> 2.20.1
>>


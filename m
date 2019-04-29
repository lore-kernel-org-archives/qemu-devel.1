Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAD4C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6362020656
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6362020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59185 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL896-0004tQ-NW
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 11:24:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL87n-00047A-C2
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL87m-0004tX-BX
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:23:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hL87m-0004t8-57
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:23:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so14610217wmf.5
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=k0FHWF1tfN0qHz43/GJyJDnwI3odotUdV6dwQqV6dWk=;
	b=Ey6EmsIkUoQKDoyZCo5ycRQTYzundDIlB6uZjk/6Knek7AJkiPoLMAqrwZVxxhVbVK
	sI9w/bgvK6HEnxsmT0EhUO8Jk5HvkNVrWzvx5PWu8B+0PR8oVxsmWTeEZ8yNPWdG2Dez
	5rWpWU68tnWidljMtZnR1tW6YWM9OlXARcXbBfbZWjjB5FHloG+Brzj8EbqAPU1ID4IY
	93GgQsywnRZcITcsJReMAFqETaF7q1zo9nVLYFKyswtAElwNFEwDsMMJ/+lv8/eeEKOl
	H5dnqsPPXDgeIjE1ScA9MOkelNec7yHf5n0RubyCzJyqM2Vt3Tps4+4ZYtXFA26eRFtT
	ACjQ==
X-Gm-Message-State: APjAAAWLhxzKtpuCQSgMVymghZ8hwe/6VENxnljz7z+hVHKhIgH46ge2
	EL6WcIkMwdBmaN/FrWfQPBogjQ==
X-Google-Smtp-Source: APXvYqx6KTAbbKpWCBZ+sEnPvFdFIE4QLNGaHA9gbCvkV7vbenxGQeXlfNLqCiwp5zBSV5ZhgZ38Vw==
X-Received: by 2002:a1c:f70e:: with SMTP id v14mr18597095wmh.74.1556551401152; 
	Mon, 29 Apr 2019 08:23:21 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id e5sm9949192wrh.79.2019.04.29.08.23.19
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 08:23:20 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190427165504.29846-1-philmd@redhat.com>
	<20190427165504.29846-2-philmd@redhat.com>
	<bca8bc52-50fc-575e-718f-8590b47fa1f8@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <03341f11-db3d-3066-5687-3702bae0860b@redhat.com>
Date: Mon, 29 Apr 2019 17:23:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bca8bc52-50fc-575e-718f-8590b47fa1f8@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/acpi: Simplify the Makefile logic
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
Cc: Yang Zhong <yang.zhong@intel.com>, Samuel Ortiz <sameo@linux.intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	=?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429152313.9Ok3d0nbt31psGHbGfvu1Wz35Z6n6T_aW02xGMADtZg@z>

7On 4/29/19 5:21 PM, Thomas Huth wrote:
> On 27/04/2019 18.55, Philippe Mathieu-Daudé wrote:
>> Since we only require to link with acpi-stub.o when CONFIG_ACPI
>> is disabled, we can simplify the Makefile logic.
>>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/acpi/Makefile.objs | 10 ++--------
>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
>> index 2d46e3789ae..c86edfbed90 100644
>> --- a/hw/acpi/Makefile.objs
>> +++ b/hw/acpi/Makefile.objs
>> @@ -1,4 +1,3 @@
>> -ifeq ($(CONFIG_ACPI),y)
>>  common-obj-$(CONFIG_ACPI_X86) += core.o piix4.o pcihp.o
>>  common-obj-$(CONFIG_ACPI_X86_ICH) += ich9.o tco.o
>>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu_hotplug.o
>> @@ -6,16 +5,11 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
>>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
>>  common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
>>  common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
>> -common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
>> -
>>  common-obj-y += acpi_interface.o
>>  common-obj-y += bios-linker-loader.o
>>  common-obj-y += aml-build.o
> 
> What about these three object files? We don't want to build them if
> CONFIG_ACPI is disabled, do we?

Indeed. This was fixed in the v2:
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04721.html

> 
>  Thomas
> 
> 
>>  common-obj-$(CONFIG_TPM) += tpm.o
>> -
>>  common-obj-$(CONFIG_IPMI) += ipmi.o
>> +
>>  common-obj-$(call lnot,$(CONFIG_IPMI)) += ipmi-stub.o
>> -else
>> -common-obj-y += acpi-stub.o
>> -endif
>> -common-obj-$(CONFIG_ALL) += acpi-stub.o ipmi-stub.o
>> +common-obj-$(call lnot,$(CONFIG_ACPI)) += acpi-stub.o
>>
> 


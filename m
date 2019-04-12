Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32ACC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 15:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71C0A2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 15:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C0A2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38419 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hExjM-0004CU-EK
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 11:04:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hExiR-0003rC-EL
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hExiO-0005tE-0w
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:03:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hExiN-0005sy-OT
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:03:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so11647864wml.4
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 08:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=tbLu4+nyl85/OB5JMk8qbuK5dp2rYy9x9rtOSqfF9B4=;
	b=mq49MlNWawoVeC9E8wbeIQC8VQaqVV1PRTSGJAM7hfaWMS0SD9A4SPxcg5+vxYZQGK
	C/pK9OQuIx8dB5Q21SHKPLO/WNhqBRF52kRQ4rvOkh2HPpYWQg0w4Fg0IJ+DWAZpd6sb
	Pv3/Hb8pEqC0ubOEnTNit6Rr94vnPvN7ME0CXOn6gDXrkKGref1Q2ekKw3hlm9Gs0BO6
	XSfTHbUqsdyLj/lAqvLWx92UrbzsqoHdyf91faZhPkK7VJiXzDcH9qGYFk2DXLigfQQL
	JCOv0lMRACFA8IXwc5/KgOW2jHH7soMOOOrFLs0wZovkES+qPU6/1QjO9ml9ZiGmHMLc
	sxrw==
X-Gm-Message-State: APjAAAV7O69U3HB0MxKWsIKmeWYpW3WCr2VY4eit0orWmL1zjX6iQc9T
	+Vdd8NEQ9a2p5P9WhgG0Akofyw==
X-Google-Smtp-Source: APXvYqw13py5w1kEj9NJyDjBGtUaWt2J1YuJntBDNA/bOncG+n+il6hLSmORt/eYlsOTR/sKcbaS5A==
X-Received: by 2002:a1c:730c:: with SMTP id d12mr11865657wmb.10.1555081418509; 
	Fri, 12 Apr 2019 08:03:38 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	q8sm11706097wmq.35.2019.04.12.08.03.37
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 08:03:37 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>
References: <20190317002259.25994-1-philmd@redhat.com>
	<20190317002259.25994-5-philmd@redhat.com>
	<20190319152830.4e7771be@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <536060c6-8243-f157-7f83-74eb04517032@redhat.com>
Date: Fri, 12 Apr 2019 17:03:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190319152830.4e7771be@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 4/8] hw/isa/southbridge: Rename
 ACPI_X86_ICH to ACPI_ICH9
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
Cc: Thomas Huth <thuth@redhat.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paul Burton <paul.burton@imgtec.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Artyom Tarasenko <atar4qemu@gmail.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412150336.vgOrvWLu0KpD6VkGFzVfH9jVijXGNn1TQS92op9RIdo@z>

On 3/19/19 3:28 PM, Igor Mammedov wrote:
> On Sun, 17 Mar 2019 01:22:55 +0100
> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> 
>> The ICH9 chipset is a generic southbridge and can be used by
>> non-X86 hardware. Rename it to make this more obvious.
> Is it actually used by anything else in QEMU beside Q35 board?

Yes, the MIPS Boston board (hw/mips/boston.c:520):

    ahci =
pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->sec_bus,
                                           PCI_DEVFN(0, 0),
                                           true, TYPE_ICH9_AHCI);

See:

commit df1d8a1f29f567567b9d20be685a4241282e7005
Author: Paul Burton <paul.burton@imgtec.com>
Date:   Thu Sep 8 15:51:58 2016 +0100

 hw/mips: MIPS Boston board support

 Introduce support for emulating the MIPS Boston development board. The
 Boston board is built around an FPGA & 3 PCIe controllers, one of which
 is connected to an Intel EG20T Platform Controller Hub. It is used
 during the development & debug of new CPUs and the software intended to
 run on them, and is essentially the successor to the older MIPS Malta
 board.

 This patch does not implement the EG20T, instead connecting an already
 supported ICH-9 AHCI controller. Whilst this isn't accurate it's enough
 for typical stock Boston software (eg. Linux kernels) to work with hard
 disks given that both the ICH-9 & EG20T implement the AHCI
 specification.


>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/acpi/Kconfig       | 2 +-
>>  hw/acpi/Makefile.objs | 2 +-
>>  hw/i2c/Makefile.objs  | 2 +-
>>  hw/isa/Kconfig        | 2 +-
>>  4 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
>> index eca3beed75..e24c895772 100644
>> --- a/hw/acpi/Kconfig
>> +++ b/hw/acpi/Kconfig
>> @@ -8,7 +8,7 @@ config ACPI_X86
>>      select ACPI_CPU_HOTPLUG
>>      select ACPI_MEMORY_HOTPLUG
>>  
>> -config ACPI_X86_ICH
>> +config ACPI_ICH9
>>      bool
>>      select ACPI_X86
>>  
>> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
>> index c86edfbed9..dff94d35e7 100644
>> --- a/hw/acpi/Makefile.objs
>> +++ b/hw/acpi/Makefile.objs
>> @@ -1,5 +1,5 @@
>>  common-obj-$(CONFIG_ACPI_X86) += core.o piix4.o pcihp.o
>> -common-obj-$(CONFIG_ACPI_X86_ICH) += ich9.o tco.o
>> +common-obj-$(CONFIG_ACPI_ICH9) += ich9.o tco.o
>>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu_hotplug.o
>>  common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
>>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
>> diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
>> index a98c786918..b632461513 100644
>> --- a/hw/i2c/Makefile.objs
>> +++ b/hw/i2c/Makefile.objs
>> @@ -3,7 +3,7 @@ common-obj-$(CONFIG_SMBUS) += smbus_slave.o smbus_master.o
>>  common-obj-$(CONFIG_SMBUS_EEPROM) += smbus_eeprom.o
>>  common-obj-$(CONFIG_DDC) += i2c-ddc.o
>>  common-obj-$(CONFIG_VERSATILE_I2C) += versatile_i2c.o
>> -common-obj-$(CONFIG_ACPI_X86_ICH) += smbus_ich9.o
>> +common-obj-$(CONFIG_ACPI_ICH9) += smbus_ich9.o
>>  common-obj-$(CONFIG_ACPI_SMBUS) += pm_smbus.o
>>  common-obj-$(CONFIG_BITBANG_I2C) += bitbang_i2c.o
>>  common-obj-$(CONFIG_EXYNOS4) += exynos4210_i2c.o
>> diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
>> index 57e09a0cb8..19101d349f 100644
>> --- a/hw/isa/Kconfig
>> +++ b/hw/isa/Kconfig
>> @@ -50,4 +50,4 @@ config LPC_ICH9
>>      # for ICH9.
>>      select ISA_BUS
>>      select ACPI_SMBUS
>> -    select ACPI_X86_ICH
>> +    select ACPI_ICH9
> 


Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7961C04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 00:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0A6206BF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 00:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0A6206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38905 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRQpw-00020N-1u
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 20:35:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hRQp2-0001cr-CW
	for qemu-devel@nongnu.org; Thu, 16 May 2019 20:34:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hRQp1-0004WK-8X
	for qemu-devel@nongnu.org; Thu, 16 May 2019 20:34:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:62764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hRQox-0004Oh-76; Thu, 16 May 2019 20:34:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	16 May 2019 17:33:57 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga001.jf.intel.com with ESMTP; 16 May 2019 17:33:55 -0700
Date: Fri, 17 May 2019 08:33:23 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190517003323.GA30229@richard>
References: <20190419003053.8260-1-richardw.yang@linux.intel.com>
	<20190419003053.8260-6-richardw.yang@linux.intel.com>
	<911eb251-8525-0efb-089b-d3feec5c68d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <911eb251-8525-0efb-089b-d3feec5c68d1@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.126
Subject: Re: [Qemu-devel] [PATCH v4 5/6] hw/acpi: Consolidate build_mcfg to
 pci.c
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: yang.zhong@intel.com, peter.maydell@linaro.org,
	Thomas Huth <thuth@redhat.com>, mst@redhat.com,
	qemu-devel@nongnu.org, shannon.zhaosl@gmail.com,
	qemu-arm@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
	imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 16, 2019 at 08:35:43PM +0200, Philippe Mathieu-Daudé wrote:
>On 4/19/19 2:30 AM, Wei Yang wrote:
>> Now we have two identical build_mcfg functions.
>> 
>> Consolidate them in acpi/pci.c.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> 
>> ---
>> v3:
>>   * adjust changelog based on Igor's suggestion
>> ---
>>  default-configs/arm-softmmu.mak  |  1 +
>>  default-configs/i386-softmmu.mak |  1 +
>>  hw/acpi/Kconfig                  |  4 +++
>>  hw/acpi/Makefile.objs            |  1 +
>>  hw/acpi/pci.c                    | 46 ++++++++++++++++++++++++++++++++
>>  hw/arm/virt-acpi-build.c         | 17 ------------
>>  hw/i386/acpi-build.c             | 18 +------------
>>  include/hw/acpi/pci.h            |  1 +
>>  8 files changed, 55 insertions(+), 34 deletions(-)
>>  create mode 100644 hw/acpi/pci.c
>> 
>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
>> index 613d19a06d..8f2796e195 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -144,6 +144,7 @@ CONFIG_XIO3130=y
>>  CONFIG_IOH3420=y
>>  CONFIG_I82801B11=y
>>  CONFIG_ACPI=y
>> +CONFIG_ACPI_PCI=y
>>  CONFIG_ARM_VIRT=y
>>  CONFIG_SMBIOS=y
>>  CONFIG_ASPEED_SOC=y
>> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
>> index ba3fb3ff50..cd5ea391e8 100644
>> --- a/default-configs/i386-softmmu.mak
>> +++ b/default-configs/i386-softmmu.mak
>> @@ -25,3 +25,4 @@
>>  CONFIG_ISAPC=y
>>  CONFIG_I440FX=y
>>  CONFIG_Q35=y
>> +CONFIG_ACPI_PCI=y
>> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
>> index eca3beed75..7265843cc3 100644
>> --- a/hw/acpi/Kconfig
>> +++ b/hw/acpi/Kconfig
>> @@ -23,6 +23,10 @@ config ACPI_NVDIMM
>>      bool
>>      depends on ACPI
>>  
>> +config ACPI_PCI
>> +    bool
>> +    depends on ACPI
>
>Shouldn't this be "depends on ACPI && PCI"?
>

I think you are right. Let me fix this.

Thanks

-- 
Wei Yang
Help you, Help me


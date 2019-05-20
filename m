Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076BEC04AB4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 00:35:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8445206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 00:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8445206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55472 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSWH5-0003t7-2j
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 20:35:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSWGA-0003Uy-57
	for qemu-devel@nongnu.org; Sun, 19 May 2019 20:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSWG8-0004oy-Sh
	for qemu-devel@nongnu.org; Sun, 19 May 2019 20:34:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:52006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hSWG7-0004h5-OT
	for qemu-devel@nongnu.org; Sun, 19 May 2019 20:34:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 May 2019 17:34:22 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by FMSMGA003.fm.intel.com with ESMTP; 19 May 2019 17:34:21 -0700
Date: Mon, 20 May 2019 08:33:50 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190520003350.GA18144@richard>
References: <20190515121146.7248-1-mst@redhat.com>
	<CAFEAcA95Uh=j+vGCT08+ztAc5Yk8RWGzApDZrrt5DS7XudGQhQ@mail.gmail.com>
	<6d652ee6-ffee-6316-88f4-ba9f2a237817@redhat.com>
	<CAP+75-XuuUamjbouNYRJzm2Qwtorwhbe+QX8BHBK_WaUc8F+7A@mail.gmail.com>
	<20190517025903.GA17182@richard>
	<20190517131315.117fea4b@Igors-MacBook-Pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517131315.117fea4b@Igors-MacBook-Pro>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.20
Subject: Re: [Qemu-devel] [PULL 00/37] pci, pc, virtio: features, fixes
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	Peter Maydell <peter.maydell@linaro.org>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 17, 2019 at 01:13:15PM +0200, Igor Mammedov wrote:
>On Fri, 17 May 2019 10:59:03 +0800
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>

[..]

>> 
>> Well, I hope this will not block the merge.
>> 
>> I took a look in the change of default-configs/arm-softmmu.mak. The general
>> idea from Thomas is put those hard-coded config to Kconfig.
>> 
>> This is fine and what I need to change in my patch is to select ACPI_PCI in
>> the proper place, if my understanding is correct.
>> 
>> Two things I need to fix:
>> 
>>   * add select ACPI_PCI in proper place of hw/arm/Kconfig
>>   * add a dummy build_mcfg() for link when ACPI_PCI is not configured.
>> 
>> Then I have two questions:
>> 
>>   * In hw/arm/Kconfig, I don't see one option contains both PCI and ACPI. I am
>>     confused where to put the select.
>>   * put dummy build_mcfg() in aml-build.c works. Igor, do you like this? Or
>>     you haver other preference?
>
>could you point out why we need dummy build_mcfg(), in the first place?
>

I may made a misunderstanding about hw/arm/Kconfig in recent upstream change.

I thought there would be no configuration to choose both ACPI and PCI at the
same time, which leads to build_mcfg() will not be compiled.

While seems Philip decides to select ACPI_PCI for ARM_VIRT.

>> 
>> >Sadly both series clash :(
>> >
>> >Regards,
>> >
>> >Phil.
>> 

-- 
Wei Yang
Help you, Help me


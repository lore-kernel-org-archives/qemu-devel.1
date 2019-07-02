Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66069C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E8D2146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E8D2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiHYg-0005Nm-Gg
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 08:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38239)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hiHTQ-0008Tm-D4
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hiHTN-0005rP-Nk
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:01:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37950)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hiHT9-0005Mb-PM; Tue, 02 Jul 2019 08:01:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A0A9B81106;
 Tue,  2 Jul 2019 12:00:52 +0000 (UTC)
Received: from [10.36.116.95] (ovpn-116-95.ams2.redhat.com [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CAC118A49;
 Tue,  2 Jul 2019 12:00:41 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
References: <20190625121421.22280-1-shameerali.kolothum.thodi@huawei.com>
 <20190702130703.0e74cbe6@redhat.com>
 <CAFEAcA8PDNTQXD3cD3XG9wkc_QOLXUcw62-8AUjSC0g7qjti7g@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0bcc011c-17ff-8bfd-1f0e-65c303272664@redhat.com>
Date: Tue, 2 Jul 2019 14:00:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8PDNTQXD3cD3XG9wkc_QOLXUcw62-8AUjSC0g7qjti7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 02 Jul 2019 12:01:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 0/8] ARM virt: ACPI memory hotplug
 support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Samuel Ortiz <sameo@linux.intel.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linuxarm <linuxarm@huawei.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Xu Wei <xuwei5@hisilicon.com>, sebastien.boeuf@intel.com,
 Laszlo Ersek <lersek@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 7/2/19 1:46 PM, Peter Maydell wrote:
> On Tue, 2 Jul 2019 at 12:07, Igor Mammedov <imammedo@redhat.com> wrote:
>>
>> On Tue, 25 Jun 2019 13:14:13 +0100
>> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
>>
>>> This series is an attempt to provide device memory hotplug support
>>> on ARM virt platform. This is based on Eric's recent works here[1]
>>> and carries some of the pc-dimm related patches dropped from his
>>> series.
>>>
>>> The kernel support for arm64 memory hot add was added recently by
>>> Robin and hence the guest kernel should be => 5.0-rc1.
>>>
>>> NVDIM support is not included currently as we still have an unresolved
>>> issue while hot adding NVDIMM[2]. However NVDIMM cold plug patches
>>> can be included, but not done for now, for keeping it simple.
>>>
>>> This makes use of GED device to sent hotplug ACPI events to the
>>> Guest. GED code is based on Nemu. Thanks to the efforts of Samuel and
>>> Sebastien to add the hardware-reduced support to Nemu using GED
>>> device[3]. (Please shout if I got the author/signed-off wrong for
>>> those patches or missed any names).
>>>
>>> This is sanity tested on a HiSilicon ARM64 platform and appreciate
>>> any further testing.
>>
>> There are several things I'd fix/amend but it's nothing that couldn't
>> be done on top as bugfixes (I'll comment later on specific issues).
>>
>> However as a whole from ACPI and memory hotplug POV series looks more
>> or less ready for merging.
>>
>> I've asked Eric to test migration (I'm quite not sure about that part),
>> (CCed David)so on condition it works:
>>
>>   Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
> If we want to get this into 4.1 I'll need somebody to do a respin
> with all the relevant fixes pretty soon (ie within a day or two,
> and that is pushing it because really it's missed the freeze
> deadline already). It might be easier just to let it go into 4.2
> instead...

OK so after those late attempts to get it in, I agree with you. If it
missed the deadline already then let's stick to the process and try to
get this just after 4.1.

I have just checked migration and it fails between a qemu 4.1 and qemu
4.0 with

"qemu-system-aarch64: Unknown savevm section or instance 'acpi-ged' 0.
Make sure that your current VM setup matches your saved VM setup,
including any hotplugged devices
qemu-system-aarch64: load of migration failed: Invalid argument"

so we would need to have a no_acpi_dev class field to avoid using the
GED device < 4.1 I think.

+ troubles with the DSDT ref files / bios-tables-test.c to be fixed.

Thanks

Eric
> 
> thanks
> -- PMM
> 


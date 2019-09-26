Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4144C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A77821D80
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A77821D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDVJ5-0002m5-KB
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 11:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iDVHI-0001qK-3R
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iDVHD-0007ek-3Y
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:01:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4541)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1iDVH2-0007bG-Qz; Thu, 26 Sep 2019 11:01:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A5A7118CB909;
 Thu, 26 Sep 2019 15:01:38 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-49.rdu2.redhat.com
 [10.10.120.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CFBE760933;
 Thu, 26 Sep 2019 15:01:33 +0000 (UTC)
Subject: Re: Invalid blob size on NVDIMM hot-add
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <5FC3163CFD30C246ABAA99954A238FA83F3FB328@lhreml524-mbs.china.huawei.com>
 <a1667b4a-72ac-48da-ab36-be1821757ac5@redhat.com>
 <5FC3163CFD30C246ABAA99954A238FA83F418D5C@lhreml524-mbs.china.huawei.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9c87a60e-20a3-85db-6eab-015183619f42@redhat.com>
Date: Thu, 26 Sep 2019 17:01:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83F418D5C@lhreml524-mbs.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 26 Sep 2019 15:01:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Leif Lindholm \(Linaro address\)" <leif.lindholm@linaro.org>,
 Linuxarm <linuxarm@huawei.com>, Auger Eric <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/26/19 13:37, Shameerali Kolothum Thodi wrote:

>>> Note: *all* relevant fw_cfg files must have their "size" fields updated
>>> in the directory blob (FW_CFG_FILE_DIR). I.e. the requirement applies to
>>> both the linker-loader script, and to all blobs that are referenced (by
>>> name) by the commands in the linker-loader script.
>>>
>>>
>>> (b) The firmware to re-read the size from the directory, after selecting
>>> the key for the sake of ACPI regeneration.
>>
>> Hmm...I am not sure this is required. In my testing with the above fix I
>> mentioned,
>> I can see that firmware is reading the correct(modified) size on select.
>> I will double check this though.
> 
> Hi Laszlo,
> 
> Right. I think the reason it works for me without your patch is when firmware
> selects the first item("etc/table-loader"), the Qemu side runs the callback
> and try to update all the acpi ram sizes including " etc/acpi/tables" which is the 
> one that matters in this specific case.

This is a good explanation.

Currently, the *only* action that occurs in the firmware before
selecting "etc/table-loader", is fetching the selector key, and size, of
"etc/table-loader".

Therefore, if the ACPI re-generation does not affect the size of
"etc/table-loader", just the size of "etc/acpi/tables" -- and QEMU
updates the size in the fw_cfg directory for "etc/acpi/tables" --, then
there is indeed no need for updating the firmware.

I was just not sure if QEMU could guarantee this invariant (i.e. that
the size of "etc/table-loader" would not change). After all, if you
modify the ACPI tables in the "etc/acpi/tables" blob, possibly even add
new tables to it, then you will likely have to append new *commands*,
for those additional ACPI objects / tables, to the linker-loader script
in "etc/table-loader".

> So with my fix with the tables_blob size align, qemu_ram_resize() calls the
> fw_cfg_modify_file() and updates the " etc/acpi/tables" size when firmware
> selects the " etc/table-loader" item.

Right, that's good.

> But I think, your below patch is still required in case " etc/table-loader" is
> changed by Qemu.

Exactly.

It really depends on whether the platform devices hot-plugged before
platform reset require new commands in the linker/loader script.

Thanks
Laszlo


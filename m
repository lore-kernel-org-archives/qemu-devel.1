Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF38C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 13:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0008206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 13:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0008206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-jedi.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juyF7-0003Vm-1b
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 09:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@the-jedi.co.uk>)
 id 1juwtk-0006S5-H9
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:45:28 -0400
Received: from vps.the-jedi.co.uk ([93.93.130.107]:34578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@the-jedi.co.uk>)
 id 1juwti-00031q-7y
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:45:28 -0400
Received: by vps.the-jedi.co.uk (Postfix, from userid 111)
 id 00D5442D19; Mon, 13 Jul 2020 12:45:23 +0100 (BST)
Received: from [192.168.0.5] (host86-179-4-163.range86-179.btcentralplus.com
 [86.179.4.163])
 by vps.the-jedi.co.uk (Postfix) with ESMTPSA id 980134242D;
 Mon, 13 Jul 2020 12:45:21 +0100 (BST)
Subject: Re: [PATCH] Allow acpi-tmr size=2
To: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
References: <5f12377f-b640-c4c5-1bcd-858c622c6c31@the-jedi.co.uk>
 <4a5cfe21-d370-8ebf-b905-c37d39b68353@msgid.tls.msk.ru>
 <20200713070946-mutt-send-email-mst@kernel.org>
From: Simon John <git@the-jedi.co.uk>
Message-ID: <7662bc2c-d958-731a-0882-62c5ab47c7a4@the-jedi.co.uk>
Date: Mon, 13 Jul 2020 12:46:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713070946-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=93.93.130.107; envelope-from=git@the-jedi.co.uk;
 helo=vps.the-jedi.co.uk
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 07:45:24
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 13 Jul 2020 09:10:50 -0400
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
Cc: imammedo@redhat.com, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I don't profess to understand most of this, I am just a user who found 
something didn't work and tracked down the cause with help from the 
people on the bugtracker.

the min=1 and max=4 was chosen as it seems to be set that way in most 
other places in the source, and 2 fits in that range.

so as macos seems to require 2 bytes but spec says 4 (32 bits) would it 
be better to set min=2 max=4, given that the original revert seems to be 
a security fix?

this works equally well:

static const MemoryRegionOps acpi_pm_tmr_ops = {
     .read = acpi_pm_tmr_read,
     .write = acpi_pm_tmr_write,
     .valid.min_access_size = 2,
     .valid.max_access_size = 4,
     .endianness = DEVICE_LITTLE_ENDIAN,
};

regards.



On 13/07/2020 12:14, Michael S. Tsirkin wrote:
> On Mon, Jul 13, 2020 at 10:20:12AM +0300, Michael Tokarev wrote:
>> 12.07.2020 15:00, Simon John wrote:
>>> macos guests no longer boot after commit 5d971f9e672507210e77d020d89e0e89165c8fc9
>>>
>>> acpi-tmr needs 2 byte memory accesses, so breaks as that commit only allows 4 bytes.
>>>
>>> Fixes: 5d971f9e672507210e7 (memory: Revert "memory: accept mismatching sizes in memory_region_access_valid")
>>> Buglink: https://bugs.launchpad.net/qemu/+bug/1886318
>>
>> Actually this fixes 77d58b1e47c8d1c661f98f12b47ab519d3561488
>> Author: Gerd Hoffmann <kraxel@redhat.com>
>> Date:   Thu Nov 22 12:12:30 2012 +0100
>> Subject: apci: switch timer to memory api
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>
>> because this is the commit which put min_access_size = 4 in there
>> (5d971f9e672507210e7 is just a messenger, actual error were here
>> earlier but it went unnoticed).
>>
>> While min_access_size=4 was most likely an error, I wonder why
>> we use 1 now, while the subject says it needs 2? What real min
>> size is here for ACPI PM timer?
>>
>> /mjt
> 
> 
> Well the ACPI spec 1.0b says
> 
> 4.7.3.3 Power Management Timer (PM_TMR)
> 
> ...
> 
> This register is accessed as 32 bits.
> 
> and this text is still there in 6.2.
> 
> 
> So it's probably worth it to cite this in the commit log
> and explain it's a spec violation.
> I think it's better to be restrictive and only allow the
> minimal variation from spec - in this case I guess this means 2 byte
> reads.
> 
> In any case pls do include an explanation for why you picked
> one over the other.
> 
>>
>>> Signed-off-by: Simon John <git@the-jedi.co.uk>
>>> ---
>>> Â hw/acpi/core.c | 2 +-
>>> Â 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
>>> index f6d9ec4f13..05ff29b9d7 100644
>>> --- a/hw/acpi/core.c
>>> +++ b/hw/acpi/core.c
>>> @@ -527,7 +527,7 @@ static void acpi_pm_tmr_write(void *opaque, hwaddr addr, uint64_t val,
>>> Â static const MemoryRegionOps acpi_pm_tmr_ops = {
>>> Â Â Â Â  .read = acpi_pm_tmr_read,
>>> Â Â Â Â  .write = acpi_pm_tmr_write,
>>> -Â Â Â  .valid.min_access_size = 4,
>>> +Â Â Â  .valid.min_access_size = 1,
>>> Â Â Â Â  .valid.max_access_size = 4,
>>> Â Â Â Â  .endianness = DEVICE_LITTLE_ENDIAN,
>>> Â };
> 


-- 
Simon John


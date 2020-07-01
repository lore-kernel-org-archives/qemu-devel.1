Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E61C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 23:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26A22082F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 23:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26A22082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqlrR-0002aT-89
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 19:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jqlqf-00024u-4M; Wed, 01 Jul 2020 19:09:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:3590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jqlqd-0003S2-7c; Wed, 01 Jul 2020 19:09:00 -0400
IronPort-SDR: JBBNZQc99eRWTgS6IEEzgbj34d9+YjWWMNC2y5o7T8BkoVfxX+m8Hp5g7VMhCVpPL/7aI5R044
 GPSdVh1kPsJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="144237039"
X-IronPort-AV: E=Sophos;i="5.75,302,1589266800"; d="scan'208";a="144237039"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 16:08:56 -0700
IronPort-SDR: AkxdBzDDRTyw8WTgxQWs6reFUh0RPeYjBtYl4Jmet/OnjfMP6JHe5/aHMsVJWLnOlS9BHSezjz
 dcrZ9Cv5RCWg==
X-IronPort-AV: E=Sophos;i="5.75,302,1589266800"; d="scan'208";a="265539614"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.212.205.13])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 16:08:55 -0700
Subject: Re: [PATCH v3 3/4] hw/block/nvme: Fix pmrmsc register size
To: Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200630110429.19972-1-philmd@redhat.com>
 <20200630110429.19972-4-philmd@redhat.com>
 <45a97bae-887c-2669-439e-08ec3e75113e@linux.intel.com>
 <e19634b7-b4b6-dbb8-e49f-bf7f96b89e81@redhat.com>
 <20200630164541.tnnabrqzejaumwrr@apples.localdomain>
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Message-ID: <9e3b7248-785a-72f0-b99b-af91740f1df7@linux.intel.com>
Date: Wed, 1 Jul 2020 16:08:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630164541.tnnabrqzejaumwrr@apples.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.120;
 envelope-from=andrzej.jakowski@linux.intel.com; helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 17:47:32
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 9:45 AM, Klaus Jensen wrote:
> On Jun 30 17:16, Philippe Mathieu-Daudé wrote:
>> On 6/30/20 5:10 PM, Andrzej Jakowski wrote:
>>> On 6/30/20 4:04 AM, Philippe Mathieu-Daudé wrote:
>>>> The Persistent Memory Region Controller Memory Space Control
>>>> register is 64-bit wide. See 'Figure 68: Register Definition'
>>>> of the 'NVM Express Base Specification Revision 1.4'.
>>>>
>>>> Fixes: 6cf9413229 ("introduce PMR support from NVMe 1.4 spec")
>>>> Reported-by: Klaus Jensen <k.jensen@samsung.com>
>>>> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> ---
>>>> Cc: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
>>>> ---
>>>>  include/block/nvme.h | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/block/nvme.h b/include/block/nvme.h
>>>> index 71c5681912..82c384614a 100644
>>>> --- a/include/block/nvme.h
>>>> +++ b/include/block/nvme.h
>>>> @@ -21,7 +21,7 @@ typedef struct QEMU_PACKED NvmeBar {
>>>>      uint32_t    pmrsts;
>>>>      uint32_t    pmrebs;
>>>>      uint32_t    pmrswtp;
>>>> -    uint32_t    pmrmsc;
>>>> +    uint64_t    pmrmsc;
>>>>  } NvmeBar;
>>>>  
>>>>  enum NvmeCapShift {
>>>> -- 2.21.3
>>>
>>> This is good catch, though I wanted to highlight that this will still 
>>> need to change as this register is not aligned properly and thus not in
>>> compliance with spec.
>>
>> I was wondering the odd alignment too. So you are saying at some time
>> in the future the spec will be updated to correct the alignment?
Yep I think so.
So PMRMSC currently is 64-bit register that is defined at E14h offset.
It is in conflict with spec because spec requires 64-bit registers to 
be 64-bit aligned.
I anticipate that changes will be needed.

>>
>> Should we use this instead?
>>
>>       uint32_t    pmrmsc;
>>  +    uint32_t    pmrmsc_upper32; /* the spec define this, but *
>>  +                                 * only low 32-bit are used  */
>>
>> Or eventually an unnamed struct:
>>
>>  -    uint32_t    pmrmsc;
>>  +    struct {
>>  +        uint32_t pmrmsc;
>>  +        uint32_t pmrmsc_upper32; /* the spec define this, but *
>>  +                                  * only low 32-bit are used  */
>>  +    };
>>
>>>
>>> Reviewed-by Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
>>>
>>
> 
> I'm also not sure what you mean Andrzej. The odd alignment is exactly
> what the spec (v1.4) says?
> 



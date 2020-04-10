Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D954C2BA19
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 01:49:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 481852074F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 01:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481852074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMinA-0001Of-Co
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 21:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1jMimO-0000UB-NY
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 21:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jingqi.liu@intel.com>) id 1jMimM-0000B2-Ms
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 21:48:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:62576)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
 id 1jMimM-0000AA-EZ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 21:48:22 -0400
IronPort-SDR: KxDKK2E2PHS5firdXC16ejxBx0a/7bwKr4D4zAntsjTRDdawvQBDRRUUJMb/nZfqIH4Edhf7Yf
 gL780R9vq4hw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 18:48:18 -0700
IronPort-SDR: XxTsvyH9vyS18bod8VzZMH59Ef7KW21sVU8b6lHh4YPRHs+7jgUnYRm0I5bNHtPAWWaixve+6U
 FTQu8AGwEjOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,364,1580803200"; d="scan'208";a="276036485"
Received: from jingqili-mobl.ccr.corp.intel.com (HELO [10.254.212.170])
 ([10.254.212.170])
 by fmsmga004.fm.intel.com with ESMTP; 09 Apr 2020 18:48:16 -0700
Subject: Re: [PATCH] exec: fetch the alignment of Linux devdax pmem character
 device nodes
To: Dan Williams <dan.j.williams@intel.com>
References: <20200401031314.11592-1-jingqi.liu@intel.com>
 <c906a3ae-c9d2-5802-5988-3c1d0302109b@oracle.com>
 <CAPcyv4igr9-DJx2ehoHj7sXk5g5GmgmivCqM3VpmJV7J4QM+kA@mail.gmail.com>
 <3873cb30-608c-6a27-c19f-f6446898796f@oracle.com>
 <9959e648-94f6-3be3-2271-3d2b855e7e48@intel.com>
 <6c12c748-6ee6-7132-f54b-bf0f90ae84c2@oracle.com>
 <2e2ba0c4-88ed-dc37-c642-a1cc7ae98f05@intel.com>
 <CAPcyv4hpA1Lc8+-3sDLBkG=sqMXbcxwQzNHYEcJevu8NypQcFQ@mail.gmail.com>
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Message-ID: <f523e1d4-7d11-a3f8-9a40-bed320bd629a@intel.com>
Date: Fri, 10 Apr 2020 09:48:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hpA1Lc8+-3sDLBkG=sqMXbcxwQzNHYEcJevu8NypQcFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.151
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/10/2020 12:46 AM, Dan Williams wrote:
> On Thu, Apr 9, 2020 at 7:33 AM Liu, Jingqi <jingqi.liu@intel.com> wrote:
>> On 4/8/2020 5:42 PM, Joao Martins wrote:
>>> On 4/8/20 3:25 AM, Liu, Jingqi wrote:
>>>> On 4/8/2020 2:28 AM, Joao Martins wrote:
>>>>> On 4/7/20 5:55 PM, Dan Williams wrote:
>>>>>> On Tue, Apr 7, 2020 at 4:01 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>>>>>> Perhaps, you meant instead:
>>>>>>>
>>>>>>>            /sys/dev/char/%d:%d/align
>>>>>>>
>>>>>> Hmm, are you sure that's working?
>>>>> It is, except that I made the slight mistake of testing with a bunch of wip
>>>>> patches on top which one of them actually adds the 'align' to child dax device.
>>>>>
>>>>> Argh, my apologies - and thanks for noticing.
>>>>>
>>>>>> I expect the alignment to be found
>>>>>> in the region device:
>>>>>>
>>>>>> /sys/class/dax:
>>>>>> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus1/region1/dax1.1/dax1.0
>>>>>> $(readlink -f /sys/dev/char/253\:263)/../align
>>>>>> $(readlink -f /sys/dev/char/253\:263)/device/align
>>>>>>
>>>>>>
>>>>>> /sys/bus/dax:
>>>>>> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus1/region1/dax1.0/dax1.0
>>>>>> $(readlink -f /sys/dev/char/253\:265)/../align
>>>>>> $(readlink -f /sys/dev/char/253\:265)/device/align <-- No such file
>>>>>>
>>>>>> The use of the /sys/dev/char/%d:%d/device is only supported by the
>>>>>> deprecated /sys/class/dax.
>>>> Hi Dan,
>>>>
>>>> Thanks for your comments.
>>>>
>>>> Seems it is a mistake.
>>>>
>>>> It should be: $(readlink -f /sys/dev/char/253\:263)/../../align
>>>>
>>> Hmm, perhaps you have an extra '../' in the path? This works for me:
>>>
>>> # ls $(readlink -f /sys/dev/char/252\:0/../align)
>>> /sys/devices/platform/e820_pmem/ndbus0/region0/dax0.0/dax0.0/../align
>>> # cat $(readlink -f /sys/dev/char/252\:0)/../align
>>> 2097152
>>> # cat /sys/dev/char/252\:0/../align
>>> 2097152
>> Hi Joao,
>>
>> Hmm, I need to have an extra '../' in the path. The details are as follows:
>>
>> # ll /dev/dax2.0
>> crw------- 1 root root 251, 5 Mar 20 13:35 /dev/dax2.0
>> # uname -r
>> 5.6.0-rc1-00044-gb19e8c684703
>> # readlink -f /sys/dev/char/251\:5/
>> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/region2/dax2.1/dax/dax2.0
>> # ls $(readlink -f /sys/dev/char/251\:5)/../align
>> ls: cannot access
>> '/sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/region2/dax2.1/dax/dax2.0/../align':
>> No such file or directory
>> # ls $(readlink -f /sys/dev/char/251\:5)/../dax_region/align
>> ls: cannot access
>> '/sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/region2/dax2.1/dax/dax2.0/../dax_region/align':
>> No such file or directory
>> # ls $(readlink -f /sys/dev/char/251\:5)/../../align
>> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/region2/dax2.1/dax/dax2.0/../../align
>> # ls $(readlink -f /sys/dev/char/251\:5)/../../dax_region/align
>> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/region2/dax2.1/dax/dax2.0/../../dax_region/align
>> # lsmod|grep pmem
>> dax_pmem_compat        16384  0
>> device_dax             20480  1 dax_pmem_compat
>> dax_pmem_core          16384  1 dax_pmem_compat
>> # lsmod|grep dax
>> dax_pmem_compat        16384  0
>> device_dax             20480  1 dax_pmem_compat
>> dax_pmem_core          16384  1 dax_pmem_compat
>>
>> Seems some configurations are different ?
>>
>> Can you share your info as above ? Thanks.
> Alternatively maybe you can use libdaxctl that automatically handles
> the ABI differences between compat-dax-class and dax-bus layouts? I
> didn't recommend it before because I was not sure about qemu's policy
> about taking on new library dependencies, but with libdaxctl you could
> do something like (untested):
>
> path = g_strdup_printf("/sys/dev/char/%d:%d", major(st.st_rdev),
> minor(st.st_rdev));
> rpath = realpath(path, NULL);
> daxctl_region_foreach(ctx, region)
>      if (strstr(daxctl_region_get_path(region), rpath)) {
>          align = daxctl_region_get_align(region);
>          break;
>      }

Thanks for your suggestion. I'll test it.

Thanks,

Jingqi



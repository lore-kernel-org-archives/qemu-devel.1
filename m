Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E826AC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B87E720771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87E720771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMYGB-0003q7-UX
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 10:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1jMYFd-0003LP-Bc
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jingqi.liu@intel.com>) id 1jMYFa-0008CG-A4
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:33:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:30950)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
 id 1jMYFa-00088I-1L
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:33:50 -0400
IronPort-SDR: /8v0frFdGiI7BbZBTQTAOBO1UF5G2PsNU8iO9upBSnMU1Kyqv7yhQk7XUwohTKxbrH9KGWniew
 VZssparc6Q5Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 07:33:36 -0700
IronPort-SDR: 9kyqAuY15GlLixjByP2rolwhGLAG7FduRl7pdWqmpvP6OAw5Y5H0bomiqjJrhGp7YZb8v8l3pi
 1PYH4dbsJbHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,363,1580803200"; d="scan'208";a="330865832"
Received: from jingqili-mobl.ccr.corp.intel.com (HELO [10.254.213.9])
 ([10.254.213.9])
 by orsmga001.jf.intel.com with ESMTP; 09 Apr 2020 07:33:34 -0700
Subject: Re: [PATCH] exec: fetch the alignment of Linux devdax pmem character
 device nodes
To: Joao Martins <joao.m.martins@oracle.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>
References: <20200401031314.11592-1-jingqi.liu@intel.com>
 <c906a3ae-c9d2-5802-5988-3c1d0302109b@oracle.com>
 <CAPcyv4igr9-DJx2ehoHj7sXk5g5GmgmivCqM3VpmJV7J4QM+kA@mail.gmail.com>
 <3873cb30-608c-6a27-c19f-f6446898796f@oracle.com>
 <9959e648-94f6-3be3-2271-3d2b855e7e48@intel.com>
 <6c12c748-6ee6-7132-f54b-bf0f90ae84c2@oracle.com>
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Message-ID: <2e2ba0c4-88ed-dc37-c642-a1cc7ae98f05@intel.com>
Date: Thu, 9 Apr 2020 22:33:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6c12c748-6ee6-7132-f54b-bf0f90ae84c2@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.120
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/8/2020 5:42 PM, Joao Martins wrote:
> On 4/8/20 3:25 AM, Liu, Jingqi wrote:
>> On 4/8/2020 2:28 AM, Joao Martins wrote:
>>> On 4/7/20 5:55 PM, Dan Williams wrote:
>>>> On Tue, Apr 7, 2020 at 4:01 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>>>> Perhaps, you meant instead:
>>>>>
>>>>>           /sys/dev/char/%d:%d/align
>>>>>
>>>> Hmm, are you sure that's working?
>>> It is, except that I made the slight mistake of testing with a bunch of wip
>>> patches on top which one of them actually adds the 'align' to child dax device.
>>>
>>> Argh, my apologies - and thanks for noticing.
>>>
>>>> I expect the alignment to be found
>>>> in the region device:
>>>>
>>>> /sys/class/dax:
>>>> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus1/region1/dax1.1/dax1.0
>>>> $(readlink -f /sys/dev/char/253\:263)/../align
>>>> $(readlink -f /sys/dev/char/253\:263)/device/align
>>>>
>>>>
>>>> /sys/bus/dax:
>>>> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus1/region1/dax1.0/dax1.0
>>>> $(readlink -f /sys/dev/char/253\:265)/../align
>>>> $(readlink -f /sys/dev/char/253\:265)/device/align <-- No such file
>>>>
>>>> The use of the /sys/dev/char/%d:%d/device is only supported by the
>>>> deprecated /sys/class/dax.
>> Hi Dan,
>>
>> Thanks for your comments.
>>
>> Seems it is a mistake.
>>
>> It should be: $(readlink -f /sys/dev/char/253\:263)/../../align
>>
> Hmm, perhaps you have an extra '../' in the path? This works for me:
>
> # ls $(readlink -f /sys/dev/char/252\:0/../align)
> /sys/devices/platform/e820_pmem/ndbus0/region0/dax0.0/dax0.0/../align
> # cat $(readlink -f /sys/dev/char/252\:0)/../align
> 2097152
> # cat /sys/dev/char/252\:0/../align
> 2097152

Hi Joao,

Hmm, I need to have an extra '../' in the path. The details are as follows:

# ll /dev/dax2.0
crw------- 1 root root 251, 5 Mar 20 13:35 /dev/dax2.0
# uname -r
5.6.0-rc1-00044-gb19e8c684703
# readlink -f /sys/dev/char/251\:5/
/sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/region2/dax2.1/dax/dax2.0
# ls $(readlink -f /sys/dev/char/251\:5)/../align
ls: cannot access 
'/sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/region2/dax2.1/dax/dax2.0/../align': 
No such file or directory
# ls $(readlink -f /sys/dev/char/251\:5)/../dax_region/align
ls: cannot access 
'/sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/region2/dax2.1/dax/dax2.0/../dax_region/align': 
No such file or directory
# ls $(readlink -f /sys/dev/char/251\:5)/../../align
/sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/region2/dax2.1/dax/dax2.0/../../align
# ls $(readlink -f /sys/dev/char/251\:5)/../../dax_region/align
/sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/region2/dax2.1/dax/dax2.0/../../dax_region/align
# lsmod|grep pmem
dax_pmem_compat        16384  0
device_dax             20480  1 dax_pmem_compat
dax_pmem_core          16384  1 dax_pmem_compat
# lsmod|grep dax
dax_pmem_compat        16384  0
device_dax             20480  1 dax_pmem_compat
dax_pmem_core          16384  1 dax_pmem_compat

Seems some configurations are different ?

Can you share your info as above ? Thanks.

>>> I don't have the deprecated dax class enabled as could you tell, so the second
>>> case is what I was testing. Except it wasn't a namespace/nvdimm but rather an
>>> hmem device-dax.
>>>
>>> '../align' though covers only one case? What about hmem which '../align' returns
>>> ENOENT; perhaps using '../dax_region/align' instead which is common to both?
>>> Albeit that wouldn't address the sub-division devices (that I mention above)
>> Seems that you mean to use $(readlink -f
>> /sys/dev/char/253\:263)/../../dax_region/align.
>>
>> Right ?
>>
> An extra '../' ?
>
> # ls $(readlink -f /sys/dev/char/252\:0/../dax_region/align)
> /sys/devices/platform/e820_pmem/ndbus0/region0/dax0.0/dax0.0/../align
> # cat $(readlink -f /sys/dev/char/252\:0)/../dax_region/align
> 2097152
> # cat /sys/dev/char/252\:0/../dax_region/align
> 2097152
>
> For HMAT/hmem devdax, though, only 'dax_region/align' is available for now:
>
> # ls $(readlink -f /sys/dev/char/252:0)/../align
> ls: cannot access /sys/devices/platform/hmem.0/dax0.0/../align: No such file or
> directory
> # ls $(readlink -f /sys/dev/char/252:0)/../dax_region/align
> /sys/devices/platform/hmem.0/dax0.0/../dax_region/align
> # cat $(readlink -f /sys/dev/char/252:0)/../dax_region/align
> 2097152
>
> The 'dax_region/align' was just an idea mainly because it's common to both
> device-dax devices -- not sure how others feel about it.

Seems it's reasonable. I need to sync the above path with yours.

Thanks,

Jingqi

>
> 	Joao
>
>> Thanks,
>>
>> Jingqi
>>
>>>> The current /sys/bus/dax device-model can
>>>> be a drop in replacement as long as software is not written to the
>>>> /sys/class sysfs layout, i.e. it uses ../ instead of device/ to walk
>>>> to the region properties.
>>>>
>>> /nods


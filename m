Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A0CC2D0EC
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 02:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEA7A206BE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 02:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA7A206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM0Pw-0003cX-Tk
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 22:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1jM0PI-00037l-7z
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 22:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jingqi.liu@intel.com>) id 1jM0PG-00029P-El
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 22:25:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:30247)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
 id 1jM0PG-00025b-5G
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 22:25:34 -0400
IronPort-SDR: IK0RZNAIEBKpFS8AO9Kliwxvrrz/Wha/Vuk0xHW4gOg/UwvKgnX/m2lzS4r7WsDKRx0yUju+Q8
 cY+tg/IbKAIg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2020 19:25:29 -0700
IronPort-SDR: swITCJNrJqDcbjiTXvS/abIRR+6uayNvPS2N5eoXn/nRBRPbXatoMYWYkYKSFCaa/GPXgG1t/b
 XtfgCIt3lWLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; d="scan'208";a="452669511"
Received: from jingqili-mobl.ccr.corp.intel.com (HELO [10.238.4.245])
 ([10.238.4.245])
 by fmsmga006.fm.intel.com with ESMTP; 07 Apr 2020 19:25:28 -0700
Subject: Re: [PATCH] exec: fetch the alignment of Linux devdax pmem character
 device nodes
To: Joao Martins <joao.m.martins@oracle.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>
References: <20200401031314.11592-1-jingqi.liu@intel.com>
 <c906a3ae-c9d2-5802-5988-3c1d0302109b@oracle.com>
 <CAPcyv4igr9-DJx2ehoHj7sXk5g5GmgmivCqM3VpmJV7J4QM+kA@mail.gmail.com>
 <3873cb30-608c-6a27-c19f-f6446898796f@oracle.com>
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Message-ID: <9959e648-94f6-3be3-2271-3d2b855e7e48@intel.com>
Date: Wed, 8 Apr 2020 10:25:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3873cb30-608c-6a27-c19f-f6446898796f@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.65
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
 Qemu Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/8/2020 2:28 AM, Joao Martins wrote:
> On 4/7/20 5:55 PM, Dan Williams wrote:
>> On Tue, Apr 7, 2020 at 4:01 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>> On 4/1/20 4:13 AM, Jingqi Liu wrote:
>>>> If the backend file is devdax pmem character device, the alignment
>>>> specified by the option 'align=NUM' in the '-object memory-backend-file'
>>>> needs to match the alignment requirement of the devdax pmem character device.
>>>>
>>>> This patch fetches the devdax pmem file 'align', so that we can compare
>>>> it with the NUM of 'align=NUM'.
>>>> The NUM needs to be larger than or equal to the devdax pmem file 'align'.
>>>>
>>>> It also fixes the problem that mmap() returns failure in qemu_ram_mmap()
>>>> when the NUM of 'align=NUM' is less than the devdax pmem file 'align'.
>>>>
>>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>>> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
>>>> ---
>>>>   exec.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
>>>>   1 file changed, 45 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/exec.c b/exec.c
>>>> index de9d949902..8221abffec 100644
>>>> --- a/exec.c
>>>> +++ b/exec.c
>>>> @@ -1736,6 +1736,42 @@ static int64_t get_file_size(int fd)
>>>>       return size;
>>>>   }
>>>>
>>>> +static int64_t get_file_align(int fd)
>>>> +{
>>>> +    int64_t align = -1;
>>>> +#if defined(__linux__)
>>>> +    struct stat st;
>>>> +
>>>> +    if (fstat(fd, &st) < 0) {
>>>> +        return -errno;
>>>> +    }
>>>> +
>>>> +    /* Special handling for devdax character devices */
>>>> +    if (S_ISCHR(st.st_mode)) {
>>>> +        g_autofree char *subsystem_path = NULL;
>>>> +        g_autofree char *subsystem = NULL;
>>>> +
>>>> +        subsystem_path = g_strdup_printf("/sys/dev/char/%d:%d/subsystem",
>>>> +                                         major(st.st_rdev), minor(st.st_rdev));
>>>> +        subsystem = g_file_read_link(subsystem_path, NULL);
>>>> +
>>>> +        if (subsystem && g_str_has_suffix(subsystem, "/dax")) {
>>>> +            g_autofree char *align_path = NULL;
>>>> +            g_autofree char *align_str = NULL;
>>>> +
>>>> +            align_path = g_strdup_printf("/sys/dev/char/%d:%d/device/align",
>>>> +                                    major(st.st_rdev), minor(st.st_rdev));
>>>> +
>>> Perhaps, you meant instead:
>>>
>>>          /sys/dev/char/%d:%d/align
>>>
>> Hmm, are you sure that's working?
> It is, except that I made the slight mistake of testing with a bunch of wip
> patches on top which one of them actually adds the 'align' to child dax device.
>
> Argh, my apologies - and thanks for noticing.
>
>> I expect the alignment to be found
>> in the region device:
>>
>> /sys/class/dax:
>> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus1/region1/dax1.1/dax1.0
>> $(readlink -f /sys/dev/char/253\:263)/../align
>> $(readlink -f /sys/dev/char/253\:263)/device/align
>>
>>
>> /sys/bus/dax:
>> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus1/region1/dax1.0/dax1.0
>> $(readlink -f /sys/dev/char/253\:265)/../align
>> $(readlink -f /sys/dev/char/253\:265)/device/align <-- No such file
>>
>> The use of the /sys/dev/char/%d:%d/device is only supported by the
>> deprecated /sys/class/dax.

Hi Dan,

Thanks for your comments.

Seems it is a mistake.

It should be: $(readlink -f /sys/dev/char/253\:263)/../../align

> I don't have the deprecated dax class enabled as could you tell, so the second
> case is what I was testing. Except it wasn't a namespace/nvdimm but rather an
> hmem device-dax.
>
> '../align' though covers only one case? What about hmem which '../align' returns
> ENOENT; perhaps using '../dax_region/align' instead which is common to both?
> Albeit that wouldn't address the sub-division devices (that I mention above)

Seems that you mean to use $(readlink -f 
/sys/dev/char/253\:263)/../../dax_region/align.

Right ?

Thanks,

Jingqi

>> The current /sys/bus/dax device-model can
>> be a drop in replacement as long as software is not written to the
>> /sys/class sysfs layout, i.e. it uses ../ instead of device/ to walk
>> to the region properties.
>>
> /nods


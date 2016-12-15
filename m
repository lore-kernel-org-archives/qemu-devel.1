Received: from eggs.gnu.org ([2001:4830:134:3::10]:53216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cHRgV-0004vh-PA
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 03:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cHRgR-0007Cx-8l
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 03:46:39 -0500
Received: from [59.151.112.132] (port=55789 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cHRgQ-00079R-Iu
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 03:46:35 -0500
References: <1481263496-8004-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1481263496-8004-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<alpine.DEB.2.10.1612131700110.2777@sstabellini-ThinkPad-X260>
	<0e652e4a-4abd-92ee-accd-59d3d6b2b4eb@cn.fujitsu.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <c66eb694-2ffa-b1f1-e33c-778cfed9ed9c@cn.fujitsu.com>
Date: Thu, 15 Dec 2016 16:46:28 +0800
MIME-Version: 1.0
In-Reply-To: <0e652e4a-4abd-92ee-accd-59d3d6b2b4eb@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 V3 1/3] Migration: Don't load
 vmdesc when xen is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>, Wen Congyang <wencongyang@gmail.com>
Cc: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie .
	dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>



On 12/15/2016 02:46 PM, Zhang Chen wrote:
>
>
> On 12/14/2016 09:00 AM, Stefano Stabellini wrote:
>> On Fri, 9 Dec 2016, Zhang Chen wrote:
>>> Xen doesn't need this.
>> Could you please elaborate a bit more on what is the problem exactly,
>> and why we don't have any issues with migration with Xen today (COLO
>> use-case aside)?
>>
>
> I test COLO without this patch, it seems run normally.
> And I review the codes not find why we need this too.
> So, I cc the original author wency about this.
>
> CC. wency.
>

I contacted wency, Here we can ignore this patch.
I will remove this patch in next version.

Thanks
Zhang Chen

> Thanks
> Zhang Chen
>
>>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>> ---
>>>   migration/savevm.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>> index 0363372..bec6c7e 100644
>>> --- a/migration/savevm.c
>>> +++ b/migration/savevm.c
>>> @@ -1973,6 +1973,10 @@ int qemu_loadvm_state(QEMUFile *f)
>>>           ret = qemu_file_get_error(f);
>>>       }
>>>   +    if (xen_enabled()) {
>>> +        return ret;
>>> +    }
>>> +
>>>       /*
>>>        * Try to read in the VMDESC section as well, so that dumping 
>>> tools that
>>>        * intercept our migration stream have the chance to see it.
>>> -- 
>>> 2.7.4
>>>
>>>
>>>
>>>
>>
>> .
>>
>

-- 
Thanks
Zhang Chen

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1cnRn2-0003Zg-5p
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1cnRmx-0006L7-46
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:21:40 -0400
Received: from [45.249.212.188] (port=2955 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1cnRmv-00068d-LG
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:21:35 -0400
References: <589C7E96.9060905@huawei.com> <589D83CE.1090803@huawei.com>
	<589DDC05.9010807@windriver.com> <58AA51D6.6020508@huawei.com>
	<1487565495.3740.27.camel@intel.com> <58AD0094.90304@windriver.com>
	<4dd92012-626a-2d80-9adb-0be398f73eb1@redhat.com>
	<58AD92AE.6040502@windriver.com>
	<6c5567f4-192d-aefd-90e4-89f53479c24e@redhat.com>
	<58AF9921.6060201@huawei.com> <58B04CD3.7010304@windriver.com>
	<7fdf2551-3d55-1bd9-2848-720a880cc93e@redhat.com>
	<58B0E191.6040108@huawei.com>
	<50916996-297e-a794-38e8-5c7ca9389419@linux.intel.com>
From: fangying <fangying1@huawei.com>
Message-ID: <a865b1b0-558f-900f-06d7-ceace1c46afb@huawei.com>
Date: Mon, 13 Mar 2017 22:58:42 +0800
MIME-Version: 1.0
In-Reply-To: <50916996-297e-a794-38e8-5c7ca9389419@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] kvm bug in __rmap_clear_dirty during live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Huang, Kai" <kai.huang@linux.intel.com>, "Herongguang (Stephen)" <herongguang.he@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Chris
	Friesen <chris.friesen@windriver.com>, "Han, Huaitong" <huaitong.han@intel.com>, "hangaohuai@huawei.com" <hangaohuai@huawei.com>, stable@vger.kernel.org
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "xudong.hao@linux.intel.com" <xudong.hao@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxinxin.wang@huawei.com" <wangxinxin.wang@huawei.com>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "guangrong.xiao@linux.intel.com" <guangrong.xiao@linux.intel.com>, linux-kernel@vger.kernel.org

Hi, Huang Kai

After weeks of intensive testing, we think the problem is solved and 
this issue can be closed.

On 2017/2/27 15:38, Huang, Kai wrote:
>
>
> On 2/25/2017 2:44 PM, Herongguang (Stephen) wrote:
>>
>>
>> On 2017/2/24 23:14, Paolo Bonzini wrote:
>>>
>>>
>>> On 24/02/2017 16:10, Chris Friesen wrote:
>>>> On 02/23/2017 08:23 PM, Herongguang (Stephen) wrote:
>>>>
>>>>> On 2017/2/22 22:43, Paolo Bonzini wrote:
>>>>
>>>>>> Hopefully Gaohuai and Rongguang can help with this too.
>>>>>>
>>>>>> Paolo
>>>>>
>>>>> Yes, we are looking into and testing this.
>>>>>
>>>>> I think this can result in any memory corruption, if VM1 writes its
>>>>> PML buffer into VM2’s VMCS (since sched_in/sched_out notifier of VM1
>>>>> is not registered yet), then VM1 is destroyed (hence its PML buffer
>>>>> is freed back to kernel), after that, VM2 starts migration, so CPU
>>>>> logs VM2’s dirty GFNS into a freed memory, results in any memory
>>>>> corruption.
>>>>>
>>>>> As its severity, this commit
>>>>> (http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=4e59516a12a6ef6dcb660cb3a3f70c64bd60cfec)
>>>>>
>>>>>
>>>>>
>>>>> is eligible to back port to kernel stable.
>>>>
>>>> Are we expecting that fix to resolve the original issue, or is it a
>>>> separate issue that needs fixing in stable?
>>>
>>> It should be the original issue.
>>>
>>> Paolo
>>>
>>> .
>>>
>> Yes, I agree, though we are still testing.
>>
>>
> Hi Stephen,
>
> Sorry for late reply. I was taking the whole week off last week. How's
> the test going?
>
> Thanks,
> -Kai
>
> .
>

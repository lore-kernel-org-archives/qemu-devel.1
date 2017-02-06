Received: from eggs.gnu.org ([2001:4830:134:3::10]:51245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cae1g-0004hf-Mz
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 02:47:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cae1c-0002tF-Qu
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 02:47:52 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:28396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cae1c-0002s2-2A
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 02:47:48 -0500
References: <1485327241-15104-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1485327241-15104-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170131100528.GC2395@work-vm> <87shnzcz0s.fsf@emacs.mitica>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58982508.4010705@huawei.com>
Date: Mon, 6 Feb 2017 15:26:00 +0800
MIME-Version: 1.0
In-Reply-To: <87shnzcz0s.fsf@emacs.mitica>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] savevm: Add new helpers to process the
 different stages of loadvm/savevm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, amit.shah@redhat.com, Li Zhijian <lizhijian@cn.fujitsu.com>

On 2017/1/31 18:19, Juan Quintela wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>> * zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
>>> There are several stages during loadvm/savevm process. In different stage,
>>> migration incoming processes different types of sections.
>>> We want to control these stages more accuracy, it will benefit COLO
>>> performance, we don't have to save type of QEMU_VM_SECTION_START
>>> sections everytime while do checkpoint, besides, we want to separate
>>> the process of saving/loading memory and devices state.
>>>
>>> So we add three new helper functions: qemu_loadvm_state_begin(),
>>> qemu_load_device_state() and qemu_savevm_live_state() to achieve
>>> different process during migration.
>>>
>>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>
>> I don't think this one can go in without the patch that follows which
>> uses these functions; we don't normally add functions
>> without the patch that uses them.
>
> Agreed.  If you want to add functions, you need new code that use them,
> or make old code use them.  It is up to you.
>

Got it, thanks, I'll merge this series with the one where we use them.

> Thanks, Juan.
>
> .
>

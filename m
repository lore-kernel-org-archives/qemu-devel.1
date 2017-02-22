Received: from eggs.gnu.org ([2001:4830:134:3::10]:39313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1cgZZt-0000Xc-Cy
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1cgZZq-0007Og-5c
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:15:41 -0500
Received: from mail.windriver.com ([147.11.1.11]:40904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Chris.Friesen@windriver.com>)
	id 1cgZZp-0007Nb-SF
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:15:38 -0500
Message-ID: <58AD92AE.6040502@windriver.com>
Date: Wed, 22 Feb 2017 07:31:26 -0600
From: Chris Friesen <chris.friesen@windriver.com>
MIME-Version: 1.0
References: <589C7E96.9060905@huawei.com> <589D83CE.1090803@huawei.com>
	<589DDC05.9010807@windriver.com> <58AA51D6.6020508@huawei.com>
	<1487565495.3740.27.camel@intel.com> <58AD0094.90304@windriver.com>
	<4dd92012-626a-2d80-9adb-0be398f73eb1@redhat.com>
In-Reply-To: <4dd92012-626a-2d80-9adb-0be398f73eb1@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] kvm bug in __rmap_clear_dirty during live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Han, Huaitong" <huaitong.han@intel.com>, "hangaohuai@huawei.com" <hangaohuai@huawei.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "fangying1@huawei.com" <fangying1@huawei.com>, "herongguang.he@huawei.com" <herongguang.he@huawei.com>, "xudong.hao@linux.intel.com" <xudong.hao@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxinxin.wang@huawei.com" <wangxinxin.wang@huawei.com>, "kai.huang@linux.intel.com" <kai.huang@linux.intel.com>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "guangrong.xiao@linux.intel.com" <guangrong.xiao@linux.intel.com>

On 02/22/2017 05:15 AM, Paolo Bonzini wrote:
>
>
> On 22/02/2017 04:08, Chris Friesen wrote:
>> On 02/19/2017 10:38 PM, Han, Huaitong wrote:
>>> Hi, Gaohuai
>>>
>>> I tried to debug the problem, and I found the indirect cause may be that
>>> the rmap value is not cleared when KVM mmu page is freed. I have read
>>> code without the root cause. Can you stable reproduce the the issue?
>>> Many guesses need to be verified.
>>
>> In both cases it seems to have been triggered by repeatedly
>> live-migrating a KVM virtual machine between two hypervisors with
>> Broadwell CPUs running the latest CentOS 7.
>>
>> It's a race of some sort, it doesn't happen every time.
>
> Can you reproduce it with kernel 4.8+?  I'm suspecting commmit
> 4e59516a12a6 ("kvm: vmx: ensure VMCS is current while enabling PML",
> 2016-07-14) to be the fix.

I can't easily try with a newer kernel, the software package we're using has 
kernel patches that would have to be ported.

I'm at a conference, don't really have time to set up a pair of test machines 
from scratch with a custom kernel.

Chris
